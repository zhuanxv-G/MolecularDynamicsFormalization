"""Merge version-bound review data only; never execute or install returned Lean code."""
from __future__ import annotations

import argparse
import json
import re
from datetime import datetime
from pathlib import Path
from zoneinfo import ZoneInfo

from render_blueprint import ROOT, entry_hash, sha256
from prepare_ch01_tasks import PILOT, fingerprint

SOURCE_KEYS = ('kind','label','section','printed_page','pdf_page','statement_latex',
               'proof_latex','proof_note','proof_discussion_latex','context_notation','statement_scope')
VERDICTS = {'PASS','TOO_WEAK','TOO_STRONG','MISSING_CLAUSE','EXTRA_ASSUMPTION',
            'WRONG_OBJECT','WRONG_QUANTIFIER','WRONG_LEVEL','POSSIBLE_ERRATUM'}


def decode(text):
    try:
        data = json.loads(text)
    except json.JSONDecodeError:
        blocks = re.findall(r'```(?:json)?\s*\n([\s\S]*?)\n```', text)
        if len(blocks) != 1:
            raise ValueError('需要人工整合：返回件须是单个JSON对象，或仅含一个JSON代码块')
        data = json.loads(blocks[0])
    if not isinstance(data, dict):
        raise ValueError('每个任务仅接收一个条目对象')
    return data


def load(path):
    return json.loads(path.read_text(encoding='utf-8-sig'))


def save(path, data):
    path.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')


def ingest(freeze=False):
    sources_path, audit_path = PILOT/'ch01_source.json', PILOT/'audit.json'
    sources, audit, tasks = load(sources_path), load(audit_path), load(PILOT/'tasks.json')
    indexed = {s['source_id']:s for s in sources}
    lean = (ROOT/'Blueprint/Ch01.lean').read_text(encoding='utf-8-sig')
    now = datetime.now(ZoneInfo('Asia/Shanghai')).isoformat()
    failures, accepted = [], []
    candidates = [p for p in (PILOT/'mathcopilot_results').iterdir()
                  if p.name.startswith('T_') and p.suffix.lower() in ('.json','.md')]
    # A first, then independent translation, then semantic audit.
    candidates.sort(key=lambda p: (0 if p.stem.startswith('T_json_review_') else
                                  1 if p.stem.startswith('T_blueprint_') else 2,p.name))
    for path in candidates:
        text = path.read_text(encoding='utf-8-sig')
        digest = sha256(text)
        if audit['processed_results'].get(path.name) == digest:
            continue
        try:
            data = decode(text)
            task = tasks[path.stem]
            if data.get('task_name') != path.stem or data.get('source_id') != task['source_id']:
                raise ValueError('任务名/source_id不匹配')
            sid, stage = task['source_id'], task['stage']
            s, a = indexed[sid], audit['items'][sid]
            fp = fingerprint(s,lean)
            if data.get('input_fingerprint') != task['input_fingerprint'] or fp != task['input_fingerprint']:
                raise ValueError('哈希已变化：保留旧返回件，修复后创建新版本任务复审')
            receipt = dict(file=str(path.relative_to(ROOT)).replace('\\','/'),sha256=digest,
                           task=path.stem,stage=stage,received_at=now,input_fingerprint=fp,
                           output=data)
            if stage == 'json_review':
                status = data.get('status')
                if status not in {'PASS','REPAIRED','NEEDS_HUMAN'}:
                    raise ValueError('未知JSON审校状态')
                corrected = data.get('corrected_json')
                if status == 'REPAIRED' and not isinstance(corrected,dict):
                    raise ValueError('REPAIRED须包含完整corrected_json')
                if isinstance(corrected,dict) and corrected.get('source_id') != sid:
                    raise ValueError('corrected_json不允许更改source_id')
                before = entry_hash(s)
                proposed = dict(s)
                if isinstance(corrected,dict):
                    proposed.update({k:corrected[k] for k in SOURCE_KEYS if k in corrected})
                after = entry_hash(proposed)
                if status == 'PASS' and before != after:
                    raise ValueError('PASS不能同时改写原文；请审校方给出REPAIRED')
                if a['frozen'] and before != after:
                    raise ValueError('条目已冻结；先显式退回第3步，不能静默替换原文')
                s.update({k:proposed[k] for k in SOURCE_KEYS if k in proposed})
                s['review_status'] = status
                if status == 'REPAIRED':
                    s['repair_log'].append(dict(timestamp=now,task=path.stem,before_sha256=before,
                        after_sha256=after,changes={k:corrected[k] for k in SOURCE_KEYS if k in corrected}))
                if before != after:
                    for other in ('blueprint_translation','semantic_review'):
                        a[other]['status']='STALE_REQUIRES_REVIEW'
                    a['verdict']='PENDING'
                    a['frozen']=False
                    audit['frozen']=False
                # Preserve existing local issues and append every new reviewer issue.
                # Closure remains a local PDF/statement decision, never an implicit deletion.
                for issue in data.get('issues',[]):
                    item=dict(code='MATHCOPILOT_JSON_ISSUE',status='NEEDS_HUMAN' if status=='NEEDS_HUMAN' else 'open',
                              detail=issue if isinstance(issue,str) else json.dumps(issue,ensure_ascii=False),task=path.stem)
                    if item not in s['issues']:
                        s['issues'].append(item)
                a[stage]['status']=status
            elif stage == 'blueprint_translation':
                if data.get('lean_decl') != s['lean_decl'] or not isinstance(data.get('lean_statement'),str):
                    raise ValueError('独立翻译须包含对应声明名和完整lean_statement')
                a[stage]['status']='RECEIVED_REQUIRES_COMPARISON'
                a[stage]['comparison']=None
            else:
                if data.get('lean_decl') != s['lean_decl'] or data.get('verdict') not in VERDICTS:
                    raise ValueError('语义审计声明名或判定不合法')
                if s['review_status'] not in {'PASS','REPAIRED'}:
                    raise ValueError('只读审计必须在approved JSON基础上进行')
                a[stage]['status']=data['verdict']
                a['verdict']=data['verdict']
                a['explanation']=data.get('explanation','')
                if data['verdict'] != 'PASS':
                    a['frozen']=False
                    audit['frozen']=False
            a[stage]['task']=path.stem
            a[stage]['input_fingerprint']=fp
            a[stage]['results'].append(receipt['file'])
            a['review_history'].append(receipt)
            audit['processed_results'][path.name]=digest
            accepted.append(path.name)
        except (ValueError,KeyError,json.JSONDecodeError) as e:
            failures.append(f'{path.name}: {e}')
    if freeze:
        problems=[]
        for sid,a in audit['items'].items():
            s=indexed[sid]
            fp=fingerprint(s,lean)
            if s['review_status'] not in {'PASS','REPAIRED'}:
                problems.append(sid+': JSON未approved')
            if a['verdict']!='PASS' or a['semantic_review'].get('input_fingerprint')!=fp:
                problems.append(sid+': 当前版本未通过只读语义审计')
            if (a['blueprint_translation']['status']!='COMPARED' or
                    not a['blueprint_translation'].get('comparison') or
                    a['blueprint_translation'].get('input_fingerprint')!=fp):
                problems.append(sid+': 独立翻译尚未本地比较整合')
            if any(issue.get('status') not in {'closed','resolved','local_verified'} for issue in s['issues']):
                problems.append(sid+': issues尚未闭合')
        if failures or problems:
            failures.extend(problems)
        else:
            for sid,a in audit['items'].items():
                fp=fingerprint(indexed[sid],lean)
                a.update(frozen=True,frozen_signature_sha256=fp['signature_sha256'],frozen_input_fingerprint=fp)
            audit.update(frozen=True,stage='FROZEN_READY_FOR_PROOFS',frozen_at=now)
    save(sources_path,sources)
    save(audit_path,audit)
    print(f'Accepted {len(accepted)} new result(s); frozen={audit["frozen"]}')
    for message in failures:
        print('NEEDS_LOCAL_REVIEW: '+message)
    return 1 if failures else 0


if __name__=='__main__':
    p=argparse.ArgumentParser()
    p.add_argument('--freeze',action='store_true',help='Only after local comparison/issue closure and all current PASS results')
    args=p.parse_args()
    raise SystemExit(ingest(args.freeze))

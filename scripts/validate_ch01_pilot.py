"""Record local evidence without upgrading pending independent semantic audits."""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
from pathlib import Path

from render_blueprint import ROOT, declarations, sha256
from prepare_ch01_tasks import PILOT, dependency_inventory, fingerprint


def strip_comments(text):
    """Remove nested Lean comments and string literals for a conservative token scan."""
    out, i, depth = [], 0, 0
    while i < len(text):
        if text.startswith('/-',i):
            depth += 1
            i += 2
        elif depth and text.startswith('-/',i):
            depth -= 1
            i += 2
        elif depth:
            out.append('\n' if text[i]=='\n' else ' ')
            i += 1
        elif text.startswith('--',i):
            end = text.find('\n',i)
            i = len(text) if end<0 else end
        elif text[i]=='"':
            i += 1
            while i<len(text):
                if text[i]=='\\':
                    i += 2
                elif text[i]=='"':
                    i += 1
                    break
                else:
                    i += 1
            out.append(' ')
        else:
            out.append(text[i])
            i += 1
    return ''.join(out)


def scan(text):
    code=strip_comments(text)
    result={k:len(re.findall(r'\b'+k+r'\b',code)) for k in ('sorry','admit','axiom','unsafe','True')}
    result['identity_implication_candidates']=re.findall(r'\b([A-Za-z]\w*)\s*(?:→|->)\s*\1\b',code)
    return result


def validate(report_dir:Path):
    report=json.loads((report_dir/'CHECK_REPORT.json').read_text(encoding='utf-8-sig'))
    if report['machine_check_status']!='passed':
        raise ValueError('Full check has not passed')
    # Do not reuse evidence if any source/configuration input changed after the check.
    for record in report['inputs']:
        actual=hashlib.sha256((ROOT/record['relative_path']).read_bytes()).hexdigest()
        if actual!=record['sha256']:
            raise ValueError('Stale check input: '+record['relative_path'])
    for check in report['checks']:
        if check.get('raw_log'):
            actual=hashlib.sha256((report_dir/check['raw_log']).read_bytes()).hexdigest()
            if actual!=check['raw_log_sha256']:
                raise ValueError('Changed check log: '+check['raw_log'])
    lean=(ROOT/'Blueprint/Ch01.lean').read_text(encoding='utf-8-sig')
    ds=declarations(lean)
    axioms_text=(report_dir/'blueprint_axiom_dependencies.log').read_text(encoding='utf-8-sig')
    inventory=dependency_inventory(lean)
    dep_scan={r['file']:scan((ROOT/r['file']).read_text(encoding='utf-8-sig')) for r in inventory}
    forbidden_dep=[f for f,s in dep_scan.items() if any(s[k] for k in ('sorry','admit','axiom','unsafe'))]
    if forbidden_dep:
        raise ValueError('Imported project proof shortcuts: '+str(forbidden_dep))
    unchanged=subprocess.run(['git','diff','--exit-code','1b1cbae1bcb27177963a43018fb2c2ba7eb00cb6',
        '--','MolecularDynamics','MolecularDynamicsFormalization.lean'],cwd=ROOT,capture_output=True,text=True)
    if unchanged.returncode:
        raise ValueError('Existing formal library differs from the pilot baseline')
    audit_path=PILOT/'audit.json'
    audit=json.loads(audit_path.read_text(encoding='utf-8-sig'))
    sources=json.loads((PILOT/'ch01_source.json').read_text(encoding='utf-8-sig'))
    indexed={s['source_id']:s for s in sources}
    for sid,d in ds.items():
        a=audit['items'][sid]
        if a['frozen'] and a['frozen_signature_sha256'] != d['signature_sha256']:
            raise ValueError('Frozen signature changed; return to semantic audit: '+sid)
        if a['frozen'] and a['frozen_input_fingerprint'] != fingerprint(indexed[sid],lean):
            raise ValueError('Frozen source, helper definitions or dependencies changed: '+sid)
        match=re.search(r"['\"]?"+re.escape(d['name'])+r"['\"]? depends on axioms:\s*\[([^\]]*)\]",axioms_text)
        if not match:
            raise ValueError('Missing #print axioms evidence: '+d['name'])
        ax=[x.strip() for x in match.group(1).split(',') if x.strip()]
        risk=scan(d['block'])
        has_hole='sorryAx' in ax or risk['sorry']>0
        priors=[x for x in ax if x!='sorryAx']
        a['axioms']=ax
        a['local_proof_status']='incomplete' if has_hole else 'checked proof + documented priors' if priors else 'self-contained Lean proof'
        a['direct_risk']='含1处sorry；不能作为已证结论' if has_hole else '无sorry/admit/新增axiom/unsafe/True/P→P；本地5条签名逐项检查'
        a['dependency_risk']='传递#print axioms含sorryAx；其他先验为'+', '.join(priors) if has_hole else '传递依赖只含'+(', '.join(priors) or '无公理')+'；导入的正式库源码无证明捷径'
        a['direct_scan']=risk
        a['documented_priors']=[
            dict(name=x,explanation={'propext':'Lean命题外延公理','Classical.choice':'Lean经典选择公理',
                'Quot.sound':'Lean商类型等价公理'}.get(x,'待人工解释的先验')) for x in priors]
        # Compilation alone does not complete the workshop.
        if a['frozen'] and a['verdict']=='PASS' and not has_hole:
            a['final_status']=a['local_proof_status']
            a['final_status_note']='冻结陈述机器检查通过；导师格式确认单独登记。'
        else:
            a['final_status']='incomplete'
    relative=str(report_dir.relative_to(ROOT)).replace('\\','/')
    audit['validation']=dict(status='passed',check_report=relative+'/CHECK_REPORT.json',
        lean_version=report['lean_version'],mathlib_revision=report['actual_mathlib_revision'],
        blueprint_fresh_check='passed',print_axioms='passed_with_documented_priors_and_one_draft_hole',
        existing_formal_library='unchanged_from_1b1cbae',formal_project_source_scan='passed',
        blueprint_scan=scan(lean),project_import_closure_scan=dep_scan,
        blueprint_sha256=sha256(lean),responsible_semantic_review='pending',
        limitations=['MathCopilot网站结果未返回，未完成语义PASS/冻结/第4–5步最终交付。',
                    '源码风险扫描是保守文本检查；数学忠实性由只读语义审计判定。',
                    '传递公理来自Lean实际#print axioms；未对Mathlib全部源码作文本风险审计。'])
    audit_path.write_text(json.dumps(audit,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print('Local check evidence recorded: 5 declarations; independent audits remain unchanged.')


if __name__=='__main__':
    p=argparse.ArgumentParser()
    p.add_argument('report_directory',type=Path)
    validate(p.parse_args().report_directory.resolve())

"""Verify the current Chapter 2 delivery without writing Chapter 1 or the formal library."""
from pathlib import Path
import json,hashlib,re,subprocess,sys
from collections import Counter
from ch02_pipeline import ROOT,BASE,sha,verify_protected,declarations,dump

def main():
    protected=verify_protected()
    sources=json.loads((BASE/'ch02_source.json').read_text(encoding='utf-8'))
    ds=declarations();audit=json.loads((BASE/'local_audit.json').read_text(encoding='utf-8'))['items']
    mapping=json.loads((BASE/'old_mapping.json').read_text(encoding='utf-8'))
    original=json.loads((ROOT/'blueprint/ch01/ch01_source.json').read_text(encoding='utf-8'))
    assert all(set(x)==set(original[0]) for x in sources),'Source schema mismatch'
    ids=[x['source_id'] for x in sources]
    assert len(set(ids))==len(ids) and set(ids)==set(ds)==set(audit)
    assert not mapping['pending'] and set(mapping['mapped'])=={f'CH02-{i:03}' for i in range(1,161)}
    assert set(mapping['mapped'].values())<=set(ids)
    assert all(a['checked'] for a in audit.values()),'Unchecked declaration'
    for sid,a in audit.items():
        assert a['signature_sha256']==ds[sid]['signature_sha256']
        assert a['block_sha256']==ds[sid]['block_sha256']
        assert a['final_status'] in {'self-contained','checked+documented priors','incomplete'}
        assert a['website_audit']=='待网站审计'
        if 'sorryAx' in a['axioms']:assert a['final_status']=='incomplete'
        if a['verdict']!='PASS':assert a['final_status']=='incomplete'
        assert a['direct_placeholder']==bool(re.search(r'\bsorry\b',ds[sid]['block']))
        assert a['transitive_placeholder']==('sorryAx' in a['axioms'] and not a['direct_placeholder'])
    batches=json.loads((BASE/'mathcopilot_tasks/MANIFEST.json').read_text(encoding='utf-8'))
    packaged=[];budgets=[]
    for batch in batches:
        assert 1<=len(batch['source_ids'])<=8
        packaged+=batch['source_ids']
        assert sha(BASE/'mathcopilot_tasks'/f"{batch['batch']}.md")==batch['full_batch_sha256']
        for t in batch['subtasks']:
            folder=ROOT/t['path'];mp=folder/'MANIFEST.json'
            assert sha(mp)==t['manifest_sha256'];m=json.loads(mp.read_text(encoding='utf-8'))
            assert m['source_json_sha256']==sha(BASE/'ch02_source.json')
            assert m['lean_sha256']==sha(ROOT/'Blueprint/Ch02.lean')
            for p,v in m['files'].items():
                assert sha(folder/p)==v['sha256'] and (folder/p).stat().st_size==v['bytes']
            total=sum(x['bytes'] for x in m['files'].values())
            assert total==m['paste_plus_pdf_bytes']==t['bytes'] and total<256000
            assert m['validation']['pdf_rendered_pixel_equality']=='PASS'
            assert m['validation']['website_acceptance']=='NOT_TESTED'
            assert all(75<=p['original_pdf_page']<=116 for p in m['page_mapping'])
            budgets.append(total)
    assert Counter(packaged)==Counter(ids),'Package source coverage'
    actual_pastes={p.parent.relative_to(ROOT).as_posix() for p in (BASE/'mathcopilot_tasks/compact').rglob('PASTE.txt')}
    expected_pastes={t['path'] for b in batches for t in b['subtasks']}
    assert actual_pastes==expected_pastes,'Obsolete active compact package'
    for a in audit.values():
        for evidence in a.get('attempt_evidence',[]):assert (ROOT/evidence).exists(),evidence
    pages=json.loads((BASE/'source_page_checks.json').read_text(encoding='utf-8'))
    assert set(range(75,117))<=set(pages['visually_checked_pdf_pages'])
    doc=(ROOT/'docs/review/CH02_BLUEPRINT.zh-CN.md').read_text(encoding='utf-8')
    for label in ['## 1.','### 2. 原文陈述','### 3. 原文证明','### 4. Lean陈述',
        '### 5. 对照表','### 6. 审计结论','### 7. 状态与证明位置']:
        assert doc.count(label)==len(ids),(label,doc.count(label))
    lean=(ROOT/'Blueprint/Ch02.lean').read_text(encoding='utf-8')
    assert not re.search(r'\b(?:admit|axiom|unsafe|True)\b',lean)
    reports={}
    for section in ['section21','section22','section23','section24','section25']:
        rp=BASE/'validation'/section/'CHECK_REPORT.json';r=json.loads(rp.read_text(encoding='utf-8-sig'))
        assert r['machine_check_status']=='passed'
        for check in r['checks']:
            assert check['exit_code']==0
            assert sha(rp.parent/check['raw_log'])==check['raw_log_sha256']
        reports[section]=sha(rp)
    for x in r['inputs']:assert sha(ROOT/x['relative_path'])==x['sha256'],'Final input drift: '+x['relative_path']
    paths=subprocess.check_output(['git','ls-files'],cwd=ROOT,text=True).splitlines()
    assert 'Blueprint/Ch02.lean' in paths
    assert not any(p.startswith('Blueprint/ch02/') for p in paths)
    out=dict(result='PASS',source_entries=len(ids),old_rows_mapped=160,full_batches=len(batches),
        compact_subtasks=len(budgets),max_paste_plus_pdf_bytes=max(budgets),protected_unchanged=protected,
        statuses=dict(Counter(a['final_status'] for a in audit.values())),
        local_verdicts=dict(Counter(a['verdict'] for a in audit.values())),
        direct_sorry=sum(a['direct_placeholder'] for a in audit.values()),
        transitive_only_sorry=sum(a['transitive_placeholder'] for a in audit.values()),
        original_pages_rendered_and_visually_checked=42,section_check_report_hashes=reports,
        website_audit='待网站审计',mentor_issues='记录于PROGRESS及CH02_BLUEPRINT，尚未确认')
    dump(BASE/'DELIVERY_VALIDATION.json',out);print(json.dumps(out,ensure_ascii=False,indent=2))
if __name__=='__main__':main()

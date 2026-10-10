"""Whole-chapter local delivery validation; no website or mentor claim."""
import argparse,json,re,csv
from collections import Counter
from local_blueprint import ROOT,RANGES,pipeline
a=argparse.ArgumentParser();a.add_argument('chapter',type=int);a.add_argument('--sections',nargs='+',required=True);x=a.parse_args();ch=x.chapter;p=pipeline(ch)
lo,hi,p0,p1=RANGES[ch];tag=f'ch{ch:02}'
sources=json.loads((p.BASE/f'{tag}_source.json').read_text(encoding='utf-8'))
original=json.loads((ROOT/'blueprint/ch01/ch01_source.json').read_text(encoding='utf-8'))
assert all(set(s)==set(original[0]) for s in sources),'Source schema mismatch'
ds=p.declarations();audit=json.loads((p.BASE/'local_audit.json').read_text(encoding='utf-8'))['items']
ids=[s['source_id'] for s in sources];assert len(set(ids))==len(ids) and set(ids)==set(ds)==set(audit)
old=list(csv.DictReader((ROOT/f'docs/review/CH{ch:02}_CLAIMS.csv').open(encoding='utf-8-sig')))
mapping=json.loads((p.BASE/'old_mapping.json').read_text(encoding='utf-8'))
assert not mapping['pending'] and set(mapping['mapped'])=={r['id'] for r in old}
assert set(mapping['mapped'].values())<=set(ids)
for sid,item in audit.items():
    assert item['checked'] and item.get('compiled',True),sid
    assert item['signature_sha256']==ds[sid]['signature_sha256'] and item['block_sha256']==ds[sid]['block_sha256']
    assert item['final_status'] in {'self-contained','checked+documented priors','incomplete'}
    assert item['website_audit']=='待网站审计'
    if 'sorryAx' in item['axioms'] or item['verdict']!='PASS':assert item['final_status']=='incomplete'
    assert item['direct_placeholder']==bool(re.search(r'\bsorry\b',ds[sid]['block']))
    assert item['transitive_placeholder']==('sorryAx' in item['axioms'] and not item['direct_placeholder'])
    for evidence in item.get('attempt_evidence',[]):assert (ROOT/evidence).exists()
batches=json.loads((p.BASE/'mathcopilot_tasks/MANIFEST.json').read_text(encoding='utf-8'))
packaged=[];budgets=[];expected=set()
for batch in batches:
    assert 1<=len(batch['source_ids'])<=8;packaged+=batch['source_ids']
    assert p.sha(p.BASE/'mathcopilot_tasks'/f'{batch["batch"]}.md')==batch['full_batch_sha256']
    for task in batch['subtasks']:
        folder=ROOT/task['path'];expected.add(task['path'])
        mp=folder/'MANIFEST.json';assert p.sha(mp)==task['manifest_sha256']
        m=json.loads(mp.read_text(encoding='utf-8'))
        assert m['source_json_sha256']==p.sha(p.BASE/f'{tag}_source.json') and m['lean_sha256']==p.sha(ROOT/f'Blueprint/Ch{ch:02}.lean')
        for name,details in m['files'].items():assert p.sha(folder/name)==details['sha256'] and (folder/name).stat().st_size==details['bytes']
        inputs=sum(v['bytes'] for v in m['files'].values());total=sum(f.stat().st_size for f in folder.iterdir() if f.is_file())
        assert inputs==m['paste_plus_pdf_bytes'] and total==m['total_task_bytes']==task['bytes'] and total<256000
        assert {f.name for f in folder.iterdir() if f.is_file()}=={'PASTE.txt','MANIFEST.json',task['subtask']+'_PAGES.pdf'}
        assert m['validation']['pdf_rendered_pixel_equality']=='PASS' and m['validation']['website_acceptance']=='NOT_TESTED'
        assert all(p0<=q['original_pdf_page']<=p1 and q['printed_page']==q['original_pdf_page']-(p0-lo) for q in m['page_mapping'])
        budgets.append(total)
assert Counter(packaged)==Counter(ids),'Package coverage'
actual={f.parent.relative_to(ROOT).as_posix() for f in (p.BASE/'mathcopilot_tasks/compact').rglob('PASTE.txt')}
assert actual==expected,'Obsolete active compact package'
pages=json.loads((p.BASE/'source_page_checks.json').read_text(encoding='utf-8'))
assert set(range(p0,p1+1))<=set(pages['visually_checked_pdf_pages'])
doc=(ROOT/f'docs/review/CH{ch:02}_BLUEPRINT.zh-CN.md').read_text(encoding='utf-8')
for label in ['## 1.','### 2. 原文陈述','### 3. 原文证明','### 4. Lean陈述','### 5. 对照表','### 6. 审计结论','### 7. 状态与证明位置']:
    assert doc.count(label)==len(ids),(label,doc.count(label))
code=re.sub(r'(?s)/-.*?-/','',(ROOT/f'Blueprint/Ch{ch:02}.lean').read_text(encoding='utf-8'))
assert not re.search(r'\b(admit|axiom|unsafe|True)\b',code)
reports={}
for section in x.sections:
    folder=p.BASE/'validation'/section
    full=json.loads((folder/'CHECK_REPORT.json').read_text(encoding='utf-8-sig'))
    local=json.loads((folder/'LOCAL_CHECK_REPORT.json').read_text(encoding='utf-8-sig'))
    assert full['machine_check_status']==local['machine_check_status']=='passed'
    assert p.sha(folder/'CHECK_REPORT.json')==local['shared_check_sha256']
    for report in [full,local]:
        for check in report['checks']:assert check['exit_code']==0 and p.sha(folder/check['raw_log'])==check['raw_log_sha256']
    reports[section]=dict(shared=p.sha(folder/'CHECK_REPORT.json'),chapter=p.sha(folder/'LOCAL_CHECK_REPORT.json'))
for report in [full,local]:
    for f in report['inputs']:assert p.sha(ROOT/f['relative_path'])==f['sha256'],f['relative_path']
result=dict(result='PASS',chapter=ch,source_entries=len(ids),old_rows_mapped=len(old),full_batches=len(batches),compact_subtasks=len(budgets),max_total_task_bytes=max(budgets),
    protected_unchanged=p.verify_protected(),statuses=dict(Counter(v['final_status'] for v in audit.values())),local_verdicts=dict(Counter(v['verdict'] for v in audit.values())),
    direct_sorry=sum(v['direct_placeholder'] for v in audit.values()),transitive_only_sorry=sum(v['transitive_placeholder'] for v in audit.values()),
    original_pages_rendered_and_visually_checked=p1-p0+1,section_check_report_hashes=reports,website_audit='待网站审计',mentor_issues='已记录，尚未确认')
p.dump(p.BASE/'DELIVERY_VALIDATION.json',result)
print(json.dumps(result,ensure_ascii=False,indent=2).encode('utf-8').decode('utf-8'))

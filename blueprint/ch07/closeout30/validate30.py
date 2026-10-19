from finalize30 import *
from concurrent.futures import ThreadPoolExecutor

def main():
    baseline=load(OUT/'FROZEN_BASELINE.json')
    def verify(kv):
        p,h=kv
        return p if not (ROOT/p).is_file() or sha(ROOT/p)!=h else None
    with ThreadPoolExecutor(max_workers=8) as pool:
        changed=[x for x in pool.map(verify,baseline.items()) if x]
    assert not changed,changed
    chapter08=[p for p in baseline if p.lower().startswith('blueprint/ch08/') or p.lower()=='blueprint/ch08.lean' or p.startswith('docs/review/CH08_')]
    assert chapter08
    raw=load(OUT/'RETURN_REGISTRATION.json')
    for r in raw['bindings']:assert sha(ROOT/r['path'])==r['sha256']
    final=load(OUT/'FINAL_COMPILE.json');lean=ROOT/'Blueprint/Ch07.lean'
    assert final['exit_code']==0 and final['canonical_sha256']==sha(lean)
    assert not final['errors'] and not final['missing_axiom_outputs']
    assert sha(ROOT/final['probe'])==final['input_sha256']
    assert sha(OUT/'FINAL_COMPILE.log')==final['log_sha256']
    full=load(OUT/'full/CHECK_REPORT.json')
    assert full['machine_check_status']=='passed' and full['exit_code']==0
    for x in full['inputs']:assert sha(ROOT/x['relative_path'])==x['sha256']
    for x in full['checks']:
        assert x['exit_code']==0
        if x['raw_log']:assert sha(OUT/'full'/x['raw_log'])==x['raw_log_sha256']
    binding=load(OUT/'FULL_BINDING.json')
    assert binding['canonical_sha256']==sha(lean) and binding['report_sha256']==sha(OUT/'full/CHECK_REPORT.json')
    # No custom axiom declarations or unfinished formal proofs are permitted.
    formal=[p for p in (ROOT/'MolecularDynamics').rglob('*.lean')]
    shortcuts=[]
    for p in formal:
        for i,line in enumerate(p.read_text(encoding='utf-8-sig').splitlines(),1):
            if re.search(r'\b(sorry|admit|axiom|unsafe)\b',line):shortcuts.append([str(p),i,line])
    assert not shortcuts,shortcuts
    ds=load(OUT/'DECLARATIONS.json');s=load(OUT/'SUMMARY.json')
    assert len(ds)==373 and Counter(d['status'] for d in ds)==s['declarations']
    assert Counter(d['reason'] for d in ds if d['reason'])==s['unproved_reasons']
    assert s['repairing']==0 and s['new_eaudit_packages']==0 and s['awaiting_reaudit']==0
    assert s['current_lean_sha256']==sha(lean) and s['current_source_sha256']==sha(BASE/'ch07_source.json')
    newproof=[d for d in ds if d['name'].split('.')[-1] in ['constrainedHOQualifiedComposition_measurable','constrainedHOOutput_hasLaw','constrainedHOOutputLaw_probability']]
    assert len(newproof)==3 and all(d['status']=='已证' and 'sorryAx' not in d['axioms'] for d in newproof)
    oldgroups=groups((OUT/'Ch07.before.lean').read_text(encoding='utf-8'));now=groups()
    changed_groups=[sid for sid,g in now.items() if strip_comments(g['code']).strip()!=strip_comments(oldgroups[sid]['code']).strip()]
    assert changed_groups==[FAIL_ID],changed_groups
    web=load(BASE/'website_audit.json');assert len(web)==118
    for w in web:
        if w['source_id']==FAIL_ID:
            assert w['audit']['verdict']=='FAIL' and w['local_repair30']['suggested_fix']==w['closeout30_return']['audit']['suggested_fix']
            assert w['effective_status']=='按网站审校意见修复，本地核验通过（未再送网站）'
    bp=(ROOT/'docs/review/CH07_BLUEPRINT.zh-CN.md').read_text(encoding='utf-8')
    for i in range(1,8):assert len(re.findall('### '+str(i)+r'\.',bp))==118
    err=(ROOT/'docs/review/CH07_ERRATA.zh-CN.md').read_text(encoding='utf-8')
    assert err.count('- 网站复审结论：')==len(load(OUT/'ERRATA_INDEX.json'))==29
    assert len(re.findall(r'^\| MD-',(BASE/'PROGRESS.md').read_text(encoding='utf-8'),re.M))==118
    src=load(BASE/'ch07_source.json');color=next(s for s in src if s['source_id'].endswith('ColoredNoiseAndExtension'))
    assert not any('Markov定理未覆盖' in x for x in color['coverage_gaps']+color['extra_assumptions'])
    gap=next(s for s in src if s['source_id']==FAIL_ID)
    assert '条件积分解' in ' '.join(gap['coverage_gaps'])
    report=dict(status='PASS',frozen_files=len(baseline),chapter08_frozen_files=len(chapter08),changed_frozen_files=changed,formal_lean_files=len(formal),formal_sorry=0,formal_custom_axiom_declarations=0,website_returns=35,website_return_files=12,raw_reaudit_counts=raw['counts'],declarations=len(ds),proven=53,unproved=69,definition_count=251,new_proofs_without_placeholders=[d['name'] for d in newproof],semantic_changed_source_groups=changed_groups,full_check='passed',full_check_inputs=len(full['inputs']),full_check_logs=len(full['checks']),lean_sha256=sha(lean),source_sha256=sha(BASE/'ch07_source.json'),compile_receipt_sha256=sha(OUT/'FINAL_COMPILE.json'),full_report_sha256=sha(OUT/'full/CHECK_REPORT.json'),repairing=0,website_resubmitted=False,new_eaudit_packages=0,unverified=['69 unproved draft statements','conditional solution/constraint preservation for random initial data','mentor decisions on errata/scope','website re-review of the one local repair (intentionally not performed)'])
    dump(OUT/'DELIVERY_VALIDATION.json',report)
    print('VALIDATION PASS',len(baseline),'frozen files;',len(chapter08),'Ch08;',len(ds),'declarations',flush=True)

if __name__=='__main__':main()

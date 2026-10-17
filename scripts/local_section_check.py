"""Reuse frozen shared checks, then build and audit the current chapter afresh.

Shared receipts retain their original HEAD/time and bytes. They are never
relabeled as a new native run. The current chapter has its own build receipt,
fresh single-file check, and axiom log bound to its actual current bytes.
"""
import argparse,json,subprocess,shutil
from pathlib import Path
from datetime import datetime
from local_blueprint import ROOT,pipeline
from local_compile import compile_recorded
a=argparse.ArgumentParser();a.add_argument('chapter',type=int);a.add_argument('report');a.add_argument('--reuse-shared',required=True)
a.add_argument('--native-build',action='store_true',help='Also build the current chapter artifact; batch source/axiom evidence is otherwise reused exactly.')
x=a.parse_args();p=pipeline(x.chapter);target=ROOT/x.report;origin=ROOT/x.reuse_shared
assert target!=origin
report=json.loads((origin/'CHECK_REPORT.json').read_text(encoding='utf-8-sig'))
assert report['machine_check_status']=='passed'
p.verify_protected()
for f in report['inputs']:assert p.sha(ROOT/f['relative_path'])==f['sha256'],f['relative_path']
for c in report['checks']:
    assert c['exit_code']==0 and p.sha(origin/c['raw_log'])==c['raw_log_sha256']
target.mkdir(exist_ok=True)
for name in ['CHECK_REPORT.json']+[c['raw_log'] for c in report['checks']]:
    src=origin/name;dst=target/name
    if dst.exists():assert dst.read_bytes()==src.read_bytes(),name
    else:shutil.copyfile(src,dst)
reuse=target/'SHARED_REUSE.json'
if not reuse.exists():
    p.dump(reuse,dict(reused_at=datetime.now().isoformat(),origin=x.reuse_shared,
        report_sha256=p.sha(origin/'CHECK_REPORT.json'),frozen_input_files=len(report['inputs']),
        validation='all current input bytes and original raw log hashes checked',
        scope='shared formal-library and frozen Ch01/02 checks only; current chapter checked separately',
        native_rerun=False))
source=ROOT/f'Blueprint/Ch{x.chapter:02}.lean'
if x.chapter!=6 or x.native_build:
    receipt,output,reused=compile_recorded(['lake','build',f'+Blueprint.Ch{x.chapter:02}'],ROOT,source,
        target/'chapter_build.log',target/'chapter_build.compile.json',reuse_failure=True)
    assert receipt['exit_code']==0,output.decode('utf-8',errors='replace')[-5000:]
    print('Current chapter build passed; shared checks reused with unchanged input hashes.',flush=True)
if x.chapter==6:
    # A current batch probe already typechecks the entire canonical source and
    # prints every axiom in that same native run. Reuse its exact bytes/logs;
    # never relabel this as a new native fresh check.
    candidates=[]
    for binding in (p.BASE/'validation/batch_axioms').glob('*-binding.json'):
        b=json.loads(binding.read_text(encoding='utf-8'))
        if b['canonical_sha256']==p.sha(source) and b['audit_source_sha256']==p.sha(p.BASE/'CheckAxioms.lean'):
            candidates.append((binding,b))
    assert candidates,'No current complete batch proof/axiom evidence'
    binding,b=max(candidates,key=lambda q:q[0].stat().st_mtime)
    probe=binding.with_name(binding.name.replace('-binding.json','.lean'))
    receipt_path=probe.with_suffix('.json');raw=probe.with_suffix('.log')
    rr=json.loads(receipt_path.read_text(encoding='utf-8'))
    assert rr['exit_code']==0 and rr['input_sha256']==p.sha(probe)==b['combined_source_sha256']
    assert p.sha(receipt_path)==b['receipt_sha256'] and rr['log_sha256']==p.sha(raw)
    expected=source.read_text(encoding='utf-8')+'\n'+(p.BASE/'CheckAxioms.lean').read_text(encoding='utf-8').partition('\n')[2]
    assert probe.read_text(encoding='utf-8')==expected
    (target/'chapter_axioms.log').write_bytes(raw.read_bytes())
    paths=['Blueprint/Ch06.lean','blueprint/ch06/CheckAxioms.lean','lakefile.toml','lean-toolchain','lake-manifest.json','scripts/local_chapter_check.ps1']
    p.dump(target/'LOCAL_CHECK_REPORT.json',dict(chapter=6,machine_check_status='passed',
        shared_check_sha256=p.sha(target/'CHECK_REPORT.json'),
        inputs=[dict(relative_path=q,sha256=p.sha(ROOT/q)) for q in paths],
        checks=[dict(name='chapter_fresh_and_axioms_reused',exit_code=0,raw_log='chapter_axioms.log',raw_log_sha256=p.sha(raw),
            original_receipt=receipt_path.relative_to(ROOT).as_posix(),original_receipt_sha256=p.sha(receipt_path),
            original_command=rr['command'],reuse_basis='entire current canonical source plus all current axiom commands; exact source and log hashes checked',native_rerun=False)],
        current_chapter_build_receipt_sha256=p.sha(target/'chapter_build.compile.json') if (target/'chapter_build.compile.json').exists() else None,
        native_build_rerun=x.native_build,
        section_acceptance='All shared full-check components reused by exact current hashes; changed chapter checked by complete native single-file plus every declaration axiom command. No second elaboration of identical chapter source.'))
    print('Section complete with verified batch check reuse:',x.report,flush=True)
    raise SystemExit(0)
subprocess.run(['pwsh','-NoProfile','-File',str(ROOT/'scripts/local_chapter_check.ps1'),
    '-Chapter',str(x.chapter),'-ReportDirectory',str(target)],cwd=ROOT,check=True)
assert p.sha(source)==receipt['input_sha256']
print('Section complete:',x.report,flush=True)

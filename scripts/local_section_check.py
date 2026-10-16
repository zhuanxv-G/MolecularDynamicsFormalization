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
receipt,output,reused=compile_recorded(['lake','build',f'+Blueprint.Ch{x.chapter:02}'],ROOT,source,
    target/'chapter_build.log',target/'chapter_build.compile.json',reuse_failure=True)
assert receipt['exit_code']==0,output.decode('utf-8',errors='replace')[-5000:]
print('Current chapter build passed; shared checks reused with unchanged input hashes.',flush=True)
subprocess.run(['pwsh','-NoProfile','-File',str(ROOT/'scripts/local_chapter_check.ps1'),
    '-Chapter',str(x.chapter),'-ReportDirectory',str(target)],cwd=ROOT,check=True)
assert p.sha(source)==receipt['input_sha256']
print('Section complete:',x.report,flush=True)

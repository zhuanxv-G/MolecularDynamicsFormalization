"""Resume an interrupted paused-Ch06 chapter check without discarding evidence."""
import json,shutil,subprocess
from datetime import datetime
from pathlib import Path
from integrate_website_returns import ROOT,read,dump,sha
from local_compile import compile_recorded

def resume(ch,round_name=None):
    assert round_name is None or round_name=='CINFTY'
    folder=ROOT/(f'blueprint/ch{ch:02}/validation/WEBSITE_REPAIR_CHAPTER_END'+('_'+round_name if round_name else '')+'/full-check')
    path=folder/'CHECK_REPORT.json';report=read(path)
    assert report['machine_check_status']=='running' and report['paused_chapter06']
    assert report['source_scan']=='passed' and report['blueprint_scan'] in ('passed','draft_with_placeholders')
    inputs={x['relative_path'].replace('\\','/'):x['sha256'] for x in report['inputs']}
    blueprint_inputs={f'Blueprint/Ch{k:02}.lean':sha(ROOT/f'Blueprint/Ch{k:02}.lean') for k in range(1,6)}
    def validate():
        for name,digest in inputs.items():assert sha(ROOT/name)==digest,('Changed check input',name)
        for name,digest in blueprint_inputs.items():assert sha(ROOT/name)==digest,('Changed active Blueprint',name)
    validate()
    original=folder/'INTERRUPTED_CHECK_REPORT.json'
    if not original.exists():shutil.copyfile(path,original)
    for check in report['checks']:
        assert check['exit_code']==0
        assert sha(folder/check['raw_log'])==check['raw_log_sha256']
    required=['git_branch','git_head','git_status','lake_version','lean_version','mathlib_revision','mathlib_status',
      'lake_build','scratch','axiom_dependencies','blueprint_fresh_Ch01','blueprint_fresh_Ch02',
      'blueprint_axiom_dependencies','chapter02_axiom_dependencies']
    commands={
      'lake_build':['build','MolecularDynamicsFormalization']+[f'+Blueprint.Ch{k:02}' for k in range(1,6)],
      'scratch':['env','lean','Scratch.lean'],
      'axiom_dependencies':['env','lean','scripts/CheckAxioms.lean'],
      'blueprint_fresh_Ch01':['env','lean','Blueprint\\Ch01.lean'],
      'blueprint_fresh_Ch02':['env','lean','Blueprint\\Ch02.lean'],
      'blueprint_axiom_dependencies':['env','lean',str(ROOT/'blueprint/ch01/CheckAxioms.lean')],
      'chapter02_axiom_dependencies':['env','lean',str(ROOT/'blueprint/ch02/CheckAxioms.lean')]}
    completed={c['name'] for c in report['checks']}
    assert set(required)-completed<=set(commands)
    signature=folder/'RESUME_INPUTS.json';dump(signature,dict(inputs=inputs,blueprint_inputs=blueprint_inputs,paused_chapter06=True))
    for name in required:
        if name in completed:continue
        reused=False;args=commands[name]
        earlier_reports=[ROOT/f'blueprint/ch{k:02}/validation/WEBSITE_REPAIR_CHAPTER_END{suffix}/full-check/CHECK_REPORT.json' for k in (2,3) for suffix in ('_CINFTY','')]
        for other in earlier_reports:
            # Build depends on every active Blueprint, while the original full
            # report's input inventory contains only Ch01/02. Never reuse an
            # old build as evidence for a changed Ch03/04/05.
            if name not in ('blueprint_fresh_Ch01','blueprint_fresh_Ch02','blueprint_axiom_dependencies','chapter02_axiom_dependencies','axiom_dependencies','scratch'):break
            if other==path:continue
            if not other.exists():continue
            prior=read(other)
            if prior['machine_check_status']!='passed' or not prior.get('paused_chapter06'):continue
            prior_inputs={x['relative_path'].replace('\\','/'):x['sha256'] for x in prior['inputs']}
            if prior_inputs!=inputs:continue
            check=next((c for c in prior['checks'] if c['name']==name and c['exit_code']==0 and
              [a.replace('\\','/') for a in c['arguments']]==[a.replace('\\','/') for a in args]),None)
            if not check:continue
            log=other.parent/check['raw_log']
            assert sha(log)==check['raw_log_sha256']
            shutil.copyfile(log,folder/f'{name}.log')
            item=dict(check,reused_from=other.relative_to(ROOT).as_posix(),
              reused_report_sha256=sha(other),reuse_rule='entire recorded input inventory byte-identical; exact command and successful log hash verified')
            report['checks'].append(item);reused=True;print('REUSED',name,flush=True);break
        if not reused:
            record,output,_=compile_recorded(['lake']+args,ROOT,signature,folder/f'{name}.log',folder/f'{name}-RESUME.json')
            assert record['exit_code']==0,output.decode('utf-8',errors='replace')
            report['checks'].append(dict(name=name,executable=shutil.which('lake'),arguments=args,cwd=str(ROOT),
              exit_code=0,raw_log=f'{name}.log',raw_log_sha256=sha(folder/f'{name}.log'),resumed=True))
            print('PASSED',name,flush=True)
        dump(path,report)
    validate();assert set(required)=={c['name'] for c in report['checks']}
    report.update(machine_check_status='passed',exit_code=0,finished_at=datetime.now().astimezone().isoformat(),
      resumed_from=original.relative_to(ROOT).as_posix(),resumed_original_sha256=sha(original),
      resumed_blueprint_inputs=blueprint_inputs,
      resume_note='Interrupted original run retained; completed phases reused only with identical full input inventory, command, and log hashes; missing phases checked.')
    dump(path,report);print('RESUMED_FULL_CHECK_PASSED',ch,flush=True)

if __name__=='__main__':
    import sys
    resume(int(sys.argv[1]),sys.argv[2] if len(sys.argv)>2 else None)

"""Reuse the accepted Chapter 2 pipeline as a read-only template for Chapters 3–6.

Never modify/run the Chapter 1 or Chapter 2 generators. Each instantiated module
has its own source records and output directory; page offsets are chapter-local.
"""
from pathlib import Path
import sys,types,re,json,hashlib,argparse,subprocess
ROOT=Path(__file__).resolve().parents[1]
RANGES={3:(97,136,119,158),4:(139,174,161,196),5:(179,209,200,230),6:(211,258,232,279)}
def pipeline(ch):
    assert ch in RANGES
    template=(ROOT/'scripts/ch02_pipeline.py').read_text(encoding='utf-8')
    text=template.replace('ch02',f'ch{ch:02}').replace('Ch02',f'Ch{ch:02}')
    text=text.replace('Chapter 2',f'Chapter {ch}').replace('第2章',f'第{ch}章')
    text=text.replace('160',str(len(__import__(f'ch{ch:02}_data').OLD_ROWS)))
    lo,hi,p0,p1=RANGES[ch];off=p0-lo
    text=text.replace('75<=p<=116',f'{p0}<=p<={p1}').replace('p-22',f'p-{off}')
    text=text.replace('53–94/PDF75–116',f'{lo}–{hi}/PDF{p0}–{p1}')
    text=text.replace('第1、2章均等待用户提交MathCopilot批次',f'第{ch}章等待用户提交MathCopilot批次；继续下一章本地流程')
    text=text.replace('namespace MD.Ch'+f'{ch:02}'+'；open',f'namespace MD.Ch{ch:02}；open')
    text=text.replace('import MolecularDynamics.Chapter02.ReviewProofs',
        f'import MolecularDynamics.Chapter{ch:02}.ReviewProofs\nimport MolecularDynamics.Chapter02.ReviewProofs',1)
    text=text.replace('open Set Filter Matrix MeasureTheory MolecularDynamics MolecularDynamics.Chapter02Review',
        f'open Set Filter Matrix MeasureTheory MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter{ch:02}Review')
    text=text.replace('variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]',
        'variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]\nvariable {R : Type*} [Ring R] [Algebra ℝ R]',1)
    text=text.replace('[NormedSpace ℝ E]。', '[NormedSpace ℝ E]；variable {R : Type*} [Ring R] [Algebra ℝ R]。')
    text=text.replace('MolecularDynamics.Chapter02Review；', f'MolecularDynamics.Chapter02Review MolecularDynamics.Chapter{ch:02}Review；')
    text=text.replace('a.update(checked=False,axioms=[]', 'a.update(checked=False,compiled=False,axioms=[]')
    text=text.replace("'已编译' if a['checked'] else '待编译'", "'已编译/公理已核' if a['checked'] else ('已编译/待公理' if a.get('compiled') else '待编译')")
    # The user's byte cap includes all three files, including the manifest.
    text=text.replace("dump(folder/'MANIFEST.json',report);subtasks.append", """dump(folder/'MANIFEST.json',report)
            for _ in range(3):
                report['total_task_bytes']=size+(folder/'MANIFEST.json').stat().st_size
                dump(folder/'MANIFEST.json',report)
            total_bytes=sum(f.stat().st_size for f in folder.iterdir() if f.is_file())
            assert total_bytes<256000,(task,total_bytes)
            subtasks.append""")
    text=text.replace('bytes=size,manifest_sha256=', 'bytes=total_bytes,manifest_sha256=')
    text=text.replace('compact子任务（输入+PDF字节）', 'compact子任务（PASTE+PDF+MANIFEST字节）')
    # Per-module source scope never includes Ch01 or prior chapter output writes.
    m=types.ModuleType('local_current_pipeline');m.__file__=str(ROOT/'scripts/local_blueprint.py')
    sys.modules[m.__name__]=m;exec(compile(text,m.__file__,'exec'),m.__dict__)
    return m
def render(ch,p):
    source=(ROOT/'scripts/render_ch02_blueprint.py').read_text(encoding='utf-8')
    source=source.replace('ch02_pipeline','local_current_pipeline').replace('ch02',f'ch{ch:02}').replace('Ch02',f'Ch{ch:02}')
    source=source.replace('第2章',f'第{ch}章').replace('Chapter 2',f'Chapter {ch}')
    source=source.replace('53–94',f'{RANGES[ch][0]}–{RANGES[ch][1]}')
    m=types.ModuleType('local_current_renderer');m.__file__=str(ROOT/'scripts/local_blueprint.py')
    sys.modules[m.__name__]=m;exec(compile(source,m.__file__,'exec'),m.__dict__)
    out=ROOT/f'docs/review/CH{ch:02}_BLUEPRINT.zh-CN.md'
    out.write_text(m.render(p.BASE/f'ch{ch:02}_source.json',ROOT/f'Blueprint/Ch{ch:02}.lean',p.BASE/'local_audit.json'),encoding='utf-8')
def landing(ch,p,batch,step):
    table=ROOT/'docs/handoff/LOCAL_PIPELINE.md';s=table.read_text(encoding='utf-8')
    row=f'| {ch} | {RANGES[ch][0]}–{RANGES[ch][1]} / {RANGES[ch][2]}–{RANGES[ch][3]} | chapter{ch:02}-blueprint | {step}；批{batch}落盘（{len(p.RECORDS)}条） | '
    old=next(x for x in s.splitlines() if x.startswith(f'| {ch} |'))
    checkpoint=old.split('|')[-3].strip()
    s=s.replace(old,row+checkpoint+' | 未完成 |');table.write_text(s,encoding='utf-8')
    state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';lines=state.read_text(encoding='utf-8').splitlines()
    lines[3]=f'下一步：第{ch}章{step}；已落盘{len(p.RECORDS)}条，批{batch}；从blueprint/ch{ch:02}/PROGRESS.md读取缺项和现有编译结果继续。'
    for i,x in enumerate(lines[:20]):
        if x.startswith('跨章唯一总进度：'):lines[i]=f'跨章唯一总进度：docs/handoff/LOCAL_PIPELINE.md；当前章逐条进度：blueprint/ch{ch:02}/PROGRESS.md。'
    state.write_text('\n'.join(lines)+'\n',encoding='utf-8')
def compile_batch(ch,p,batch):
    folder=p.BASE/'validation';folder.mkdir(exist_ok=True)
    log=folder/f'batch{batch}-lean.log';evidence=folder/f'batch{batch}-COMPILE.json'
    input_sha=p.sha(ROOT/f'Blueprint/Ch{ch:02}.lean')
    previous=json.loads(evidence.read_text(encoding='utf-8')) if evidence.exists() else {}
    if previous.get('exit_code')==0 and previous.get('input_sha256')==input_sha and log.exists() and previous.get('log_sha256')==p.sha(log):
        print('Reused passed single-file evidence:',batch)
    else:
        command=['lake','env','lean',f'Blueprint/Ch{ch:02}.lean']
        result=subprocess.run(command,cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
        log.write_bytes(result.stdout)
        p.dump(evidence,dict(command=command,exit_code=result.returncode,input_sha256=input_sha,log_sha256=p.sha(log),decl_blocks={sid:d['block_sha256'] for sid,d in p.declarations().items()}))
        if result.returncode:
            print(result.stdout.decode('utf-8',errors='replace').encode(sys.stdout.encoding,errors='replace').decode(sys.stdout.encoding));raise SystemExit(result.returncode)
        print('Single-file Lean passed:',batch)
    audit=json.loads((p.BASE/'local_audit.json').read_text(encoding='utf-8'))
    for item in audit['items'].values():item.update(compiled=True,compile_evidence=evidence.relative_to(ROOT).as_posix())
    p.dump(p.BASE/'local_audit.json',audit)
def main():
    a=argparse.ArgumentParser();a.add_argument('chapter',type=int);a.add_argument('--checked');a.add_argument('--compile',action='store_true');a.add_argument('--batch',default='01');a.add_argument('--step',default='①–④当前节');args=a.parse_args()
    p=pipeline(args.chapter)
    if args.checked:p.checked(ROOT/args.checked)
    p.generate();render(args.chapter,p);landing(args.chapter,p,args.batch,args.step)
    if args.compile:
        compile_batch(args.chapter,p,args.batch)
        p.generate();render(args.chapter,p);landing(args.chapter,p,args.batch,args.step)
if __name__=='__main__':main()

"""Chapter-end acceptance, once after all repair batches, excluding paused Ch06."""
import re,subprocess
from datetime import datetime
from integrate_website_returns import ROOT,read,dump,sha
from eaudit_review_tasks import declarations,render_document
from local_compile import compile_recorded
from repair_queue import render
from local_stage import stage

def finish(ch):
    base=ROOT/f'blueprint/ch{ch:02}';web=read(base/'website_audit.json')
    assert all(w.get('repair',{}).get('status') in ('awaiting_reaudit','awaiting_mentor') or
      (w['returned_audit']['verdict']=='PASS' and w['binding']['bound']) for w in web)
    assert all(w['json_review']['status']!='CORRECTED' or w.get('repair',{}).get('json_review_locally_verified') for w in web)
    receipt=base/'validation/WEBSITE_REPAIR_CHAPTER_ACCEPTANCE.json';assert not receipt.exists(),'Reuse chapter acceptance; do not rerun'
    folder=base/'validation/WEBSITE_REPAIR_CHAPTER_END';folder.mkdir(parents=True,exist_ok=True)
    ds=declarations(ch);names=[];groups={}
    for sid,d in ds.items():
        groups[sid]=[f'MD.Ch{ch:02}.'+n for n in re.findall(r'(?m)^(?:noncomputable\s+)?(?:theorem|def)\s+(\w+)',d['block'])]
        names+=groups[sid]
    assert len(names)==len(set(names))
    ap=folder/'CheckAxioms.lean';ap.write_text(f'import Blueprint.Ch{ch:02}\n'+'\n'.join('#print axioms '+n for n in names)+'\n',encoding='utf-8')
    r,out,_=compile_recorded(['lake','env','lean',ap.relative_to(ROOT).as_posix()],ROOT,ap,folder/'axioms.log',folder/'AXIOMS.json')
    assert r['exit_code']==0,out.decode('utf-8',errors='replace')
    parsed={}
    for n in names:
        m=re.search("'"+re.escape(n)+r"' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)",out.decode('utf-8'));assert m,n
        parsed[n]=[x.strip() for x in (m.group(1) or '').split(',') if x.strip()]
    dump(folder/'AXIOM_DECLARATIONS.json',parsed)
    audit=read(base/'local_audit.json')
    for sid,d in ds.items():
        a=audit['items'][sid];axioms=sorted({x for n in groups[sid] for x in parsed[n]})
        a.update(signature_sha256=d['signature_sha256'],block_sha256=d['block_sha256'],compiled=True,checked=True,axioms=axioms,
          axiom_log=(folder/'axioms.log').relative_to(ROOT).as_posix(),direct_placeholder='sorry' in d['block'],
          transitive_placeholder='sorryAx' in axioms and 'sorry' not in d['block'])
        a['final_status']='incomplete' if 'sorryAx' in axioms or a['direct_placeholder'] else ('checked+documented priors' if a.get('documented_priors') else 'self-contained')
    dump(base/'local_audit.json',audit)
    (ROOT/f'docs/review/CH{ch:02}_BLUEPRINT.zh-CN.md').write_text(render_document(ch),encoding='utf-8')
    report=folder/'full-check'
    if not (report/'CHECK_REPORT.json').exists():
        with (folder/'full-check-driver.log').open('wb') as log:
            p=subprocess.run(['pwsh','-NoProfile','-File','scripts/check.ps1','-ReportDirectory',str(report),'-PauseChapter06'],cwd=ROOT,stdout=log,stderr=subprocess.STDOUT)
        assert p.returncode==0,'Chapter full check failed; inspect saved report'
    full=read(report/'CHECK_REPORT.json');assert full['machine_check_status']=='passed' and full['paused_chapter06']
    from website_repair_delivery import refresh
    deliveries=refresh(ch)
    web=read(base/'website_audit.json')
    dump(receipt,dict(chapter=ch,time=datetime.now().isoformat(),lean_sha256=sha(ROOT/f'Blueprint/Ch{ch:02}.lean'),
      source_sha256=sha(base/f'ch{ch:02}_source.json'),axiom_decl_count=len(names),full_check_report=str(report.relative_to(ROOT)/'CHECK_REPORT.json'),
      full_check_report_sha256=sha(report/'CHECK_REPORT.json'),chapter06='paused, Blueprint.Ch06 not compiled; batch27 unverified',website='awaiting user submission',new_proofs='none'))
    counts=render()[ch];dump(base/'WEBSITE_SUMMARY.json',dict(chapter=ch,total=len(web),**dict(counts)))
    active={w.get('repair',{}).get('eaudit') for w in web if w.get('repair',{}).get('status')=='awaiting_reaudit'}
    index=base/'mathcopilot_tasks/EAUDIT_INDEX.md';lines=['# EAUDIT 待提交包','', '只提交以下现行包；旧EAUDIT保留历史，不重复提交。','']
    for p in sorted((base/'mathcopilot_tasks').glob('EAUDIT*/INDEX.md')):
        if p.parent.name in active:lines.append(f'- [{p.parent.name}]({p.parent.name}/INDEX.md)')
    index.write_text('\n'.join(lines)+'\n',encoding='utf-8')
    state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';text=state.read_text(encoding='utf-8')
    text=re.sub(r'^下一步：.*$',f'下一步：第{ch}章本轮已修/分流完成且章末完整检查通过；按队列继续第{ch+1}章。网站复审未提交。',text,count=1,flags=re.M)
    state.write_text(text,encoding='utf-8')
    work=ROOT/'docs/handoff/WORK_LOG.zh-CN.md';work.write_text(work.read_text(encoding='utf-8')+f'\n## {datetime.now().date()} 第{ch}章网站修复章末验收\n全章{len(ds)}条/{len(names)}项公理、固定版本完整check通过；已修条目待用户提交EAUDIT，导师问题保持原签名；未写新证明。\n第6章未编译，batch27仍未验证；下一章按REPAIR_QUEUE接续。\n',encoding='utf-8')
    stage([f'blueprint/ch{ch:02}/validation/WEBSITE_REPAIR_CHAPTER_END',str(receipt.relative_to(ROOT)).replace('\\','/'),
      f'blueprint/ch{ch:02}/local_audit.json',f'blueprint/ch{ch:02}/WEBSITE_SUMMARY.json',f'blueprint/ch{ch:02}/mathcopilot_tasks/EAUDIT_INDEX.md',
      f'docs/review/CH{ch:02}_BLUEPRINT.zh-CN.md','docs/handoff/REPAIR_QUEUE.md','docs/handoff/CURRENT_STATE.zh-CN.md',
      'docs/handoff/WORK_LOG.zh-CN.md','scripts/check.ps1','scripts/website_repair_finish.py','scripts/repair_queue.py',
      'AGENTS.md','scripts/website_repair_delivery.py',f'blueprint/ch{ch:02}/website_audit.json',f'blueprint/ch{ch:02}/EAUDIT_REGISTRY.json']+
      [p for e in deliveries for p in (f'blueprint/ch{ch:02}/validation/{e}',f'blueprint/ch{ch:02}/mathcopilot_tasks/{e}')])
    subprocess.run(['git','commit','-m',f'ch{ch:02}: accept website repairs after chapter full check; Ch06 remains paused'],cwd=ROOT,check=True)
    subprocess.run(['git','push'],cwd=ROOT,check=True)
    print('CHAPTER_ACCEPTED',ch,dict(counts),flush=True)

if __name__=='__main__':
    import sys
    finish(int(sys.argv[1]))

"""Validate and commit the first repaired section without touching Ch06 work."""
import json
import re
import subprocess
from pathlib import Path
from datetime import datetime
from integrate_website_returns import ROOT, sha, read, dump, integrate
from ch01_full_tools import declarations, mark_checked
from render_blueprint import render
from refresh_website_baseline import refresh
from local_stage import stage

BASE=ROOT/'blueprint/ch01'
TASK=BASE/'mathcopilot_tasks/EAUDIT02'
REPORT=BASE/'validation/EAUDIT02-full'
TARGETS={'MD-1.1-NewtonModel','MD-1.1-HardSphere'}


def finalize():
    full=read(REPORT/'CHECK_REPORT.json')
    assert full['machine_check_status']=='passed'
    for row in full['inputs']:assert sha(ROOT/row['relative_path'])==row['sha256'],row['relative_path']
    for row in full['checks']:
        assert row['exit_code']==0 and sha(REPORT/row['raw_log'])==row['raw_log_sha256'],row['name']
    single=read(BASE/'validation/EAUDIT02/FINAL_COMPILE.json')
    assert single['exit_code']==0 and single['input_sha256']==sha(ROOT/'Blueprint/Ch01.lean')
    assert single['log_sha256']==sha(BASE/'validation/EAUDIT02/final-single-lean.log')
    prep=read(BASE/'mathcopilot_results/EAUDIT02_PREPARATION.json')
    assert prep['lean_sha256']==sha(ROOT/'Blueprint/Ch01.lean')
    assert prep['source_sha256']==sha(BASE/'ch01_source.json')
    binding_receipt=read(BASE/'mathcopilot_results/binding20261013/RECEIPT.json')
    for path,digest in binding_receipt['raw_files'].items():assert sha(ROOT/path)==digest
    historical=next(iter(binding_receipt['bindings'].values()))['registration_commit']
    old_source=json.loads(subprocess.check_output(['git','show',historical+':blueprint/ch01/ch01_source.json'],cwd=ROOT).decode('utf-8-sig'))
    current_source=read(BASE/'ch01_source.json')
    assert all(a==b for a,b in zip(old_source,current_source) if a['source_id'] not in prep['source_ids'])
    # Every old batch stays the actual bound historical input, even though Lean changed.
    manifest=read(BASE/'mathcopilot_tasks/MANIFEST.json')
    for m in manifest:assert sha(BASE/'mathcopilot_tasks'/(m['batch']+'.md'))==m['task_sha256']
    task_manifest=read(TASK/'MANIFEST.json')
    for key,digest in task_manifest['input_sha256'].items():
        path=TASK/key if key=='BATCH_EAUDIT02.md' else ROOT/key
        assert sha(path)==digest,key
    for sub in task_manifest['subtasks']:
        folder=ROOT/sub['path'];mp=folder/'MANIFEST.json';m=read(mp)
        assert sha(mp)==sub['manifest_sha256']
        assert sha(folder/'PASTE.txt')==m['paste_sha256']
        total=sum(p.stat().st_size for p in folder.iterdir() if p.is_file())
        assert total==m['total_task_bytes']==sub['total_bytes'] and total<256000
        assert m['crop_pixel_identity']=='PASS'
        assert m['expected_output']=='/workspace/.mathcopilot/reviews/ch01_eaudit/EAUDIT02_review.json'
        assert 'input_sha256' in (folder/'PASTE.txt').read_text(encoding='utf-8')
        for e in m['dependency_excerpts']:assert sha(ROOT/e['path'])==e['file_sha256'],e['path']
    audit=read(BASE/'local_audit.json');ds=declarations();changes=[]
    for sid,a in audit['items'].items():
        if sid in TARGETS:
            changes.append(dict(source_id=sid,old_signature_sha256=a['signature_sha256'],new_signature_sha256=ds[sid]['signature_sha256']))
            a.update(verdict='PASS',signature_sha256=ds[sid]['signature_sha256'],proof_status='definition',missing=None,
                explanation=('EAUDIT02本地预审：精确三维粒子质量重复，初始时刻在开放连通域内；势能沿轨迹可微并保留真实二阶时间导数和两类初值。'
                    if sid.endswith('NewtonModel') else
                    'EAUDIT02本地预审：全时间全粒子对不可穿透；局部孤立碰撞、位置连续、碰撞外真实自由运动，速度实际左右极限接入二体法向冲量、反转、分离及动量/能量守恒。无摩擦孤立二体范围[EXTRA]已披露，网站仍待复审，不声明解存在。'))
            extra=dict(source='网站FAIL指出的缺失资格与动力学',lean=ds[sid]['name']+'及EAUDIT02辅助定义',note='修复；所有新技术范围明确[EXTRA]，原文未弱化，网站复审未验证')
            if extra not in a['correspondence']:a['correspondence'].append(extra)
        else:
            assert a['signature_sha256']==ds[sid]['signature_sha256'],sid
    dump(BASE/'local_audit.json',audit)
    mark_checked(REPORT/'blueprint_axiom_dependencies.log')
    for ch in (1,3,2):integrate(ch)
    audit=read(BASE/'local_audit.json')
    assert all(a['checked'] for a in audit['items'].values())
    assert all(a['final_status']=='incomplete' for a in audit['items'].values() if 'sorryAx' in a['axioms'])
    doc=ROOT/'docs/review/CH01_BLUEPRINT.zh-CN.md'
    doc.write_text(render(BASE/'ch01_source.json',ROOT/'Blueprint/Ch01.lean',BASE/'local_audit.json'),encoding='utf-8')
    checked=dict(eaudit='EAUDIT02',section='1.1',source_ids=prep['source_ids'],signature_changes=changes,
                 single_compile='blueprint/ch01/validation/EAUDIT02/FINAL_COMPILE.json',
                 full_check='blueprint/ch01/validation/EAUDIT02-full/CHECK_REPORT.json',
                 full_check_sha256=sha(REPORT/'CHECK_REPORT.json'),axiom_count=len(audit['items']),
                 sorry_policy='existing placeholders unchanged; sorryAx means incomplete',
                 raw_returns_intact=True,historical_batch_hashes_intact=True,
                 compact_bytes=[s['total_bytes'] for s in task_manifest['subtasks']],
                 source_pages_verified=[28,29,30],website_reaudit='pending',
                 lean_sha256=sha(ROOT/'Blueprint/Ch01.lean'),source_sha256=sha(BASE/'ch01_source.json'))
    dump(BASE/'validation/EAUDIT02/ACCEPTANCE.json',checked)
    registry=BASE/'EAUDIT_REGISTRY.json'
    entries=read(registry) if registry.exists() else []
    if not any(e['eaudit']=='EAUDIT02' for e in entries):entries.append(checked)
    dump(registry,entries)
    (BASE/'EAUDIT.md').write_text('# 网站签名修复复审登记\n\nEAUDIT01为历史试点五条，原始收据及任务保持。\n\nEAUDIT02：§1.1两个FAIL签名已修，Schrodinger材料缺失已补；PDF28–30、单文件、全工程及141条公理检查通过，三份compact实际字节和裁页一致性通过。网站复审未提交；导师问题未裁定。详见EAUDIT_REGISTRY.json及mathcopilot_tasks/EAUDIT02/INDEX.md。\n',encoding='utf-8')
    index=BASE/'mathcopilot_tasks/INDEX.md';text=index.read_text(encoding='utf-8')
    if '## EAUDIT02' not in text:
        text+='\n## EAUDIT02：§1.1首批网站修复\n\n[三份compact及输出文件要求](EAUDIT02/INDEX.md)。本次修复优先提交此版本；BATCH02保留作历史绑定输入，不代表新签名已经网站PASS。\n'
        index.write_text(text,encoding='utf-8')
    progress=BASE/'PROGRESS.md';lines=progress.read_text(encoding='utf-8').splitlines()
    lines=[x.replace('网站返回141（版本绑定待验）','网站返回141（136已绑定，旧试点5条待EAUDIT01）') for x in lines]
    for i,line in enumerate(lines):
        if line.startswith('| MD-'):
            cells=line.split('|');sid=cells[1].strip()
            if sid in prep['source_ids']:cells[3]=' 陈述已写；已编译/公理已核 ';lines[i]='|'.join(cells)
    if '## 2026-10-13 EAUDIT02检查点' not in lines:
        lines+=['','## 2026-10-13 EAUDIT02检查点','','§1.1两个FAIL修签名及Schrodinger补材料完成；原页、本地预审、最终单文件、完整check和141条公理通过；三份compact最大113282字节，网站复审待提交。其余CORRECTED未重新核页，不自动合并；导师未裁定。']
    progress.write_text('\n'.join(lines)+'\n',encoding='utf-8')
    state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';lines=state.read_text(encoding='utf-8').splitlines()
    lines[3]='下一步：回第6章§6.2，复用已落盘96条/批18及短证明证据，完成本节检查提交后处理第1章§1.1.1下一批网站修复；第1→3→2章修复顺序不变。'
    for ch in (1,3,2):
        d=read(ROOT/f'blueprint/ch{ch:02}/WEBSITE_SUMMARY.json')
        row=f'第{ch}章：网站PASS {d["website_pass"]} / 修复中 {d["repairing"]} / 待导师 {d["awaiting_mentor"]} / 待复审 {d["awaiting_reaudit"]}。'
        lines=[row if x.startswith(f'第{ch}章：网站PASS ') else x for x in lines]
    note='第1章EAUDIT02：§1.1两条FAIL签名已修、Schrodinger补材料；PDF28–30/单文件/完整check/141条公理/compact字节及裁页均已验；网站复审待提交。'
    if note not in lines:lines.insert(9,note)
    state.write_text('\n'.join(lines)+'\n',encoding='utf-8')
    next_line=lines[3]
    for p in (ROOT/'AGENTS.md',ROOT/'docs/handoff/RESUME_PROMPT.zh-CN.md'):
        content=p.read_text(encoding='utf-8').splitlines()
        i=next(i for i,x in enumerate(content[:9]) if x.startswith('下一步：'));content[i]=next_line
        p.write_text('\n'.join(content)+'\n',encoding='utf-8')
    table=ROOT/'docs/handoff/LOCAL_PIPELINE.md';content=table.read_text(encoding='utf-8')
    note='网站修复检查点：第1章§1.1 EAUDIT02已本地检验并生成3份复审包；回第6章§6.2，完成该节后处理第1章下一批。网站计数见CURRENT_STATE及各章WEBSITE_SUMMARY。'
    if note not in content:content+='\n'+note+'\n';table.write_text(content,encoding='utf-8')
    log=ROOT/'docs/handoff/WORK_LOG.zh-CN.md';text=log.read_text(encoding='utf-8')
    if '## 2026-10-13 第1章：§1.1网站修复EAUDIT02' not in text:
        with log.open('a',encoding='utf-8') as f:f.write('\n## 2026-10-13 第1章：§1.1网站修复EAUDIT02\nNewton/HardSphere签名修复、原页两项CORRECTED核对合并（其中Newton补漏词），Schrodinger补定义；单文件/完整check/141条公理/3份compact字节与裁页通过。\n下一步：回第6章§6.2（96条/批18），节提交后继续第1章§1.1.1网站修复；EAUDIT02待网站复审，导师问题未裁定，heartbeat不变。\n')
    paths=['Blueprint/Ch01.lean']
    for ch in (1,2,3):
        for name in ('PROGRESS.md','local_audit.json','website_audit.json','NEEDS_HUMAN.md','WEBSITE_SUMMARY.json','SOURCE_REVIEW_QUEUE.json'):
            paths.append(f'blueprint/ch{ch:02}/{name}')
    paths+=['blueprint/ch01/ch01_source.json','blueprint/ch01/EAUDIT.md','blueprint/ch01/EAUDIT_REGISTRY.json','blueprint/ch01/mathcopilot_tasks/INDEX.md',
            'docs/review/CH01_BLUEPRINT.zh-CN.md','blueprint/ch01/mathcopilot_results/EAUDIT02_PREPARATION.json',
            'blueprint/ch02/mathcopilot_results/binding20261013/A_BINDING.json']
    for folder in (TASK,BASE/'validation/EAUDIT02',REPORT):paths.extend(p.relative_to(ROOT).as_posix() for p in folder.rglob('*') if p.is_file())
    refresh('blueprint/ch01/validation/EAUDIT02/ACCEPTANCE.json',paths)
    paths+=['AGENTS.md','docs/handoff/RESUME_PROMPT.zh-CN.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/LOCAL_PIPELINE.md','docs/handoff/WORK_LOG.zh-CN.md',
            'scripts/integrate_website_returns.py','scripts/prepare_ch01_eaudit02.py','scripts/finalize_ch01_eaudit02.py','blueprint/ch06/BASELINE.json']
    stage(paths,allow_ch01_return=True)
    staged=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
    assert not any(p.startswith(('Blueprint/Ch06.lean','blueprint/ch06/')) and p!='blueprint/ch06/BASELINE.json' for p in staged)
    subprocess.run(['git','commit','-m','ch01 sec1.1: repair website FAIL models and prepare bound EAUDIT02'],cwd=ROOT,check=True)
    subprocess.run(['git','push'],cwd=ROOT,check=True)
    print('EAUDIT02: full checks and fixed inputs verified; section committed and pushed; website re-audit pending.')


if __name__=='__main__':finalize()

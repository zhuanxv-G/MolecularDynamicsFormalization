"""Refresh final-snapshot packets, preserving all earlier packages and checks."""
import re
import subprocess
from datetime import datetime
from integrate_website_returns import ROOT,read,dump,sha
from eaudit_review_tasks import build,declarations
from local_stage import stage

def refresh(ch, *, commit=False):
    base=ROOT/f'blueprint/ch{ch:02}';web=read(base/'website_audit.json')
    lean=ROOT/f'Blueprint/Ch{ch:02}.lean';source=base/f'ch{ch:02}_source.json'
    before=(sha(lean),sha(source));ds=declarations(ch)
    records=[];active=[]
    for w in web:
        if w.get('repair',{}).get('status')!='awaiting_reaudit':continue
        sid=w['source_id'];e=w['repair']['eaudit']
        mf=base/'mathcopilot_tasks'/e/'MANIFEST.json'
        packet=next((s for s in read(mf)['subtasks'] if s['source_id']==sid),None) if mf.exists() else None
        pm=read(ROOT/packet['path']/'MANIFEST.json') if packet else {}
        if pm.get('source_block_sha256')==ds[sid]['block_sha256'] and pm.get('input_sha256',{}).get(f'Blueprint/Ch{ch:02}.lean')==before[0] and pm.get('input_sha256',{}).get(f'blueprint/ch{ch:02}/ch{ch:02}_source.json')==before[1]:continue
        records.append(w)
    if not records:return []
    existing=[int(p.name[6:]) for p in (base/'mathcopilot_tasks').glob('EAUDIT[0-9][0-9]')]
    number=max(existing,default=0)+1
    sections=list(dict.fromkeys(w['section'] for w in records)) if all('section' in w for w in records) else []
    source_sections={s['source_id']:s['section'] for s in read(source)}
    sections=list(dict.fromkeys(source_sections[w['source_id']] for w in records))
    registry=read(base/'EAUDIT_REGISTRY.json')
    for section in sections:
        rows=[w for w in records if source_sections[w['source_id']]==section]
        for start in range(0,len(rows),8):
            chunk=rows[start:start+8];e=f'EAUDIT{number:02}';number+=1
            task=build(ch,e,section,[w['source_id'] for w in chunk]);reused=[]
            for w in chunk:
                sid=w['source_id'];old=w['repair']['eaudit'];receipt=base/'validation'/old/'ACCEPTANCE.json'
                assert receipt.exists(),(sid,old,'no accepted local check')
                reused.append(dict(source_id=sid,prior_eaudit=old,acceptance=receipt.relative_to(ROOT).as_posix(),sha256=sha(receipt)))
                w['repair'].update(eaudit=e,task_index=task['task_index'],input_sha256=task['input_sha256'],prior_eaudit=old)
            record=dict(chapter=ch,eaudit=e,section=section,source_ids=task['source_ids'],reaudit_ids=task['source_ids'],human_ids=[],lean_sha256=before[0],source_sha256=before[1],kind='delivery-only refresh; all source_id declarations included',reused_local_checks=reused,new_proofs='none',website='awaiting user submission',task_index=task['task_index'])
            folder=base/'validation'/e;folder.mkdir(exist_ok=True);dump(folder/'ACCEPTANCE.json',record)
            registry.append(record);active.append(e)
    assert before==(sha(lean),sha(source)),'Delivery refresh must not modify source'
    dump(base/'website_audit.json',web);dump(base/'EAUDIT_REGISTRY.json',registry)
    present={w.get('repair',{}).get('eaudit') for w in web if w.get('repair',{}).get('status')=='awaiting_reaudit'}
    index=base/'mathcopilot_tasks/EAUDIT_INDEX.md'
    index.write_text('# EAUDIT 待提交包\n\n只提交以下现行包；包含每个source_id的全部主/辅助声明。旧包保留历史，不重复提交。\n\n'+'\n'.join(f'- [{e}]({e}/INDEX.md)' for e in sorted(present))+'\n',encoding='utf-8')
    from repair_queue import render
    render()
    work=ROOT/'docs/handoff/WORK_LOG.zh-CN.md'
    work.write_text(work.read_text(encoding='utf-8')+f'\n## {datetime.now().date()} 第{ch}章复审材料完整性刷新\n现行包增加同一source_id全部辅助结论并绑定最终快照；原包保留，{len(records)}条/{len(active)}批重新生成并核对哈希、预算和原页像素。\nLean/原文未修改，复用已通过编译与公理证据；网站仍待用户提交。\n',encoding='utf-8')
    if commit:
        paths=[f'blueprint/ch{ch:02}/website_audit.json',f'blueprint/ch{ch:02}/EAUDIT_REGISTRY.json',f'blueprint/ch{ch:02}/mathcopilot_tasks/EAUDIT_INDEX.md','docs/handoff/WORK_LOG.zh-CN.md','docs/handoff/REPAIR_QUEUE.md','docs/handoff/CURRENT_STATE.zh-CN.md','scripts/website_repair_delivery.py','scripts/eaudit_review_tasks.py']
        for e in active:paths.extend([f'blueprint/ch{ch:02}/validation/{e}',f'blueprint/ch{ch:02}/mathcopilot_tasks/{e}'])
        stage(paths)
        subprocess.run(['git','commit','-m',f'ch{ch:02}: include all source conclusions in final snapshot EAUDIT delivery'],cwd=ROOT,check=True)
        p=subprocess.run(['git','push'],cwd=ROOT)
        if p.returncode:subprocess.run(['git','-c','http.sslBackend=openssl','push'],cwd=ROOT,check=True)
    print('DELIVERY_REFRESHED',ch,len(records),active,flush=True)
    return active

if __name__=='__main__':
    import sys
    refresh(int(sys.argv[1]),commit=True)

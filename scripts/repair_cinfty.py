"""Correct smooth/analytic order encoding exposed by the chapter 5 audit."""
import re
from datetime import datetime
from integrate_website_returns import ROOT,read,dump
from eaudit_review_tasks import declarations
from website_repair_batch import prepare,verify,commit_section
from repair_queue import render

def run(ch):
    assert ch in (2,3,4)
    base=ROOT/f'blueprint/ch{ch:02}';sources=read(base/f'ch{ch:02}_source.json')
    web={w['source_id']:w for w in read(base/'website_audit.json')};ds=declarations(ch)
    by_section={}
    for s in sources:
        k=s['source_id'];old=ds[k]['block']
        if web[k].get('repair',{}).get('status')=='awaiting_mentor':continue
        new=old.replace('ContDiff ℝ ⊤','ContDiff ℝ ∞').replace('ContDiffOn ℝ ⊤','ContDiffOn ℝ ∞')
        if old!=new:by_section.setdefault(s['section'],[]).append((s,new))
    if not by_section:return
    acceptance=base/'validation/WEBSITE_REPAIR_CHAPTER_ACCEPTANCE.json'
    if acceptance.exists():
        old=base/'validation/WEBSITE_REPAIR_CHAPTER_ACCEPTANCE_PRE_CINFTY.json'
        assert not old.exists();acceptance.rename(old)
    work=ROOT/'docs/handoff/WORK_LOG.zh-CN.md'
    work.write_text(work.read_text(encoding='utf-8')+f'\n## {datetime.now().date()} 第{ch}章C∞编码补充修复\n第5章返回件暴露的ContDiff外层⊤=Cω同样影响本章；旧章末验收保留为PRE_CINFTY，不提升为新签名通过。\n只修非待导师条目为∞；不写新证明，已有证明小修失败则记录占位，另做本修订章末验收。\n',encoding='utf-8')
    state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md'
    state.write_text(re.sub(r'^下一步：.*$',f'下一步：第{ch}章C∞编码补充修复；先读最新EAUDIT收据，不提升旧章末验收，不重复已通过批次。',state.read_text(encoding='utf-8'),count=1,flags=re.M),encoding='utf-8')
    for sec,entries in by_section.items():
        existing=[int(p.name[6:]) for p in (base/'validation').glob('EAUDIT[0-9][0-9]')]
        num=max(existing,default=0)+1;eaudits=[]
        for start in range(0,len(entries),8):
            part=entries[start:start+8];e=f'EAUDIT{num:02}';num+=1
            edits={s['source_id']:dict(code=code,category='C',note='C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。') for s,code in part}
            pages=set()
            for s,_ in part:
                p=[int(n) for n in re.findall(r'\d+',s['pdf_page'])];pages.update(range(p[0],p[-1]+1))
            prepare(ch,e,sec,edits,pages=sorted(pages));verify(ch,e);eaudits.append(e)
        commit_section(ch,sec+' CINF',eaudits)
    render()

if __name__=='__main__':
    import sys
    run(int(sys.argv[1]))

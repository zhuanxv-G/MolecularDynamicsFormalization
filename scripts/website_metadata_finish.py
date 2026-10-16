"""Merge visually checked editorial corrections; retain exact Lean evidence."""
import copy,re,subprocess
from datetime import datetime
from integrate_website_returns import ROOT,read,dump,sha,display
from website_repair_batch import entry_hash
from eaudit_review_tasks import render_document
from website_repair_delivery import refresh
from repair_queue import render
from local_stage import stage

APPROVED={
  2:['MD-2.2.3-VerletExpansion','MD-2.3.1-LJOscillator','MD-2.4.1-KineticFlow',
     'MD-2.4.1-VerletComposition','MD-2.4.3-HarmonicSplit'],
  3:['MD-3.6.1-ReversedTrajectoryPrinted'],
  4:['MD-4.2.2-MollifiedPotential','MD-4.3-HolonomicRelation','MD-4.3.4-GramProjectedEuler',
     'MD-4.3.5-ConstrainedOrders','MD-4.4-WaterPairPotential','MD-4.4-RigidHamiltonian',
     'MD-4.4.1-AxisRotation','MD-4.4.1-PrincipalAxisField','MD-4.4.2-RigidSystemSymplectic',
     'MD-4.4.2-DLMPrintedSystemStructure'],
  5:['MD-5.3.1-RegularDistribution','MD-5.3.2-ShellDensity','MD-5.3.2-WholeShellVolumeLimit',
     'MD-5.3.2-IdealGasEnergy','MD-5.3.2-IdealGasPartition','MD-5.4.1-FlowInvariant',
     'MD-5.4.1-SetErgodic','MD-5.4.1-HarmonicFlow','MD-5.4.1-TwoOscillatorFlow',
     'MD-5.5-Correlation','MD-5.6-ZeroPerturbation','MD-5.6-EulerLogFlow']}

def pages(value):
    nums=[int(n) for n in re.findall(r'\d+',value)]
    return set(range(nums[0],nums[-1]+1))

def run(ch):
    base=ROOT/f'blueprint/ch{ch:02}';source=base/f'ch{ch:02}_source.json'
    lean=ROOT/f'Blueprint/Ch{ch:02}.lean';lean_hash=sha(lean)
    acceptance=base/'validation/WEBSITE_REPAIR_CHAPTER_ACCEPTANCE.json';accepted=read(acceptance)
    record_path=base/'validation/METADATA_REVIEW_20261016.json'
    saved=read(record_path) if record_path.exists() else None
    assert accepted['lean_sha256']==lean_hash
    if saved:
        assert saved['source_after_sha256']==sha(source) and saved['unchanged_lean_sha256']==lean_hash
        assert accepted['source_sha256'] in (saved['source_before_sha256'],saved['source_after_sha256'])
    else:assert accepted['source_sha256']==sha(source)
    if saved and saved.get('delivery_complete'):
        print('REUSE_METADATA_REVIEW',ch,flush=True);return
    sources=read(source);web=read(base/'website_audit.json');ws={w['source_id']:w for w in web}
    before_hash=saved['source_before_sha256'] if saved else sha(source)
    changes=copy.deepcopy(saved['changes']) if saved else []
    for s in sources:
        k=s['source_id']
        if k not in APPROVED[ch]:continue
        proposal=ws[k]['json_review'].get('corrected_json') or {}
        fields={key:dict(before=s.get(key),after=proposal[key]) for key in
          ('kind','label','section','printed_page','pdf_page') if key in proposal and proposal[key]!=s.get(key)}
        if not fields:continue
        before_entry=entry_hash(s);old_pages=pages(s['pdf_page'])
        for key,change in fields.items():s[key]=change['after']
        new_pages=pages(s['pdf_page']);offset=21 if ch==5 else 22
        assert {p+offset for p in pages(s['printed_page'])}==new_pages,(k,s['printed_page'],s['pdf_page'])
        # Canonical page citations become exact, while adjacent derivation or
        # algorithm pages remain explicitly attached as review context.
        context=set(s.get('review_context_pdf_pages',[]))|(old_pages-new_pages)
        if context:s['review_context_pdf_pages']=sorted(context)
        s['source_page_verification']='VERIFIED_RENDERED; validation/METADATA_REVIEW_20261016.json'
        s.setdefault('repair_log',[]).append(dict(stage='EDITORIAL_METADATA_VISUAL_REVIEW',timestamp=datetime.now().isoformat(),
          before_sha256=before_entry,after_sha256=entry_hash(s),changed_fields=list(fields),changes=fields,
          raw_return=ws[k].get('json_review_raw_path',ws[k]['raw_path']),
          reason='已对照原页标题、展示式与跨页续文；合并页码/标签/原文类别，原文/签名及既有statement_scope不变。移出的相邻推导页明确保留为review_context_pdf_pages，不裁定数学疑误。'))
        ws[k]['repair']['metadata_locally_verified']=True
        changes.append(dict(source_id=k,fields=fields,source_pages=sorted(new_pages),context_pages=sorted(context)))
    assert {c['source_id'] for c in changes}==set(APPROVED[ch])
    dump(source,sources);dump(base/'website_audit.json',web)
    dump(record_path,dict(chapter=ch,time=datetime.now().isoformat(),source_pdf_sha256=sha(next(ROOT.parent.glob('Leimkuhler2015b*.pdf'))),
      source_before_sha256=before_hash,source_after_sha256=sha(source),unchanged_lean_sha256=lean_hash,
      verification='visual inspection of original rendered pages; no Lean source change; reuse accepted compile, axiom and chapter full check',changes=changes))
    deliveries=refresh(ch)
    if not any(h['after_source_sha256']==sha(source) for h in accepted.get('metadata_refreshes',[])):
        accepted.setdefault('metadata_refreshes',[]).append(dict(time=datetime.now().isoformat(),before_source_sha256=before_hash,
          after_source_sha256=sha(source),receipt=record_path.relative_to(ROOT).as_posix(),unchanged_lean_sha256=lean_hash,
          full_check='reused: all Lean files unchanged, only source citation metadata and delivery changed'))
    accepted['source_sha256']=sha(source);dump(acceptance,accepted)
    (ROOT/f'docs/review/CH{ch:02}_BLUEPRINT.zh-CN.md').write_text(render_document(ch),encoding='utf-8')
    counts=render()[ch];web=read(base/'website_audit.json');audit=read(base/'local_audit.json')['items'];ws={w['source_id']:w for w in web}
    rows=[f'# 第{ch}章网站审计修复进度','',
      f'当前{len(sources)}条；网站返回已登记。原页、单文件、公理与章末固定版本检查已验；网站复审待用户提交，导师问题未裁定。',
      '第6章暂停，不进入第7章；正式库冻结。旧网站PASS只覆盖绑定快照。',
      f'网站PASS {counts["website_pass"]} / 已修待复审 {counts["awaiting_reaudit"]} / 待导师 {counts["awaiting_mentor"]} / 修复中 {counts["repairing"]}。','',
      '| source_id | 原文审校 | 网站状态 | 本地证明状态 | EAUDIT |','|---|---|---|---|---|']
    for s in sources:
        w=ws[s['source_id']];status=display(w);proof=audit[s['source_id']]['final_status']
        rows.append('| '+ ' | '.join([s['source_id'],w['json_review']['status'],status,proof,w.get('repair',{}).get('eaudit','—')])+' |')
    (base/'PROGRESS.md').write_text('\n'.join(rows)+'\n',encoding='utf-8')
    review=base/'SOURCE_REVIEW_QUEUE.json'
    if review.exists():
        q=read(review)
        for item in q:
            if ws[item['source_id']].get('repair',{}).get('json_review_locally_verified'):
                item['status']='locally page-verified and merged; editorial metadata reviewed; explicit local scope repairs retained'
        dump(review,q)
    assert sha(lean)==lean_hash
    work=ROOT/'docs/handoff/WORK_LOG.zh-CN.md';work.write_text(work.read_text(encoding='utf-8')+f'\n## {datetime.now().date()} 第{ch}章原文元数据收尾\n{len(changes)}条CORRECTED页码/标签/类别按原页合并；移出的相邻推导页明确作附件上下文，Lean字节未改，复用原编译/公理/章末检查。\n最终JSON哈希已重绑EAUDIT现行包，旧包保留；网站和导师尚未确认，第6章暂停。\n',encoding='utf-8')
    owned=[source.relative_to(ROOT).as_posix(),record_path.relative_to(ROOT).as_posix(),acceptance.relative_to(ROOT).as_posix(),
      f'blueprint/ch{ch:02}/website_audit.json',f'blueprint/ch{ch:02}/EAUDIT_REGISTRY.json',f'blueprint/ch{ch:02}/mathcopilot_tasks/EAUDIT_INDEX.md',
      f'blueprint/ch{ch:02}/PROGRESS.md',f'docs/review/CH{ch:02}_BLUEPRINT.zh-CN.md',
      'docs/handoff/WORK_LOG.zh-CN.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/REPAIR_QUEUE.md',
      'scripts/eaudit_review_tasks.py','scripts/website_metadata_finish.py']
    if review.exists():owned.append(review.relative_to(ROOT).as_posix())
    for e in deliveries:owned.extend([f'blueprint/ch{ch:02}/validation/{e}',f'blueprint/ch{ch:02}/mathcopilot_tasks/{e}'])
    completed=read(record_path);completed['delivery_complete']=True;dump(record_path,completed)
    stage(owned);subprocess.run(['git','commit','-m',f'ch{ch:02}: merge visually verified citation metadata and refresh final EAUDIT packages'],cwd=ROOT,check=True)
    p=subprocess.run(['git','push'],cwd=ROOT)
    if p.returncode:subprocess.run(['git','-c','http.sslBackend=openssl','push'],cwd=ROOT,check=True)
    print('METADATA_ACCEPTED',ch,len(changes),flush=True)

if __name__=='__main__':
    import sys
    run(int(sys.argv[1]))

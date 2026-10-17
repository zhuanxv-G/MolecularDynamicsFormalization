"""Apply the returned A transcription fixes, preserving mathematical errata literally."""
from common import *
FIELDS=['kind','label','printed_page','pdf_page','statement_latex','proof_latex',
 'proof_discussion_latex','proof_note','context_notation']
def run():
 returns=load(OUT/'RETURNS.json')
 for ch in range(2,6):
  ss=load(base(ch)/f'ch{ch:02}_source.json');src={s['source_id']:s for s in ss}
  ww=load(base(ch)/'website_audit.json');web={w['source_id']:w for w in ww};changes=[]
  for r in returns:
   if r['chapter']!=ch:continue
   sid=r['source_id'];j=r['json_review'];c=j.get('corrected_json')
   if not c:continue
   # This return explicitly could not inspect its missing attachment; do not adopt an unverified reconstruction.
   if 'R1_ATTACHMENT_MISSING' in j.get('issue_codes',[]):
    web[sid]['closeout24_transcription_status']='原附件缺失；未采用返回的重建引文，保留现有已核原文。'
    continue
   s=src[sid];delta={k:dict(before=s.get(k),after=c[k]) for k in FIELDS if k in c and s.get(k)!=c[k]}
   if not delta:continue
   for k,v in delta.items():s[k]=v['after']
   row=dict(source_id=sid,batch=r['batch'],fields=delta,issue_codes=j.get('issue_codes',[]),
    basis='采用网站A对原页的排印/省略更正；保留原书数学疑误，未用工作修正版覆盖原文。非全部页面本轮重复视觉核对。')
   s.setdefault('repair_log',[]).append(dict(stage='CLOSEOUT24_WEBSITE_A_TRANSCRIPTION',changed_fields=list(delta),
    batch=r['batch'],reason=row['basis'],evidence='blueprint/closeout24/ch%02d/TRANSCRIPTION_CHANGES.json'%ch))
   s['closeout24_A_status']=j['status'];web[sid]['closeout24_transcription']=row;changes.append(row)
  dump(base(ch)/f'ch{ch:02}_source.json',ss);dump(base(ch)/'website_audit.json',ww)
  dump(OUT/f'ch{ch:02}/TRANSCRIPTION_CHANGES.json',changes)
  print(ch,len(changes),'source transcription records integrated')
if __name__=='__main__':run()

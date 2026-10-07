from pathlib import Path
import json,csv,re,hashlib,datetime
OUT=Path(__file__).resolve().parent; ROOT=OUT.parents[2]
def load(n):return json.loads((OUT/n).read_text(encoding='utf-8-sig'))
def save(n,x):(OUT/n).write_text(json.dumps(x,ensure_ascii=False,indent=2),encoding='utf-8')
ledger=list(csv.DictReader((ROOT/'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv').open(encoding='utf-8-sig')))
declarations=load('declarations.json')
for d in declarations:
    lines=(OUT/'snapshot'/d['file']).read_text(encoding='utf-8').splitlines()
    pat=r'^[ \t]*(?:(?:private|protected|noncomputable)\s+)*'+d['kind']+r'\s+'+re.escape(d['name'])+r'(?=\s|[({:])'
    exact=[i for i,l in enumerate(lines,1) if re.search(pat,l)]
    if len(exact)==1:d['line']=exact[0]
save('declarations.json',declarations)
for filename in ['selected-theorems.json','random-five.json']:
    a=load(filename); arr=a['sample'] if isinstance(a,dict) else a
    for d in arr:
        exact=[x for x in declarations if x['file']==d['file'] and x['name']==d['name']]
        if len(exact)==1:d['line']=exact[0]['line']
    save(filename,a)
sections=list(csv.DictReader((ROOT/'docs/CHAPTER_SECTION_INVENTORY.csv').open(encoding='utf-8-sig')))
modules=list(csv.DictReader((OUT/'module-map.csv').open(encoding='utf-8-sig')))
for m in modules:
    stem=Path(m['file']).stem
    hits=[r for r in ledger if m['file'] in r['existing_lean'] or re.search(r'\b'+re.escape(stem)+r'\b',r['existing_lean'])]
    ids=list(dict.fromkeys([x for x in m['sections_from_inventory'].split(';') if x]+[r['chapter_section'] for r in hits]))
    m['sections_from_ledger']=';'.join(ids)
    m['mapping_status']='登记映射，尚未逐项语义终审' if ids else ('源码页码锚点，节映射待补' if m['header_page_evidence'] else '目录章节可知，精确节/依赖映射未登记')
with (OUT/'module-map.csv').open('w',encoding='utf-8-sig',newline='') as f:
    w=csv.DictWriter(f,fieldnames=list(modules[0]));w.writeheader();w.writerows(modules)
save('mapping-summary.json',{'modules':len(modules),'with_section_registry':sum(bool(m['sections_from_ledger']) for m in modules),'with_header_page_anchor':sum(bool(m['header_page_evidence']) for m in modules),'without_either':sum(not m['sections_from_ledger'] and not m['header_page_evidence'] for m in modules)})
log=(OUT/'all-registered-axioms.log').read_text(encoding='utf-8-sig')
rows=re.findall(r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]",log)
zero=re.findall(r"'([^']+)' does not depend on any axioms",log)
bad=[(n,x) for n,x in rows if set(z.strip() for z in x.split(',') if z.strip())-{'propext','Classical.choice','Quot.sound'}]
save('axioms-summary.json',{'registered_count':len(rows)+len(zero),'with_axioms':len(rows),'without_axioms':zero,'nonstandard':bad,'selected_count':21})
fail=[]
for p in (ROOT/'docs/verification').rglob('*.exit'):
    if OUT in p.parents:continue
    x=p.read_text(encoding='utf-8-sig').strip()
    if x!='0': fail.append({'file':p.relative_to(ROOT).as_posix(),'exit':x})
save('historical-failed-exits.json',fail)
meta=[]
for rel in ['STATUS.md','FORMALIZATION_MAP.md','ASSUMPTIONS.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/WORK_LOG.zh-CN.md','docs/handoff/PROGRESS_OVERVIEW.zh-CN.md','docs/CHAPTER_SECTION_INVENTORY.csv','docs/TEXTBOOK_DECLARATION_CANDIDATES.csv','docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv']:
    p=ROOT/rel
    dt=datetime.datetime.fromtimestamp(p.stat().st_mtime,datetime.timezone(datetime.timedelta(hours=8)))
    meta.append({'file':rel,'mtime_asia_shanghai':dt.isoformat(timespec='seconds'),'sha256':hashlib.sha256(p.read_bytes()).hexdigest()})
save('document-metadata.json',meta)
before=load('inputs-before.json'); after=load('inputs-after-build.json')
save('snapshot-hashes.json',[{'file':str(p.relative_to(OUT/'snapshot')).replace('\\','/'),'sha256':hashlib.sha256(p.read_bytes()).hexdigest()} for p in (OUT/'snapshot').rglob('*.lean')])
print('MODULE_MAP',load('mapping-summary.json'));print('AXIOMS',load('axioms-summary.json')); print('FAILURES',len(fail)); print('DOC_TIMES',[(r['file'],r['mtime_asia_shanghai']) for r in meta[:6]])

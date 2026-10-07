from pathlib import Path
import re, json, csv, hashlib, random, datetime
from collections import Counter
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[3]
OUT = Path(__file__).resolve().parent
def write(name, value):
    (OUT / name).write_text(value, encoding='utf-8')
def dump(name, value):
    write(name, json.dumps(value, ensure_ascii=False, indent=2))
def read_csv(path):
    with path.open(encoding='utf-8-sig', newline='') as f:
        return list(csv.DictReader(f))
def code_only(src):
    # Retain line numbers while removing nested block comments, line comments, strings.
    out=[]; i=0; depth=0; string=False
    while i<len(src):
        if depth:
            if src.startswith('/-',i): depth+=1; out.extend('  '); i+=2
            elif src.startswith('-/',i): depth-=1; out.extend('  '); i+=2
            else: out.append('\n' if src[i]=='\n' else ' '); i+=1
        elif string:
            if src[i]=='\\': out.extend('  '); i+=2
            elif src[i]=='"': string=False; out.append(' '); i+=1
            else: out.append('\n' if src[i]=='\n' else ' '); i+=1
        elif src.startswith('/-',i): depth=1; out.extend('  '); i+=2
        elif src.startswith('--',i):
            j=src.find('\n',i)
            if j<0: j=len(src)
            out.extend(' '*(j-i)); i=j
        elif src[i]=='"': string=True; out.append(' '); i+=1
        else: out.append(src[i]); i+=1
    return ''.join(out)

formal=sorted((ROOT/'MolecularDynamics').rglob('*.lean'))
aux=[ROOT/'Scratch.lean', ROOT/'MolecularDynamicsFormalization.lean', ROOT/'scripts/CheckAxioms.lean']
project=sorted(p for p in ROOT.rglob('*.lean') if '.lake' not in p.parts and '.git' not in p.parts)
sections=read_csv(ROOT/'docs/CHAPTER_SECTION_INVENTORY.csv')
ledger=read_csv(ROOT/'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv')
imports=set(re.findall(r'^import\s+(\S+)', (ROOT/'MolecularDynamicsFormalization.lean').read_text(encoding='utf-8-sig'),re.M))
patterns={
 'sorry':r'\bsorry\b','admit':r'\badmit\b','axiom':r'\baxiom\b','opaque':r'\bopaque\b',
 'native_decide':r'\bnative_decide\b','maxHeartbeats_zero':r'\bset_option\s+maxHeartbeats\s+0\b',
 'implemented_by':r'\bimplemented_by\b','unsafe':r'\bunsafe\b',
 'all_resource_settings':r'\bset_option\s+(?:maxHeartbeats|maxRecDepth|synthInstance.maxHeartbeats)\s+\S+',
 'trivial_definition_candidates':r'\b(?:def|abbrev)\s+[^\n]+:=\s*(?:0|True|False|fun[^\n]*=>\s*(?:0|True|False))\s*$'}
matches={k:[] for k in patterns}; declarations=[]; modules=[]; counts={}
for p in project:
    src=p.read_text(encoding='utf-8-sig'); clean=code_only(src); rel=p.relative_to(ROOT).as_posix()
    scope='formal' if p in formal else ('entry_or_audit' if p in aux else 'draft_history')
    for key,pattern in patterns.items():
        for m in re.finditer(pattern,clean,re.M):
            line=clean.count('\n',0,m.start())+1
            matches[key].append({'file':rel,'line':line,'scope':scope,'text':src.splitlines()[line-1].strip()})
    if p not in formal: continue
    chapter=re.search(r'Chapter(\d+)',rel)
    ch=int(chapter[1]) if chapter else 0
    local=[]
    for m in re.finditer(r'^\s*((?:(?:private|protected|noncomputable)\s+)*)(def|abbrev|structure|inductive|theorem|lemma)\s+([^\s({:]+)',clean,re.M):
        line=clean.count('\n',0,m.start())+1
        d={'chapter':ch,'file':rel,'line':line,'kind':m[2],'name':m[3],'private':'private' in m[1]}
        declarations.append(d);local.append(d)
    module=rel[:-5].replace('/','.')
    linked=[s['section_id'] for s in sections if p.stem in re.split(r'[;,]',s.get('proof_dependency_ids',''))]
    header=src[:src.find('-/')+2] if src.startswith('import') and '-/' in src[:3500] else src[:1000]
    pages='; '.join(dict.fromkeys(re.findall(r'[^\n]*(?:[Pp]rinted|PDF|[Ss]ection|§)[^\n]*',header)))
    modules.append({'file':rel,'chapter':ch,'sections_from_inventory':';'.join(linked), 'header_page_evidence':pages,'root_import':module in imports,'public_theorems':sum(d['kind'] in ['theorem','lemma'] and not d['private'] for d in local),'definitions':sum(d['kind'] not in ['theorem','lemma'] for d in local)})
    snap=OUT/'snapshot'/rel; snap.parent.mkdir(parents=True,exist_ok=True); snap.write_text(src,encoding='utf-8')
dump('source-scan.json',{'excluded':['.lake','.git'],'project_lean_files':len(project),'formal_lean_files':len(formal),'matches':matches})
dump('declarations.json',declarations)
with (OUT/'module-map.csv').open('w',encoding='utf-8-sig',newline='') as f:
    w=csv.DictWriter(f,fieldnames=list(modules[0]));w.writeheader();w.writerows(modules)
dump('source-counts.json',{str(ch):{'files':sum(m['chapter']==ch for m in modules),'public_theorems':sum(d['chapter']==ch and d['kind'] in ['theorem','lemma'] and not d['private'] for d in declarations),'definitions':sum(d['chapter']==ch and d['kind'] not in ['theorem','lemma'] for d in declarations)} for ch in range(9)})
dump('ledger-numbered.json',[r for r in ledger if '-NUM-' in r['item_id'] and r['kind']!='reference_only'])

pdf=next(ROOT.parent.glob('*.pdf'))
reader=PdfReader(str(pdf)); pages=[]; numbered=[]
for n,p in enumerate(reader.pages,1):
    txt=p.extract_text() or ''; pages.append({'pdf_page':n,'text':txt})
    for m in re.finditer(r'(?m)^\s*(Theorem|Lemma|Proposition|Corollary|Definition)\s+(\d+)\.(\d+)\b',txt):
        numbered.append({'kind':m[1],'chapter':int(m[2]),'number':int(m[3]),'pdf_page':n,'context':txt[m.start():m.start()+650]})
dump('pdf-pages.json',pages)
dump('pdf-numbered-matches.json',numbered)
unique={}
for r in numbered: unique.setdefault((r['kind'],r['chapter'],r['number']),[]).append(r['pdf_page'])
dump('pdf-numbered-unique.json',[{'kind':k[0],'chapter':k[1],'number':k[2],'pages':v} for k,v in sorted(unique.items(),key=lambda x:(x[0][1],x[0][0],x[0][2]))])
dump('pdf-metadata.json',{'path':str(pdf),'pages':len(reader.pages),'sha256':hashlib.sha256(pdf.read_bytes()).hexdigest()})
print(json.dumps({'root':str(ROOT),'project_lean_files':len(project),'formal_lean_files':len(formal),'scan_counts':{k:len(v) for k,v in matches.items()},'pdf_pages':len(pages),'numbered_unique':len(unique),'source_counts':json.loads((OUT/'source-counts.json').read_text(encoding='utf-8'))},ensure_ascii=False))

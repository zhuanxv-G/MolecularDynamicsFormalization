"""Check actual GitHub blob rich HTML at an immutable commit, retaining evidence locally."""
import argparse, concurrent.futures, json, posixpath, re, subprocess
from pathlib import Path
from urllib.parse import urlsplit, unquote
import requests
from bs4 import BeautifulSoup
from fix_github_render import formulas, ROOT, OUT, read, write

REPO='https://github.com/zhuanxv-G/MolecularDynamicsFormalization'

def find_rich(obj):
    if isinstance(obj,dict):
        if 'richText' in obj:return obj
        for v in obj.values():
            r=find_rich(v)
            if r is not None:return r
    elif isinstance(obj,list):
        for v in obj:
            r=find_rich(v)
            if r is not None:return r

def fetch(sha,path):
    cache=OUT/'github-pages'/sha/(path+'.html')
    if cache.exists():html=read(cache)
    else:
        r=requests.get(f'{REPO}/blob/{sha}/{path}',timeout=60);r.raise_for_status();r.encoding='utf-8';html=r.text;write(cache,html)
    soup=BeautifulSoup(html,'html.parser')
    for script in soup.find_all('script',type='application/json'):
        try:rich=find_rich(json.loads(script.string or '{}'))
        except ValueError:continue
        if rich is not None:return rich
    raise RuntimeError('No richText payload: '+path)

def run(sha,stage):
    ledger=json.loads(read(OUT/'render_fix_changes.json'))
    paths=sorted({p for s in ledger['stages'] for p in s['files'] if p.endswith('.md')})
    results={}; rich_pages={}
    def one(path):
        try:
            d=fetch(sha,path);html=d.get('richText');soup=BeautifulSoup(html or '','html.parser')
            math=soup.find_all('math-renderer');expected=formulas(read(ROOT/path))[1]
            double=sum(bool(re.search(r'&amp;(?:gt|lt);',str(m))) for m in math)
            links=[a.get('href','') for a in soup.find_all('a',href=True)]
            for node in soup.find_all(['math-renderer','code','pre']):node.decompose()
            residue=re.findall(r'\$(?=[\\A-Za-z])',soup.get_text())
            result=dict(truncated=d.get('richTextTruncated'),richText_present=html is not None,expected=expected,renderers=len(math),residue=len(residue),double_escaped=double)
            result['passed']=d.get('richTextTruncated') is False and html is not None and len(math)>=expected and not residue and not double
            return path,result,html,links
        except Exception as e:return path,dict(passed=False,error=str(e)),None,[]
    links_by={}
    with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
        for path,result,html,links in pool.map(one,paths):
            results[path]=result;rich_pages[path]=html;links_by[path]=links
            print(path,json.dumps(result),flush=True)
    targets=[]
    for path,links in links_by.items():
        for href in links:
            u=urlsplit(href)
            if not u.fragment:continue
            if u.netloc and u.netloc!='github.com':continue
            p=unquote(u.path)
            prefix='/zhuanxv-G/MolecularDynamicsFormalization/blob/'
            if p.startswith(prefix):
                tail=p[len(prefix):];ref,_,p=tail.partition('/')
                if ref not in [sha,'book-ch01-08-render-v2','book-ch01-08-render-v3']:continue
            elif p.startswith('/'):
                continue
            elif p:p=posixpath.normpath(posixpath.join(posixpath.dirname(path),p))
            else:p=path
            if not p.endswith('.md'):continue
            targets.append((path,p,unquote(u.fragment)))
    missing=[];errors=[]
    for p in sorted({p for _,p,_ in targets}-rich_pages.keys()):
        try:rich_pages[p]=fetch(sha,p).get('richText')
        except Exception as e:errors.append(dict(path=p,error=str(e)))
    ids={p:{n.get('id') for n in BeautifulSoup(h or '','html.parser').find_all(id=True)} for p,h in rich_pages.items()}
    for source,p,anchor in targets:
        if anchor not in ids.get(p,set()) and 'user-content-'+anchor not in ids.get(p,set()):missing.append(dict(source=source,target=p,anchor=anchor))
    report=dict(commit=sha,stage=stage,files=results,anchor_links=len(targets),missing_anchors=missing,anchor_errors=errors,expected=sum(x.get('expected',0) for x in results.values()),renderers=sum(x.get('renderers',0) for x in results.values()))
    report['passed']=all(x['passed'] for x in results.values()) and not missing and not errors
    write(OUT/f'render_check_v{stage+1}.json',json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({k:v for k,v in report.items() if k!='files'},ensure_ascii=False),flush=True)
    return report['passed']

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('sha');p.add_argument('--stage',type=int,required=True);a=p.parse_args()
    raise SystemExit(0 if run(a.sha,a.stage) else 1)

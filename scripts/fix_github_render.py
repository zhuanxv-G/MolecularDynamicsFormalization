"""Reversible GFM math conversion and section-preserving blueprint partitioning."""
import argparse, hashlib, json, re, subprocess, tempfile, posixpath
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'output'
BASE = 'book-ch01-08-render'
def git(*args):
    return subprocess.check_output(['git', *args], cwd=ROOT)
def read(p): return p.read_bytes().decode('utf-8')
def write(p,s): p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(s.encode('utf-8'))
def sha(b): return hashlib.sha256(b).hexdigest()

def formulas(s, convert=False):
    result=[]; count=0; fence=None; display=False
    for line in s.splitlines(keepends=True):
        body=re.sub(r'^(?:> ?)+','',line)
        f=re.match(r'\s*(`{3,}|~{3,})(.*)',body)
        if f:
            if fence is None: fence=f[1][0]; math=f[2].strip()=='math';count+=int(math)
            elif f[1][0]==fence: fence=None
            result.append(line);continue
        if fence:result.append(line);continue
        if re.match(r'^\s*\$\$\s*$',body):
            count+=int(not display);display=not display;result.append(line);continue
        if display:
            if convert:
                prefix=line[:len(line)-len(body)]
                line=prefix+body.replace('<',r'\lt ').replace('>',r'\gt ')
            result.append(line);continue
        i=0;new='';table=line.lstrip().startswith('|')
        while i<len(line):
            if line[i]=='$' and (i==0 or line[i-1]!='\\'):
                if line.startswith('$`',i):
                    end=line.find('`$',i+2)
                    if end!=-1:count+=1;new+=line[i:end+2];i=end+2;continue
                end=line.find('$',i+1)
                if end!=-1:
                    inner=line[i+1:end];count+=1
                    if convert:
                        inner=inner.replace('<',r'\lt ').replace('>',r'\gt ')
                        # Literal code marks inside a formula are presentation only.
                        inner=re.sub(r'`([^`]+)`',r'\\texttt{\1}',inner)
                        if table:inner=inner.replace('\\\\',r'\cr ').replace(r'\|',r'\Vert ').replace('|',r'\vert ')
                        new+='$`'+inner+'`$'
                    else:new+=line[i:end+1]
                    i=end+1;continue
            if line[i]=='`':
                m=re.match(r'`+',line[i:]);mark=m[0];end=line.find(mark,i+len(mark))
                if end!=-1:new+=line[i:end+len(mark)];i=end+len(mark);continue
            new+=line[i];i+=1
        result.append(new)
    return ''.join(result),count

def record_change(records,path,old,new):
    if old==new:return
    # Every replacement records exact old/new bytes, with source line numbers.
    import difflib
    a=old.splitlines(keepends=True);b=new.splitlines(keepends=True)
    if len(a)==len(b):
        for i,(before,after) in enumerate(zip(a,b)):
            if before!=after:records.append(dict(file=path,line=i+1,new_line=i+1,old=before,new=after))
        return
    for tag,i,j,k,l in difflib.SequenceMatcher(None,a,b,autojunk=False).get_opcodes():
        if tag!='equal': records.append(dict(file=path,line=i+1,new_line=k+1,old=''.join(a[i:j]),new=''.join(b[k:l])))

def stage(n):
    OUT.mkdir(exist_ok=True)
    ledger_path=OUT/'render_fix_changes.json'
    ledger=json.loads(ledger_path.read_text(encoding='utf-8')) if n==2 else dict(base=BASE,stages=[])
    entries=[];files=[];partitions={}
    paths=[ROOT/'README.md',*sorted((ROOT/'docs/review').rglob('*.md'))]
    if n==1:paths=[p for p in paths if '_BLUEPRINT.' not in p.name]
    for p in paths:
        rel=p.relative_to(ROOT).as_posix();old=read(p);new,_=formulas(old,True)
        new=new.replace('book-ch01-08-render-v2','book-ch01-08-render-v3') if n==2 else new.replace('book-ch01-08-render','book-ch01-08-render-v2')
        if old!=new:record_change(entries,rel,old,new);write(p,new);files.append(rel)
    if n==2:
        for p in sorted((ROOT/'docs/review').glob('CH??_BLUEPRINT.zh-CN.md')):
            rel=p.relative_to(ROOT).as_posix();old=read(p);sections=re.split(r'(?m)(?=^## )',old)
            groups=[];current=''
            for section in sections:
                if len(section.encode())>148000:raise RuntimeError('Oversized section: '+rel)
                if current and len((current+section).encode())>60000:groups.append(current);current=''
                current+=section
            if current:groups.append(current)
            names=[f'docs/review/blueprint/{p.name[:4]}/part{i+1:02}.zh-CN.md' for i in range(len(groups))]
            newline='\r\n' if '\r\n' in old else '\n'
            navs=[];index='# '+p.name[:4]+' BLUEPRINT 分部目录'+newline*2
            for i,(name,body) in enumerate(zip(names,groups)):
                nav=('['+'上一部分](part%02d.zh-CN.md)'%i if i else '上一部分：无')+' / [目录](../../'+p.name+') / '+('[下一部分](part%02d.zh-CN.md)'%(i+2) if i+1<len(groups) else '下一部分：无')+'\n\n'
                write(ROOT/name,nav+body);navs.append(nav);files.append(name)
                titles=[t.rstrip('\r') for t in re.findall(r'^## (.+)',body,re.M)]
                index+='- [第%d部分](blueprint/%s/part%02d.zh-CN.md)：%s'%(i+1,p.name[:4],i+1,'；'.join(titles))+newline
            write(p,index);files.append(rel);partitions[rel]=dict(parts=names,navs=navs,original=old,index=index)
    ledger['stages'].append(dict(stage=n,changes=entries,files=sorted(set(files)),partitions=partitions))
    if n==2:
        link_changes=[];link_files=[]
        for rel,v in partitions.items():
            for part,nav in zip(v['parts'],v['navs']):
                old=read(ROOT/part)
                def move(m):
                    href=m[1]
                    if href.startswith(('http:','https:','#','/','mailto:')):return m[0]
                    path,sep,anchor=href.partition('#')
                    target=posixpath.normpath(posixpath.join(posixpath.dirname(rel),path))
                    return ']('+posixpath.relpath(target,posixpath.dirname(part))+(sep+anchor if sep else '')+')'
                new=nav+re.sub(r'\]\(([^)]+)\)',move,old[len(nav):])
                if old!=new:record_change(link_changes,part,old,new);write(ROOT/part,new);link_files.append(part)
        ledger['stages'].append(dict(stage=n,changes=link_changes,files=link_files,partitions={}))
    write(ledger_path,json.dumps(ledger,ensure_ascii=False,indent=2)+'\n')
    verify(ledger)
    print(json.dumps(dict(stage=n,files=len(set(files)),replacements=len(entries)),ensure_ascii=False))

def verify(ledger):
    restored={}
    for step in reversed(ledger['stages']):
        for rel,v in step['partitions'].items():
            combined=''
            for name,nav in zip(v['parts'],v['navs']):
                s=restored.pop(name,read(ROOT/name));assert s.startswith(nav),name;combined+=s[len(nav):]
            assert combined==v['original'],rel
            restored[rel]=combined
        for change in reversed(step['changes']):
            rel=change['file'];s=restored.get(rel,read(ROOT/rel));lines=s.splitlines(keepends=True);pos=sum(len(l) for l in lines[:change['new_line']-1]);new=change['new']
            assert s[pos:pos+len(new)]==new,(rel,change['new_line'])
            restored[rel]=s[:pos]+change['old']+s[pos+len(new):]
    evidence={}
    for rel,s in restored.items():
        original_hash=git('rev-parse',BASE+':'+rel).decode().strip()
        with tempfile.NamedTemporaryFile(delete=False) as f:
            f.write(s.encode('utf-8')); temp=Path(f.name)
        try:
            restored_hash=git('hash-object','--path='+rel,str(temp)).decode().strip()
        finally:temp.unlink()
        evidence[rel]=dict(expected=original_hash,restored=restored_hash,passed=original_hash==restored_hash)
        if restored_hash!=original_hash:
            write(OUT/'render_reversibility.json',json.dumps(dict(passed=False,files=evidence),indent=2)+'\n')
            raise AssertionError(rel)
    write(OUT/'render_reversibility.json',json.dumps(dict(passed=True,files=evidence),indent=2)+'\n')

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--stage',type=int,choices=[1,2]);ap.add_argument('--verify',action='store_true');a=ap.parse_args()
    if a.verify:verify(json.loads(read(OUT/'render_fix_changes.json')))
    else:stage(a.stage)

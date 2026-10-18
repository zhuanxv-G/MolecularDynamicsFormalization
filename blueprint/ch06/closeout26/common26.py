from pathlib import Path
import json,re,hashlib,sys
ROOT=Path(__file__).resolve().parents[3]
OUT=Path(__file__).resolve().parent
BASE=OUT.parent
LEAN=ROOT/'Blueprint/Ch06.lean'
sys.path.insert(0,str(ROOT/'scripts'))
sys.path.insert(0,str(BASE/'closeout25'))
def load(p):return json.loads(Path(p).read_text(encoding='utf-8-sig'))
def dump(p,d):
 p=Path(p);p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
from common25 import groups
DECL=re.compile(r'(?m)^(?:@\[[^\]\n]+\]\s*)*(?:(?:noncomputable|private|protected)\s+)*(theorem|lemma|def|abbrev)\s+(\w+)')
def chunks(code):
 ms=list(DECL.finditer(code));return [dict(kind=m[1],name=m[2],code=code[m.start():ms[i+1].start() if i+1<len(ms) else len(code)].strip()) for i,m in enumerate(ms)]
def human(x):
 if isinstance(x,str):return x
 if isinstance(x,list):return '；'.join(human(t) for t in x)
 if isinstance(x,dict):return '；'.join(str(k)+'：'+human(t) for k,t in x.items())
 return str(x)
def quote(s):return '\n'.join('> '+x for x in str(s).splitlines())
def flat(s):return str(s).replace('|','\\|').replace('\n',' ')
def strip_comments(s):
 out=[];i=0;depth=0
 while i<len(s):
  if s[i:i+2]=='/-':depth+=1;i+=2
  elif depth and s[i:i+2]=='-/':depth-=1;i+=2
  elif depth:i+=1
  elif s[i:i+2]=='--':
   j=s.find('\n',i);i=len(s) if j<0 else j
  else:out.append(s[i]);i+=1
 return ''.join(out)
# Read only the literal mapping; PDF packages are unnecessary for Markdown reports.
import ast
_tree=ast.parse((BASE/'closeout25/packages25.py').read_text(encoding='utf-8-sig'))
EXPLICIT=ast.literal_eval(next(n.value for n in _tree.body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='EXPLICIT' for t in n.targets)))

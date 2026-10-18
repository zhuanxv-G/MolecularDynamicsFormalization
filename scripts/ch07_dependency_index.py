"""Read-only project declaration index; copied and adapted from chapter 6 accepted exporter."""
from ch07_pipeline import ROOT
import re
from collections import defaultdict
COMMAND=re.compile(r'(?m)^(?:@\[[^\]\n]+\]\s*)*(?:(?:noncomputable|private|protected|unsafe|partial) +)*(def|abbrev|structure|class|inductive|theorem|lemma|instance|namespace|section|end|open|variable|local|set_option|attribute|notation|scoped|#\w+)\b')
def strip_comments(s):
 # Nested Lean comments are handled by a scanner rather than a greedy regex.
 out=[];i=0;depth=0
 while i<len(s):
  if s[i:i+2]=='/-':depth+=1;i+=2
  elif depth and s[i:i+2]=='-/':depth-=1;i+=2
  elif depth:i+=1
  elif s[i:i+2]=='--':
   j=s.find('\n',i);i=len(s) if j<0 else j
  else:out.append(s[i]);i+=1
 return ''.join(out)
def tokens(s):return set(re.findall(r'[\w₀-₉]+(?:\.[\w₀-₉]+)*',strip_comments(s)))

def masked_comments(s):
 # Preserve source offsets while excluding documentation examples from commands.
 out=list(s);i=0;depth=0
 while i<len(s):
  if s[i:i+2]=='/-':
   depth+=1;out[i:i+2]='  ';i+=2
  elif depth and s[i:i+2]=='-/':
   depth-=1;out[i:i+2]='  ';i+=2
  elif depth:
   if s[i]!='\n':out[i]=' '
   i+=1
  elif s[i:i+2]=='--':
   end=s.find('\n',i);end=len(s) if end<0 else end
   out[i:end]=' '*(end-i);i=end
  else:i+=1
 return ''.join(out)
def index_project():
 paths={'Blueprint/Ch07.lean'};pending=list(paths)
 while pending:
  p=pending.pop()
  for imp in re.findall(r'(?m)^import ([\w.]+)',(ROOT/p).read_text(encoding='utf-8-sig')):
   q=imp.replace('.','/')+'.lean'
   if q.startswith('MolecularDynamics/') and q not in paths:paths.add(q);pending.append(q)
 aliases=defaultdict(list);allitems=[];contexts={}
 for rel in sorted(paths):
  text=(ROOT/rel).read_text(encoding='utf-8-sig');ms=list(COMMAND.finditer(masked_comments(text)));stack=[];context=[]
  for j,m in enumerate(ms):
   code=text[m.start():ms[j+1].start() if j+1<len(ms) else len(text)].rstrip()
   # Remove the next declaration's trailing documentation.
   while code.endswith('-/') and '/-' in code:code=code[:code.rfind('/-')].rstrip()
   kind=m[1];tail=text[m.end():].splitlines()[0].strip()
   if kind in ('namespace','section'):
    stack.append((kind,tail.split()[0] if tail else ''));continue
   if kind=='end':
    if stack:stack.pop()
    continue
   if kind in ('variable','open','local','notation','scoped'):
    context.append(code);continue
   if kind not in ('def','abbrev','structure','class','inductive','theorem','lemma'):continue
   name=re.match(r'[\w.₀-₉]+',tail)
   if not name:continue
   name=name[0];ns='.'.join(x[1] for x in stack if x[0]=='namespace')
   full=(ns+'.'+name).strip('.')
   if kind in ('theorem','lemma'):
    split=re.search(r'\s+:=\s*(?:by\b|\n)',code)
    if split:code=code[:split.start()].rstrip()
    else:
     split=code.rfind(' := ')
     if split>=0:code=code[:split].rstrip()
   d=dict(name=name,namespace=ns,full_name=full,path=rel,line=text[:m.start()].count('\n')+1,kind=kind,code=code)
   allitems.append(d)
   bits=full.split('.')
   for k in range(len(bits)):aliases['.'.join(bits[k:])].append(d)
  contexts[rel]='\n'.join(dict.fromkeys(context))
 return aliases,contexts,allitems

"""Reuse one official Lean compiler worker; save full diagnostics per checked version."""
from common31 import *
import subprocess,threading,queue,time,atexit,os
class LeanCompiler:
 def __init__(self):
  self.proc=subprocess.Popen(['lake','--no-cache','env','lean','--server'],cwd=ROOT,stdin=subprocess.PIPE,stdout=subprocess.PIPE,stderr=(OUT/'lean-server-stderr.log').open('wb'))
  self.messages=queue.Queue();self.version=0;self.uri=(OUT/'ActiveCheck.lean').as_uri()
  threading.Thread(target=self.read,daemon=True).start();atexit.register(self.close)
  self.send(dict(id=1,method='initialize',params=dict(processId=os.getpid(),rootUri=ROOT.as_uri(),capabilities={},initializationOptions=dict(hasWidgets=False))))
  while True:
   m=self.messages.get(timeout=120)
   if m.get('id')==1:
    assert 'error' not in m,m;break
  self.send(dict(method='initialized',params={}))
 def send(self,m):
  b=json.dumps(dict(jsonrpc='2.0',**m)).encode();self.proc.stdin.write(b'Content-Length: '+str(len(b)).encode()+b'\r\n\r\n'+b);self.proc.stdin.flush()
 def read(self):
  try:
   while True:
    headers={}
    while True:
     line=self.proc.stdout.readline()
     if not line:raise EOFError('Lean server exited')
     if line in [b'\r\n',b'\n']:break
     k,v=line.decode().split(':',1);headers[k.lower()]=v.strip()
    n=int(headers['content-length']);b=b''
    while len(b)<n:b+=self.proc.stdout.read(n-len(b))
    self.messages.put(json.loads(b))
  except Exception as e:self.messages.put(dict(reader_error=str(e)))
 def check(self,text,label,source):
  self.version+=1;v=self.version;(OUT/'ActiveCheck.lean').write_text(text,encoding='utf-8')
  if v==1:self.send(dict(method='textDocument/didOpen',params=dict(textDocument=dict(uri=self.uri,languageId='lean4',version=v,text=text))))
  else:self.send(dict(method='textDocument/didChange',params=dict(textDocument=dict(uri=self.uri,version=v),contentChanges=[dict(text=text)])))
  diagnostics=[];events=[];started=time.time();saw_progress=False
  dump(OUT/'LEAN_SERVER_RUNNING.json',dict(pid=self.proc.pid,status='running',label=label,version=v,source_sha256=sha(source)))
  while True:
   m=self.messages.get(timeout=3600)
   events.append(dict(method=m.get('method'),id=m.get('id'),version=m.get('params',{}).get('version'),diagnostics=len(m.get('params',{}).get('diagnostics',[])),processing=m.get('params',{}).get('processing')))
   if 'reader_error' in m:raise RuntimeError(m)
   p=m.get('params',{})
   if m.get('method')=='textDocument/publishDiagnostics' and p.get('uri')==self.uri and p.get('version')==v:
    diagnostics=p.get('diagnostics',[])
   if m.get('method')=='$/lean/fileProgress' and p.get('textDocument',{}).get('uri')==self.uri and p.get('textDocument',{}).get('version')==v:
    if p.get('processing'):saw_progress=True
    elif saw_progress:
     # File completion is emitted after final diagnostics; drain a sync request to fence delivery.
     self.send(dict(id=1000+v,method='textDocument/hover',params=dict(textDocument=dict(uri=self.uri),position=dict(line=len(text.splitlines())-1,character=1))))
   if m.get('id')==1000+v:break
  out='\n'.join(d.get('message','') for d in diagnostics)+'\n'
  log=OUT/'compiled'/(label+'.log');log.write_text(out,encoding='utf-8');dump(OUT/'compiled'/(label+'-lsp-events.json'),events)
  errors=[d for d in diagnostics if d.get('severity')==1]
  names=re.findall(r'(?m)^#print axioms (\S+)',text)
  printed={'MD.Ch08.'+m[1].split('MD.Ch08.')[-1] for m in re.finditer(r"'([^']+)' (?:depends on axioms:|does not depend on any axioms)",out)}
  missing=set(names)-printed
  receipt=dict(command=['lake','--no-cache','env','lean','--server'],mode='official Lean compiler single-file LSP elaboration',exit_code=1 if errors or missing else 0,input_sha256=sha(source),log_sha256=sha(log),version=v,uri=self.uri,elapsed_seconds=time.time()-started,errors=errors,missing_axiom_outputs=sorted(missing),canonical_sha256=sha(LEAN))
  dump(OUT/'compiled'/(label+'.json'),receipt)
  dump(OUT/'LEAN_SERVER_RUNNING.json',dict(pid=self.proc.pid,status='checked',label=label,version=v,exit_code=receipt['exit_code']))
  if errors or missing:print(out[-12000:],flush=True);print('ERRORS',errors,'MISSING',missing,flush=True)
  return receipt
 def close(self):
  try:self.proc.terminate()
  except Exception:pass

COMPILER=None
def compile_text(text,label,source):
 global COMPILER
 if COMPILER is None:COMPILER=LeanCompiler()
 return COMPILER.check(text,label,source)

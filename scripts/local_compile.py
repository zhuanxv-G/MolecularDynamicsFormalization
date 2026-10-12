"""Compiler receipts survive interrupted chats and deduplicate live native jobs."""
import hashlib,json,os,subprocess,time
from pathlib import Path
from datetime import datetime
import psutil
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
def write(p,d):Path(p).write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
def live(d):
    if d.get('status')!='running':return False
    for prefix in ('parent','compiler'):
        if prefix+'_pid' not in d:continue
        try:
            p=psutil.Process(d[prefix+'_pid'])
            if p.create_time()==d[prefix+'_create_time'] and p.is_running():return True
        except psutil.Error:pass
    return False
def compile_recorded(command,cwd,source,log,receipt,*,reuse_failure=False):
    source,log,receipt=map(Path,(source,log,receipt));running=receipt.with_name(receipt.stem+'-RUNNING.json')
    digest=sha(source)
    def saved():
        if not receipt.exists() or not log.exists():return None
        r=json.loads(receipt.read_text(encoding='utf-8-sig'))
        if r.get('input_sha256')==digest and r.get('log_sha256')==sha(log) and (reuse_failure or r['exit_code']==0):return r
    r=saved()
    if r:return r,log.read_bytes(),True
    # Include receipts written before the helper was installed.
    legacy=log.with_name(log.stem.replace('-lean','')+'-RUNNING.json')
    active=next((p for p in [running,legacy] if p.exists() and
        json.loads(p.read_text(encoding='utf-8')).get('input_sha256')==digest and
        live(json.loads(p.read_text(encoding='utf-8')))),None)
    if active:
        print('Waiting for existing compiler; no duplicate launch:',active.name,flush=True)
        while live(json.loads(active.read_text(encoding='utf-8'))):
            r=saved()
            if r:return r,log.read_bytes(),True
            time.sleep(5)
        r=saved()
        if r:return r,log.read_bytes(),True
    assert sha(source)==digest,'Input changed while waiting for a compiler.'
    proc=subprocess.Popen(command,cwd=cwd,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    parent=psutil.Process(os.getpid());child=psutil.Process(proc.pid)
    state=dict(command=command,input_sha256=digest,parent_pid=parent.pid,parent_create_time=parent.create_time(),compiler_pid=child.pid,compiler_create_time=child.create_time(),started_at=datetime.now().isoformat(),status='running')
    write(running,state)
    output=proc.communicate()[0]
    assert sha(source)==digest,'Compiler input changed during execution.'
    log.write_bytes(output)
    r=dict(command=command,exit_code=proc.returncode,input_sha256=digest,log_sha256=sha(log))
    write(receipt,r)
    state.update(status='completed',exit_code=proc.returncode,completed_at=datetime.now().isoformat())
    write(running,state)
    return r,output,False

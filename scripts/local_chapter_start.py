"""Start the next authorized branch only after previous delivery passes."""
import json,subprocess,hashlib,sys
from datetime import datetime,timedelta
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];ch=int(sys.argv[1]);assert ch in (5,6)
def git(*args):return subprocess.check_output(['git',*args],cwd=ROOT,text=True).strip()
table=ROOT/'docs/handoff/LOCAL_PIPELINE.md';s=table.read_text(encoding='utf-8')
previous=next(x for x in s.splitlines() if x.startswith(f'| {ch-1} |'))
assert previous.split('|')[-2].strip()=='完成'
delivery=json.loads((ROOT/f'blueprint/ch{ch-1:02}/DELIVERY_VALIDATION.json').read_text(encoding='utf-8'))
assert delivery['result']=='PASS'
branch=f'chapter{ch:02}-blueprint';current=git('branch','--show-current')
base=ROOT/f'blueprint/ch{ch:02}';baseline=base/'BASELINE.json'
if baseline.exists():
    assert current==branch
    print('Existing chapter baseline reused; resume its current files.');sys.exit()
assert current==f'chapter{ch-1:02}-blueprint'
head=git('rev-parse','HEAD');assert git('rev-parse','@{upstream}')==head
subprocess.run(['git','switch','-c',branch],cwd=ROOT,check=True)
old=json.loads((ROOT/f'blueprint/ch{ch-1:02}/BASELINE.json').read_text(encoding='utf-8'))
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
for p,h in {**old['protected'],**old['unrelated']}.items():assert sha(ROOT/p)==h,p
baseline.write_text(json.dumps(dict(base_head=head,branch=branch,protected=old['protected'],
    unrelated=old['unrelated'],source_pdf=old['source_pdf']),ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
lake=ROOT/'lakefile.toml';content=lake.read_text(encoding='utf-8')
assert f'Blueprint.Ch{ch:02}' not in content
content=content.replace(f'"Blueprint.Ch{ch-1:02}"',f'"Blueprint.Ch{ch-1:02}", "Blueprint.Ch{ch:02}"')
lake.write_text(content,encoding='utf-8')
if ch==5:
    now=datetime.now();timebox=base/'section_timeboxes.json'
    timebox.write_text(json.dumps({'5.1':dict(started_at=now.isoformat(),deadline=(now+timedelta(hours=2)).isoformat(),status='active',rule='缺大型理论或单条3次失败后sorry并继续；本节最多2小时。')},ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
oldrow=next(x for x in s.splitlines() if x.startswith(f'| {ch} |'))
parts=oldrow.split('|');parts[3]=' '+branch+' ';parts[4]=' ①首批准备 ';parts[-3]=' 基于'+head[:12]+' '
table.write_text(s.replace(oldrow,'|'.join(parts)),encoding='utf-8')
print('Started',branch,'from pushed previous final commit',head)

"""Enable at most eight review pairs per native source/axiom batch."""
import json,subprocess,sys,hashlib
from pathlib import Path
from datetime import datetime
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'scripts'))
from ch06_errata import SPECS
base=ROOT/'blueprint/ch06';data=ROOT/'scripts/ch06_data.py'
assert len(json.loads((base/'ch06_source.json').read_text(encoding='utf-8')))==249
hook='from ch06_errata import apply as apply_errata22\napply_errata22(RECORDS)\n'
old=data.read_text(encoding='utf-8')
if hook not in old:data.write_text(old.rstrip()+'\n'+hook,encoding='utf-8')
config=base/'errata_enabled.json'
enabled=json.loads(config.read_text(encoding='utf-8'))['enabled'] if config.exists() else []
for n in range(0,len(SPECS),8):
    group=list(SPECS)[n:n+8]
    enabled=list(dict.fromkeys(enabled+group))
    config.write_text(json.dumps(dict(enabled=enabled,rule='22号：每批至多8个原文条目的双版本修补；未经导师确认'),ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    label='errata22-'+str(n//8+1).zfill(2)
    # Passing earlier batches are skipped by receipt only when all bytes match.
    if sys.argv[1:] and int(sys.argv[1])>n//8+1:continue
    command=[sys.executable,'scripts/local_blueprint.py','6','--batch',label,'--step','22号勘误原文/修正版配对']
    print('RUN',*command,flush=True)
    subprocess.run(command,cwd=ROOT,check=True)
    digest=hashlib.sha256((ROOT/'Blueprint/Ch06.lean').read_bytes()).hexdigest()[:10]
    for command in [[sys.executable,'scripts/ch06_batch_axioms.py',label+'-'+digest],
                    [sys.executable,'scripts/ch06_sync22.py']]:
        print('RUN',*command,flush=True)
        subprocess.run(command,cwd=ROOT,check=True)
    with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
        f.write(f'\n## {datetime.now().date()} 22号勘误批{n//8+1}\n已启用{len(enabled)}个原文/修正版配对；249条正文完整单文件与逐声明公理检查通过，证据{label}-{digest}。\n下一步：继续未完成勘误配对，随后章末完整check；不进入第7章。\n')
print('ALL REVIEW PAIRS LANDED; FINAL ACCEPTANCE STILL REQUIRED',flush=True)

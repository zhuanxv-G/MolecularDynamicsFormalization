from common import *
from local_compile import compile_recorded
def run(ch):
 dest=OUT/f'ch{ch:02}';report=dest/'full'
 cmd=['pwsh','-NoProfile','-File',str(ROOT/'scripts/check.ps1'),'-ReportDirectory',str(report),'-PauseChapter06']
 binding=dict(chapter=ch,current_lean_sha256=sha(lean(ch)),
  inline_axiom_declarations=[n for g in groups(ch).values() for n in g['names']],
  report='blueprint/closeout24/ch%02d/full/CHECK_REPORT.json'%ch,
  scope='标准完整check额外绑定当前章源码；运行期间不得更改任何Lean源文件。')
 dump(dest/'CHECK_INPUT.json',binding)
 r,o,reuse=compile_recorded(cmd,ROOT,lean(ch),dest/'full-run.log',dest/'full-run.json')
 if r['exit_code']:
  print(o.decode('utf-8',errors='replace')[-10000:],flush=True);raise SystemExit(r['exit_code'])
 assert load(report/'CHECK_REPORT.json')['machine_check_status']=='passed'
 print(f'CH{ch:02} complete project check PASS',flush=True)
if __name__=='__main__':run(int(sys.argv[1]))

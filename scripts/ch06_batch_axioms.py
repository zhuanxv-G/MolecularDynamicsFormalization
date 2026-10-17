"""Print every current declaration's axioms in a self-contained source per batch."""
import sys,json
from local_blueprint import ROOT,pipeline,render
from local_compile import compile_recorded
p=pipeline(6);label=sys.argv[1];folder=p.BASE/'validation/batch_axioms';folder.mkdir(exist_ok=True)
source=ROOT/'Blueprint/Ch06.lean';audit=p.BASE/'CheckAxioms.lean'
text=source.read_text(encoding='utf-8')+'\n'+audit.read_text(encoding='utf-8').partition('\n')[2]
probe=folder/(label+'.lean')
if probe.exists():assert probe.read_text(encoding='utf-8')==text
else:probe.write_text(text,encoding='utf-8')
receipt,out,reused=compile_recorded(['lake','env','lean',str(probe.relative_to(ROOT))],ROOT,probe,
    probe.with_suffix('.log'),probe.with_suffix('.json'),reuse_failure=True)
assert receipt['exit_code']==0,out.decode('utf-8',errors='replace')[-5000:]
p.checked(probe.with_suffix('.log'));p.generate();render(6,p)
p.dump(folder/(label+'-binding.json'),dict(canonical_source='Blueprint/Ch06.lean',canonical_sha256=p.sha(source),
    audit_source_sha256=p.sha(audit),combined_source_sha256=p.sha(probe),receipt_sha256=p.sha(probe.with_suffix('.json')),
    scope='entire canonical source followed by all current #print axioms commands; no import of stale chapter olean'))
print('Batch axioms passed:',label,len(p.RECORDS),flush=True)

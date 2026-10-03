from pathlib import Path
import re, json, hashlib

out=Path(__file__).resolve().parent
repo=out.parent.parent/'MolecularDynamicsFormalization'
s=(out/'Hamiltonian.lean').read_text(encoding='utf-8')
s=s.replace('import MolecularDynamics.Chapter01.ParticleCoordinates',
 'import MolecularDynamics.Chapter01.LocalTrajectories')
s=s.replace('namespace T3Implementation','namespace MolecularDynamics').replace('end T3Implementation','end MolecularDynamics')
for name, following in [('massOperator','velocityOperator'),('velocityOperator','coordinateVelocity')]:
 pattern=r'noncomputable def '+name+r' \{n : ℕ\}.*?(?=noncomputable def '+following+r' \{n : ℕ\})'
 s,n=re.subn(pattern,'',s,count=1,flags=re.S)
 assert n==1
pattern=r'theorem massOperator_velocityOperator \{n : ℕ\}.*?(?=/-- T3-K1)'
s,n=re.subn(pattern,'',s,count=1,flags=re.S)
assert n==1
s=re.sub(r'^#print axioms .*\n','',s,flags=re.M)
s=s.replace('massOperator_apply','massOperator_coordinate').replace('velocityOperator_apply','velocityOperator_coordinate')
s=s.replace('This module does not change the formal library. Operator definitions match\nT2-L0 and will be replaced by shared names on coordinated integration.',
 'Proposed integration module, not yet installed in the formal library.\nMass operators are reused from the shared T2 LocalTrajectories module.')
(out/'IntegrationCandidate.lean').write_text(s,encoding='utf-8')
names=re.findall(r'^(?:@\[simp\] )?theorem (\w+)',s,re.M)
checks='\nnamespace MolecularDynamics\n\n'+''.join('#print axioms '+n+'\n' for n in names)+'\nend MolecularDynamics\n'
p=out/'Probe08_IntegrationCandidate.lean'
assert not p.exists()
p.write_text(s+checks,encoding='utf-8')
inputs=[repo/'MolecularDynamics/Chapter01/LocalTrajectories.lean',
 repo/'.lake/build/lib/lean/MolecularDynamics/Chapter01/LocalTrajectories.olean']
(out/'INTEGRATION_INPUTS_BEFORE.json').write_text(json.dumps({'purpose':'Candidate-only compatibility; no source integration',
 'files':[{'path':str(p),'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()} for p in inputs],
 'all_named_declarations_audited':names},ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'candidate_theorems':len(names),'source':'IntegrationCandidate.lean'},ensure_ascii=False))

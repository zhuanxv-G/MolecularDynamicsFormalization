from pathlib import Path
import hashlib, json

out = Path(__file__).resolve().parent
repo = out.parent.parent / 'MolecularDynamicsFormalization'
source = out / 'Probe09_IntegrationExactGoals.lean'
assert not source.exists(), 'Use a new probe name for a new attempt'
candidate = (out / 'IntegrationCandidate.lean').read_text(encoding='utf-8')
spec = (out.parent / 't3-preparation-20261002/Probe03_TargetTypes.tail.txt').read_text(encoding='utf-8')
spec = spec.replace('T3Preparation', 'MolecularDynamics')
proofs = (out / 'SpecProofs.tail.lean').read_text(encoding='utf-8').replace('T3Implementation', 'MolecularDynamics')
source.write_text(candidate + '\n' + spec + '\n' + proofs, encoding='utf-8')
inputs = [repo/'MolecularDynamics/Chapter01/LocalTrajectories.lean',
    repo/'.lake/build/lib/lean/MolecularDynamics/Chapter01/LocalTrajectories.olean']
before = json.loads((out/'INTEGRATION_INPUTS_BEFORE.json').read_text(encoding='utf-8'))
after = {'purpose': 'Input continuity between candidate and exact-goal compatibility runs',
    'files': [{'path': str(p), 'bytes': p.stat().st_size,
        'sha256': hashlib.sha256(p.read_bytes()).hexdigest()} for p in inputs]}
after['unchanged_since_probe08'] = after['files'] == before['files']
assert after['unchanged_since_probe08'], 'Shared T2 input changed; inspect before relying on compatibility'
(out/'INTEGRATION_INPUTS_AFTER.json').write_text(json.dumps(after, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
print(json.dumps({'source': source.name, 'shared_inputs_unchanged': True}))

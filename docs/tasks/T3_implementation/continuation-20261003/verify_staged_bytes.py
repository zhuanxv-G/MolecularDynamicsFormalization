from pathlib import Path
import hashlib
import json
import subprocess

repo = Path(__file__).resolve().parents[4]
git = ['git', '-c', f'safe.directory={repo.as_posix()}']
sha = lambda data: hashlib.sha256(data).hexdigest()
blob = lambda path: subprocess.check_output(git + ['show', ':' + path], cwd=repo)
delivery = repo / 'docs/tasks/T3_implementation'
manifest = json.loads((delivery / 'MANIFEST.json').read_text(encoding='utf-8-sig'))
for entry in manifest['files']:
    path = 'docs/tasks/T3_implementation/' + entry['path']
    staged = blob(path)
    assert len(staged) == entry['bytes'] and sha(staged) == entry['sha256'], path
report = json.loads((repo / 'docs/verification/2026-10-03-T3-first-batch-retry03/CHECK_REPORT.json').read_text(encoding='utf-8-sig'))
for entry in report['inputs']:
    path = entry['relative_path'].replace('\\', '/')
    assert sha(blob(path)) == entry['sha256'], 'Checked input/index mismatch: ' + path
candidate = (delivery / 'evidence/IntegrationCandidate.lean').read_text(encoding='utf-8')
formal = (repo / 'MolecularDynamics/Chapter01/Hamiltonian.lean').read_text(encoding='utf-8')
assert candidate.split('namespace MolecularDynamics', 1)[1] == formal.split('namespace MolecularDynamics', 1)[1]
record = {
    'frozen_manifest_staged_files_verified': len(manifest['files']),
    'accepted_inputs_staged_hashes_verified': len(report['inputs']),
    'formal_mathematical_body_matches_candidate': True,
    'formal_source_sha256': sha(blob('MolecularDynamics/Chapter01/Hamiltonian.lean')),
}
print(json.dumps(record, ensure_ascii=False))

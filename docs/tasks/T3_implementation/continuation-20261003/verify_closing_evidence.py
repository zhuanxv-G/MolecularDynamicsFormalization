"""Verify the fixed T3 commit and received CI evidence without rerunning Lean."""
from datetime import datetime
import hashlib
import json
from pathlib import Path
import subprocess
import zipfile

repo = Path(__file__).resolve().parents[4]
delivery = repo / 'docs/tasks/T3_implementation'
continuation = Path(__file__).resolve().parent
ci = repo / 'docs/verification/2026-10-03-T3-first-batch-retry03/remote-ci'
commit = '21b4d6cbb5121c5f194a4dda9b9d718148b2e1a1'
expected_zip_sha = '0124589fa611127393b6394e14d282a9fce319d4cc06eb666116347de5d4e0b1'


def digest(data):
    return hashlib.sha256(data).hexdigest()


def read_json(path):
    return json.loads(path.read_text(encoding='utf-8-sig'))


def git_blob(path):
    return subprocess.check_output(['git', 'show', f'{commit}:{path}'], cwd=repo)


run = read_json(ci / 'WORKFLOW_RUN.json')
jobs = read_json(ci / 'WORKFLOW_JOBS.json')['jobs']
artifacts = read_json(ci / 'WORKFLOW_ARTIFACTS.json')['artifacts']
report = read_json(ci / 'artifact/CHECK_REPORT.json')
assert run['id'] == 37101092891 and run['head_sha'] == commit
assert run['status'] == 'completed' and run['conclusion'] == 'success'
assert any(j['id'] == 111140613029 and j['conclusion'] == 'success' for j in jobs)
assert report['head'] == commit and report['exit_code'] == 0
assert report['machine_check_status'] == 'passed'
assert report['expected_toolchain'] == 'leanprover/lean4:v4.34.0'
assert report['actual_mathlib_revision'] == '5ed2965256430c3649e86755f9576b54eca72435'
assert 'version 4.34.0' in report['lean_version']
artifact = next(a for a in artifacts if a['id'] == 11266920446)
zip_bytes = (ci / 'ARTIFACT.zip').read_bytes()
assert artifact['digest'] == 'sha256:' + expected_zip_sha
assert len(zip_bytes) == artifact['size_in_bytes'] == 5013
assert digest(zip_bytes) == expected_zip_sha
with zipfile.ZipFile(ci / 'ARTIFACT.zip') as archive:
    assert archive.testzip() is None
    members = archive.namelist()
    assert len(members) == 11
    for name in members:
        assert '..' not in Path(name).parts and not Path(name).is_absolute()
        assert archive.read(name) == (ci / 'artifact' / name).read_bytes()

current_differences = []
fixed_inputs = []
for item in report['inputs']:
    path = item['relative_path'].replace('\\', '/')
    data = git_blob(path)
    assert digest(data) == item['sha256'], 'CI input differs from Git blob: ' + path
    fixed_inputs.append({'path': path, 'bytes': len(data), 'sha256': digest(data)})
    if digest((repo / path).read_bytes()) != item['sha256']:
        current_differences.append(path)
assert len(fixed_inputs) == 15
for check in report['checks']:
    assert check['exit_code'] == 0, check['name']
    raw_log = (ci / 'artifact' / check['raw_log']).read_bytes()
    assert digest(raw_log) == check['raw_log_sha256'], check['raw_log']
build_log = (ci / 'artifact/lake_build.log').read_text(encoding='utf-8')
axioms_log = (ci / 'artifact/axiom_dependencies.log').read_text(encoding='utf-8')
assert '8932 jobs' in build_log
assert '171 imported project declarations' in axioms_log

manifest = read_json(delivery / 'MANIFEST.json')
for item in manifest['files']:
    path = 'docs/tasks/T3_implementation/' + item['path']
    for data in [git_blob(path), (repo / path).read_bytes()]:
        assert len(data) == item['bytes'] and digest(data) == item['sha256'], path
assert len(manifest['files']) == 56

probe_sources = []
for name in ['FormalExactGoals', 'FormalBoundaries']:
    result = read_json(continuation / f'{name}.result.json')
    path = f'docs/tasks/T3_implementation/continuation-20261003/{name}.lean'
    source = (continuation / f'{name}.lean').read_bytes()
    assert source == git_blob(path)
    assert digest(source) == result['source_sha256'] and result['exit_code'] == 0
    assert digest((continuation / f'{name}.log').read_bytes()) == result['output_sha256']
    assert result['formal_source_sha256'] == digest(git_blob('MolecularDynamics/Chapter01/Hamiltonian.lean'))
    probe_sources.append({'path': path, 'bytes': len(source), 'sha256': digest(source)})
assert 'MolecularDynamics/Chapter01/Hamiltonian.lean' not in current_differences
assert 'MolecularDynamics/Chapter01/LocalTrajectories.lean' not in current_differences

received_files = []
for path in sorted(ci.rglob('*')):
    if path.is_file() and path.name != 'RECEIPT_VERIFICATION.json':
        data = path.read_bytes()
        received_files.append({'path': path.relative_to(repo).as_posix(), 'bytes': len(data), 'sha256': digest(data)})
record = {
    'verified_at': datetime.now().astimezone().isoformat(),
    'kind': 'Fixed T3 evidence receipt verification; no new Lean execution',
    'fixed_t3_commit': commit,
    'current_head': subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=repo, text=True).strip(),
    'workflow_run_id': run['id'],
    'workflow_conclusion': run['conclusion'],
    'artifact_id': artifact['id'],
    'artifact_zip_bytes': len(zip_bytes),
    'artifact_zip_sha256': digest(zip_bytes),
    'zip_members_verified': len(members),
    'fixed_commit_inputs_verified': fixed_inputs,
    'current_worktree_differs_from_t3_check_inputs': current_differences,
    'current_differences_reason': 'Later T4 commits changed shared imports and audit probes; the T3 run covers the fixed T3 commit.',
    'frozen_delivery_files_verified': len(manifest['files']),
    'probe_source_files_verified': probe_sources,
    'ci_raw_logs_verified': len(report['checks']),
    'build_jobs': 8932,
    'audited_project_declarations': 171,
    'job_log_saved_form': 'Connector-decoded text saved as UTF-8 with LF; original artifact raw logs separately byte-verified.',
    'received_files': received_files,
    'passed': True,
}
(ci / 'RECEIPT_VERIFICATION.json').write_text(json.dumps(record, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
print(json.dumps({k: v for k, v in record.items() if k not in ['fixed_commit_inputs_verified', 'received_files']}, ensure_ascii=False))

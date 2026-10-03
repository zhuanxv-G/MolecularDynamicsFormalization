from datetime import datetime, timezone, timedelta
from pathlib import Path
import hashlib
import json
import os
import subprocess
import time

out = Path(__file__).resolve().parent
repo = out.parents[3]
bin_dir = Path(r'C:\Users\ustc\.elan\toolchains\leanprover--lean4---v4.34.0\bin')
env = os.environ.copy()
env['PATH'] = str(bin_dir) + os.pathsep + env['PATH']
safe_dirs = [repo] + sorted(p for p in (repo / '.lake/packages').iterdir()
                          if p.is_dir() and (p / '.git').exists())
for index, path in enumerate(safe_dirs):
    assert path.resolve().is_relative_to(repo.resolve())
    env[f'GIT_CONFIG_KEY_{index}'] = 'safe.directory'
    env[f'GIT_CONFIG_VALUE_{index}'] = path.as_posix()
env['GIT_CONFIG_COUNT'] = str(len(safe_dirs))
sha = lambda path: hashlib.sha256(path.read_bytes()).hexdigest()
formal_source = repo / 'MolecularDynamics/Chapter01/Hamiltonian.lean'

for name in ['FormalExactGoals', 'FormalBoundaries']:
    source = out / f'{name}.lean'
    log = out / f'{name}.log'
    result = out / f'{name}.result.json'
    assert not log.exists() and not result.exists(), 'Preserve earlier evidence'
    started = datetime.now(timezone(timedelta(hours=8)))
    tick = time.monotonic()
    command = [str(bin_dir / 'lake.exe'), 'env', 'lean', str(source)]
    with log.open('wb') as stream:
        code = subprocess.run(command, cwd=repo, env=env, stdout=stream,
                              stderr=subprocess.STDOUT, check=False).returncode
    record = {
        'command': command, 'cwd': str(repo), 'started_at': started.isoformat(),
        'elapsed_seconds': round(time.monotonic() - tick, 3), 'exit_code': code,
        'source_sha256': sha(source), 'output_sha256': sha(log),
        'formal_source_sha256': sha(formal_source), 'runner_sha256': sha(Path(__file__)),
        'purpose': 'Original nine goals and seven boundaries against the installed module',
        'git_safe_directories_scope': 'current process and fixed local dependencies',
    }
    result.write_text(json.dumps(record, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(record, ensure_ascii=False), flush=True)
    if code:
        print(log.read_text(encoding='utf-8', errors='replace'), flush=True)
        raise SystemExit(code)

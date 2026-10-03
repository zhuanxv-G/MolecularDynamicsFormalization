from pathlib import Path
from datetime import datetime, timezone, timedelta
import hashlib, json, os, subprocess, sys, time

out = Path(__file__).resolve().parent
repo = out.parent.parent/'MolecularDynamicsFormalization'
bin_dir = Path(r'C:\Users\ustc\.elan\toolchains\leanprover--lean4---v4.34.0\bin')
env = os.environ.copy()
env['PATH'] = str(bin_dir)+os.pathsep+env['PATH']
# The sandbox Windows account differs from the checkout owner. Scope Git's
# ownership exceptions to this process and these existing project checkouts.
git_dirs = [repo] + sorted(p for p in (repo/'.lake/packages').iterdir()
    if p.is_dir() and (p/'.git').exists())
for p in git_dirs:
    assert p.resolve().is_relative_to(repo.resolve())
count = int(env.get('GIT_CONFIG_COUNT', '0'))
for p in git_dirs:
    env[f'GIT_CONFIG_KEY_{count}'] = 'safe.directory'
    env[f'GIT_CONFIG_VALUE_{count}'] = p.as_posix()
    count += 1
env['GIT_CONFIG_COUNT'] = str(count)
mathlib = subprocess.check_output(['git','-C',str(repo/'.lake/packages/mathlib'),
    'rev-parse','HEAD'], env=env, text=True).strip()
assert mathlib == '5ed2965256430c3649e86755f9576b54eca72435'
for filename in sys.argv[1:]:
    source = (out/filename).resolve()
    assert source.is_relative_to(out) and source.is_file()
    log, result = source.with_suffix('.log'), source.with_suffix('.result.json')
    assert not log.exists() and not result.exists(), 'Evidence is immutable'
    cmd = [str(bin_dir/'lake.exe'), 'env', 'lean', str(source)]
    start, tick = datetime.now(timezone(timedelta(hours=8))), time.monotonic()
    with log.open('wb') as f:
        p = subprocess.Popen(cmd, cwd=repo, env=env, stdout=f, stderr=subprocess.STDOUT)
        try:
            code = p.wait(timeout=180)
        except subprocess.TimeoutExpired:
            subprocess.run(['taskkill','/PID',str(p.pid),'/T','/F'],capture_output=True,timeout=15)
            f.write(b'\nTIMEOUT after 180 seconds; scoped process cleanup\n')
            code = 124
    sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
    record = {'command': cmd, 'cwd': str(repo), 'started_at': start.isoformat(),
        'elapsed_seconds': round(time.monotonic()-tick,3), 'exit_code': code,
        'source_sha256': sha(source), 'output_sha256': sha(log),
        'runner_sha256': sha(Path(__file__)), 'pinned_lean': 'leanprover/lean4:v4.34.0',
        'mathlib_revision': mathlib, 'process_scoped_git_safe_directories': [p.as_posix() for p in git_dirs]}
    result.write_text(json.dumps(record,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(record,ensure_ascii=False))
    print(log.read_text(encoding='utf-8',errors='replace'))
    if code: sys.exit(code)

from pathlib import Path
import os, sys, subprocess, hashlib, json, time
from datetime import datetime, timezone, timedelta

sys.stdout.reconfigure(encoding='utf-8')

out = Path(__file__).resolve().parent
repo = out.parent.parent / 'MolecularDynamicsFormalization'
bin_dir = Path(r'C:\Users\ustc\.elan\toolchains\leanprover--lean4---v4.34.0\bin')
env = os.environ.copy()
env['PATH'] = str(bin_dir) + os.pathsep + env['PATH']
for relative in sys.argv[1:]:
    source = (out / relative).resolve()
    if not source.is_file() or not source.is_relative_to(out):
        raise RuntimeError('Probe must be inside the T3 preparation directory')
    log, result_path = source.with_suffix('.log'), source.with_suffix('.result.json')
    if log.exists() or result_path.exists():
        raise RuntimeError('Existing evidence is immutable; use a new attempt name')
    command = [str(bin_dir/'lake.exe'), 'env', 'lean', str(source)]
    start, tick = datetime.now(timezone(timedelta(hours=8))), time.monotonic()
    # Direct-to-file output prevents a surviving Windows child from keeping
    # communicate() pipes open after a Lake parent timeout.
    with log.open('wb') as output_file:
        p = subprocess.Popen(command, cwd=repo, env=env,
            stdout=output_file, stderr=subprocess.STDOUT)
        try:
            code = p.wait(timeout=180)
        except subprocess.TimeoutExpired:
            cleanup = subprocess.run(['taskkill','/PID',str(p.pid),'/T','/F'],
                capture_output=True, timeout=15)
            output_file.write(b'\nTIMEOUT after 180 seconds; scoped process-tree cleanup\n')
            output_file.write(cleanup.stdout + cleanup.stderr)
            try:
                p.wait(timeout=10)
            except subprocess.TimeoutExpired:
                p.kill()
            code = 124
    output = log.read_text(encoding='utf-8', errors='replace')
    result = {'command': command, 'cwd': str(repo), 'started_at': start.isoformat(),
        'elapsed_seconds': round(time.monotonic()-tick,3), 'exit_code': code,
        'source_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
        'output_sha256': hashlib.sha256(log.read_bytes()).hexdigest(),
        'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'pinned_lean': 'leanprover/lean4:v4.34.0',
        'mathlib_revision': subprocess.check_output(['git','-C','.lake/packages/mathlib','rev-parse','HEAD'], cwd=repo,text=True).strip()}
    result_path.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(result,ensure_ascii=False))
    print(output)
    if code != 0:
        sys.exit(code)

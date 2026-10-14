"""Record the user's website-repair exception in the active chapter baseline.

Only explicitly owned review artifacts may change. Formal-library source hashes
remain enforced. Python cache regeneration is recorded but never staged.
"""
import json
from pathlib import Path
from integrate_website_returns import ROOT, sha, dump


def refresh(receipt, paths):
    p=ROOT/'blueprint/ch06/BASELINE.json'
    b=json.loads(p.read_text(encoding='utf-8-sig'))
    allowed=set(paths)
    # Driver output can continue after refresh/commit; compiler evidence is
    # instead hashed by CHECK_REPORT/FINAL_COMPILE and remains protected.
    runner_logs={rel for rel in allowed if rel.startswith('blueprint/') and Path(rel).name in ('finalize-run.log','run.log')}
    volatile=[]
    for rel in runner_logs:
        expected=b['protected'].pop(rel,None)
        if expected:
            volatile.append(dict(path=rel,previous_sha256=expected,current_sha256=sha(ROOT/rel),reason='acceptance/commit driver output; not a mathematical input or compiler evidence'))
    allowed-=runner_logs
    changes=[]
    for rel,expected in b['protected'].items():
        current=sha(ROOT/rel)
        if current!=expected:
            assert rel in allowed and not rel.startswith('MolecularDynamics/'),rel
            changes.append(dict(path=rel,before_sha256=expected,after_sha256=current))
            b['protected'][rel]=current
    runtime=[]
    for rel,expected in b['unrelated'].items():
        current=sha(ROOT/rel)
        if current!=expected:
            assert rel in ('scripts/__pycache__/ch01_full_tools.cpython-312.pyc','scripts/__pycache__/render_blueprint.cpython-312.pyc'),rel
            runtime.append(dict(path=rel,before_sha256=expected,after_sha256=current,reason='Python import regenerated runtime cache; source unchanged; never staged'))
            b['unrelated'][rel]=current
    for rel in allowed:
        assert not rel.startswith(('MolecularDynamics/','tmp/','output/','scripts/__pycache__/')),rel
        if (ROOT/rel).is_file():b['protected'][rel]=sha(ROOT/rel)
    b.setdefault('licensed_website_repair_exceptions',[]).append(dict(
        authorization='用户2026-10-13网站版本绑定/修复新指令',receipt=receipt,
        changed_files=changes,runtime_cache_refresh=runtime,volatile_runner_logs=volatile,formal_library_hashes='unchanged'))
    dump(p,b)
    print('Active baseline: licensed review changes',len(changes),'runtime cache records',len(runtime))

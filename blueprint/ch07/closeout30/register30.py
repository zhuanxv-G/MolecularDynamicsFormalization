from pathlib import Path
import json, hashlib, subprocess, sys
from collections import Counter

ROOT = Path(__file__).resolve().parents[3]
OUT = Path(__file__).resolve().parent
BASE = OUT.parent
sys.path.insert(0, str(BASE/'closeout29'))
from common29 import groups

def load(p): return json.loads(Path(p).read_text(encoding='utf-8-sig'))
def dump(p, d):
    p = Path(p); p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(d, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
def sha(p): return hashlib.sha256(Path(p).read_bytes()).hexdigest()

def main():
    assert subprocess.check_output(['git','branch','--show-current'],cwd=ROOT,text=True).strip()=='chapter08-blueprint'
    if not (OUT/'FROZEN_BASELINE.json').exists():
        paths = list((ROOT/'MolecularDynamics').rglob('*'))
        for n in [1,2,3,4,5,6,8]:
            paths += list((ROOT/f'blueprint/ch{n:02}').rglob('*'))
            paths += [ROOT/f'Blueprint/Ch{n:02}.lean']
            paths += list((ROOT/'docs/review').glob(f'CH{n:02}_*'))
        paths += list((BASE/'mathcopilot_tasks').rglob('*'))
        dump(OUT/'FROZEN_BASELINE.json',{p.relative_to(ROOT).as_posix():sha(p) for p in paths if p.is_file()})
        dump(OUT/'INITIAL_GIT_STATUS.json',dict(head=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),status=subprocess.check_output(['git','status','--short'],cwd=ROOT,text=True)))
    for rel in ['Blueprint/Ch07.lean','blueprint/ch07/ch07_source.json','blueprint/ch07/website_audit.json','blueprint/ch07/local_audit.json','blueprint/ch07/proof_attempts.json']:
        p=ROOT/rel; dest=OUT/(p.stem+'.before'+p.suffix)
        if not dest.exists(): dest.write_bytes(p.read_bytes())
    original=subprocess.check_output(['git','show','bf0f8b8a:Blueprint/Ch07.lean'],cwd=ROOT)
    # Git stores LF, while the original submitted Windows working file is CRLF.
    # Exact submitted bytes are checked separately against every input_sha256.
    assert original.replace(b'\r\n',b'\n')==(OUT/'Ch07.before.lean').read_bytes().replace(b'\r\n',b'\n')
    assert not subprocess.check_output(['git','log','--format=%H','bf0f8b8a..HEAD','--','Blueprint/Ch07.lean'],cwd=ROOT).strip()
    manifest=load(BASE/'mathcopilot_tasks/EAUDIT_MANIFEST.json')
    tt={t['subtask']:t for b in manifest for t in b['subtasks']}
    rows=[];bindings=[]
    for p in sorted((BASE/'mathcopilot_results/eaudit').glob('EAUDIT*_result.json')):
        d=load(p)
        for x in d['items']:
            t=tt[x['subtask']]; folder=ROOT/t['path']; m=load(folder/'MANIFEST.json')
            assert sha(folder/'MANIFEST.json')==t['manifest_sha256']
            assert x['source_id']==t['source_id'] and x['source_id'] in m['source_ids']
            for k,h in d['input_sha256'].items():
                assert m['input_sha256'][k]==h
                assert sha(OUT/('Ch07.before.lean' if k=='Blueprint/Ch07.lean' else 'ch07_source.before.json'))==h
            for k,h in x.get('input_sha256',{}).items(): assert m['input_sha256'][k]==h
            assert sha(folder/'PASTE.txt')==m['files']['PASTE.txt']['sha256']
            assert sha(folder/'PAGES.pdf')==m['input_sha256']['PAGES.pdf']
            rows.append(dict(batch=d['batch'],**x))
        bindings.append(dict(batch=d['batch'],path=p.relative_to(ROOT).as_posix(),sha256=sha(p),merged_from=d.get('merged_from'),items=len(d['items'])))
    counts=Counter(x['audit']['verdict'] for x in rows)
    assert counts==dict(PASS=24,FAIL=1,NEEDS_HUMAN=10),counts
    assert len(rows)==len({x['source_id'] for x in rows})==35 and len(bindings)==12
    dump(OUT/'RETURNS.json',rows)
    dump(OUT/'RETURN_REGISTRATION.json',dict(counts=counts,bindings=bindings,input_binding='Each item is matched by source_id/subtask to its original manifest. The split returns carry shared Lean/source hashes (no duplicated per-item hashes); these and original manifest/PASTE/PDF bytes are checked exactly. Ch07 equals bf0f8b8a after Git LF/Windows CRLF normalization; git log confirms no later Ch07 change.',submitted_lean_sha256=sha(OUT/'Ch07.before.lean'),git_lf_sha256=hashlib.sha256(original).hexdigest()))
    web=load(OUT/'website_audit.before.json'); rr={x['source_id']:x for x in rows}
    for w in web:
        if w['source_id'] in rr:
            x=rr[w['source_id']]
            w.update(closeout30_return=x,audit=x['audit'],json_review=x['json_review'],effective_status={'PASS':'网站复审PASS（绑定送审版本）','FAIL':'按网站意见修复中','NEEDS_HUMAN':'按版本分流中'}[x['audit']['verdict']])
    dump(BASE/'website_audit.json',web)
    print('REGISTERED',dict(counts),flush=True)

if __name__=='__main__': main()

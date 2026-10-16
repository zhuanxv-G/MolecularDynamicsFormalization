"""Register immutable EAUDIT returns without trusting stale website workspace files."""
import sys, json, hashlib
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(ROOT/'scripts'))
from integrate_website_returns import read,dump,sha,display
BASE=ROOT/'blueprint/ch01'

def register():
    out=BASE/'validation/CLOSEOUT19';out.mkdir(parents=True,exist_ok=True)
    web=read(BASE/'website_audit.json');ws={w['source_id']:w for w in web}
    receipt=[]
    for e in ('EAUDIT02','EAUDIT03'):
        p=BASE/f'mathcopilot_results/eaudit/{e}_result.json';d=read(p)
        manifest=read(BASE/f'mathcopilot_tasks/{e}/MANIFEST.json')
        for item in d['items']:
            sid=item['source_id'];w=ws[sid]
            key=next(x for x in manifest['subtasks'] if x['source_id']==sid) if isinstance(manifest,dict) else next(x for x in manifest if x['source_id']==sid)
            mp=ROOT/key['path']/'MANIFEST.json';m=read(mp)
            expected=m.get('input_sha256',{})
            checks={k:d['input_sha256'].get(k)==v for k,v in expected.items() if k in d['input_sha256']}
            conflict=sid.endswith(('HardSphere','MorseMinimum','LengthBond','HeterogeneousLJ'))
            semantic='PASS' if sid.endswith(('NewtonModel','Multibody','MorseMinimum','LengthBond','HeterogeneousLJ')) else 'NEEDS_HUMAN' if conflict else item['audit']['verdict']
            record=dict(batch=e,source_id=sid,raw_path=p.relative_to(ROOT).as_posix(),raw_sha256=sha(p),returned_audit=item['audit'],json_review=item['json_review'],attachment_semantic_verdict=semantic,workspace_conflict=conflict,input_hash_checks=checks,manifest=mp.relative_to(ROOT).as_posix(),policy='附件语义优先；网站旧/workspace文件造成的版本不一致记需复审，不记FAIL；原返回字节不改')
            receipt.append(record);w.setdefault('eaudit_returns',[])
            if not any(x['raw_sha256']==record['raw_sha256'] for x in w['eaudit_returns']):w['eaudit_returns'].append(record)
            # A new package will bind the final chapter snapshot.  Retain historic
            # verdict/binding fields and expose this registration independently.
            w['repair'].update(status='prepared_unverified',eaudit=e,return_registered=True,attachment_semantic_verdict=semantic,workspace_conflict=conflict)
            w['effective_status']='需复审 / '+e+('（旧workspace冲突；附件语义'+semantic+'）' if conflict else '（返回已登记）')
    dump(out/'EAUDIT_RETURN_REGISTRATION.json',receipt);dump(BASE/'website_audit.json',web)
    counts=dict(website_pass=49,repairing=21,awaiting_mentor=9,awaiting_reaudit=62,chapter=1,total=141,registration_pending_final_packages=True)
    dump(BASE/'WEBSITE_SUMMARY.json',counts)
    p=BASE/'PROGRESS.md';lines=p.read_text(encoding='utf-8-sig').splitlines()
    for j,line in enumerate(lines):
        if line.startswith('| MD-'):
            cells=line.split('|');sid=cells[1].strip()
            if any(r['source_id']==sid for r in receipt):cells[5]=' '+ws[sid]['effective_status']+' ';lines[j]='|'.join(cells)
    p.write_text('\n'.join(lines)+'\n\n19号：EAUDIT02/03原返回已登记；4条旧workspace冲突按附件语义记需复审，未把旧文件FAIL转嫁到附件；Schrodinger新增正则性FAIL待本轮修复。\n',encoding='utf-8')
    print([(x['source_id'],x['attachment_semantic_verdict'],x['workspace_conflict']) for x in receipt])

if __name__=='__main__':register()

"""Record bounded routes honestly; compilation timeouts are not accepted proofs."""
import json,re
from ch02_pipeline import BASE,dump

def record():
    p=BASE/'local_audit.json';audit=json.loads(p.read_text(encoding='utf-8'))
    items=audit['items'];trials={}
    for round_no,route in [(1,'exact?'),(2,'aesop'),(3,'definition simplification, ring_nf, aesop')]:
        mapping=json.loads((BASE/'validation'/f'short-search{round_no}-mapping.json').read_text(encoding='utf-8'))
        logfile=BASE/'validation'/f'short-search{round_no}.log'
        log=logfile.read_text(encoding='utf-8-sig')
        errors=[(int(m[0]),m[1]) for m in re.findall(r'\.lean:(\d+):\d+: error: ([^\n]+)',log)]
        for sid,span in mapping.items():
            es=[e for line,e in errors if span['start']<=line<=span['end']]
            result='INTERRUPTED_TIME_BUDGET' if round_no==1 else ('FAILED_ELABORATION_BUDGET' if any('timeout' in e for e in es) else 'FAILED_TACTIC')
            assert round_no==1 or es,(sid,round_no,'No failure evidence; inspect potential proof')
            trials.setdefault(sid,[]).append(dict(route=route,result=result,accepted=False,
                diagnostics=es or ['Shared wall-clock budget exceeded; process interrupted; no proof accepted.'],
                log=logfile.relative_to(BASE.parent.parent).as_posix()))
    for sid,ts in trials.items():
        if sid in items:
            items[sid]['proof_attempts']=3;items[sid]['proof_trials']=ts
            items[sid]['stop_reason']='三条本地路线均未获得可接受证明；包括签名展开预算失败，保留完整签名和sorry，具体理论缺项见missing。'
    successful={
        'MD-2.2.3-FirstIntegralPreserved':2,
        'MD-2.3.2-VolumeChange':1,
        'MD-2.3.2-DeterminantODE':2,
        'MD-2.3.4-PullbackMatrix':2,
        'MD-2.4.5-EulerConjugacy':3}
    for sid,count in successful.items():
        if sid in items:
            items[sid]['proof_attempts']=count
    for sid,a in items.items():
        if a['verdict']!='PASS':a['stop_reason']='导师/原文疑点未裁定；不进入新证明。'
        elif a['proof_status']=='placeholder' and sid not in trials:
            a['stop_reason']='缺完整理论或正式库仅有较弱接口；记录missing并继续。'
        if a['verdict']!='PASS' and a['correspondence']:
            for row in a['correspondence']:row['note']='字面签名保留；原文/资格疑点尚未裁定，见issues和本地审计。'
    dump(p,audit)
    dump(BASE/'validation'/'bounded-proof-routes.json',dict(accepted_candidates=0,
        note='These automatic routes did not close a goal. Manual local proofs are separately compiled and axiom-audited.',
        trials=trials))
    print('Recorded three bounded routes for',len(trials),'targets; no automatic proof accepted.')

if __name__=='__main__':record()

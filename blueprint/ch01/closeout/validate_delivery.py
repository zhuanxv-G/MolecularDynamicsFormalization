"""Validate delivered bytes, declaration coverage, original pages and frozen inputs."""
import sys,re,json,hashlib,collections,subprocess
from pathlib import Path
import fitz
ROOT=Path(__file__).resolve().parents[3];sys.path.insert(0,str(ROOT/'scripts'))
from integrate_website_returns import read,dump,sha
from eaudit_review_tasks import declarations,declaration_names
BASE=ROOT/'blueprint/ch01';OUT=BASE/'validation/CLOSEOUT19'

def validate(require_full=False):
    ds=declarations(1);src={s['source_id']:s for s in read(BASE/'ch01_source.json')};web={w['source_id']:w for w in read(BASE/'website_audit.json')}
    pending=set(read(OUT/'PENDING_SOURCE_IDS.json'));packages=read(OUT/'CURRENT_EAUDIT_PACKAGES.json');errata=read(OUT/'ERRATA_RECORDS.json')
    actual_lean=sha(ROOT/'Blueprint/Ch01.lean');actual_source=sha(BASE/'ch01_source.json')
    frozen=read(OUT/'FROZEN_INPUTS.json');assert all(sha(ROOT/p)==h for p,h in frozen.items())
    assert not subprocess.check_output(['git','diff','--name-only','93d2d3e5','--','MolecularDynamics/','Blueprint/Ch02.lean','Blueprint/Ch03.lean','Blueprint/Ch04.lean','Blueprint/Ch05.lean'],cwd=ROOT)
    other=read(ROOT/'docs/handoff/REPAIR_DELIVERY_VALIDATION.json')
    for ch in range(2,6):
        a=other['chapters'][str(ch)]
        assert sha(ROOT/f'Blueprint/Ch{ch:02}.lean')==a['lean_sha256']
        assert sha(ROOT/f'blueprint/ch{ch:02}/ch{ch:02}_source.json')==a['source_sha256']
    raw={}
    for row in read(OUT/'EAUDIT_RETURN_REGISTRATION.json'):
        p=ROOT/row['raw_path'];assert sha(p)==row['raw_sha256'];assert all(row['input_hash_checks'].values())
        mp=ROOT/row['manifest'];m=read(mp);folder=mp.parent;assert sha(folder/'PASTE.txt')==m['paste_sha256']
        pdf=next(folder.glob('*PAGES.pdf'));assert sha(pdf)==m['input_sha256'][pdf.name]
        raw[row['raw_path']]=sha(p)
    pdf=next(ROOT.parent.glob('Leimkuhler2015b*.pdf'));book=fitz.open(pdf);seen=[];packet_rows=[];dep_count=0
    for e in packages:
        assert len(e['source_ids'])<=8 and e['lean_sha256']==actual_lean and e['source_sha256']==actual_source
        task=ROOT/e['task_index'];assert task.exists();rootm=read(task.parent/'MANIFEST.json')
        assert rootm['input_sha256']==e['input_sha256']
        for row in e['subtasks']:
            sid=row['source_id'];seen.append(sid);folder=ROOT/row['path'];mp=folder/'MANIFEST.json';m=read(mp);paste=folder/'PASTE.txt';t=paste.read_text(encoding='utf-8')
            assert sha(mp)==row['manifest_sha256'];assert sha(paste)==m['paste_sha256']
            assert t.startswith('以本 PASTE 和附件为准') and 'Mathlib 标准库定义按标准数学含义直接采信' in t
            for k,h in m['input_sha256'].items():assert '"'+k+'": "'+h+'"' in t
            assert ds[sid]['block'] in t and m['source_declarations']==declaration_names(ds[sid]['block'])
            assert m['source_block_sha256']==ds[sid]['block_sha256']
            if sid in {x['source_id'] for x in errata}:assert '原文版为忠实转录，修正版为勘误版本，请分别审校' in t
            # Mathematical source fields and all annotations are included; history remains file-hash-bound.
            displayed=json.loads(re.search(r'## 原文JSON\n```json\n([\s\S]*?)\n```',t).group(1))
            assert displayed=={k:v for k,v in src[sid].items() if k!='repair_log'}
            crop=next(folder.glob('*PAGES.pdf'));assert sha(crop)==m['input_sha256'][crop.name]
            cropped=fitz.open(crop);assert len(cropped)==len(m['pdf_page_mapping'])
            for i,n in enumerate(m['pdf_page_mapping']):
                assert cropped[i].get_pixmap(matrix=fitz.Matrix(.5,.5)).samples==book[n-1].get_pixmap(matrix=fitz.Matrix(.5,.5)).samples
            for dep in m['dependency_excerpts']:
                assert sha(ROOT/dep['path'])==dep['file_sha256'];dep_count+=1
            total=sum(f.stat().st_size for f in folder.iterdir() if f.is_file())
            assert total==m['total_task_bytes']==row['total_bytes'] and total<256000
            packet_rows.append(dict(source_id=sid,eaudit=e['eaudit'],total_bytes=total,paste_sha256=sha(paste),manifest_sha256=sha(mp)))
    assert len(seen)==len(set(seen)) and set(seen)==pending
    assert set(src)==set(ds)==set(web)
    assert len(src)==141 and len(pending)==93
    # Every original FAIL is either explicitly repaired or preserved as a documented erratum.
    errors={e['source_id'] for e in errata};repaired={x['source_id'] for x in read(OUT/'SIGNATURE_REPAIRS.json')}
    prior={sid for e in read(BASE/'EAUDIT_REGISTRY.json') if e.get('eaudit') in ('EAUDIT02','EAUDIT03') for sid in e.get('source_ids',[])}
    attachment_pass={r['source_id'] for r in read(OUT/'EAUDIT_RETURN_REGISTRATION.json') if r['attachment_semantic_verdict']=='PASS' and not r['workspace_conflict']}
    assert all((w['source_id'] in pending and w['source_id'] in repaired|errors|prior) or
               (w['source_id'] in attachment_pass and w['effective_status'].startswith('网站PASS'))
               for w in web.values() if w['audit']['verdict']=='FAIL')
    assert read(BASE/'WEBSITE_SUMMARY.json')['repairing']==0
    flagged={s['source_id'] for s in src.values() if any(i.get('code') in ('ERRATUM?','POSSIBLE_ERRATUM') for i in s.get('issues',[]))}
    assert flagged<=errors,(flagged-errors)
    for e in errata:
        assert e['source_id'] in pending
        assert all(n in declaration_names(ds[e['source_id']]['block']) for n in e['corrected_names'])
    assert all(read(OUT/'LITERAL_SIGNATURE_PRESERVATION.json').values())
    assert not re.search(r'(?m)^\s*(?:axiom|unsafe)\b', (ROOT/'Blueprint/Ch01.lean').read_text(encoding='utf-8'))
    report=read(OUT/'full/CHECK_REPORT.json') if (OUT/'full/CHECK_REPORT.json').exists() else {}
    if require_full:
        assert report.get('machine_check_status')=='passed' and report.get('exit_code')==0
        for inp in report['inputs']:assert sha(ROOT/inp['relative_path'])==inp['sha256']
        for check in report['checks']:
            assert check['exit_code']==0
            if check.get('raw_log'):assert sha(OUT/'full'/check['raw_log'])==check['raw_log_sha256']
    result=dict(total_source_ids=141,website_pass=48,awaiting_reaudit=93,repairing=0,errata_entries=len(errata),axiom_declarations=len(read(OUT/'AXIOM_DECLARATIONS.json')),
       frozen_source_files=len(frozen),frozen_ch02_05_lean_and_json=True,current_batches=len(packages),current_packets=len(seen),max_packet_bytes=max(x['total_bytes'] for x in packet_rows),
       dependency_file_hash_checks=dep_count,original_page_pixel_checks='PASS',raw_return_sha256=raw,literal_signatures_preserved=True,all_flagged_errata_covered=True,
       lean_sha256=actual_lean,source_sha256=actual_source,full_check=report.get('machine_check_status','not_run'),full_check_sha256=sha(OUT/'full/CHECK_REPORT.json') if report.get('finished_at') else None,
       website_new_reaudit='NOT_SUBMITTED',mentor_review='PENDING',packets=packet_rows)
    dump(OUT/'DELIVERY_VALIDATION.json',result);print({k:v for k,v in result.items() if k!='packets'})
    return result

if __name__=='__main__':validate('--full' in sys.argv)

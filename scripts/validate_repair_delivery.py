"""Final read-only checks of current snapshots, packets and paused work."""
import hashlib,json,re,subprocess
from collections import Counter
from datetime import datetime
from integrate_website_returns import ROOT,read,dump,sha
from eaudit_review_tasks import declarations,declaration_names,axiom_pattern

def validate():
    supplement=ROOT/'docs/handoff/ANNOTATED_AXIOMS';sx=read(supplement/'VERIFICATION.json')
    sr=read(supplement/'COMPILE.json');assert sr['exit_code']==0 and sr['log_sha256']==sha(supplement/'axioms.log')
    supplement_log=(supplement/'axioms.log').read_text(encoding='utf-8')
    result=dict(time=datetime.now().isoformat(),chapters={},website='not submitted; no fresh website PASS claimed',mentor='not confirmed',new_proofs='none')
    pdf_hash=sha(next(ROOT.parent.glob('Leimkuhler2015b*.pdf')))
    base_ref='6b822a9a524f'
    tree=subprocess.check_output(['git','ls-tree','-r','--name-only',base_ref],cwd=ROOT).decode().splitlines()
    for ch in (2,3,4,5):
        base=ROOT/f'blueprint/ch{ch:02}';lean=ROOT/f'Blueprint/Ch{ch:02}.lean';source=base/f'ch{ch:02}_source.json'
        accepted=read(base/'validation/WEBSITE_REPAIR_CHAPTER_ACCEPTANCE.json')
        assert accepted['lean_sha256']==sha(lean) and accepted['source_sha256']==sha(source)
        full_path=ROOT/accepted['full_check_report'];full=read(full_path)
        assert sha(full_path)==accepted['full_check_report_sha256'] and full['machine_check_status']=='passed' and full['paused_chapter06']
        for item in full['inputs']:assert sha(ROOT/item['relative_path'])==item['sha256'],item['relative_path']
        assert full['source_scan']=='passed'
        metadata=read(base/'validation/METADATA_REVIEW_20261016.json')
        assert metadata['delivery_complete'] and metadata['source_after_sha256']==sha(source) and metadata['unchanged_lean_sha256']==sha(lean)
        sources=read(source);ds=declarations(ch);audit=read(base/'local_audit.json')['items'];web=read(base/'website_audit.json')
        assert len(sources)==len(ds)==len(web)
        original_path=next(p for p in tree if p.lower()==f'blueprint/ch{ch:02}/ch{ch:02}_source.json')
        original={s['source_id']:s for s in json.loads(subprocess.check_output(['git','show',base_ref+':'+original_path],cwd=ROOT).decode('utf-8-sig'))}
        for s in sources:
            before=original[s['source_id']].get('repair_log',[])
            assert s.get('repair_log',[])[:len(before)]==before,('repair log overwritten',s['source_id'])
        names=[]
        for sid,d in ds.items():
            a=audit[sid];assert a['compiled'] and a['checked'] and a['block_sha256']==d['block_sha256'] and a['signature_sha256']==d['signature_sha256'],sid
            log=(ROOT/a['axiom_log']).read_text(encoding='utf-8')
            for n in declaration_names(d['block']):
                name=f'MD.Ch{ch:02}.'+n;names.append(name)
                assert re.search(axiom_pattern(name),log) or re.search(axiom_pattern(name),supplement_log),name
            if 'sorryAx' in a['axioms']:assert a['final_status']=='incomplete',sid
        assert len(names)==len(set(names))==accepted['axiom_decl_count']
        counts=Counter();present=set();items=[]
        for w in web:
            sid=w['source_id'];repair=w.get('repair',{});status=repair.get('status')
            if w['json_review']['status']=='CORRECTED':assert repair.get('json_review_locally_verified'),sid
            if status=='awaiting_mentor':counts['awaiting_mentor']+=1;continue
            if status!='awaiting_reaudit':
                assert w['returned_audit']['verdict']=='PASS' and w['binding']['bound'],sid
                counts['website_pass']+=1;continue
            counts['awaiting_reaudit']+=1;e=repair['eaudit'];present.add(e)
            task=base/'mathcopilot_tasks'/e;bundle=read(task/'MANIFEST.json')
            assert 1<=len(bundle['subtasks'])<=8
            packet=next(t for t in bundle['subtasks'] if t['source_id']==sid);folder=ROOT/packet['path'];m=read(folder/'MANIFEST.json')
            assert sha(folder/'MANIFEST.json')==packet['manifest_sha256']
            assert m['source_block_sha256']==ds[sid]['block_sha256'] and m['source_declarations']==declaration_names(ds[sid]['block']),sid
            hashes=m['input_sha256'];assert hashes[f'Blueprint/Ch{ch:02}.lean']==sha(lean) and hashes[f'blueprint/ch{ch:02}/ch{ch:02}_source.json']==sha(source)
            assert m['source_pdf_sha256']==pdf_hash and m['crop_pixel_identity']=='PASS'
            assert sha(folder/'PASTE.txt')==m['paste_sha256']
            paste=(folder/'PASTE.txt').read_text(encoding='utf-8')
            assert paste.startswith('以本 PASTE 和附件为准；/workspace 中的 Ch0x.lean、ch0x_source.json、BATCH*.md 等是旧版本，忽略它们。Mathlib 标准库定义按标准数学含义直接采信，只需展开 MolecularDynamics / MD.* 命名空间的项目定义。')
            assert ds[sid]['block'] in paste and 'json.loads' in paste and m['expected_output'] in paste
            assert all(v in paste for v in hashes.values())
            for name,digest in hashes.items():
                if name.endswith('_PAGES.pdf'):assert sha(folder/name)==digest
                elif name.startswith('BATCH_'):assert sha(task/name)==digest
            for dep in m['dependency_excerpts']:assert sha(ROOT/dep['path'])==dep['file_sha256'],dep['path']
            total=sum(p.stat().st_size for p in folder.iterdir() if p.is_file());assert total==m['total_task_bytes']<256000
            items.append(sid)
        index=(base/'mathcopilot_tasks/EAUDIT_INDEX.md').read_text(encoding='utf-8')
        assert set(re.findall(r'\[(EAUDIT\d+)\]',index))==present
        assert len(items)==len(set(items)) and sum(counts.values())==len(web)
        result['chapters'][ch]=dict(total=len(web),**dict(counts),repairing=0,axiom_declarations=len(names),
          current_batches=len(present),single_item_packets=len(items),lean_sha256=sha(lean),source_sha256=sha(source))
    assert not subprocess.check_output(['git','diff','--name-only',base_ref,'HEAD','--','MolecularDynamics'],cwd=ROOT).strip(),'Formal library changed'
    for suffix in ('Blueprint/Ch06.lean','blueprint/ch06/ch06_source.json'):
        old_path=next(p for p in tree if p.lower()==suffix.lower())
        old=subprocess.check_output(['git','show',base_ref+':'+old_path],cwd=ROOT)
        current=subprocess.check_output(['git','show','HEAD:'+suffix],cwd=ROOT)
        assert old==current,('Paused Ch06 content changed',suffix)
    paused=read(ROOT/'blueprint/ch06/validation/PAUSED_WIP_20261014.json')
    assert paused['lean_sha256']==sha(ROOT/'Blueprint/Ch06.lean') and 'UNVERIFIED' in paused['batch27']
    result['chapter06']=dict(status='paused',wip_commit=base_ref,batch27='unverified; not rerun',batch26_pdf='document closed recorded, not repaired')
    result['totals']={key:sum(c.get(key,0) for c in result['chapters'].values()) for key in ['total','website_pass','awaiting_reaudit','awaiting_mentor','repairing','axiom_declarations','current_batches','single_item_packets']}
    dump(ROOT/'docs/handoff/REPAIR_DELIVERY_VALIDATION.json',result)
    print(json.dumps(result['totals'],ensure_ascii=False),flush=True)
    return result

if __name__=='__main__':validate()

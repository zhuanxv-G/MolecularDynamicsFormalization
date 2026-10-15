"""Small, explicit signature/source repairs; no automatic mathematical choices."""
import copy
import hashlib
import json
import re
import subprocess
from datetime import datetime
from pathlib import Path
from integrate_website_returns import ROOT, read, dump, sha, display
from eaudit_review_tasks import declarations, build, render_document
from local_compile import compile_recorded
from repair_queue import render as render_queue

def entry_hash(s):
    return hashlib.sha256(json.dumps({k:v for k,v in s.items() if k!='repair_log'},ensure_ascii=False,sort_keys=True).encode()).hexdigest()

def axiom_footer(ch,text):
    text=re.sub(r'\n/- BEGIN WEBSITE REPAIR AXIOMS -/[\s\S]*?/- END WEBSITE REPAIR AXIOMS -/\s*$', '', text)
    names=re.findall(r'(?m)^(?:noncomputable\s+)?(?:theorem|def)\s+(\w+)',text)
    assert len(names)==len(set(names))
    return text.rstrip()+'\n\n/- BEGIN WEBSITE REPAIR AXIOMS -/\n'+''.join(f'#print axioms MD.Ch{ch:02}.{n}\n' for n in names)+'/- END WEBSITE REPAIR AXIOMS -/\n'

def prepare(ch, eaudit, section, edits, *, pages, source_only=(), human=None):
    """edits map source_id to code/category/note; pages have been visually inspected."""
    human = human or {}; base = ROOT/f'blueprint/ch{ch:02}'
    folder=base/'validation'/eaudit; folder.mkdir(parents=True,exist_ok=True)
    prep=folder/'PREPARATION.json'
    if prep.exists():
        saved=read(prep); assert saved['lean_sha256']==sha(ROOT/f'Blueprint/Ch{ch:02}.lean')
        return saved
    assert len(set(edits)|set(source_only)|set(human)) <= 8
    ds=declarations(ch); lean=ROOT/f'Blueprint/Ch{ch:02}.lean'; text=lean.read_text(encoding='utf-8-sig')
    old_sha=sha(lean); sources=read(base/f'ch{ch:02}_source.json'); before=copy.deepcopy(sources)
    web=read(base/'website_audit.json'); ws={w['source_id']:w for w in web}
    decisions_path=ROOT/'docs/handoff/REPAIR_DECISIONS.json'
    decisions=read(decisions_path) if decisions_path.exists() else {}
    overrides_path=base/'website_signature_overrides.json';overrides=read(overrides_path) if overrides_path.exists() else {}
    prior_proofs={}
    for sid,e in edits.items():
        old=ds[sid]['block']; assert text.count(old)==1
        code=e['code'].strip(); assert not re.search(r'\b(admit|axiom|unsafe|True)\b',code)
        prior_proofs[sid]=old
        text=text.replace(old,code,1)
        start=text.index('source_id: '+sid); stop=text.index('-/',start)
        for old_comment,new_comment in e.get('comment_corrections',{}).items():
            comment=text[start:stop];assert old_comment in comment,(sid,old_comment)
            updated=comment.replace(old_comment,new_comment);text=text[:start]+updated+text[stop:]
            stop=start+len(updated)
        text=text[:stop]+'\n[EXTRA] '+e['note']+' '+text[stop:]
        decisions[sid]={'category':e['category'],'handling':e['note'],'section':section}
    # Compile the real chapter and print its axioms in one invocation. This
    # avoids loading the large imports again for a separate audit-only file.
    text=axiom_footer(ch,text)
    lean.write_text(text,encoding='utf-8')
    touched=set(edits)|set(source_only)|set(human)
    for s in sources:
        sid=s['source_id']
        if sid not in touched: continue
        w=ws[sid]; old=entry_hash(s); changed=[];annotation_corrections={}
        source_pages=[int(x) for x in re.findall(r'\d+',s['pdf_page'])]
        required=set(range(source_pages[0],source_pages[-1]+1))
        assert required<=set(pages), (sid,required,pages)
        if w['json_review']['status']=='CORRECTED':
            proposal=w['json_review'].get('corrected_json') or {}
            for key in ('statement_latex','proof_latex','proof_note','proof_discussion_latex','context_notation','statement_scope'):
                if key in proposal and s.get(key)!=proposal[key]:s[key]=proposal[key];changed.append(key)
            s['review_status']='CORRECTED'
        if sid in edits:
            for key,value in edits[sid].get('source_updates',{}).items():
                assert key in ('issues','extra_assumptions','excluded_qualitative','context_notation')
                if s.get(key)!=value:
                    annotation_corrections[key]={'before':s.get(key),'after':value}
                    s[key]=value;changed.append(key)
            note='[EXTRA] '+edits[sid]['note']
            if note not in s['extra_assumptions']: s['extra_assumptions'].append(note)
            if 'scope' in edits[sid] and s.get('statement_scope') != edits[sid]['scope']:
                s['statement_scope']=edits[sid]['scope'];changed.append('statement_scope')
            overrides[sid]={'code':edits[sid]['code'].strip(),'extra_assumptions':s['extra_assumptions']}
        s['source_page_verification']=f'VERIFIED_RENDERED; validation/{eaudit}/SOURCE_PAGE_VERIFICATION.json'
        s.setdefault('repair_log',[]).append(dict(stage=eaudit+'_LOCAL_REPAIR',timestamp=datetime.now().isoformat(),before_sha256=old,after_sha256=entry_hash(s),changed_fields=changed,annotation_corrections=annotation_corrections,raw_return=w.get('json_review_raw_path',w['raw_path']),reason='已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。'))
        w['repair']={'eaudit':eaudit,'status':'awaiting_mentor' if sid in human else 'prepared_unverified','signature_changed':sid in edits,'json_review_locally_verified':True}
        if sid in human:
            question=human[sid]; w['repair']['mentor_question']=question;w['needs_category']='原文数学判断'
            decisions[sid]={'category':'D','handling':'仅登记问题/选项/网站反例，保持签名现状','section':section}
        elif sid in source_only:
            decisions[sid]={'category':'B','handling':'原文CORRECTED原页复核合并；签名复用，补材料复审','section':section}
        w['effective_status']=display(w)
    assert all(s==o for s,o in zip(sources,before) if s['source_id'] not in touched)
    dump(base/f'ch{ch:02}_source.json',sources);dump(base/'website_audit.json',web)
    dump(overrides_path,overrides);dump(decisions_path,decisions)
    dump(folder/'SOURCE_PAGE_VERIFICATION.json',dict(pdf_sha256=sha(next(ROOT.parent.glob('Leimkuhler2015b*.pdf'))),pages=pages,verification='visual inspection of rendered original pages in this chat',source_ids=sorted(touched)))
    if human:
        path=base/'NEEDS_HUMAN.md'; doc=path.read_text(encoding='utf-8') if path.exists() else '# 待导师问题\n'
        doc+=f'\n## {eaudit} 原文数学判断（保持现状）\n\n'
        for sid,q in human.items():
            a=ws[sid]['audit'];doc+=f'- {sid}：{q} 网站反例：{a.get("counterexample") or a.get("explanation")}; 原返回{ws[sid]["returned_audit"]["verdict"]}保留。\n'
        path.write_text(doc,encoding='utf-8')
    saved=dict(chapter=ch,eaudit=eaudit,section=section,source_ids=sorted(touched),reaudit_ids=[s['source_id'] for s in sources if s['source_id'] in touched and s['source_id'] not in human],human_ids=list(human),old_lean_sha256=old_sha,lean_sha256=sha(lean),source_sha256=sha(base/f'ch{ch:02}_source.json'),pages=pages,prior_proof_blocks=prior_proofs)
    dump(prep,saved); render_queue()
    work=ROOT/'docs/handoff/WORK_LOG.zh-CN.md'
    work.write_text(work.read_text(encoding='utf-8')+f'\n## {datetime.now().date()} 第{ch}章§{section} {eaudit}待验检查点\n{len(touched)}条原页已核，签名/JSON已落盘；本批单文件、公理及EAUDIT包尚未验证，先读收据再续。\n第6章暂停；不写新证明。\n',encoding='utf-8')
    return saved

def verify(ch,eaudit):
    base=ROOT/f'blueprint/ch{ch:02}';folder=base/'validation'/eaudit;prep=read(folder/'PREPARATION.json')
    lean=ROOT/f'Blueprint/Ch{ch:02}.lean';assert prep['lean_sha256']==sha(lean)
    target=f'.lake/build/lib/lean/Blueprint/Ch{ch:02}.olean';(ROOT/target).parent.mkdir(parents=True,exist_ok=True)
    record,output,reused=compile_recorded(['lake','env','lean','-o',target,f'Blueprint/Ch{ch:02}.lean'],ROOT,lean,folder/'single-file.log',folder/'COMPILE.json')
    if record['exit_code']:
        print(output.decode('utf-8',errors='replace')); raise RuntimeError('Single-file compile failed; repair locally before acceptance')
    ds=declarations(ch);names=[]
    for sid in prep['source_ids']:
        names.extend(f'MD.Ch{ch:02}.'+m for m in re.findall(r'(?m)^(?:noncomputable\s+)?(?:theorem|def)\s+(\w+)',ds[sid]['block']))
    ap=folder/'CheckAxioms.lean';ap.write_text(f'import Blueprint.Ch{ch:02}\n'+'\n'.join('#print axioms '+n for n in names)+'\n',encoding='utf-8')
    if '/- BEGIN WEBSITE REPAIR AXIOMS -/' in lean.read_text(encoding='utf-8'):
        log=output
        (folder/'axioms.log').write_bytes(log)
        dump(folder/'AXIOMS.json',dict(record,mode='same compiler invocation as single-file compile; persistent chapter #print axioms footer'))
    else:
        r,log,_=compile_recorded(['lake','env','lean',ap.relative_to(ROOT).as_posix()],ROOT,ap,folder/'axioms.log',folder/'AXIOMS.json')
        assert r['exit_code']==0,log.decode('utf-8',errors='replace')
    parsed={}
    for name in names:
        m=re.search("'"+re.escape(name)+r"' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)",log.decode('utf-8'))
        assert m,name;parsed[name]=[x.strip() for x in (m.group(1) or '').split(',') if x.strip()]
    audit=read(base/'local_audit.json')
    for sid in prep['source_ids']:
        a=audit['items'][sid];d=ds[sid]
        group_names=[f'MD.Ch{ch:02}.'+m for m in re.findall(r'(?m)^(?:noncomputable\s+)?(?:theorem|def)\s+(\w+)',d['block'])]
        group_axioms=sorted({x for name in group_names for x in parsed[name]})
        a.update(signature_sha256=d['signature_sha256'],block_sha256=d['block_sha256'],compiled=True,checked=True,axioms=group_axioms,axiom_log=(folder/'axioms.log').relative_to(ROOT).as_posix(),direct_placeholder='sorry' in d['block'])
        a['final_status']='incomplete' if 'sorryAx' in a['axioms'] or a['direct_placeholder'] else ('checked+documented priors' if a.get('documented_priors') else 'self-contained')
        a['transitive_placeholder']='sorryAx' in a['axioms'] and not a['direct_placeholder']
    dump(base/'local_audit.json',audit);dump(folder/'AXIOM_DECLARATIONS.json',parsed)
    tasks=build(ch,eaudit,prep['section'],prep['reaudit_ids']) if prep['reaudit_ids'] else None
    acceptance={k:prep[k] for k in ('chapter','eaudit','section','source_ids','reaudit_ids','human_ids','lean_sha256','source_sha256','pages')}
    acceptance.update(single_file_compile=record,axiom_decl_count=len(names),existing_proofs='all current declaration bodies rechecked by full single-file compile',new_proofs='none',full_check='deferred to chapter end',website='awaiting user submission',task_index=tasks['task_index'] if tasks else None)
    dump(folder/'ACCEPTANCE.json',acceptance)
    registry=base/'EAUDIT_REGISTRY.json';entries=read(registry) if registry.exists() else [];entries.append(acceptance);dump(registry,entries)
    web=read(base/'website_audit.json')
    for w in web:
        if w['source_id'] in prep['reaudit_ids']:
            w['repair'].update(status='awaiting_reaudit',task_index=tasks['task_index'],input_sha256=tasks['input_sha256']);w['effective_status']=display(w)
    dump(base/'website_audit.json',web)
    (ROOT/f'docs/review/CH{ch:02}_BLUEPRINT.zh-CN.md').write_text(render_document(ch),encoding='utf-8')
    counts=render_queue()[ch];dump(base/'WEBSITE_SUMMARY.json',dict(chapter=ch,total=len(web),**dict(counts)))
    progress=base/'PROGRESS.md';lines=progress.read_text(encoding='utf-8-sig').splitlines();ws={w['source_id']:w for w in web}
    for i,line in enumerate(lines):
        if line.startswith('| MD-'):
            cells=line.split('|');sid=cells[1].strip()
            if sid in prep['source_ids'] and len(cells)==8:
                cells[3]=' 已核/单文件通过/公理已核 ';cells[5]=' '+ws[sid]['effective_status']+' ';lines[i]='|'.join(cells)
    lines += ['',f'{eaudit} §{prep["section"]}：{len(prep["source_ids"])}条落盘，单文件与{len(names)}项公理通过；未写新证明；完整check留到章末；网站待复审。']
    progress.write_text('\n'.join(lines)+'\n',encoding='utf-8')
    index=base/'mathcopilot_tasks/EAUDIT_INDEX.md';lines=['# EAUDIT 待提交包','', '网站尚未复审；各PASTE绑定其附件快照。','']
    for path in sorted((base/'mathcopilot_tasks').glob('EAUDIT*/INDEX.md')):lines.append(f'- [{path.parent.name}]({path.parent.name}/INDEX.md)')
    index.write_text('\n'.join(lines)+'\n',encoding='utf-8')
    state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';text=state.read_text(encoding='utf-8');text=re.sub(r'^下一步：.*$',f'下一步：第{ch}章从§{prep["section"]}之后最早未处理项接续；已落盘{eaudit}，单文件/公理已验，复审未提交。',text,count=1,flags=re.M);state.write_text(text,encoding='utf-8')
    work=ROOT/'docs/handoff/WORK_LOG.zh-CN.md';work.write_text(work.read_text(encoding='utf-8')+f'\n## {datetime.now().date()} 第{ch}章§{prep["section"]} {eaudit}\n{len(prep["source_ids"])}条落盘；原页{prep["pages"]}、单文件、{len(names)}项公理及复审附件哈希/字节通过；未写新证明，章末完整check尚未运行。\n网站待用户提交；待导师{len(prep["human_ids"])}条保持签名，下一步按修复队列接续。\n',encoding='utf-8')
    print('ACCEPTED',ch,eaudit,len(names),counts,flush=True)
    return acceptance

def commit_section(ch,section,eaudits):
    from local_stage import stage
    paths=[f'Blueprint/Ch{ch:02}.lean',f'docs/review/CH{ch:02}_BLUEPRINT.zh-CN.md','scripts/website_repair_batch.py','scripts/repair_queue.py','scripts/eaudit_review_tasks.py','docs/handoff/REPAIR_DECISIONS.json','docs/handoff/REPAIR_QUEUE.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/WORK_LOG.zh-CN.md']
    paths += [f'blueprint/ch{ch:02}/'+n for n in ('ch%02d_source.json'%ch,'website_audit.json','website_signature_overrides.json','EAUDIT_REGISTRY.json','local_audit.json','NEEDS_HUMAN.md','PROGRESS.md','WEBSITE_SUMMARY.json','mathcopilot_tasks/EAUDIT_INDEX.md')]
    for e in eaudits: paths += [f'blueprint/ch{ch:02}/validation/{e}',f'blueprint/ch{ch:02}/mathcopilot_tasks/{e}']
    # An interrupted section can leave an accepted earlier batch untracked.
    for p in (ROOT/f'blueprint/ch{ch:02}/validation').glob('EAUDIT[0-9][0-9]/ACCEPTANCE.json'):
        tracked=subprocess.run(['git','ls-files','--error-unmatch',p.relative_to(ROOT).as_posix()],cwd=ROOT,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
        if tracked.returncode:
            paths += [p.parent.relative_to(ROOT).as_posix(),f'blueprint/ch{ch:02}/mathcopilot_tasks/{p.parent.name}']
    paths += [p.relative_to(ROOT).as_posix() for p in (ROOT/'scripts').glob(f'repair_ch{ch:02}*.py')]
    stage([p for p in paths if (ROOT/p).exists()])
    subprocess.run(['git','commit','-m',f'ch{ch:02} sec{section}: repair website audit signatures and package {", ".join(eaudits)}; no new proofs'],cwd=ROOT,check=True)
    pushed=subprocess.run(['git','push'],cwd=ROOT)
    if pushed.returncode:
        # Windows schannel intermittently fails the TLS handshake. One bounded
        # fallback keeps certificate verification enabled and changes no config.
        subprocess.run(['git','-c','http.sslBackend=openssl','push'],cwd=ROOT,check=True)

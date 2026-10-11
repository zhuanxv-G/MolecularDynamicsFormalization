"""Authorized Ch01 return exception: preserve receipts, repair one signature, re-audit."""
from pathlib import Path
import json,hashlib,re,sys,subprocess
from datetime import datetime
from ch01_full_tools import ROOT,BASE,declarations,sync,mark_checked
from render_blueprint import render,entry_hash
from build_mathcopilot_compact import definitions,uncomment
import fitz
from pypdf import PdfReader,PdfWriter
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
def dump(p,v):
    p.parent.mkdir(parents=True,exist_ok=True)
    p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
task=BASE/'mathcopilot_tasks/EAUDIT01'
recorddir=BASE/'mathcopilot_results/integration20261011'
phase=sys.argv[1]
receipt=recorddir/'RECEIPT.json'
if phase=='prepare':
    assert not receipt.exists(),'Already prepared; reuse files and check evidence.'
    result=BASE/'mathcopilot_results/review.json'
    results=json.loads(result.read_text(encoding='utf-8-sig'))
    sources=json.loads((BASE/'ch01_source.json').read_text(encoding='utf-8-sig'))
    indexed={s['source_id']:s for s in sources};ds=declarations()
    assert len(results)==5 and len({r['source_id'] for r in results})==5
    for r in results:
        assert r['source_id'] in indexed and r['audit']['lean_decl']==indexed[r['source_id']]['lean_decl']
        assert r['audit']['verdict'] in {'PASS','FAIL','NEEDS_HUMAN'}
    before={}
    recorddir.mkdir(parents=True,exist_ok=True)
    for rel in ['Blueprint/Ch01.lean','blueprint/ch01/ch01_source.json','blueprint/ch01/local_audit.json']:
        path=ROOT/rel;dest=recorddir/'before'/rel
        dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(path.read_bytes());before[rel]=sha(path)
    (recorddir/'review-original.json').write_bytes(result.read_bytes())
    target=indexed['MD-1.4-LegendreHamiltonian'];proposal=next(r['json_review']['corrected_json'] for r in results if r['source_id']==target['source_id'])
    assert proposal['statement_latex']==target['statement_latex']
    original_hash=entry_hash(target)
    for k in ['proof_latex','proof_note','proof_discussion_latex','context_notation','statement_scope']:
        target[k]=proposal[k]
    # Do not replace prior issues/logs with the reviewer's proposed versions.
    target['issues'] += [dict(code=i['code'],status='local_verified',detail=i['detail'],receipt='review.json') for i in next(r['json_review']['issues'] for r in results if r['source_id']==target['source_id'])]
    target['extra_assumptions'].append('[EXTRA] hPositive : (M q).PosDef；展开p23正物理质量及满秩Jacobian继承的对称正定背景，任意可逆矩阵反例不属于此子类。字面可逆原句保留，配置相关M及全部六项结论不变。')
    target['review_status']='CORRECTED'
    target['repair_log'].append(dict(stage='RETURN_EXCEPTION_EAUDIT01',timestamp=datetime.now().isoformat(),before_sha256=original_hash,after_sha256=entry_hash(target),reason='原页PDF46–47已重新视觉核对；不完整sup计算移入proof_discussion，修正广义坐标维数，显式展开继承的正定背景。原语句不改，旧签名和全部返回件保留。'))
    dump(BASE/'ch01_source.json',sources)
    leanpath=ROOT/'Blueprint/Ch01.lean';lean=leanpath.read_text(encoding='utf-8-sig')
    old='(q : Position n) (p : Momentum n) (hM : IsUnit (M q)) :'
    assert lean.count(old)==1
    lean=lean.replace(old,'(q : Position n) (p : Momentum n) (hM : IsUnit (M q))\n    (hPositive : (M q).PosDef) :')
    lean=lean.replace('independent audit must settle the intended premise. It has not been silently added.',
        '[EXTRA] EAUDIT01: hPositive explicitly unfolds the inherited symmetric positive\ndefinite mechanical background. The literal invertibility sentence stays in JSON;\nthe old arbitrary-invertible signature and counterexamples remain in the receipt.')
    leanpath.write_text(lean,encoding='utf-8')
    website=[]
    for r in results:
        website.append(dict(source_id=r['source_id'],json_review=r['json_review'],returned_audit=r['audit'],
            audit=dict(lean_decl=r['audit']['lean_decl'],verdict='NEEDS_HUMAN',explanation=('旧任意可逆签名FAIL已保存；当前签名补hPositive并登记EAUDIT01，待独立重审。' if r['audit']['verdict']=='FAIL' else r['audit']['explanation']),counterexample=r['audit'].get('counterexample'),suggested_fix=r['audit'].get('suggested_fix')),
            receipt=dict(path=result.relative_to(ROOT).as_posix(),sha256=sha(result),input_version_status='返回件未附输入SHA256或网站job；来源和版本绑定尚未验证，不提升为网站PASS或冻结。',old_signature_sha256=ds[r['source_id']]['signature_sha256'],reaudit='EAUDIT01')))
    dump(BASE/'website_audit.json',website)
    audit=json.loads((BASE/'local_audit.json').read_text(encoding='utf-8'))
    a=audit['items'][target['source_id']]
    a.update(verdict='NEEDS_HUMAN',checked=False,axioms=[],final_status='incomplete',explanation='旧仅可逆签名确有负质量及非对称反例；新hPositive展开继承背景并保留配置相关矩阵和全部六项结论；待EAUDIT01独立语义审校。',counterexample='旧签名反例n=1,M=−1,U=p=0及非对称2×2矩阵；当前hPositive排除此类，不作为新签名反例。',missing='一般配置相关对称正定矩阵Legendre上确界理论未补证明；保持sorry。')
    dump(BASE/'local_audit.json',audit)
    sync()
    # Fully qualified tokens also need actual definitions; preserve all namespaces.
    ds=declarations();index=definitions(['Blueprint/Ch01.lean']+[p.relative_to(ROOT).as_posix() for p in (ROOT/'MolecularDynamics').rglob('*.lean')])
    def refs(code):
        tokens=re.findall(r'[\w\u2080-\u2089]+(?:\.[\w\u2080-\u2089]+)*',uncomment(code))
        return {t.rsplit('.',1)[-1] for t in tokens if t.rsplit('.',1)[-1] in index}
    pdf=next(ROOT.parent.glob('Leimkuhler2015b*.pdf'));reader=PdfReader(pdf);original=fitz.open(pdf)
    manifests=[];full=['# EAUDIT01：第1章五条返回件后的A+C重审','', '旧四条NEEDS_HUMAN和一条FAIL不改写成PASS；只生成，不提交网站。','']
    pagesets={'MD-1.5.3-Thm1.1':[54,55],'MD-1.2-EnergyConservation':[41,42],
        'MD-1.3-NewtonEulerLagrange':[45,46],'MD-1.4-LegendreHamiltonian':[46,47],'MD-1.5.1-FlowInverse':[48,49]}
    for j,r in enumerate(results):
        sid=r['source_id'];s=indexed[sid];folder=task/chr(97+j);folder.mkdir(parents=True,exist_ok=True)
        selected={};pending=refs(ds[sid]['statement'])
        while pending:
            name=pending.pop()
            if name in selected:continue
            selected[name]=index[name]
            for d in index[name]:pending |= refs(d['code'])-selected.keys()
        text=['逐字核对原页JSON，再只读核对实际Lean陈述及以下全部实际定义；逐项审[EXTRA]/疑误、对象、量词、前提与全部结论。不得改工程或补证明。材料不足/读页失败写NEEDS_HUMAN，未核对不记PASS。只返回本source_id的json_review和audit；同时回显MANIFEST的source_json_sha256和lean_sha256。',
            'Lean4.34.0/Mathlibv4.34.0；namespace MD.Ch01；noncomputable；open Set Filter MolecularDynamics；三维粒子/广义配置均为EuclideanSpace ℝ (Fin n)。完整定义摘录是审校材料，不是独立Lean工程。',
            '## 本条JSON',json.dumps(s,ensure_ascii=False,indent=2),'## 实际签名',ds[sid]['statement'],'## 旧返回件',json.dumps(r,ensure_ascii=False,indent=2)]
        excerpts=[]
        for name,choices in sorted(selected.items()):
            for d in choices:
                text += [f"## {d['namespace']}.{name} ({d['path']}:{d['line']})",d['code']]
                excerpts.append(dict(path=d['path'],namespace=d['namespace'],name=name,code_sha256=hashlib.sha256(d['code'].encode()).hexdigest()))
        paste=folder/'PASTE.txt';paste.write_text('\n\n'.join(text)+'\n',encoding='utf-8')
        out=folder/f'EAUDIT01{chr(97+j)}_PAGES.pdf';writer=PdfWriter();pages=pagesets[sid]
        for p in pages:writer.add_page(reader.pages[p-1]).compress_content_streams(level=9)
        writer.compress_identical_objects();writer.write(out);exported=fitz.open(out)
        for k,p in enumerate(pages):assert original[p-1].get_pixmap().samples==exported[k].get_pixmap().samples
        report=dict(batch='EAUDIT01',source_ids=[sid],source_json_sha256=sha(BASE/'ch01_source.json'),lean_sha256=sha(leanpath),signature_sha256=ds[sid]['signature_sha256'],source_pdf_sha256=sha(pdf),definition_excerpts=excerpts,page_mapping=[dict(attachment_page=k+1,original_pdf_page=p,printed_page=p-23) for k,p in enumerate(pages)],files={p.name:dict(bytes=p.stat().st_size,sha256=sha(p)) for p in [paste,out]},validation=dict(pdf_rendered_pixel_equality='PASS',website_acceptance='NOT_TESTED'))
        mp=folder/'MANIFEST.json';dump(mp,report)
        for _ in range(3):report['total_task_bytes']=sum(p.stat().st_size for p in [paste,out,mp]);dump(mp,report)
        total=sum(p.stat().st_size for p in [paste,out,mp]);assert total==report['total_task_bytes'] and total<256000,(sid,total)
        manifests.append(dict(source_id=sid,path=folder.relative_to(ROOT).as_posix(),bytes=total,manifest_sha256=sha(mp)))
        full += ['## '+sid,json.dumps(s,ensure_ascii=False,indent=2),ds[sid]['statement']]
    dump(task/'MANIFEST.json',manifests);(task/'BATCH_EAUDIT01.md').write_text('\n\n'.join(full)+'\n',encoding='utf-8')
    taskindex=['# EAUDIT01重审提交索引','','每条只粘贴PASTE.txt并关联其裁页PDF，实际三件合计<256000字节；只生成，待用户提交。','']
    taskindex += [f"- {m['source_id']}：[{Path(m['path']).name}/PASTE.txt]({Path(m['path']).name}/PASTE.txt)，{m['bytes']}字节。" for m in manifests]
    (task/'INDEX.md').write_text('\n'.join(taskindex)+'\n',encoding='utf-8')
    indexpath=BASE/'mathcopilot_tasks/INDEX.md'
    with indexpath.open('a',encoding='utf-8') as f:f.write('\n## EAUDIT01：2026-10-11新返回件\n\n五条返回原样保留；旧Legendre仅可逆签名FAIL，新hPositive显式修订后待重审。BATCH01旧compact为历史版本；优先提交[EAUDIT01/INDEX.md](EAUDIT01/INDEX.md)，当前四条NEEDS与一条修订均不冻结、不称网站PASS。\n')
    dump(receipt,dict(raw_return_sha256=sha(result),before=before,source_ids=[r['source_id'] for r in results],raw_counts={'NEEDS_HUMAN':4,'FAIL':1},source_visual_rechecked_pdf_pages=[46,47],signature_changed_only='MD-1.4-LegendreHamiltonian',website_version_binding='UNVERIFIED',next='完整check后finalize，更新当前章冻结例外基线并提交推送，再回第4章。'))
    (ROOT/'docs/review/CH01_BLUEPRINT.zh-CN.md').write_text(render(BASE/'ch01_source.json',leanpath,BASE/'local_audit.json'),encoding='utf-8')
    print('Prepared authorized Ch01 exception and 5 compact EAUDIT tasks; max',max(m['bytes'] for m in manifests))
elif phase=='finalize':
    report=ROOT/sys.argv[2]
    data=json.loads((report/'CHECK_REPORT.json').read_text(encoding='utf-8-sig'));assert data['machine_check_status']=='passed'
    for inp in data['inputs']:assert sha(ROOT/inp['relative_path'])==inp['sha256']
    for check in data['checks']:assert check['exit_code']==0 and sha(report/check['raw_log'])==check['raw_log_sha256']
    previous_sources=json.loads((recorddir/'before/blueprint/ch01/ch01_source.json').read_text(encoding='utf-8-sig'))
    current_sources=json.loads((BASE/'ch01_source.json').read_text(encoding='utf-8-sig'))
    assert len(previous_sources)==len(current_sources)==141
    previous_index={s['source_id']:s for s in previous_sources}
    assert set(previous_index)=={s['source_id'] for s in current_sources}
    for s in current_sources:
        if s['source_id']!='MD-1.4-LegendreHamiltonian':assert s==previous_index[s['source_id']],s['source_id']
    oldlean=(recorddir/'before/Blueprint/Ch01.lean').read_text(encoding='utf-8-sig')
    expected=oldlean.replace('(q : Position n) (p : Momentum n) (hM : IsUnit (M q)) :',
        '(q : Position n) (p : Momentum n) (hM : IsUnit (M q))\n    (hPositive : (M q).PosDef) :').replace(
        'independent audit must settle the intended premise. It has not been silently added.',
        '[EXTRA] EAUDIT01: hPositive explicitly unfolds the inherited symmetric positive\ndefinite mechanical background. The literal invertibility sentence stays in JSON;\nthe old arbitrary-invertible signature and counterexamples remain in the receipt.')
    assert expected==(ROOT/'Blueprint/Ch01.lean').read_text(encoding='utf-8-sig'),'Unexpected Ch01 Lean change'
    audit=json.loads((BASE/'local_audit.json').read_text(encoding='utf-8'))
    audit['items']['MD-1.4-LegendreHamiltonian']['counterexample']='旧签名反例n=1,M=−1,U=p=0及非对称2×2矩阵；当前hPositive排除此类，不作为新签名反例。'
    dump(BASE/'local_audit.json',audit)
    mark_checked(report/'blueprint_axiom_dependencies.log');sync()
    # sync refreshes legacy current-version batches; preserve the explicit EAUDIT link.
    ip=BASE/'mathcopilot_tasks/INDEX.md'
    with ip.open('a',encoding='utf-8') as f:f.write('\n## EAUDIT01：返回件整合\n\nBATCH01旧compact是历史输入；优先提交[EAUDIT01/INDEX.md](EAUDIT01/INDEX.md)。四条原NEEDS、一条旧FAIL已保存；新签名待网站重审，无网站PASS或冻结。\n')
    (ROOT/'docs/review/CH01_BLUEPRINT.zh-CN.md').write_text(render(BASE/'ch01_source.json',ROOT/'Blueprint/Ch01.lean',BASE/'local_audit.json'),encoding='utf-8')
    progress=BASE/'PROGRESS.md';text=progress.read_text(encoding='utf-8').replace('原文仍DRAFT，网站尚未返回。','五条返回件已登记（来源及输入绑定未核验）；旧四条NEEDS/一条FAIL保留，新签名待EAUDIT01重审，不冻结。')
    text+='\n## 2026-10-11 返回件例外\n\n仅Legendre原页字段分类/坐标维数及签名正定背景修订，全部六项结论保留；原签名、原始返回和哈希见mathcopilot_results/integration20261011/RECEIPT.json。当前单文件与完整check通过，含sorryAx仍incomplete；EAUDIT01五份三件预算和原页像素相等已核，网站提交未测试。\n'
    progress.write_text(text,encoding='utf-8')
    # New source metadata after axiom syncing does not change source entries/Lean.
    # Task hashes use the source before this final sync; ensure byte identity.
    for mp in task.glob('*/MANIFEST.json'):
        m=json.loads(mp.read_text(encoding='utf-8'));assert m['source_json_sha256']==sha(BASE/'ch01_source.json') and m['lean_sha256']==sha(ROOT/'Blueprint/Ch01.lean')
    baseline=ROOT/'blueprint/ch04/BASELINE.json';b=json.loads(baseline.read_text(encoding='utf-8'))
    changes=[]
    for p,h in b['protected'].items():
        current=sha(ROOT/p)
        if current!=h:
            assert p=='Blueprint/Ch01.lean' or p.startswith(('blueprint/ch01/','docs/review/CH01_')),(p,'Outside Ch01 exception')
            changes.append(dict(path=p,before_sha256=h,after_sha256=current));b['protected'][p]=current
    exception=dict(reason='用户允许当前节提交后整合第1章新返回件',receipt=receipt.relative_to(ROOT).as_posix(),raw_return_sha256=sha(BASE/'mathcopilot_results/review.json'),full_check=report.relative_to(ROOT).as_posix(),full_check_sha256=sha(report/'CHECK_REPORT.json'),changes=changes)
    b.setdefault('authorized_ch01_return_exceptions',[]).append(exception);dump(baseline,b)
    r=json.loads(receipt.read_text(encoding='utf-8'));r['full_check']=exception['full_check'];r['changes']=changes;r['next']='继续第4章§4.1，从16条检查点接续，复用原证据。';dump(receipt,r)
    registry=BASE/'processed_returns.json'
    entries=json.loads(registry.read_text(encoding='utf-8')) if registry.exists() else []
    assert not any(e['raw_return_sha256']==exception['raw_return_sha256'] for e in entries)
    entries.append(dict(raw_return='blueprint/ch01/mathcopilot_results/review.json',raw_return_sha256=exception['raw_return_sha256'],receipt=exception['receipt'],status='integrated; EAUDIT01 pending; no website PASS'))
    dump(registry,entries)
    # Freeze new immutable exception artifacts too; user-supplied raw filenames
    # remain receipt-hashed so a new return can be detected before its integration.
    for path in [BASE/'website_audit.json',registry,receipt,*task.rglob('*')]:
        if path.is_file():b['protected'][path.relative_to(ROOT).as_posix()]=sha(path)
    dump(baseline,b)
    print('Ch01 return checked; authorized refreeze changes',len(changes))
else:raise ValueError(phase)

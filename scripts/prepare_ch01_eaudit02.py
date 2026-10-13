"""First website-repair section: merge locally page-checked A proposals, create C tasks.

Run only after final Ch01 signature edits. Do not regenerate historical BATCHes.
The external dependency bundles are never read into or copied to these tasks.
"""
import copy
import hashlib
import json
import re
from datetime import datetime
from pathlib import Path
import fitz
from pypdf import PdfReader, PdfWriter
from integrate_website_returns import ROOT, sha, read, dump, display
from render_blueprint import entry_hash
from ch01_full_tools import declarations
from build_mathcopilot_compact import definitions, referenced

BASE=ROOT/'blueprint/ch01'
TASK=BASE/'mathcopilot_tasks/EAUDIT02'
SIDS=['MD-1.1-Schrodinger','MD-1.1-NewtonModel','MD-1.1-HardSphere']


def prepare():
    receipt=BASE/'mathcopilot_results/EAUDIT02_PREPARATION.json'
    if receipt.exists():
        saved=read(receipt)
        assert sha(ROOT/'Blueprint/Ch01.lean')==saved['lean_sha256']
        assert sha(BASE/'ch01_source.json')==saved['source_sha256']
        print('Existing EAUDIT02 preparation reused; no duplicate repair_log.')
        return
    raw={w['source_id']:w for w in read(BASE/'mathcopilot_results/BATCH02_result.json')}
    sources=read(BASE/'ch01_source.json')
    old_source_sha256=sha(BASE/'ch01_source.json')
    old_sources=copy.deepcopy(sources)
    indexed={s['source_id']:s for s in sources}
    ds=declarations()
    visual=BASE/'validation/EAUDIT02/source_pages'
    visual.mkdir(parents=True,exist_ok=True)
    pdf=next(ROOT.parent.glob('Leimkuhler2015b*.pdf'))
    expected_pdf=read(BASE/'mathcopilot_tasks/MANIFEST.json')[0]['source_pdf_sha256']
    assert sha(pdf)==expected_pdf
    book=fitz.open(pdf)
    pages=[]
    for p in (28,29,30):
        path=visual/f'pdf{p:03}.png'
        book[p-1].get_pixmap(matrix=fitz.Matrix(1.3,1.3)).save(path)
        pages.append(dict(pdf_page=p,printed_page=p-23,png=path.relative_to(ROOT).as_posix(),png_sha256=sha(path),
                          verification='VIEW_IMAGE: original PDF28/29/30 visually checked in this turn; fresh render must match cached inspected pixels'))
        old=ROOT/f'tmp/ch01_full/pdf{p:03}.png'
        assert fitz.Pixmap(path).samples==fitz.Pixmap(old).samples
    changed_fields={}
    for sid in SIDS:
        s=indexed[sid]
        before=entry_hash(s)
        c=raw[sid]['json_review'].get('corrected_json') or {}
        changes=[]
        for key in ('statement_latex','proof_latex','proof_note','proof_discussion_latex','context_notation','statement_scope'):
            if key in c and c[key]!=s.get(key):
                changes.append(key)
                s[key]=c[key]
        s['review_status']=raw[sid]['json_review']['status']
        for issue in raw[sid]['json_review'].get('issues',[]):
            if isinstance(issue,dict) and issue not in s['issues']:
                s['issues'].append(dict(issue,status='local_verified',receipt='BATCH02_result.json'))
        s['source_page_verification']='VERIFIED_RENDERED; 2026-10-13 PDF'+s['pdf_page']+'; validation/EAUDIT02/SOURCE_PAGE_VERIFICATION.json'
        if sid.endswith('NewtonModel'):
            s['extra_assumptions'].append('[EXTRA] EAUDIT02：精确N*3维与逐粒子重复质量；正质量；含初始时刻的开放连通时间域；势能沿轨迹可微，资格保证实际梯度而非总化默认值。一般n维定义仅为辅助。')
        if sid.endswith('HardSphere'):
            s['extra_assumptions']=[('[历史签名，EAUDIT02已替换] '+x) for x in s['extra_assumptions']]
            s['extra_assumptions'].append('[EXTRA] EAUDIT02：以标准无摩擦孤立二体弹性碰撞展开standard rules；同时多接触需另有规则。碰撞时刻在整个开放时间域局部孤立，排除稠密事件集使动力学真空化；全粒子对全时间不可穿透；位置连续，碰撞外真实自由运动；实际速度左右极限接入法向冲量、法向速度反转、碰后分离及全部动量/动能守恒。旧只含瞬时必要守恒关系的说明为历史版本。')
        s['repair_log'].append(dict(stage='EAUDIT02_LOCAL_PAGE_RECHECK',timestamp=datetime.now().isoformat(),
            before_sha256=before,after_sha256=entry_hash(s),changed_fields=changes,
            raw_return='blueprint/ch01/mathcopilot_results/BATCH02_result.json',
            raw_sha256=sha(BASE/'mathcopilot_results/BATCH02_result.json'),
            reason='PDF28–30视觉核对；Newton补回原页第i个核的遗漏词；Schrodinger提案当前字段已一致，保留已有文本；原书数学不改。Newton/HardSphere签名按网站FAIL加强模型资格及补全动力学；其余条目不改。'))
        changed_fields[sid]=changes
    assert all(s==old for s,old in zip(sources,old_sources) if s['source_id'] not in SIDS)
    dump(BASE/'ch01_source.json',sources)
    dump(BASE/'validation/EAUDIT02/SOURCE_PAGE_VERIFICATION.json',dict(source_pdf_sha256=expected_pdf,pages=pages))
    paths={'Blueprint/Ch01.lean'}
    pending=list(paths)
    while pending:
        path=pending.pop()
        for imp in re.findall(r'(?m)^import ([\w.]+)',(ROOT/path).read_text(encoding='utf-8-sig')):
            name=imp.replace('.','/')+'.lean'
            if name.startswith('MolecularDynamics/') and name not in paths:
                paths.add(name);pending.append(name)
    index=definitions(sorted(paths))
    for choices in list(index.values()):
        for d in choices:
            if d['namespace']:index.setdefault(d['namespace']+'.'+d['name'],[]).append(d)
    materials={}
    selected_by_sid={}
    for sid in SIDS:
        selected={};pending=referenced(ds[sid]['statement'],index)
        while pending:
            name=sorted(pending)[0];pending.remove(name)
            if name in selected:continue
            choices=index[name];selected[name]=[d for d in choices if d['path']=='Blueprint/Ch01.lean'] or choices
            for d in selected[name]:pending.update(referenced(d['code'],index)-selected.keys())
        chunks=['## 原文JSON','```json',json.dumps(indexed[sid],ensure_ascii=False,indent=2),'```',
                '','## 当前完整Lean签名/定义','```lean',ds[sid]['statement'],'```',
                '','上下文：Lean4.34.0/Mathlibv4.34.0；namespace MD.Ch01；noncomputable section；',
                'open Set Filter MolecularDynamics MolecularDynamics.Chapter01Review；open scoped Topology BigOperators ContDiff InnerProductSpace。',
                '标准Mathlib符号按固定版本展开；项目实际定义如下。多重同名候选均列出，不猜测解析。',
                '','## 已绑定旧返回及本次修复','```json',json.dumps(raw[sid]['audit'],ensure_ascii=False,indent=2),'```','']
        excerpts=[]
        seen=set()
        for choices in selected.values():
            for d in choices:
                key=(d['path'],d['line'])
                if key in seen:continue
                seen.add(key)
                chunks.extend([f'### {d["path"]}:{d["line"]} namespace {d["namespace"]}','```lean',d['code'],'```',''])
                excerpts.append(dict(path=d['path'],line=d['line'],name=d['name'],namespace=d['namespace'],
                                     file_sha256=sha(ROOT/d['path']),excerpt_sha256=hashlib.sha256(d['code'].encode()).hexdigest()))
        materials[sid]='\n'.join(chunks)+'\n';selected_by_sid[sid]=excerpts
    TASK.mkdir(parents=True,exist_ok=True)
    full=TASK/'BATCH_EAUDIT02.md'
    full.write_text('# EAUDIT02：第1章§1.1签名修复及补材料复审\n\n'+'\n'.join(materials.values()),encoding='utf-8')
    shared={'BATCH_EAUDIT02.md':sha(full),'Blueprint/Ch01.lean':sha(ROOT/'Blueprint/Ch01.lean'),
            'blueprint/ch01/ch01_source.json':sha(BASE/'ch01_source.json')}
    reader=PdfReader(pdf);subtasks=[]
    for j,sid in enumerate(SIDS):
        label='EAUDIT02'+chr(97+j);folder=TASK/chr(97+j);folder.mkdir(exist_ok=True)
        # Include the complete section to retain context, with original page mapping.
        page_numbers=(28,29,30)
        writer=PdfWriter()
        for p in page_numbers:writer.add_page(reader.pages[p-1])
        crop=folder/(label+'_PAGES.pdf')
        with crop.open('wb') as f:writer.write(f)
        cropped=fitz.open(crop)
        for k,p in enumerate(page_numbers):assert cropped[k].get_pixmap(matrix=fitz.Matrix(.5,.5)).samples==book[p-1].get_pixmap(matrix=fitz.Matrix(.5,.5)).samples
        hashes={**shared,label+'_materials':hashlib.sha256(materials[sid].encode()).hexdigest(),label+'_PAGES.pdf':sha(crop)}
        prompt=('先A原文逐字审校，再C只读核对当前完整签名及项目实际定义；全部对象/域/量词/前提/结论和[EXTRA]逐项判断，不以sorry判签名FAIL，不修改工程或补证明。原书疑误保留并NEEDS_HUMAN。'
                '\n本条'+sid+'；附件页1/2/3分别是原PDF28/29/30（印刷5/6/7）。\n'
                '必须创建目录并把结果实际写入 /workspace/.mathcopilot/reviews/ch01_eaudit/EAUDIT02_review.json 文件；文件仅含JSON对象：batch=EAUDIT02、input_sha256、items。'
                '已有文件时先核对共享键BATCH_EAUDIT02.md、Blueprint/Ch01.lean、blueprint/ch01/ch01_source.json完全相同；相同则按source_id合并本条并合并input_sha256的子任务独立键，保留其他条；共享键不同则报告版本冲突。input_sha256逐项回显下列哈希。'
                'items每条字段source_id,json_review{status,issue_codes,corrected_json,issues,evidence},audit{lean_decl,verdict,explanation,counterexample,suggested_fix}；'
                'status=APPROVED/CORRECTED/NEEDS_HUMAN，verdict=PASS/FAIL/NEEDS_HUMAN。最后仅回报实际文件路径。\n\ninput_sha256：\n'+json.dumps(hashes,ensure_ascii=False,indent=2)+'\n\n')
        paste=folder/'PASTE.txt';paste.write_text(prompt+materials[sid],encoding='utf-8')
        mp=folder/'MANIFEST.json'
        m=dict(eaudit='EAUDIT02',subtask=label,source_id=sid,input_sha256=hashes,
               source_pdf_sha256=expected_pdf,pdf_page_mapping=list(page_numbers),crop_pixel_identity='PASS',
               paste_sha256=sha(paste),dependency_excerpts=selected_by_sid[sid],
               expected_output='/workspace/.mathcopilot/reviews/ch01_eaudit/EAUDIT02_review.json')
        for _ in range(3):
            m['total_task_bytes']=paste.stat().st_size+crop.stat().st_size+(mp.stat().st_size if mp.exists() else 0)
            dump(mp,m)
        total=sum(p.stat().st_size for p in folder.iterdir() if p.is_file())
        assert total<256000,(label,total)
        subtasks.append(dict(subtask=label,source_id=sid,path=folder.relative_to(ROOT).as_posix(),total_bytes=total,
                             manifest_sha256=sha(mp),semantic_review='pending'))
    dump(TASK/'MANIFEST.json',dict(eaudit='EAUDIT02',input_sha256=shared,subtasks=subtasks))
    (TASK/'INDEX.md').write_text('# EAUDIT02：第1章§1.1复审\n\n每条粘贴PASTE.txt，并上传同目录原页PDF；网站只由用户提交。a补齐Schrodinger材料，b修Newton，c修HardSphere。\n\n'
        +'\n'.join('- ['+s['subtask']+']('+s['path'].split('EAUDIT02/')[1]+'/PASTE.txt)：'+s['source_id']+'，'+str(s['total_bytes'])+'字节。' for s in subtasks)
        +'\n\n要求实际输出 /workspace/.mathcopilot/reviews/ch01_eaudit/EAUDIT02_review.json，并包含input_sha256；本地字节及裁页一致性已验，网站执行及语义PASS尚未验证。\n',encoding='utf-8')
    wp=BASE/'website_audit.json';web=read(wp)
    for w in web:
        if w['source_id'] in SIDS:
            w['repair']=dict(eaudit='EAUDIT02',status='awaiting_reaudit',
                             signature_changed=w['source_id']!='MD-1.1-Schrodinger',
                             json_review_locally_verified=True,
                             task_index='blueprint/ch01/mathcopilot_tasks/EAUDIT02/INDEX.md',
                             input_sha256=shared)
            w['effective_status']=display(w)
    dump(wp,web)
    dump(receipt,dict(source_ids=SIDS,lean_sha256=shared['Blueprint/Ch01.lean'],source_sha256=shared['blueprint/ch01/ch01_source.json'],
                      raw_return_sha256=sha(BASE/'mathcopilot_results/BATCH02_result.json'),
                      changed_source_fields=changed_fields,old_source_sha256=old_source_sha256,
                      task_index='blueprint/ch01/mathcopilot_tasks/EAUDIT02/INDEX.md',website_reaudit='not submitted',
                      protected_historical_batch_files='not regenerated'))
    print('Prepared 3 EAUDIT02 compact tasks:',[s['total_bytes'] for s in subtasks])


if __name__=='__main__':prepare()

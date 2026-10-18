"""First-round Chapter 7 A+C packs with recursively complete project definitions."""
from common29 import *
RECORDS=[]
EXCLUDED=[]
def verify_frozen():
    for p,h in load(OUT/'FROZEN_BASELINE.json').items():
        assert sha(ROOT/p)==h,p
    return len(load(OUT/'FROZEN_BASELINE.json'))

from ch07_dependency_index import index_project,tokens,strip_comments
import pymupdf as fitz

def closure(code,index):
    selected={};pending=[(t,'Blueprint/Ch07.lean','MD.Ch07') for t in tokens(code)]
    while pending:
        token,path,ns=pending.pop();choices=index.get(token,[])
        # Project structure projections require the complete owning structure.
        if not choices and '.' in token:
            bits=token.split('.')
            for i in range(len(bits)-1,0,-1):
                choices=index.get('.'.join(bits[:i]),[])
                if choices:break
        exact=[d for d in choices if d['full_name']==ns+'.'+token]
        same=[d for d in choices if d['path']==path]
        if exact:choices=exact
        elif same:choices=same
        elif len(token)<=2 and '.' not in token:
            choices=[d for d in choices if d['kind']=='abbrev' and d['path'].endswith('ReviewDefinitions.lean')]
        for d in choices:
            key=d['full_name']
            if key in selected:continue
            selected[key]=d
            pending.extend((t,d['path'],d['namespace']) for t in tokens(d['code']) if t!=d['name'])
    return sorted(selected.values(),key=lambda d:(d['path'],d['line']))

def build():
    global RECORDS
    selected=[r['source_id'] for r in load(OUT/'REPAIRS.json')]
    selected += [r['source_id'] for r in load(OUT/'HUMAN_REPAIRS.json') if r['signature_changed']]
    g=groups()
    RECORDS=[dict(r,code=g[r['source_id']]['code']) for r in load(BASE/'ch07_source.json') if r['source_id'] in selected]
    dump(OUT/'REAUDIT_SELECTION.json',dict(source_ids=selected,entries=len(selected)))
    verify_frozen();index,contexts,allitems=index_project();book=fitz.open(next(ROOT.parent.glob('*.pdf')))
    tasks=BASE/'mathcopilot_tasks';tasks.mkdir(exist_ok=True);manifests=[];validation=[]
    for start in range(0,len(RECORDS),3):
        batch=f'EAUDIT{start//3+1:02}';subtasks=[];full=['# '+batch+' 第7章修改后陈述复审','']
        for j,r in enumerate(RECORDS[start:start+3]):
            label=batch+chr(97+j);dest=tasks/batch/chr(97+j);dest.mkdir(parents=True,exist_ok=True)
            ds=closure(r['code'],index);covered={d['full_name'] for d in ds}
            # Check every explicit project constant, including recursively used definitions.
            missing=[]
            for d in [dict(code=r['code'])]+ds:
                for t in tokens(d['code']):
                    if not t.startswith(('MolecularDynamics.','MD.')):continue
                    if t in covered or any(t.startswith(n+'.') for n in covered):continue
                    if any(v['full_name']==t for v in allitems):missing.append(t)
                    elif t not in ['MolecularDynamics.Chapter06Review','MD.Ch07']:
                        # Namespace names may occur in fully qualified types only via actual constants.
                        if not any(n.startswith(t+'.') for n in covered):missing.append(t)
            assert not missing,(r['source_id'],missing)
            nums=[int(s) for s in re.findall(r'\d+',r['pdf_page'])];pages=list(range(nums[0],nums[-1]+1))
            attachment=dest/'PAGES.pdf';export=fitz.open()
            for p in pages:export.insert_pdf(book,from_page=p-1,to_page=p-1)
            export.save(attachment,garbage=4,deflate=True);export.close()
            inputs={'Blueprint/Ch07.lean':sha(ROOT/'Blueprint/Ch07.lean'),'blueprint/ch07/ch07_source.json':sha(BASE/'ch07_source.json'),attachment.name:sha(attachment)}
            source={k:v for k,v in r.items() if k not in ['code','local_verdict','missing']}
            text='以附件/PASTE 为准，忽略 /workspace 旧文件；Mathlib 定义按标准含义采信。\n'
            text+='本任务只审本条：原文转录、对象资格、定义体、量词、全部结论及[EXTRA]是否一致；Lean编译不代替语义审阅。\n'
            text+='Lean/Mathlib均4.34.0。原页PDF映射：'+str(pages)+'；印刷页='+str([p-21 for p in pages])+'.\n'
            text+='input_sha256请原样回显：\n'+json.dumps(inputs,ensure_ascii=False,indent=2)+'\n'
            text+='用代码将JSON对象(batch,input_sha256,items)写到 /workspace/.mathcopilot/reviews/ch07/'+label+'_review.json；items仅含本source_id。\n'
            text+='items字段：source_id、verdict(PASS/FAIL/NEEDS_HUMAN)、transcription、semantic_review、counterexample、suggested_fix、printed_version、corrected_version。逐版区分原文疑误和修正版结论；缺材料必须具体指出，不猜测。写后json.loads自检，最后仅回复路径及统计。\n\n'
            text+='## 原文JSON\n```json\n'+json.dumps(source,ensure_ascii=False,indent=2)+'\n```\n\n'
            text+='## 完整本条Lean\n```lean\n'+r['code']+'\n```\n\n'
            text+='## 项目依赖定义体及选择规格\n以下def/abbrev/structure完整保留；定理列出完整类型，Mathlib标准定义无需摘录。\n'
            for d in ds:
                text+='\n### '+d['full_name']+' ('+d['path']+':'+str(d['line'])+')\n'
                text+='原文件上下文：\n```lean\n'+contexts[d['path']]+'\n```\n'
                text+='```lean\n'+d['code']+'\n```\n'
            (dest/'PASTE.txt').write_text(text,encoding='utf-8')
            dpi=72
            if attachment.stat().st_size+len(text.encode())+10000>=256000:
                # Full-page lossless raster fallback; do not retry cropping scripts.
                for dpi in [126,108,90,72]:
                    raster=fitz.open()
                    for p in pages:
                        original=book[p-1];pix=original.get_pixmap(dpi=dpi);q=raster.new_page(width=original.rect.width,height=original.rect.height);q.insert_image(q.rect,pixmap=pix)
                    attachment.write_bytes(raster.tobytes(garbage=4,deflate=True));raster.close()
                    if attachment.stat().st_size+len(text.encode())+10000<256000:break
                inputs[attachment.name]=sha(attachment)
                # Only the attachment hash changes after full-page rasterization.
                text=re.sub(r'"'+re.escape(attachment.name)+r'": "[a-f0-9]{64}"','"'+attachment.name+'": "'+sha(attachment)+'"',text)
                (dest/'PASTE.txt').write_text(text,encoding='utf-8')
            check=fitz.open(attachment)
            for k,p in enumerate(pages):
                assert book[p-1].get_pixmap(dpi=dpi).samples==check[k].get_pixmap(dpi=dpi).samples,(label,p,dpi)
            check.close()
            mf=dict(batch=batch,subtask=label,source_ids=[r['source_id']],input_sha256=inputs,
                page_mapping=[dict(attachment_page=k+1,original_pdf_page=p,printed_page=p-21) for k,p in enumerate(pages)],
                definition_excerpts=[dict(full_name=d['full_name'],kind=d['kind'],path=d['path'],line=d['line'],code_sha256=hashlib.sha256(d['code'].encode()).hexdigest()) for d in ds],
                validation=dict(project_constant_closure='PASS',missing_project_definitions=[],full_page_render_equality_dpi=dpi,website_submitted=False),
                files={p.name:dict(bytes=p.stat().st_size,sha256=sha(p)) for p in [dest/'PASTE.txt',attachment]})
            for _ in range(4):dump(dest/'MANIFEST.json',mf);mf['total_task_bytes']=sum(p.stat().st_size for p in dest.iterdir() if p.is_file())
            dump(dest/'MANIFEST.json',mf)
            assert mf['total_task_bytes']==sum(p.stat().st_size for p in dest.iterdir() if p.is_file())<256000,(label,mf['total_task_bytes'])
            subtasks.append(dict(subtask=label,source_id=r['source_id'],path=dest.relative_to(ROOT).as_posix(),bytes=mf['total_task_bytes'],manifest_sha256=sha(dest/'MANIFEST.json')))
            validation.append(dict(source_id=r['source_id'],project_constants=len(ds),missing=[]))
            full+=['## '+r['source_id'],'```json',json.dumps(source,ensure_ascii=False,indent=2),'```','```lean',r['code'],'```','']
        (tasks/(batch+'.md')).write_text('\n'.join(full),encoding='utf-8')
        dump(tasks/batch/'MANIFEST.json',dict(batch=batch,subtasks=subtasks))
        manifests.append(dict(batch=batch,source_ids=[s['source_id'] for s in subtasks],subtasks=subtasks))
    dump(tasks/'EAUDIT_MANIFEST.json',manifests)
    dump(OUT/'PACKAGE_VALIDATION.json',dict(batches=len(manifests),subtasks=len(validation),covered_entries=len(validation),checks=validation,website_submitted=False))
    (tasks/'EAUDIT_INDEX.md').write_text('# 第7章待用户提交的复审任务包\n\n'+f'{len(manifests)}批、{len(validation)}子包，覆盖{len(validation)}条；尚未提交网站。\n\n'+'\n'.join('- '+b['batch']+'：'+', '.join(b['source_ids']) for b in manifests)+'\n',encoding='utf-8')
    print('PACKAGES',len(manifests),len(validation),flush=True)
if __name__=='__main__':build()

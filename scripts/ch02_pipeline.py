"""Chapter 2-only generation; never writes the Chapter 1 delivery or formal library."""
from pathlib import Path
import json,re,hashlib,csv,subprocess,argparse
import fitz
from pypdf import PdfReader,PdfWriter
from ch02_data import ROOT,BASE,RECORDS,EXCLUDED
from build_mathcopilot_compact import definitions,referenced

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def dump(p,v):p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
def verify_protected():
    baseline=json.loads((BASE/'BASELINE.json').read_text(encoding='utf-8'))
    for p,h in baseline['protected'].items():assert sha(ROOT/p)==h, 'Protected input changed: '+p
    for p,h in baseline['unrelated'].items():assert sha(ROOT/p)==h, 'Other task file changed: '+p
    return len(baseline['protected'])

def declarations():
    text=(ROOT/'Blueprint/Ch02.lean').read_text(encoding='utf-8-sig');out={}
    marks=list(re.finditer(r'/-- source_id:\s*([^\s·]+)[\s\S]*?-/',text))
    for i,m in enumerate(marks):
        end=marks[i+1].start() if i+1<len(marks) else text.rfind('end MD.Ch02')
        raw=text[m.end():end].strip();d=re.search(r'\b(def|theorem)\s+(\w+)',raw)
        statement=raw if d.group(1)=='def' else re.split(r'\s:=\s*by\b',raw,1)[0].rstrip()
        out[m.group(1)]=dict(name='MD.Ch02.'+d.group(2),statement=statement,block=raw,
            line=text[:m.end()].count('\n')+raw[:d.start()].count('\n')+2,
            signature_sha256=hashlib.sha256(statement.encode()).hexdigest())
    return out

def generate():
    verify_protected()
    header='''import MolecularDynamics.Chapter02.ReviewProofs
import MolecularDynamics.Chapter02.EulerConvergence
import MolecularDynamics.Chapter02.ActualFlowVariations
import MolecularDynamics.Chapter02.LiouvilleVolume
import MolecularDynamics.Chapter02.HamiltonianVolume
import MolecularDynamics.Chapter01.Lagrangian
import Mathlib.Tactic

open Set Filter Matrix MeasureTheory MolecularDynamics MolecularDynamics.Chapter02Review
open scoped BigOperators Topology ContDiff InnerProductSpace Matrix.Norms.L2Operator
noncomputable section
namespace MD.Ch02
variable {n Nc : ℕ}

'''
    chunks=[header]
    sources=[]
    for r in RECORDS:
        sources.append({k:v for k,v in r.items() if k not in
            ('code','local_verdict','local_explanation','priors','missing','correspondence')})
        comment=f"/-- source_id: {r['source_id']} · {r['label'] or r['kind']} · §{r['section']} · 印刷p.{r['printed_page']} / PDFp.{r['pdf_page']}"
        comment+=''.join('\n[EXTRA] '+x for x in r['extra_assumptions'])
        comment+=''.join('\n['+x.get('code','NEEDS_HUMAN')+'] '+x['detail'] for x in r['issues'])
        chunks += [comment+' -/\n'+r['code']+'\n\n']
    chunks+=['end MD.Ch02\n']
    (ROOT/'Blueprint/Ch02.lean').write_text(''.join(chunks),encoding='utf-8')
    dump(BASE/'ch02_source.json',sources)
    dump(BASE/'excluded_qualitative.json',EXCLUDED)
    audit_path=BASE/'local_audit.json';previous=json.loads(audit_path.read_text(encoding='utf-8'))['items'] if audit_path.exists() else {}
    ds=declarations();items={}
    for r in RECORDS:
        sid=r['source_id'];d=ds[sid];a=previous.get(sid,{})
        if a.get('signature_sha256')!=d['signature_sha256']:a.update(checked=False,axioms=[],final_status='incomplete')
        direct=bool(re.search(r'\bsorry\b',d['block']))
        a.update(lean_decl=d['name'],verdict=r['local_verdict'],explanation=r['local_explanation'],
            signature_sha256=d['signature_sha256'],direct_placeholder=direct,
            proof_status='placeholder' if direct else ('definition' if r['code'].startswith('def ') else ('existing_bridge' if r['priors'] else 'local_proof')),
            documented_priors=r['priors'],missing=r['missing'],website_audit='待网站审计',
            correspondence=r['correspondence'] or [dict(source='原文完整数学对象和展示式',lean=d['name']+'；定义体/完整签名见上',note='一致；逐条技术条件见[EXTRA]')],
            counterexample=None,suggested_fix=None,proof_attempts=a.get('proof_attempts',0))
        items[sid]=a
    dump(audit_path,dict(template='C',method='local_read_only_semantic_review',website_audit='待网站审计',items=items))
    (BASE/'CheckAxioms.lean').write_text('import Blueprint.Ch02\n\n'+'\n'.join('#print axioms '+s['lean_decl'] for s in sources)+'\n',encoding='utf-8')
    mapping={oid:r['source_id'] for r in RECORDS for oid in r['old_ids']}
    old=list(csv.DictReader((ROOT/'docs/review/CH02_CLAIMS.csv').open(encoding='utf-8-sig')))
    dump(BASE/'old_mapping.json',dict(mapped=mapping,pending=[r['id'] for r in old if r['id'] not in mapping],excluded={}))
    packages(sources,ds)
    progress(sources,items,mapping,old)
    print('Generated',len(sources),'entries;',len(mapping),'/160 old rows mapped; protected',verify_protected())

def packages(sources,ds):
    taskdir=BASE/'mathcopilot_tasks';taskdir.mkdir(exist_ok=True)
    paths=['Blueprint/Ch02.lean']+[p.relative_to(ROOT).as_posix() for p in (ROOT/'MolecularDynamics').rglob('*.lean')]
    index=definitions(paths+['.lake/packages/mathlib/Mathlib/Analysis/ODE/Basic.lean'])
    pdf=next(ROOT.parent.glob('Leimkuhler2015b*.pdf'));reader=PdfReader(pdf); original=fitz.open(pdf)
    batches=[];num=1
    for sec in dict.fromkeys(s['section'] for s in sources):
        its=[s for s in sources if s['section']==sec]
        for offset in range(0,len(its),8):batches.append((f'BATCH{num:02}',its[offset:offset+8]));num+=1
    manifests=[];lines=['# 第2章 MathCopilot 批次索引','','网站暂不可用；只由用户提交，全部待网站审计。每批≤8条；每个compact子任务全文粘贴PASTE.txt，仅关联对应原页PDF。未冻结、网站接收未验证。',
        '','| 批次 | source_id | compact子任务（输入+PDF字节） |','|---|---|---|']
    prompt='''A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。
'''
    for batch,its in batches:
        full=[f'# {batch} 第2章A原文审校 + C只读语义审计','',prompt,'Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。','']
        subtasks=[]
        # One item per compact task gives a predictable conservative byte budget.
        for j,s in enumerate(its):
            sid=s['source_id'];task=batch+chr(97+j);folder=taskdir/'compact'/batch/chr(97+j);folder.mkdir(parents=True,exist_ok=True)
            numbers=[int(n) for n in re.findall(r'\d+',s['pdf_page'])];pages=set(range(numbers[0],numbers[-1]+1))
            # Include explicitly cited context pages and primary preceding setup.
            for m in re.finditer(r'PDF\s*(?:p\.?\s*)?(\d+)(?:[–-](\d+))?',json.dumps([s['context_notation'],s['extra_assumptions']],ensure_ascii=False)):
                pages.update(range(int(m.group(1)),int(m.group(2) or m.group(1))+1))
            pages=sorted(p for p in pages if 75<=p<=116)
            selected={};pending=referenced(ds[sid]['statement'],index)
            while pending:
                name=sorted(pending)[0];pending.remove(name)
                if name in selected:continue
                choices=index[name]
                # Namespace ambiguity must be visible, never resolved by guessing.
                preferred=[d for d in choices if d['path']=='Blueprint/Ch02.lean']
                chosen=preferred or choices
                selected[name]=chosen
                for d in chosen:pending.update(referenced(d['code'],index)-selected.keys())
            materials=['## 原页映射','| 附件页 | 原PDF页 | 印刷页 |','|---|---|---|']
            materials += [f'| {k+1} | {p} | {p-22} |' for k,p in enumerate(pages)]
            materials += ['','## 完整原文JSON','```json',json.dumps(s,ensure_ascii=False,indent=2),'```','','## 实际Lean签名/定义','```lean',ds[sid]['statement'],'```','',
                '原上下文：namespace MD.Ch02；open Set Filter Matrix MeasureTheory MolecularDynamics MolecularDynamics.Chapter02Review；open scoped BigOperators Topology ContDiff InnerProductSpace Matrix.Norms.L2Operator；noncomputable section；variable {n Nc : ℕ}。',
                '标准Mathlib符号按4.34.0解释；如下为项目实际依赖定义，保留原代码。多个同名定义列出命名空间，若仍缺决定性上下文需NEEDS_HUMAN。','']
            excerpts=[]
            for name,choices in sorted(selected.items()):
                for d in choices:
                    materials += [f"### {d['namespace']}.{name} ({d['path']}:{d['line']})",'```lean',d['code'],'```','']
                    excerpts.append(dict(path=d['path'],namespace=d['namespace'],name=name,code_sha256=hashlib.sha256(d['code'].encode()).hexdigest()))
            text='请直接使用下方完整材料执行A+C；无需读取Markdown附件。原页见附件 '+task+'_PAGES.pdf。PDF读取失败明确报告工具错误，未核对不记通过。\n\n'+prompt+'\n'+'\n'.join(materials)
            (folder/'PASTE.txt').write_text(text,encoding='utf-8')
            writer=PdfWriter()
            for p in pages:writer.add_page(reader.pages[p-1]).compress_content_streams(level=9)
            writer.compress_identical_objects();pdfout=folder/(task+'_PAGES.pdf');writer.write(pdfout)
            exported=fitz.open(pdfout)
            for k,p in enumerate(pages):
                assert original[p-1].get_pixmap().samples==exported[k].get_pixmap().samples,(task,p)
            size=len(text.encode())+pdfout.stat().st_size
            assert size<256000,(task,size)
            report=dict(batch=batch,subtask=task,source_ids=[sid],page_mapping=[dict(attachment_page=k+1,original_pdf_page=p,printed_page=p-22) for k,p in enumerate(pages)],
                source_pdf_sha256=sha(pdf),source_json_sha256=sha(BASE/'ch02_source.json'),lean_sha256=sha(ROOT/'Blueprint/Ch02.lean'),
                signature_sha256=ds[sid]['signature_sha256'],definition_excerpts=excerpts,paste_plus_pdf_bytes=size,
                files={p.name:dict(bytes=p.stat().st_size,sha256=sha(p)) for p in [folder/'PASTE.txt',pdfout]},
                validation=dict(verbatim_source_signature_definitions='PASS',pdf_rendered_pixel_equality='PASS',website_acceptance='NOT_TESTED'))
            dump(folder/'MANIFEST.json',report);subtasks.append(dict(subtask=task,path=folder.relative_to(ROOT).as_posix(),bytes=size,manifest_sha256=sha(folder/'MANIFEST.json')))
            full += ['### '+sid,'```json',json.dumps(s,ensure_ascii=False,indent=2),'```','```lean',ds[sid]['statement'],'```','']
        (taskdir/(batch+'.md')).write_text('\n'.join(full)+'\n',encoding='utf-8')
        manifests.append(dict(batch=batch,source_ids=[s['source_id'] for s in its],full_batch_sha256=sha(taskdir/(batch+'.md')),subtasks=subtasks))
        lines.append('| '+batch+' | '+', '.join(s['source_id'] for s in its)+' | '+', '.join(f"[{t['subtask']}](compact/{batch}/{chr(97+k)}/PASTE.txt) ({t['bytes']})" for k,t in enumerate(subtasks))+' |')
    dump(taskdir/'MANIFEST.json',manifests)
    lines+=['','返回件原样放blueprint/ch02/mathcopilot_results/，按source_id整合，repair_log只追加；修订签名后重新审计。第1章冻结不受本生成器影响。']
    (taskdir/'INDEX.md').write_text('\n'.join(lines)+'\n',encoding='utf-8')
    (BASE/'mathcopilot_results').mkdir(exist_ok=True)
    (BASE/'mathcopilot_results/README.md').write_text('网站不可用，尚无返回件。用户按INDEX提交后将原始JSON或Markdown放此处；原始件保留，非PASS或签名修复需EAUDIT。\n',encoding='utf-8')

def progress(sources,audit,mapping,old):
    lines=['# 第2章本地五步流程进度','','范围：印刷p.53–94/PDF75–116，Exercises及参考文献排除；第1章冻结暂停，heartbeat ACTIVE/15分钟原样。',
        '下一步：见CURRENT_STATE顶部；按节推进。网站不可用，未冻结。',
        f'当前{len(sources)}条；旧清单映射{len(mapping)}/160；本地PASS {sum(a["verdict"]=="PASS" for a in audit.values())}；网站返回0。','',
        '| source_id | JSON | Blueprint | 本地预审 | 网站审计 | 证明/状态 |','|---|---|---|---|---|---|']
    for s in sources:
        a=audit[s['source_id']];proof=a['proof_status']+' / '+a.get('final_status','incomplete')
        if a.get('missing'):proof+='；'+a['missing']
        lines.append('| '+' | '.join([s['source_id'],'DRAFT/原页已核','已编译' if a['checked'] else '待编译',a['verdict'],'待网站审计',proof.replace('|','/')])+' |')
    lines+=['','## 旧160条完整映射','','| 旧id | 新source_id或当前缺项 |','|---|---|']
    for r in old:lines.append('| '+r['id']+' | '+mapping.get(r['id'],'PENDING：所属节尚未处理')+' |')
    lines+=['','## NEEDS_HUMAN / [ERRATUM?] / 缺理论','']
    for s in sources:
        a=audit[s['source_id']]
        if a['verdict']!='PASS' or s['issues'] or a.get('missing'):
            lines.append('- '+s['source_id']+'：'+a['explanation']+' '+(a.get('missing') or '')+' '.join(i['detail'] for i in s['issues']))
    lines+=['','## 定性段落排除','']+[f"- p.{x['printed_page']}/PDF{x['pdf_page']}：{x['reason']}" for x in EXCLUDED]
    (BASE/'PROGRESS.md').write_text('\n'.join(lines)+'\n',encoding='utf-8')

def checked(log):
    audit=json.loads((BASE/'local_audit.json').read_text(encoding='utf-8'));text=Path(log).read_text(encoding='utf-8-sig')
    for a in audit['items'].values():
        m=re.search("'"+re.escape(a['lean_decl'])+r"' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)",text)
        assert m,'Missing axiom output '+a['lean_decl']
        axs=[] if m.group(1) is None else [x.strip() for x in m.group(1).split(',') if x.strip()]
        a.update(checked=True,axioms=axs,final_status='incomplete' if 'sorryAx' in axs or a['verdict']!='PASS' else ('checked+documented priors' if a['documented_priors'] else 'self-contained'),
            axiom_log=str(Path(log).relative_to(ROOT)))
    dump(BASE/'local_audit.json',audit)

if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--checked');args=parser.parse_args()
    if args.checked:checked(ROOT/args.checked)
    generate()

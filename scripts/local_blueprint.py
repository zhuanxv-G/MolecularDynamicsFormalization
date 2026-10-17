"""Reuse the accepted Chapter 2 pipeline as a read-only template for Chapters 3–6.

Never modify/run the Chapter 1 or Chapter 2 generators. Each instantiated module
has its own source records and output directory; page offsets are chapter-local.
"""
from pathlib import Path
import sys,types,re,json,hashlib,argparse,subprocess
ROOT=Path(__file__).resolve().parents[1]
RANGES={3:(97,136,119,158),4:(139,174,161,196),5:(179,209,200,230),6:(211,258,232,279)}
def pipeline(ch):
    assert ch in RANGES
    template=(ROOT/'scripts/ch02_pipeline.py').read_text(encoding='utf-8')
    text=template.replace('ch02',f'ch{ch:02}').replace('Ch02',f'Ch{ch:02}').replace('CH02',f'CH{ch:02}')
    text=text.replace('Chapter 2',f'Chapter {ch}').replace('第2章',f'第{ch}章')
    text=text.replace('第1章冻结暂停', '第1–5章冻结，正式库冻结' if ch==6 else '第1章按授权网站修复例外处理，正式库冻结')
    text=text.replace('160',str(len(__import__(f'ch{ch:02}_data').OLD_ROWS)))
    lo,hi,p0,p1=RANGES[ch];off=p0-lo
    text=text.replace('75<=p<=116',f'{p0}<=p<={p1}').replace('p-22',f'p-{off}')
    text=text.replace('53–94/PDF75–116',f'{lo}–{hi}/PDF{p0}–{p1}')
    text=text.replace('第1、2章均等待用户提交MathCopilot批次',f'第{ch}章等待用户提交MathCopilot批次；继续下一章本地流程')
    text=text.replace('namespace MD.Ch'+f'{ch:02}'+'；open',f'namespace MD.Ch{ch:02}；open')
    text=text.replace('import MolecularDynamics.Chapter02.ReviewProofs',
        f'import MolecularDynamics.Chapter{ch:02}.ReviewProofs\nimport MolecularDynamics.Chapter02.ReviewProofs',1)
    if not (ROOT/f'MolecularDynamics/Chapter{ch:02}/ReviewProofs.lean').exists():
        text=text.replace(f'import MolecularDynamics.Chapter{ch:02}.ReviewProofs',
                          f'import MolecularDynamics.Chapter{ch:02}.Statements')
    if ch==4:
        text=text.replace('Matrix.Norms.L2Operator','Matrix.Norms.Elementwise')
        text=text.replace('import Mathlib.Tactic', 'import Mathlib.LinearAlgebra.Matrix.ToLinearEquiv\nimport Mathlib.Analysis.Matrix.Spectrum\nimport Mathlib.Analysis.Calculus.Deriv.Slope\nimport Mathlib.Analysis.SpecialFunctions.Trigonometric.ArctanDeriv\nimport Mathlib.LinearAlgebra.FiniteDimensional.Lemmas\nimport Mathlib.Tactic',1)
    if ch==5:
        text=text.replace('import Mathlib.Tactic','import Mathlib.MeasureTheory.Measure.Lebesgue.EqHaar\nimport Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform\nimport Mathlib.Analysis.Calculus.ParametricIntegral\nimport Mathlib.Analysis.Calculus.Deriv.Slope\nimport Mathlib.Analysis.Calculus.LineDeriv.IntegrationByParts\nimport Mathlib.Analysis.Calculus.Taylor\nimport Mathlib.Analysis.SpecialFunctions.Gamma.Basic\nimport MolecularDynamics.Chapter01.ReviewDefinitions\nimport Mathlib.Tactic',1)
    text=text.replace('open Set Filter Matrix MeasureTheory MolecularDynamics MolecularDynamics.Chapter02Review',
        f'open Set Filter Matrix MeasureTheory MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter{ch:02}Review')
    if ch==6:
        text=text.replace('import Mathlib.Tactic',
            'import MolecularDynamics.Chapter06.WienerStratonovich\nimport MolecularDynamics.Chapter06.WienerDeterministicLaw\nimport Mathlib.Analysis.Calculus.Deriv.MeanValue\nimport Mathlib.Analysis.Calculus.Deriv.Shift\nimport Mathlib.Analysis.Calculus.Taylor\nimport Mathlib.Tactic',1)
        text=text.replace(f'open Set Filter Matrix MeasureTheory MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter{ch:02}Review',
            f'open Set Filter Matrix MeasureTheory ProbabilityTheory MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter{ch:02}Review')
        text=text.replace('open scoped BigOperators Topology ContDiff InnerProductSpace Matrix.Norms.L2Operator\n',
            'open scoped BigOperators Topology ContDiff InnerProductSpace Matrix.Norms.L2Operator ENNReal NNReal\n',1)
    text=text.replace('variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]',
        'variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]\nvariable {R : Type*} [Ring R] [Algebra ℝ R]',1)
    text=text.replace('[NormedSpace ℝ E]。', '[NormedSpace ℝ E]；variable {R : Type*} [Ring R] [Algebra ℝ R]。')
    text=text.replace('MolecularDynamics.Chapter02Review；', f'MolecularDynamics.Chapter02Review MolecularDynamics.Chapter{ch:02}Review；')
    text=text.replace('a.update(checked=False,axioms=[]', 'a.update(checked=False,compiled=False,axioms=[]')
    text=text.replace("'已编译' if a['checked'] else '待编译'", "'已编译/公理已核' if a['checked'] else ('已编译/待公理' if a.get('compiled') else '待编译')")
    text=text.replace("re.match(r'(?:noncomputable )?def '", "re.match(r'(?:@\\[[^\\]]+\\]\\s*)*(?:noncomputable )?def '")
    # The user's byte cap includes all three files, including the manifest.
    text=text.replace("dump(folder/'MANIFEST.json',report);subtasks.append", """dump(folder/'MANIFEST.json',report)
            for _ in range(3):
                report['total_task_bytes']=size+(folder/'MANIFEST.json').stat().st_size
                dump(folder/'MANIFEST.json',report)
            total_bytes=sum(f.stat().st_size for f in folder.iterdir() if f.is_file())
            assert total_bytes<256000,(task,total_bytes)
            subtasks.append""")
    text=text.replace('bytes=size,manifest_sha256=', 'bytes=total_bytes,manifest_sha256=')
    # A few plot pages have large vector streams. Keep the complete original
    # page at the highest fitting raster resolution, losslessly, and compare
    # every rendered pixel at that recorded resolution before accepting it.
    text=text.replace("size=(folder/'PASTE.txt').stat().st_size+pdfout.stat().st_size", """render_dpi=previous.get('validation',{}).get('pdf_rendered_pixel_equality_dpi',72) if cached else 72
            if (folder/'PASTE.txt').stat().st_size+pdfout.stat().st_size+8192>=256000:
                if 'exported' in locals() and not exported.is_closed:exported.close()
                for render_dpi in (144,108,72):
                    flattened=fitz.open()
                    reference=[]
                    for p in pages:
                        op=original[p-1];pix=op.get_pixmap(dpi=render_dpi)
                        reference.append(pix.samples)
                        fp=flattened.new_page(width=op.rect.width,height=op.rect.height)
                        fp.insert_image(fitz.Rect(0,0,pix.width*72/render_dpi,pix.height*72/render_dpi),
                            stream=pix.tobytes('png'),keep_proportion=False)
                    flattened.save(pdfout,garbage=4,deflate=True,use_objstms=1)
                    exported=fitz.open(pdfout)
                    assert all(reference[k]==exported[k].get_pixmap(dpi=render_dpi).samples for k in range(len(pages))),(task,render_dpi)
                    exported.close()
                    if (folder/'PASTE.txt').stat().st_size+pdfout.stat().st_size+8192<256000:break
            size=(folder/'PASTE.txt').stat().st_size+pdfout.stat().st_size""")
    text=text.replace("pdf_rendered_pixel_equality='PASS',website_acceptance", "pdf_rendered_pixel_equality='PASS',pdf_rendered_pixel_equality_dpi=render_dpi,website_acceptance")
    if ch==6:
        text=text.replace('仅返回JSON数组，每个source_id恰一次，字段：',
            '用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：')
        text=text.replace("size=(folder/'PASTE.txt').stat().st_size+pdfout.stat().st_size", """compact_inputs={f'Blueprint/Ch06.lean':sha(ROOT/'Blueprint/Ch06.lean'),
                'blueprint/ch06/ch06_source.json':sha(BASE/'ch06_source.json'),
                task+'_PAGES.pdf':sha(pdfout),'signature_sha256':ds[sid]['signature_sha256']}
            prefix=('以附件/PASTE 为准，忽略 /workspace 旧文件；Mathlib 定义按标准含义采信。'
                +f'\\n本子任务batch={task}；实际写入 /workspace/.mathcopilot/reviews/ch06/{task}_review.json。'
                +'写入后用json.loads自检，最后只回复实际路径和统计。input_sha256必须逐项原样回显：\\n'
                +json.dumps(compact_inputs,ensure_ascii=False,indent=2)+'\\n\\n')
            (folder/'PASTE.txt').write_text(prefix+text,encoding='utf-8')
            size=(folder/'PASTE.txt').stat().st_size+pdfout.stat().st_size""")
        text=text.replace("signature_sha256=ds[sid]['signature_sha256'],definition_excerpts=",
            "input_sha256=compact_inputs,signature_sha256=ds[sid]['signature_sha256'],definition_excerpts=")
    text=text.replace('compact子任务（输入+PDF字节）', 'compact子任务（PASTE+PDF+MANIFEST字节）')
    # A qualified project identifier must select its real namespace, rather than
    # disappear because the excerpt index originally had only bare-name keys.
    text=text.replace("{d['namespace']}.{name}","{d['namespace']}.{d['name']}")
    text=text.replace("namespace=d['namespace'],name=name,", "namespace=d['namespace'],name=d['name'],")
    # Per-module source scope never includes Ch01 or prior chapter output writes.
    m=types.ModuleType('local_current_pipeline');m.__file__=str(ROOT/'scripts/local_blueprint.py')
    sys.modules[m.__name__]=m;exec(compile(text,m.__file__,'exec'),m.__dict__)
    raw_definitions=m.definitions
    def namespace_index(paths):
        index=raw_definitions(paths)
        # A transparent type alias can carry an inline attribute. Preserve it
        # and command boundaries in excerpts, without changing frozen exporters.
        attr_definition=re.compile(r'(?m)^(?:@\[[^\n]+?\]\s*)*(?:(?:noncomputable|private|protected) +)*(?:def|abbrev|structure|class) +([\w.\u2080-\u2089]+)')
        attr_command=re.compile(r'(?m)^(?:@\[[^\n]+?\]\s*)*(?:(?:noncomputable|private|protected|unsafe|partial) +)*(?:def|abbrev|structure|class|theorem|lemma|instance|namespace|end|open|variable|local|set_option|attribute|notation|scoped|#\w+)\b')
        for relative in paths:
            source=(ROOT/relative).read_text(encoding='utf-8-sig')
            if not re.search(r'(?m)^@\[',source):continue
            # Reindex this one file, so a preceding unannotated definition
            # cannot accidentally swallow the next attributed declaration.
            for name in list(index):
                index[name]=[d for d in index[name] if d['path']!=relative]
                if not index[name]:del index[name]
            for match in attr_definition.finditer(source):
                stop=attr_command.search(source,match.end());end=stop.start() if stop else len(source)
                code=source[match.start():end].rstrip()
                while code.endswith('-/'):
                    opening=code.rfind('/-')
                    if opening<0:break
                    code=code[:opening].rstrip()
                namespaces=re.findall(r'(?m)^namespace ([\w.]+)',source[:match.start()])
                name=match.group(1)
                index.setdefault(name,[]).append(dict(name=name,namespace=namespaces[-1] if namespaces else '',
                    code=code,path=relative,line=source[:match.start()].count('\n')+1))
        for choices in list(index.values()):
            for definition in choices:
                if definition['namespace']:
                    qualified=definition['namespace']+'.'+definition['name']
                    index.setdefault(qualified,[]).append(definition)
        return index
    m.definitions=namespace_index
    if ch>=5:
        raw_generate=m.generate
        def generate_with_old_links():
            raw_generate()
            path=m.BASE/'old_mapping.json'
            mapping=json.loads(path.read_text(encoding='utf-8'))
            links={}
            for record in m.RECORDS:
                for old_id in record['old_ids']:
                    links.setdefault(old_id,[]).append(record['source_id'])
            # Preserve all literal, corrected and derived parts of a split row.
            mapping['all_source_ids_by_old_id']=links
            m.dump(path,mapping)
            if ch==6:
                code=(ROOT/'Blueprint/Ch06.lean').read_text(encoding='utf-8')
                clean=re.sub(r'(?s)/-.*?-/', '', code)
                declared=re.findall(r'(?m)^(?:noncomputable )?(?:def|abbrev|theorem|lemma) (\w+)',clean)
                assert len(declared)==len(set(declared))
                (m.BASE/'CheckAxioms.lean').write_text('import Blueprint.Ch06\n\n'+
                    '\n'.join('#print axioms MD.Ch06.'+name for name in declared)+'\n',encoding='utf-8')
        m.generate=generate_with_old_links
    if ch==6:
        primary_checked=m.checked
        def checked_with_auxiliaries(log):
            primary_checked(log)
            outputs=Path(log).read_text(encoding='utf-8-sig')
            audit=json.loads((m.BASE/'local_audit.json').read_text(encoding='utf-8'))
            for sid,decl in m.declarations().items():
                row=audit['items'][sid];individual={}
                clean=re.sub(r'(?s)/-.*?-/', '', decl['block'])
                for name in re.findall(r'(?m)^(?:noncomputable )?(?:def|abbrev|theorem|lemma) (\w+)',clean):
                    qualified='MD.Ch06.'+name
                    found=re.search("'"+re.escape(qualified)+r"' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)",outputs)
                    assert found,'Missing auxiliary axiom output '+qualified
                    individual[qualified]=[] if found.group(1) is None else [a.strip() for a in found.group(1).split(',') if a.strip()]
                row['declaration_axioms']=individual
                row['axioms']=sorted({a for axioms in individual.values() for a in axioms})
                row['transitive_placeholder']='sorryAx' in row['axioms'] and not row['direct_placeholder']
                row['final_status']='incomplete' if 'sorryAx' in row['axioms'] or row['verdict']!='PASS' else ('checked+documented priors' if row['documented_priors'] else 'self-contained')
            m.dump(m.BASE/'local_audit.json',audit)
        m.checked=checked_with_auxiliaries
    return m
def render(ch,p):
    source=(ROOT/'scripts/render_ch02_blueprint.py').read_text(encoding='utf-8')
    source=source.replace('ch02_pipeline','local_current_pipeline').replace('ch02',f'ch{ch:02}').replace('Ch02',f'Ch{ch:02}')
    source=source.replace('第2章',f'第{ch}章').replace('Chapter 2',f'Chapter {ch}')
    source=source.replace('53–94',f'{RANGES[ch][0]}–{RANGES[ch][1]}')
    m=types.ModuleType('local_current_renderer');m.__file__=str(ROOT/'scripts/local_blueprint.py')
    sys.modules[m.__name__]=m;exec(compile(source,m.__file__,'exec'),m.__dict__)
    out=ROOT/f'docs/review/CH{ch:02}_BLUEPRINT.zh-CN.md'
    out.write_text(m.render(p.BASE/f'ch{ch:02}_source.json',ROOT/f'Blueprint/Ch{ch:02}.lean',p.BASE/'local_audit.json'),encoding='utf-8')
def landing(ch,p,batch,step):
    if ch==5 and p.RECORDS:
        from datetime import datetime,timedelta
        timer=p.BASE/'section_timeboxes.json'
        boxes=json.loads(timer.read_text(encoding='utf-8')) if timer.exists() else {}
        section=p.RECORDS[-1]['section']
        if section not in boxes:
            now=datetime.now();boxes[section]=dict(started_at=now.isoformat(),deadline=(now+timedelta(hours=2)).isoformat(),status='active',rule='单节2小时；缺大型理论或单条3次失败后sorry并继续。')
            p.dump(timer,boxes)
    table=ROOT/'docs/handoff/LOCAL_PIPELINE.md';s=table.read_text(encoding='utf-8')
    row=f'| {ch} | {RANGES[ch][0]}–{RANGES[ch][1]} / {RANGES[ch][2]}–{RANGES[ch][3]} | chapter{ch:02}-blueprint | {step}；批{batch}落盘（{len(p.RECORDS)}条） | '
    old=next(x for x in s.splitlines() if x.startswith(f'| {ch} |'))
    checkpoint=old.split('|')[-3].strip()
    s=s.replace(old,row+checkpoint+' | 未完成 |');table.write_text(s,encoding='utf-8')
    state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';lines=state.read_text(encoding='utf-8').splitlines()
    next_line=f'下一步：第{ch}章{step}；已落盘{len(p.RECORDS)}条，批{batch}；从blueprint/ch{ch:02}/PROGRESS.md读取缺项和现有编译结果继续。'
    if ch==6 and '## 22号运行检查点' in lines:
        at=lines.index('## 22号运行检查点')
        index=next(i for i in range(at+1,len(lines)) if lines[i].startswith('下一步：'))
        lines[index]=next_line
    else:lines[3]=next_line
    for i,x in enumerate(lines[:20]):
        if x.startswith('跨章唯一总进度：'):lines[i]=f'跨章唯一总进度：docs/handoff/LOCAL_PIPELINE.md；当前章逐条进度：blueprint/ch{ch:02}/PROGRESS.md。'
    state.write_text('\n'.join(lines)+'\n',encoding='utf-8')
def compile_batch(ch,p,batch):
    folder=p.BASE/'validation';folder.mkdir(exist_ok=True)
    log=folder/f'batch{batch}-lean.log';evidence=folder/f'batch{batch}-COMPILE.json'
    input_sha=p.sha(ROOT/f'Blueprint/Ch{ch:02}.lean')
    previous=json.loads(evidence.read_text(encoding='utf-8')) if evidence.exists() else {}
    if previous.get('exit_code')==0 and previous.get('input_sha256')==input_sha and log.exists() and previous.get('log_sha256')==p.sha(log):
        print('Reused passed single-file evidence:',batch)
    else:
        # A preflight checks the entire serialized future file, not a weakened
        # fragment. Reuse only identical bytes and intact source/log evidence.
        for candidate in (folder/'preflight').glob('*.json'):
            if candidate.stem.endswith('-RUNNING'):continue
            saved=json.loads(candidate.read_text(encoding='utf-8'))
            source=candidate.with_suffix('.lean');raw=candidate.with_suffix('.log')
            if (saved.get('exit_code')==0 and saved.get('input_sha256')==input_sha
                and source.exists() and raw.exists() and p.sha(source)==input_sha
                and p.sha(raw)==saved.get('log_sha256')):
                log.write_bytes(raw.read_bytes())
                p.dump(evidence,dict(saved,reused_from=candidate.relative_to(ROOT).as_posix(),
                    canonical_source=f'Blueprint/Ch{ch:02}.lean',
                    reuse_basis='identical full source bytes; original compiler source, receipt and raw log retained',
                    decl_blocks={sid:d['block_sha256'] for sid,d in p.declarations().items()}))
                print('Reused identical complete preflight:',candidate.name)
                break
        else:
            candidate=None
        if candidate is not None:
            audit=json.loads((p.BASE/'local_audit.json').read_text(encoding='utf-8'))
            for item in audit['items'].values():item.update(compiled=True,compile_evidence=evidence.relative_to(ROOT).as_posix())
            p.dump(p.BASE/'local_audit.json',audit)
            return
        command=['lake','env','lean',f'Blueprint/Ch{ch:02}.lean']
        from local_compile import compile_recorded
        receipt,output,reused=compile_recorded(command,ROOT,ROOT/f'Blueprint/Ch{ch:02}.lean',log,evidence,reuse_failure=True)
        p.dump(evidence,dict(receipt,decl_blocks={sid:d['block_sha256'] for sid,d in p.declarations().items()}))
        if receipt['exit_code']:
            print(output.decode('utf-8',errors='replace').encode(sys.stdout.encoding,errors='replace').decode(sys.stdout.encoding));raise SystemExit(receipt['exit_code'])
        print('Single-file Lean passed:',batch)
    audit=json.loads((p.BASE/'local_audit.json').read_text(encoding='utf-8'))
    for item in audit['items'].values():item.update(compiled=True,compile_evidence=evidence.relative_to(ROOT).as_posix())
    p.dump(p.BASE/'local_audit.json',audit)

def sync_attempts(ch,p):
    audit=json.loads((p.BASE/'local_audit.json').read_text(encoding='utf-8'))
    for path in (p.BASE/'validation/short_search').glob('*.json'):
        routes=json.loads(path.read_text(encoding='utf-8'))
        if not isinstance(routes,list):continue
        for sid,a in audit['items'].items():
            if sid.endswith('-'+path.stem):
                a['proof_attempts']=len(routes)
                a['attempt_evidence']=[path.relative_to(ROOT).as_posix()]+[r[k] for r in routes for k in ['source','log']]
    p.dump(p.BASE/'local_audit.json',audit)
    p.progress(json.loads((p.BASE/f'ch{ch:02}_source.json').read_text(encoding='utf-8')),
        audit['items'],json.loads((p.BASE/'old_mapping.json').read_text(encoding='utf-8'))['mapped'],
        list(p.csv.DictReader((ROOT/'docs/review'/f'CH{ch:02}_CLAIMS.csv').open(encoding='utf-8-sig'))))
def main():
    a=argparse.ArgumentParser();a.add_argument('chapter',type=int);a.add_argument('--checked');a.add_argument('--compile',action='store_true');a.add_argument('--batch',default='01');a.add_argument('--step',default='①–④当前节');args=a.parse_args()
    p=pipeline(args.chapter)
    if args.checked:p.checked(ROOT/args.checked)
    p.generate();sync_attempts(args.chapter,p);render(args.chapter,p);landing(args.chapter,p,args.batch,args.step)
    if args.compile:
        compile_batch(args.chapter,p,args.batch)
        p.generate();render(args.chapter,p);landing(args.chapter,p,args.batch,args.step)
if __name__=='__main__':main()

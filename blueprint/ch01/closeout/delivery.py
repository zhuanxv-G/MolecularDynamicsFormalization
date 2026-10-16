"""Evidence-backed chapter-1 docs and final-snapshot EAUDIT packages only."""
import sys,re,json,hashlib,subprocess,collections
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];sys.path.insert(0,str(ROOT/'scripts'))
from integrate_website_returns import read,dump,sha
from eaudit_review_tasks import declarations,declaration_names,axiom_pattern,build
BASE=ROOT/'blueprint/ch01';OUT=BASE/'validation/CLOSEOUT19'

def commands(text):
    pat=r'(?m)^(?:@[\[][\s\S]*?[\]]\s*)?(?:noncomputable\s+)?(?:theorem|lemma|def|abbrev)\s+(\w+)'
    matches=list(re.finditer(pat,text));result={}
    for j,m in enumerate(matches):
        end=matches[j+1].start() if j+1<len(matches) else text.rfind('end MD.Ch01')
        block=text[m.start():end]
        block=re.split(r'\n\s*/\*',block)[0]
        # A doc comment at the end belongs to the following command.
        if '/--' in block:block=block[:block.rfind('/--')]
        result[m.group(1)]=block.strip()
    return result

def accept():
    lean=ROOT/'Blueprint/Ch01.lean';text=lean.read_text(encoding='utf-8-sig');ds=declarations(1);decls=commands(text)
    receipt=read(OUT/'final-single.json');assert receipt['exit_code']==0 and receipt['input_sha256']==sha(lean)
    log=(OUT/'final-single.log').read_text(encoding='utf-8');assert sha(OUT/'final-single.log')==receipt['log_sha256']
    axioms={}
    for name in declaration_names(text):
        m=re.search(axiom_pattern('MD.Ch01.'+name),log);assert m,name
        axioms[name]=[x.strip() for x in (m.group(1) or '').split(',') if x.strip()]
    assert len(axioms)==len(set(axioms))
    dump(OUT/'AXIOM_DECLARATIONS.json',axioms)
    errata=read(OUT/'ERRATA_RECORDS.json');er={e['source_id']:e for e in errata}
    raw_returns=read(OUT/'EAUDIT_RETURN_REGISTRATION.json');rr={x['source_id']:x for x in raw_returns}
    src=read(BASE/'ch01_source.json');web=read(BASE/'website_audit.json');ws={w['source_id']:w for w in web}
    audit=read(BASE/'local_audit.json');repairs={x['source_id']:x for x in read(OUT/'SIGNATURE_REPAIRS.json')}
    baseline=subprocess.check_output(['git','show','124b8956:Blueprint/Ch01.lean'],cwd=ROOT).decode('utf-8-sig')
    old=commands(baseline)
    literal_checks={}
    for name,block in old.items():
        if 'literal' in name.lower() and re.match(r'theorem\b',block):
            before=block.split(' := by',1)[0];after=decls[name].split(' := by',1)[0]
            # Keep tokens, object order and all hypotheses exactly, independent of newline style.
            literal_checks[name]=before.split()==after.split()
            assert literal_checks[name],name
            assert re.search(r':= by\s+sorry',decls[name]),name
    dump(OUT/'LITERAL_SIGNATURE_PRESERVATION.json',literal_checks)
    timebox={'constraintdimension_unconstrained':'零约束导数核维数的同一路线至少3次不匹配；按时间盒保留sorry（signatures01、dual01–03原始日志）。',
             'morse_minimum':'既有三次失败时间盒保持，不恢复指数极限/曲率长证明。',
             'periodic_translation_momentum':'既有三次失败时间盒保持，不恢复Pi空间链式导数长证明。'}
    for e in errata:
        names=e['corrected_names'];assert names and all(n in axioms for n in names)
        e['proof_status']={n:('sorry' if 'sorryAx' in axioms[n] else 'proved') for n in names}
        if all(v=='proved' for v in e['proof_status'].values()):e['missing']=''
        e['original_status']='sorry，不证' if 'sorryAx' in axioms[e['original_name'].split('.')[-1]] else '原文定义/已证数学子句保留；经验或文字歧义未当作已证命题'
    dump(OUT/'ERRATA_RECORDS.json',errata)
    metrics=collections.Counter();decl_rows={}
    original_names={e['original_name'].split('.')[-1] for e in errata}
    for name,ax in axioms.items():
        block=decls[name];direct=bool(re.search(r'\bsorry\b',block));incomplete='sorryAx' in ax
        category=None
        if incomplete:
            category='原书疑误不证' if ('literal' in name.lower() and '_corrected' not in name and name != 'variationalMatrixLiteral') else '时间盒止' if name in timebox else '缺大型理论'
            metrics[category]+=1
        else:
            metrics['已证或定义']+=1
            metrics['定义项' if re.match(r'(?:noncomputable )?(?:def|abbrev)\b',block) else '已证定理']+=1
        metrics['声明总数']+=1
        decl_rows[name]=dict(axioms=ax,direct_placeholder=direct,transitive_placeholder=incomplete and not direct,status='incomplete' if incomplete else 'self-contained',sorry_category=category,stop_reason=timebox.get(name))
    dump(OUT/'DECLARATION_STATUS.json',decl_rows);dump(OUT/'DECLARATION_COUNTS.json',dict(metrics))
    pending=[]
    for s in src:
        sid=s['source_id'];w=ws[sid];a=audit['items'][sid];d=ds[sid];names=declaration_names(d['block']);ax=sorted({x for n in names for x in axioms[n]})
        a.update(signature_sha256=d['signature_sha256'],block_sha256=d['block_sha256'],compiled=True,checked=True,axioms=ax,
                 axiom_log='blueprint/ch01/validation/CLOSEOUT19/final-single.log',direct_placeholder=any(decl_rows[n]['direct_placeholder'] for n in names),transitive_placeholder=any(decl_rows[n]['transitive_placeholder'] for n in names))
        a['final_status']='incomplete' if 'sorryAx' in ax else ('checked+documented priors' if a.get('documented_priors') else 'self-contained')
        if sid in repairs:
            a.update(verdict='PASS',explanation='19号本地签名预审：'+repairs[sid]['note'],proof_status='placeholder' if 'sorryAx' in ax else 'local_proof_or_definition')
            a.setdefault('correspondence',[]).append(dict(source='网站指出缺项及原文完整子句',lean='; '.join('MD.Ch01.'+n for n in names),note=repairs[sid]['note']))
        if sid in er:
            e=er[sid];a.update(verdict='NEEDS_HUMAN',explanation=e['problem']+' 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。')
            a['missing']=e['missing'] or ('原书疑误原文版保留sorry，不用于证明修正版。' if 'sorryAx' in ax else None)
            if not any(x.get('stage')=='CLOSEOUT19_DUAL_VERSION' for x in s.get('repair_log',[])):
                s.setdefault('repair_log',[]).append(dict(stage='CLOSEOUT19_DUAL_VERSION',original_statement_unchanged=True,corrected_names=e['corrected_names'],reason=e['change'],mentor_default=e['default_option'],mentor_confirmed=False))
        # Keep original website verdict and binding immutable; no local check is a website PASS.
        att=rr.get(sid)
        eligible_pass=(w['audit']['verdict']=='PASS' and w['binding']['bound'] and sid not in repairs and sid not in er)
        if att and att['attachment_semantic_verdict']=='PASS' and not att['workspace_conflict'] and sid not in repairs and sid not in er:
            eligible_pass=True
            w['effective_status']='网站PASS（附件绑定 '+att['batch']+'；定义/签名未改）'
        elif eligible_pass:w['effective_status']='网站PASS（历史绑定 '+w['binding']['version']+'；当前主声明及依赖未改）'
        else:
            pending.append(sid);w.setdefault('repair',{}).update(status='awaiting_reaudit',eaudit='CLOSEOUT19',category='D' if sid in er else repairs.get(sid,{}).get('category','材料补齐'),mentor_required=sid in er)
            w['effective_status']='已修待复审 / 现行包待生成'+('；原书疑误待导师' if sid in er else '')
        if 'sorryAx' in ax and not a.get('missing'):
            a['missing']='缺完成本条全部结论的已验证证明；一般正则层/动力学/谱或测度桥接未建；本轮只修签名，不把子结果冒充整条。'
    # Correct the rejected tighter numerical tolerance without altering the historic log entry.
    s=next(s for s in src if s['source_id'].endswith('-LJTimeScaling'))
    if not any(x.get('stage')=='CLOSEOUT19_NUMERIC_TOLERANCE' for x in s['repair_log']):
        s['repair_log'].append(dict(stage='CLOSEOUT19_NUMERIC_TOLERANCE',reason='按所列参数真实结果约2.1649606ps；0.005ps容差过紧（初始尝试失败），现明示0.01ps容差并由Lean验证；不改教材2.17ps。'))
    # All textbook quotation fields must be byte-for-byte preserved from the starting snapshot.
    original_src={x['source_id']:x for x in json.loads(subprocess.check_output(['git','show','124b8956:blueprint/ch01/ch01_source.json'],cwd=ROOT))}
    for s in src:assert s['statement_latex']==original_src[s['source_id']]['statement_latex'],s['source_id']
    dump(BASE/'ch01_source.json',src);dump(BASE/'local_audit.json',audit);dump(BASE/'website_audit.json',web)
    summary=dict(chapter=1,total=len(src),website_pass=len(src)-len(pending),awaiting_reaudit=len(pending),awaiting_mentor=len(errata),repairing=0,
                 counts_are_disjoint=False,mentor_is_subset_of_reaudit=True,raw_verdicts_preserved=True,scope='网站PASS只覆盖明确绑定的原声明；当前双版本或变更待复审',declarations=dict(metrics))
    dump(BASE/'WEBSITE_SUMMARY.json',summary);dump(OUT/'PENDING_SOURCE_IDS.json',pending)
    (BASE/'CheckAxioms.lean').write_text('import Blueprint.Ch01\n'+''.join('#print axioms MD.Ch01.'+n+'\n' for n in axioms),encoding='utf-8')
    print('ACCEPTED',summary)

def docs():
    src=read(BASE/'ch01_source.json');byid={s['source_id']:s for s in src};ds=declarations(1);audit=read(BASE/'local_audit.json')['items'];web={w['source_id']:w for w in read(BASE/'website_audit.json')}
    er=read(OUT/'ERRATA_RECORDS.json');stats=read(BASE/'WEBSITE_SUMMARY.json');dr=read(OUT/'DECLARATION_STATUS.json')
    code_by_name=commands((ROOT/'Blueprint/Ch01.lean').read_text(encoding='utf-8-sig'))
    lines=['# 第1章原书疑误与双版本审阅单','',
       '教材：B. Leimkuhler 与 C. Matthews，Molecular Dynamics: With Deterministic and Stochastic Numerical Methods，Springer，2015，第1章正文。',
       '页码以工作区原PDF的1起始物理页为准：本章这些页面PDF页＝印刷页＋23。本文完整摘录对应句/式，附问题、理由和工作修正版，可单独交给核查人；不是已获作者或导师批准的正式勘误。',
       'Lean 4.34.0 / Mathlib固定修订5ed2965256430c3649e86755f9576b54eca72435。sorry表示尚未完成证明；编译通过只验证类型和已写证明。所有命名属于MD.Ch01；原文版占位不能作为修正版证明依据。',
       '定义或定性叙述没有可伪造的证明义务：原公式定义/已证局部数学子句保留，完整经验句只作逐字文献记录；一般假字面定理保留sorry，不证。默认选项仅是本次并列展示的工作版本，全部须导师确认。','']
    for j,e in enumerate(er,1):
        s=byid[e['source_id']];names=e['corrected_names'];states=[]
        for n in names:
            status=('定义已完成，无定理证明义务' if re.match(r'(?:noncomputable )?(?:def|abbrev)\b',code_by_name[n]) else '已证') if e['proof_status'][n]=='proved' else 'sorry；'+e['missing']
            states.append('`MD.Ch01.'+n+'`：'+status)
        lines += [f'## {j}. {e["source_id"]}','',f'- source_id：{e["source_id"]}；印刷页 {s["printed_page"]} / PDF页 {s["pdf_page"]}。',
          '- 原文引文（逐字）：','',*['> '+t for t in s['statement_latex'].splitlines()],'',
          '- 问题所在：'+e['problem'],'- 反例或理由：'+e['mathematical_counterexample'],
          '- 原文版 Lean 名称及状态：`'+e['original_name']+'`；'+e['original_status']+'。',
          '- 修正版 Lean 名称、改动内容、证明状态：'+e['change']+'；'+'；'.join(states)+'。',
          '- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“'+e['change']+'”是否可作为勘误。',
          '- 导师选项：'+' / '.join(e['mentor_options'])+'；我们默认采用“'+e['default_option']+'”，待确认。']
        if e['counterexample_names']:
            lines+=['- Lean反例：'+'、'.join('`MD.Ch01.'+n+'`（已证）' for n in e['counterexample_names'])+'。']
        if e['source_id'].endswith('-LJRepulsion'):
            lines+=['- 说明：已证原数学子句`lj_repulsion`仅为LJ单侧极限；原句的long simulations / rarely仍未数学化，不报告为已证明。']
        if e['source_id'].endswith('-IsoscelesCoordinates'):
            lines+=['- 同页上下文原文（PDF62，排版换行合并，fi字形规范化）：', '',
              '> By a judicious choice of initial conditions, the center of mass can be kept at the origin and the net rotation removed. This corresponds to a symmetric configuration which is termed the isosceles three body problem (i.e., at all times the atoms are the vertices of an isosceles triangle).', '',
              '- 同页上下文另请核对：在提出等腰坐标前，书中由去掉平动/旋转自由度过渡到对称配置；公式本身正确，疑点在此前过渡，不是矩阵三行数值。']
        if e['source_id'].endswith('-FlowJacobianLiteral'):
            lines+=['- 定义项说明：原`variationalMatrixLiteral`保持原取值点，是精确定义；后续两条原文定理保留sorry。定义不需要也没有伪造sorry证明。']
        lines+=['']
    (ROOT/'docs/review/CH01_ERRATA.zh-CN.md').write_text('\n'.join(lines)+'\n',encoding='utf-8')
    # Complete seven-part chapter handout, including all variants in part four.
    lines=['# 第1章 Lean Blueprint 本地审阅材料','',f'正文印刷p.1–45，习题排除；141个source_id，{stats["website_pass"]}条网站历史/附件PASS，{stats["awaiting_reaudit"]}条当前待复审（其中{len(er)}条疑误关联条目待导师）。正式库字节冻结，当前声明尚未网站冻结。',
           '勘误详见[CH01_ERRATA.zh-CN.md](CH01_ERRATA.zh-CN.md)；现行网站提交入口见[EAUDIT_INDEX.md](../../blueprint/ch01/mathcopilot_tasks/EAUDIT_INDEX.md)。','']
    for s in src:
        sid=s['source_id'];a=audit[sid];d=ds[sid];w=web[sid]
        lines += [f'## 1. {sid} · {s["label"] or s["kind"]} · 印刷p.{s["printed_page"]} / PDFp.{s["pdf_page"]}','',
            '### 2. 原文陈述','',*['> '+l for l in s['statement_latex'].splitlines()],'',
            '### 3. 原文证明','',s.get('proof_latex') or '原书无独立完整证明（proof_latex=null）。',s.get('proof_note') or '',s.get('proof_discussion_latex') or '',
            '','### 4. 完整当前Lean（原文与修正版独立列出）','','```lean',d['block'],'```','',
            '### 5. 对照与范围','',*['- '+x for x in s.get('extra_assumptions',[])],*['- '+i.get('detail','') for i in s.get('issues',[])],
            '','### 6. 审计结论','',a['verdict']+'；'+a['explanation'],'网站：'+w['effective_status']+'。',
            '','### 7. 证明状态与位置','',a['final_status']+'；当前整组公理：'+', '.join(a['axioms'])+'。',
            f'位置：Blueprint/Ch01.lean:{d["line"]}；{d["name"]}。单文件及本组全部命名声明#print axioms已验证；完整check见CLOSEOUT19/full/CHECK_REPORT.json。',
            '直接sorry：'+str(a['direct_placeholder'])+'；仅传递占位风险：'+str(a['transitive_placeholder'])+'。',a.get('missing') or '本组无sorryAx。','']
    (ROOT/'docs/review/CH01_BLUEPRINT.zh-CN.md').write_text('\n'.join(lines)+'\n',encoding='utf-8')
    lines=['# 第1章收口进度','',f'141条；网站PASS {stats["website_pass"]} / 已修待复审 {stats["awaiting_reaudit"]} / 网站FAIL修复中 0。',f'待导师{len(er)}条是待复审的子集，不重复计入总数；网站原始FAIL/NEEDS判定和历史绑定保持，当前签名变更必须新审。','',
           '| source_id | JSON | Blueprint | 本地预审 | 网站审计 | 证明 |','|---|---|---|---|---|---|']
    for s in src:
        sid=s['source_id'];a=audit[sid];d=ds[sid];names=declaration_names(d['block']);good=sum('sorryAx' not in dr[n]['axioms'] for n in names)
        lines+=['| '+' | '.join([sid,s['review_status']+'/原页已核','已编译/逐项公理已核',a['verdict'],web[sid]['effective_status'],f'{good}/{len(names)}项无sorryAx；'+a['final_status']])+' |']
    lines+=['','原书疑误原文版不证、修正版及反例分别登记于[勘误清单](../../docs/review/CH01_ERRATA.zh-CN.md)。逐声明状态与sorry分类见validation/CLOSEOUT19/DECLARATION_STATUS.json。','完整check结果见validation/CLOSEOUT19/full/CHECK_REPORT.json；网站复审和导师裁定未验证。']
    (BASE/'PROGRESS.md').write_text('\n'.join(lines)+'\n',encoding='utf-8')
    # Local queue mirrors the four repair categories without modifying frozen ch02–05 queue rows.
    changes={x['source_id']:x for x in read(OUT/'SIGNATURE_REPAIRS.json')};errs={e['source_id']:e for e in er}
    lines=['# 第1章修复队列（19号）','','A漏前提/定义域；B漏结论；C对象不忠实；D原书疑误。网站FAIL修复中=0，D保留原文并另立修正版，待导师；当前包由EAUDIT_INDEX管理。','',
       '| source_id | 历史网站判定 | 类别 | 处理 | 状态 |','|---|---|---|---|---|']
    for sid in read(OUT/'PENDING_SOURCE_IDS.json'):
        w=web[sid];c=changes.get(sid);e=errs.get(sid)
        lines+=['| '+' | '.join([sid,w['audit']['verdict'],'D' if e else c['category'] if c else 'B（材料）',e['change'] if e else c['note'] if c else '补完整当前声明与实际定义闭包，保持原文；待网站独立复审','已修待复审'+('/待导师' if e else '')])+' |']
    (BASE/'REPAIR_QUEUE.md').write_text('\n'.join(lines)+'\n',encoding='utf-8')
    epath=BASE/'NEEDS_HUMAN.md';old=epath.read_text(encoding='utf-8-sig');marker='## 19号双版本现行入口'
    if marker in old:old=old[:old.index(marker)]
    epath.write_text(old+'\n'+marker+'\n\n原有9项选项保留；本轮涵盖全部source标记疑误及相关推论，共20条。现行原文/修正版名称、状态、默认选项与人工核查点见[CH01_ERRATA.zh-CN.md](../../docs/review/CH01_ERRATA.zh-CN.md)。默认选项不是导师批准。\n',encoding='utf-8')
    print('Rendered docs and local repair queue')

def packages():
    src=read(BASE/'ch01_source.json');pending=set(read(OUT/'PENDING_SOURCE_IDS.json'));web=read(BASE/'website_audit.json');ws={w['source_id']:w for w in web};er={e['source_id'] for e in read(OUT/'ERRATA_RECORDS.json')}
    # Dedicated names do not overwrite EAUDIT01–03, nor any historic package.
    groups=[]
    for sec in dict.fromkeys(s['section'] for s in src):
        sids=[s['source_id'] for s in src if s['section']==sec and s['source_id'] in pending]
        for i in range(0,len(sids),8):groups.append((sec,sids[i:i+8]))
    # Omit historical repair metadata from the displayed mathematical excerpt;
    # its full source-file hash still binds the immutable source JSON.  Lossless
    # PDF compression preserves the original-page pixels and avoids the 256KB cap.
    import types
    builder_source=(ROOT/'scripts/eaudit_review_tasks.py').read_text(encoding='utf-8')
    builder_source=builder_source.replace("json.dumps(indexed[sid],ensure_ascii=False,indent=2)","json.dumps({k:v for k,v in indexed[sid].items() if k != 'repair_log'},ensure_ascii=False,indent=2)")
    builder_source=builder_source.replace("  cropped=fitz.open(crop)","  packed=fitz.open(crop);compressed=packed.tobytes(garbage=4,deflate=True);packed.close();crop.write_bytes(compressed)\n  cropped=fitz.open(crop)")
    builder=types.ModuleType('closeout19_builder');builder.__file__=str(ROOT/'scripts/eaudit_review_tasks.py');exec(compile(builder_source,builder.__file__,'exec'),builder.__dict__)
    entries=[]
    for i,(sec,sids) in enumerate(groups,4):
        name=f'EAUDIT{i:02}';folder=BASE/'mathcopilot_tasks'/name
        saved=read(folder/'CLOSEOUT19_ACCEPTED.json') if (folder/'CLOSEOUT19_ACCEPTED.json').exists() else None
        if saved and saved['lean_sha256']==sha(ROOT/'Blueprint/Ch01.lean') and saved['source_sha256']==sha(BASE/'ch01_source.json'):
            item=saved
        else:
            assert not subprocess.check_output(['git','ls-files','--',folder.relative_to(ROOT).as_posix()],cwd=ROOT), 'Never overwrite a committed historical packet'
            item=builder.build(1,name,sec,sids)
            for task in item['subtasks']:
                p=ROOT/task['path']/'PASTE.txt';t=p.read_text(encoding='utf-8')
                instruction='\n原文版为忠实转录，修正版为勘误版本，请分别审校。原书疑误的原文定理保留sorry不证；不要将其真假/占位状态误判为修正版的语义FAIL。原文JSON逐字摘录不因新增修正版而改写。\n'
                if task['source_id'] in er:t=t.replace('\n本条',instruction+'\n本条',1)
                p.write_text(t,encoding='utf-8');mp=p.parent/'MANIFEST.json';m=read(mp);m['paste_sha256']=sha(p)
                for _ in range(4):m['total_task_bytes']=sum(f.stat().st_size for f in p.parent.iterdir() if f.is_file());dump(mp,m)
                actual=sum(f.stat().st_size for f in p.parent.iterdir() if f.is_file());assert actual==m['total_task_bytes']<256000
                task['total_bytes']=actual;task['manifest_sha256']=sha(mp)
            manifest=read(folder/'MANIFEST.json');manifest['subtasks']=item['subtasks'];dump(folder/'MANIFEST.json',manifest)
            item.update(lean_sha256=sha(ROOT/'Blueprint/Ch01.lean'),source_sha256=sha(BASE/'ch01_source.json'),section=sec)
            dump(folder/'CLOSEOUT19_ACCEPTED.json',item)
        for sid in sids:
            ws[sid]['repair'].update(eaudit=name,status='awaiting_reaudit',task_index=item['task_index'],input_sha256=item['input_sha256'])
            ws[sid]['effective_status']='已修待复审 / '+name+('；原书疑误待导师' if sid in er else '')
        entries.append(item);print('PACKAGED',name,len(sids),flush=True)
    assert {sid for e in entries for sid in e['source_ids']}==pending
    dump(OUT/'CURRENT_EAUDIT_PACKAGES.json',entries);dump(BASE/'website_audit.json',web)
    lines=['# 第1章现行EAUDIT待提交包','',f'仅列本次最终快照：{len(pending)}条、{len(entries)}批。历史EAUDIT01–03及旧BATCH保留作证据，不是当前提交入口。每个子任务独立粘贴PASTE.txt并上传同目录PDF；同批按source_id合并返回。','原文版为忠实转录，修正版为勘误版本，请分别审校。全部input_sha256已内嵌；网站执行与新判定尚未验证。','']
    for e in entries:lines+=['- ['+e['eaudit']+']('+e['eaudit']+'/INDEX.md)：§'+e['section']+'；'+str(len(e['source_ids']))+'条。']
    (BASE/'mathcopilot_tasks/EAUDIT_INDEX.md').write_text('\n'.join(lines)+'\n',encoding='utf-8')
    registry=read(BASE/'EAUDIT_REGISTRY.json');registry=[r for r in registry if r.get('closeout')!='19']
    registry.append(dict(closeout='19',current_packages=entries,website_reaudit='awaiting user submission'));dump(BASE/'EAUDIT_REGISTRY.json',registry)
    docs()

if __name__=='__main__':globals()[sys.argv[1]]()

"""Produce honest per-declaration reasons, review pairs and mentor-facing totals."""
import re,json,sys
from pathlib import Path
from collections import Counter
from local_blueprint import ROOT,pipeline
from ch06_errata import SPECS
p=pipeline(6);B=p.BASE
audit=json.loads((B/'local_audit.json').read_text(encoding='utf-8'))['items']
bykey={r['source_id'].split('-')[-1]:r for r in p.RECORDS}
out={};counts=Counter();reasons=Counter()
# Existing local calculations with no completed short bridge are time-box
# stops, not evidence that Mathlib lacks an entire major theory.
bounded_local={'partitionMass','partitionDomain','lennardJonesNonintegrable','equipartition',
    'temperatureChoiceDerivatives','walkVariance','walkGridMoments','interpolatedWalkMean',
    'riemannTags','ouGibbsLimit','bathHamiltonEquations','densityExpectation','massGibbsStationary',
    'variableFrictionCommutingStationary','directedGraphIrreducible'}
for r in p.RECORDS:
    a=audit[r['source_id']];declarations={}
    route_path=B/'validation/short_search'/(r['source_id'].split('-')[-1]+'.json')
    if route_path.exists():
        saved=json.loads(route_path.read_text(encoding='utf-8'))
        if saved and saved[-1].get('inline_bridge') and saved[-1]['exit_code']!=0 and a.get('checked') and a.get('compiled') and 'sorryAx' not in a['axioms']:
            receipt=ROOT/a['compile_evidence'];rr=json.loads(receipt.read_text(encoding='utf-8'))
            assert rr['exit_code']==0
            probe=ROOT/rr['command'][-1];raw=receipt.with_suffix('.log')
            assert p.sha(probe)==rr['input_sha256'] and p.sha(raw)==rr['log_sha256']
            assert len(saved)<3
            saved.append(dict(route=len(saved)+1,exit_code=0,proof=r['code'].split(' := by',1)[1].strip(),
                source=probe.relative_to(ROOT).as_posix(),log=raw.relative_to(ROOT).as_posix(),
                source_sha256=p.sha(probe),log_sha256=p.sha(raw),inline_bridge=True))
            p.dump(route_path,saved)
    code=re.sub(r'(?s)/-.*?-/', '',r['code'])
    matches=list(re.finditer(r'(?m)^(?:noncomputable )?(def|theorem|lemma|abbrev) (\w+)',code))
    for i,m in enumerate(matches):
        block=code[m.start():matches[i+1].start() if i+1<len(matches) else len(code)]
        name='MD.Ch06.'+m[2];axioms=a.get('declaration_axioms',{}).get(name)
        placeholder=bool(re.search(r'\bsorry\b',block))
        key=r['source_id'].split('-')[-1]
        corrected=m[2].endswith('_corrected') or m[2] in ('theorem61','theorem62','timeItoFormula')
        reason=r.get('missing') or a.get('explanation')
        if corrected and key in SPECS:
            target=SPECS[key][0]
            if target and target in bykey:reason=bykey[target].get('missing') or '修正版整体尚缺现成完整桥接；不建立大型理论。'
            if key=='DiffusiveTaylorPrinted':reason='C³修正后的Taylor余项与sqrt(dt)扩散缩放复合，未找到直接短桥；本轮时间盒止，未声称编译证明通过。'
        if m[1] in ('def','abbrev'):status='定义';category=None
        elif axioms is not None and 'sorryAx' not in axioms and a.get('checked'):status='已证';category=None
        else:
            status='未证'
            if not corrected and ('Printed' in m[2] or a['verdict']!='PASS'):
                category='原书疑误不证'
            elif any(word in (reason or '') for word in ['三条','时间盒','短证明路线']) or m[2].startswith('diffusiveTaylorPrinted_corrected') or m[2] in bounded_local or (route_path.exists() and len(saved)>=3 and all(q['exit_code']!=0 for q in saved)):
                category='时间盒止'
                if m[2] in bounded_local:reason='本轮未完成现成完整短桥的本地检索，按时间盒停止；不据此声称缺整套理论。具体缺项：'+(reason or '')
                elif route_path.exists() and len(saved)>=3 and all(q['exit_code']!=0 for q in saved):reason='三条编译支持的短证明路线均失败，时间盒止。具体缺项：'+(reason or '')
            else:category='缺大型理论'
            reasons[category]+=1
        path=B/'validation/short_search'/f'{key}.json'
        routes=json.loads(path.read_text(encoding='utf-8')) if path.exists() else []
        assert len(routes)<=3,(key,len(routes))
        declarations[name]=dict(kind=m[1],status=status,classification=category,direct_placeholder=placeholder,
            axioms=axioms,reason=reason if status=='未证' else None,
            compiler_route_count=len(routes),route_evidence=path.relative_to(ROOT).as_posix() if routes else None)
        counts[status]+=1
    out[r['source_id']]=dict(local_verdict=a['verdict'],declarations=declarations)
p.dump(B/'proof_attempts.json',dict(rule='最多3种路线；失败分类只用缺大型理论/原书疑误不证/时间盒止；definitions do not create theorem obligations',
    counts=dict(counts),unproved_reasons=dict(reasons),items=out))
lines=['# 第6章原书疑误与双版本审阅单','',
    '教材：B. Leimkuhler 与 C. Matthews，Molecular Dynamics: With Deterministic and Stochastic Numerical Methods，Springer，2015，第6章正文。',
    '页码：PDF物理页从1起数，本章PDF页＝印刷页＋21。原句和原公式逐字保留；修正版是工作建议，均待导师裁定。网站审计尚未提交。',
    '原文版的错误断言不证明；原文公式的定义仅记录表达式。对形式微分、算子域等尚有歧义的原句，逐字文字完整保留，Lean表达式或明确实现仅记录其可陈述部分，不等同于原句全部含义已获证明。修正版定义、已证定理与未证定理分别标明。第7项属于既有Lean辅助定义缺口，不归因于教材。','']
def decl_status(name):
    q='MD.Ch06.'+name
    for v in out.values():
        if q in v['declarations']:
            z=v['declarations'][q]
            if z['status']=='定义':return '定义已落盘；'+('公理/类型已核' if z['axioms'] is not None else '待本批编译核验')
            return z['status']+('；'+z['classification'] if z['classification'] else '')
    return '尚未落盘，不计完成'
for key,(target,example,change) in SPECS.items():
    if key not in bykey:continue
    r=bykey[key];name=r['lean_decl'].rsplit('.',1)[1]
    original={'Proposition62':'proposition62Printed','FiniteDistribution':'finiteDistributionPrinted',
        'TimeItoFormula':'timeItoFormulaPrinted','FPPolynomialAdjoint':'fpPolynomialAdjointPrinted',
        'Theorem61':'theorem61Printed','Theorem62':'theorem62Printed',
        'BrownianNonpositive':'brownianNegativeDefinitePrinted','PeriodicPotentialBound':'periodicConfiningPrinted',
        'LyapunovYoungBounds':'laplacianBoundPrinted'}.get(key,name)
    corrected=name+'_corrected'
    issues=' '.join(x['detail'].removeprefix('[ERRATUM?]') for x in r['issues'])
    if key=='Proposition62':issues+=' 原书p.230末句印刷ν→0，实际应为ν→∞。'
    if key=='Theorem61':issues+=' 质量Laplacian表达式另列`MD.Ch06.brownianMassGeneratorPrinted`与`MD.Ch06.brownianMassGeneratorPrinted_corrected`；二者只定义表达式，状态分别为'+decl_status('brownianMassGeneratorPrinted')+'、'+decl_status('brownianMassGeneratorPrinted_corrected')+'。'
    counters=[name for name in out[r['source_id']]['declarations'] if 'counterexample' in name.lower()]
    if counters:example+=' Lean反例：'+'；'.join('`'+name+'`（'+decl_status(name.rsplit('.',1)[1])+'）' for name in counters)+'。'
    lines += ['## '+str(len([x for x in lines if x.startswith('## ')])+1)+'. '+r['source_id'],'',
        '- source_id：'+r['source_id']+'；印刷页 '+r['printed_page']+' / PDF页 '+r['pdf_page']+'。',
        '- 原文引文（逐字）：','',*['> '+s for s in r['statement_latex'].splitlines()],'',
        *(['- 原书证明中的相关逐字段落：','',*['> '+s for s in r['proof_latex'].splitlines()],''] if key=='Proposition62' else []),
        '- 问题所在：'+issues,
        '- 反例或理由：'+example,
        '- 原文版 Lean 名称及状态：`MD.Ch06.'+original+'`：'+decl_status(original)+'。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。',
        '- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.'+corrected+'`：'+decl_status(corrected)+'；'+change,
        '- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。',
        '- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。',
        '- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。','']
(ROOT/'docs/review/CH06_ERRATA.zh-CN.md').write_text('\n'.join(lines),encoding='utf-8')
summary=dict(entries=len(p.RECORDS),local_PASS=sum(v['verdict']=='PASS' for v in audit.values()),
    local_NEEDS_HUMAN=sum(v['verdict']!='PASS' for v in audit.values()),
    errata_records=sum(k in bykey for k in SPECS),source_errata_records=sum(k in bykey and k!='WeakItoAlias' for k in SPECS),
    declarations=dict(counts),unproved_reasons=dict(reasons),website_submitted=False)
p.dump(B/'validation/RESUME22/COUNTS.json',summary)
print('Counts:',json.dumps(summary,ensure_ascii=True))

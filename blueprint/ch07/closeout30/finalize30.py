from triage30 import *
import re
from collections import Counter

def strip_comments(s): return re.sub(r'/\-[\s\S]*?-/', '',s)
def chunks(s):
    s=strip_comments(s)
    ms=list(re.finditer(r'(?m)^(?:noncomputable )?(def|abbrev|theorem|lemma|structure)\s+(\w+)',s))
    return [dict(kind=m[1],name=m[2],code=s[m.start():ms[i+1].start() if i+1<len(ms) else len(s)].strip()) for i,m in enumerate(ms)]
def semantic(d): return re.sub(r'\s+',' ',d['code']).strip()
def quote(s): return '\n'.join('> '+x for x in (s or '').splitlines())
def flat(s): return str(s).replace('|','/').replace('\n',' ')

def main():
    lean=ROOT/'Blueprint/Ch07.lean';gg=groups();srcs=load(BASE/'ch07_source.json')
    rr={r['source_id']:r for r in load(OUT/'RETURNS.json')}
    oldweb=load(OUT/'website_audit.before.json');first={w['source_id']:w['closeout29_return'] for w in oldweb}
    latest={s['source_id']:rr.get(s['source_id'],first[s['source_id']]) for s in srcs}
    rawcounts=Counter(x['audit']['verdict'] for x in latest.values())
    assert rawcounts==dict(PASS=90,FAIL=1,NEEDS_HUMAN=27),rawcounts
    final=load(OUT/'FINAL_COMPILE.json')
    assert final['exit_code']==0 and final['canonical_sha256']==sha(lean)
    log=(OUT/'FINAL_COMPILE.log').read_text(encoding='utf-8-sig')
    assert final['log_sha256']==sha(OUT/'FINAL_COMPILE.log')
    axs={m[1].split('MD.Ch07.')[-1]:[a.strip() for a in (m[2] or '').split(',') if a.strip()] for m in re.finditer(r"'([^']+)' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)",log)}
    previous={d['name']:d for d in load(BASE/'closeout29/DECLARATIONS.json')}
    olddecl={d['name']:d for d in chunks((OUT/'Ch07.before.lean').read_text(encoding='utf-8'))}
    current={d['name']:d for d in chunks(lean.read_text(encoding='utf-8'))}
    assert len(axs)==len(current)==len(final['declarations'])
    web=load(BASE/'website_audit.json');ww={w['source_id']:w for w in web}
    decls=[];counts=Counter();reasons=Counter();local=load(OUT/'local_audit.before.json')
    for s in srcs:
        sid=s['source_id'];key=sid.split('-')[-1];r=latest[sid];ds=[]
        accepted=gg[sid]['names'] if r['audit']['verdict']=='PASS' else PASS30.get(key,[]) if sid in rr else []
        assert not set(accepted)-set(gg[sid]['names']),(sid,set(accepted)-set(gg[sid]['names']))
        for d in chunks(gg[sid]['code']):
            name='MD.Ch07.'+d['name'];ax=axs[d['name']]
            same=d['name'] in olddecl and semantic(d)==semantic(olddecl[d['name']])
            status='未证' if 'sorryAx' in ax else '定义' if d['kind'] in ['def','abbrev','structure'] else '已证'
            reason=previous.get(name,{}).get('reason') if status=='未证' else None
            if status=='未证' and not reason: reason='缺大型理论'
            counts[status]+=1
            if reason:reasons[reason]+=1
            website='PASS（送审签名未变）' if d['name'] in accepted and same else '按意见修复，本地核验通过（未再送网站）' if sid==FAIL_ID else '见原始报告的分版本意见；不推定完整定理PASS'
            ds.append(dict(name=name,kind=d['kind'],source_id=sid,status=status,axioms=ax,reason=reason,direct_placeholder=bool(re.search(r'\bsorry\b',d['code'])),unchanged_submitted_statement=same,website_verdict=website,website_signature_pass=d['name'] in accepted and same))
        s['closeout30_declarations']=ds;decls+=ds
        w=ww[sid]
        if sid==FAIL_ID:effective='按网站审校意见修复，本地核验通过（未再送网站）'
        elif r['audit']['verdict']=='PASS':effective='网站PASS（复审绑定版本）' if sid in rr else '网站PASS（首轮签名未改）'
        elif sid in rr and accepted:effective='修正版/限定声明=网站PASS；原文疑误或范围待导师'
        else:effective='原文疑误或范围待导师；限定定义与分版本意见另列'
        w.update(effective_status=effective,actual_scope=s['statement_scope'],coverage_gaps=s['coverage_gaps'])
        w['versions30']=dict(submitted=dict(round='复审' if sid in rr else '首轮',verdict=r['audit']['verdict'],explanation=r['audit']['explanation']),declarations=ds,
            printed=dict(status='原文保留；数学疑误或范围待导师' if r['audit']['verdict']=='NEEDS_HUMAN' or s['issues'] else '原文保留',fidelity='以原始逐项说明为准；忠实性通过不等于原书命题正确'),
            corrected=dict(website_pass_declarations=[d['name'] for d in ds if d['website_signature_pass']],note=NOTES.get(key,'首轮分版本意见沿用原返回；不把定义或部分结论计为完整定理')),
            prior_version_assessment=dict(printed=w.get('printed_version'),corrected=w.get('corrected_version')),
            counterexample=r['audit'].get('counterexample'),scope_note=NOTES.get(key),suggested_fix=r['audit'].get('suggested_fix'))
        if sid==FAIL_ID:
            repair=load(OUT/'REPAIR.json');repair.update(status=effective,compile_receipt='blueprint/ch07/closeout30/FINAL_COMPILE.json')
            dump(OUT/'REPAIR.json',repair);w['local_repair30']=repair
        a=local['items'][sid]
        a.update(checked=True,compiled=True,statement_scope=s['statement_scope'],extra_assumptions=s['extra_assumptions'],issues=s['issues'],coverage_gaps=s['coverage_gaps'],block_sha256=hashlib.sha256(gg[sid]['code'].encode()).hexdigest(),compile_receipt='blueprint/ch07/closeout30/FINAL_COMPILE.json',declaration_axioms={d['name']:d['axioms'] for d in ds},closeout30_declarations=ds,website=r['audit']['verdict'],semantic_review='30号复审分版本登记；一项按意见局部修复，数学证明状态逐声明核验。',final_status='incomplete' if any(d['status']=='未证' for d in ds) else ('checked+documented priors' if s.get('documented_priors') else 'self-contained'))
    assert len(decls)==len(axs)
    dump(OUT/'DECLARATIONS.json',decls);dump(BASE/'ch07_source.json',srcs);dump(BASE/'website_audit.json',web);dump(BASE/'local_audit.json',local)
    attempts=load(OUT/'proof_attempts.before.json');attempts['closeout30']=dict(counts=counts,unproved_reasons=reasons,new_proofs=[d['name'] for d in decls if d['name'].split('.')[-1] not in olddecl and d['status']=='已证'],compile_receipt='blueprint/ch07/closeout30/FINAL_COMPILE.json',attempts=[dict(route='推前概率引理方向',result='首次方向用反；改用HasLaw.isProbabilityMeasure_iff.mp，未增加占位')])
    dump(BASE/'proof_attempts.json',attempts)
    issues=[s for s in srcs if s['issues'] or latest[s['source_id']]['audit']['verdict']=='NEEDS_HUMAN']
    issueids={s['source_id'] for s in issues}
    scope_only=['MD-7.7.2-SpectralQualification','MD-7.12-ConstrainedCanonicalErgodicity']
    summary=dict(total=118,first_round=dict(PASS=66,FAIL=28,NEEDS_HUMAN=24),reaudit=dict(PASS=24,FAIL=1,NEEDS_HUMAN=10),latest_raw=dict(rawcounts),website_pass=90,website_pass_counting='各条最新返回直接PASS；从NEEDS_HUMAN分出的通过版本另计，不与原书问题数相加',local_repairs=1,repairing=0,awaiting_reaudit=0,reaudit_human_corrected_or_limited_signature_pass_items=len(PASS30),reaudit_human_scope_only_items=scope_only,original_text_human_items=27,errata_or_scope_records=len(issues),declarations=dict(counts),unproved_reasons=dict(reasons),current_lean_sha256=sha(lean),current_source_sha256=sha(BASE/'ch07_source.json'),new_eaudit_packages=0,website_resubmitted=False)
    dump(BASE/'WEBSITE_SUMMARY.json',summary);dump(OUT/'SUMMARY.json',summary)
    progress=['# 第7章逐条进度','','第7章最终收口：网站复审35条（24 PASS / 1 FAIL / 10 NEEDS_HUMAN）；唯一FAIL已按意见修复并通过本地核验，未再送网站。',
        '全章118条最新返回直接PASS 90条；27条原文或范围问题待导师。复审NEEDS_HUMAN中8条有明确认可的修正版/限定签名，另2条仅认可已披露范围的定义。分版意见不与原书问题混为一类。',
        'FAIL修复中=0；不再生成EAUDIT包。编译与全部声明公理通过，完整check状态见closeout30/full/CHECK_REPORT.json。','',
        '| source_id | PDF页 | 首轮 | 复审 | 当前状态 | 证明状态 |','|---|---|---|---|---|---|']
    bp=['# 第7章逐条审阅材料','','正文118条。最新网站返回直接通过90条；1条按意见修复并在本地核验，未再次送审。另27条原文或范围问题待导师；各版本签名意见与证明状态分别列出。','']
    for s in srcs:
        sid=s['source_id'];r=latest[sid];w=ww[sid];ds=s['closeout30_declarations']
        progress.append('| '+' | '.join([sid,s['pdf_page'],first[sid]['audit']['verdict'],rr[sid]['audit']['verdict'] if sid in rr else '—',w['effective_status'],'未证' if any(d['status']=='未证' for d in ds) else '定义/已证'])+' |')
        bp += ['## '+sid,'',f'印刷页 {s["printed_page"]} / PDF页 {s["pdf_page"]}。','','### 1. 原文陈述','',quote(s['statement_latex']),'','### 2. 原文证明','',quote(s.get('proof_latex') or s.get('proof_note') or '原书未给独立完整证明。'),'','### 3. 完整当前Lean（原文与修正版独立保留）','','```lean',gg[sid]['code'],'```','','### 4. 对照表','','| 原文对象或结论 | 实际覆盖 |','|---|---|','| 所选数学成分 | '+flat(s['statement_scope'])+' |','| 对象、量词、前提 | 见完整声明与下方新增资格 |','','### 5. [EXTRA] 与覆盖缺口','']+['- '+x for x in s['extra_assumptions']]+['- 覆盖缺口：'+x for x in s['coverage_gaps']]+['','### 6. 审计结论（含网站复审结论）','','网站首轮结论：'+first[sid]['audit']['verdict']+'。'+first[sid]['audit']['explanation'],
            '网站复审结论：'+(r['audit']['verdict']+'。'+r['audit']['explanation'] if sid in rr else '本条未进入本轮复审，沿用首轮已绑定版本意见。'),
            '按版本登记：'+(NOTES.get(sid.split('-')[-1]) or '原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。'),
            '当前状态：'+w['effective_status']+'。','本条实际覆盖：'+s['statement_scope'],'','### 7. 状态与证明位置','']+['- `'+d['name']+'`：'+d['status']+('；'+d['reason'] if d['reason'] else '')+'；网站：'+d['website_verdict'] for d in ds]+['','位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。','']
    (BASE/'PROGRESS.md').write_text('\n'.join(progress)+'\n',encoding='utf-8')
    (ROOT/'docs/review/CH07_BLUEPRINT.zh-CN.md').write_text('\n'.join(bp)+'\n',encoding='utf-8')
    err=['# 第7章原书疑误与双版本审阅单','','教材：Leimkuhler–Matthews《Molecular Dynamics》（2015）第7章正文。',f'共{len(issues)}项原书疑误、论证缺口或范围待核记录；其中最新网站返回需人工判断27条，另含保留的范围核查和受约束分裂乘子解释。记录数不等于已确认排印错误数。',
        '网站复审35条已到齐。签名/修正版通过与原文疑误分别记录；8条复审人工项有明确的修正版或限定签名通过意见，2条只认可已披露范围的定义，未把完整谱论或遍历定理写成已通过。',
        '转录纠正：PDF291的九字母OABOAOBAO、PDF315(7.25c)括号内正号均已目视核对原页；旧漏字和误符号不计为原书勘误。','']
    for i,s in enumerate(issues,1):
        sid=s['source_id'];r=latest[sid];a=r['audit'];w=ww[sid];ds=s['closeout30_declarations'];corrected=[d for d in ds if '_corrected' in d['name']]
        counter=a.get('counterexample')
        if isinstance(counter,dict): counter='；'.join(k+'：'+str(v) for k,v in counter.items())
        err += [f'## {i}. '+sid,'',f'- source_id：{sid}；印刷页 {s["printed_page"]} / PDF页 {s["pdf_page"]}。','- 原文引文（逐字）：','',quote(s['statement_latex']),'',
            '- 原页核对：'+('已目视核对原页PDF339（本轮）；原印Hc/Oc都写λdt，O步含Wiener噪声。' if sid==FAIL_ID else '已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。'),
            '- 问题所在：'+('；'.join(s['issues']) or '原文论证范围或技术资格需选定；不直接断言公式错误。'),
            '- 反例或理由：'+(counter or a['explanation']),
            '- 原文版 Lean 名称及状态：'+'；'.join('`'+d['name']+'`：'+d['status'] for d in ds if '_corrected' not in d['name'])+'。定义只记录目标，不等于原书结论已证。',
            '- 修正版 Lean 名称、改动内容、证明状态：'+('；'.join('`'+d['name']+'`：'+d['status']+('（'+d['reason']+'）' if d['reason'] else '') for d in corrected) or '保留限定定义或子结论；没有独立完整修正版定理。')+' '+s['statement_scope'],
            '- 待人工核查点：'+(NOTES.get(sid.split('-')[-1]) or '请核对原文公式的解释、所选函数空间/算子域与结论适用范围。'),
            '- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：'+(a.get('suggested_fix') or '请明确原文所指范围。'),
            '- 网站首轮结论：'+first[sid]['audit']['verdict']+'。'+first[sid]['audit']['explanation'],
            '- 网站复审结论：'+(a['verdict']+'。'+a['explanation'] if sid in rr else '本条不在35条复审中，沿用首轮分版本意见。'),
            '- 分版本结论：'+w['effective_status']+'。'+(NOTES.get(sid.split('-')[-1]) or w.get('corrected_version',{}).get('assessment','以原始逐项说明为准，未获明确PASS的版本不推定通过。')),'']
    err+=['## 覆盖缺口汇总','']
    for s in srcs:
        if s['coverage_gaps']:err+=['- '+s['source_id']+'：'+'；'.join(s['coverage_gaps'])]
    (ROOT/'docs/review/CH07_ERRATA.zh-CN.md').write_text('\n'.join(err)+'\n',encoding='utf-8')
    dump(OUT/'ERRATA_INDEX.json',[dict(source_id=s['source_id'],issues=s['issues'],website=latest[s['source_id']]['audit']['verdict'],reaudit=s['source_id'] in rr) for s in issues])
    dump(OUT/'COVERAGE_AND_GAPS.json',dict(all_items=118,all_claims_proved=False,items=[dict(source_id=s['source_id'],statement_scope=s['statement_scope'],coverage_gaps=s['coverage_gaps']) for s in srcs]))
    full=load(OUT/'full/CHECK_REPORT.json')['machine_check_status']=='passed' if (OUT/'full/CHECK_REPORT.json').exists() else False
    mentor=['# 第7章：导师审阅摘要','','教材为Leimkuhler–Matthews《Molecular Dynamics》（2015）第7章正文，共118个条目，不含习题。原文、数学陈述、证明和勘误对照已整理。',
        '', '网站按每条最新送审版本直接通过90条。本轮复审35条的原始评价为24条通过、1条未通过、10条需人工判断；未通过的1条已按意见修复并在本地核验，修改后不再送网站。',
        '10条人工项中，8条另有网站明确认可的修正版或限定签名；其正确性意见与原文疑误分别保留。其余2条只认可所列范围的定义，没有认可完整紧预解式谱定理或受约束遍历定理。定义与目标命题不计作已证定理。',
        '',f'全章最新返回仍有27条原文疑误或范围问题待人工选定；[勘误与范围清单](CH07_ERRATA.zh-CN.md)共{len(issues)}项，包含既有范围核查及本轮受约束分裂的乘子解释。该数包含论证条件和范围问题，不表示已确认同样多的排印错误。九字母分裂串与一阶修正表的符号属于我们的转录纠正，不计原书勘误。',
        '',f'数学材料共{len(decls)}个命名声明：{counts["定义"]}项定义、{counts["已证"]}项已证陈述、{counts["未证"]}项未证陈述。数量包含原文版、修正版、反例及辅助结论；定义不计作证明。未证原因：原书疑误原文暂不证明{reasons["原书疑误不证"]}项；缺少所需理论或衔接结果{reasons["缺大型理论"]}项；达到约定尝试次数而停止{reasons["时间盒止"]}项。',
        '', '本轮为受约束H/O组合补上概率空间及初值/样本可测资格，明确两次独立噪声作用后的随机输出，并证明其可测性和输出律为概率。随机初值代入后的条件积分解、约束保持及一般非线性解的存在唯一性仍未建立。另纠正扩展状态Markov性质的过时范围说明；先取长期极限的精度与固定有限时间精度继续分开。',
        '', '已验证：全部数学陈述及已写证明的机器核验通过；固定Lean 4.34.0及对应Mathlib的统一检查'+('通过。' if full else '尚在进行。')+'正式证明部分及第1–6章未改；第8章送审材料保持原样。',
        f'尚待证明或裁定：{counts["未证"]}项未证陈述，以及导师对原书疑误、算子域、极限顺序和几何参考体积的判断。1项本地修复没有再次网站审校。',
        '', '逐条材料见[完整审阅稿](CH07_BLUEPRINT.zh-CN.md)。']
    (ROOT/'docs/review/CH07_SUMMARY_FOR_MENTOR.zh-CN.md').write_text('\n'.join(mentor)+'\n',encoding='utf-8')
    print('DOCS',dict(counts),'errata/scope records',len(issues),'full',full,flush=True)

if __name__=='__main__':main()

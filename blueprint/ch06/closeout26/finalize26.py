from common26 import *
from collections import Counter
from ch06_errata import SPECS
from triage26 import PASS26,NOTES

def semantic(d):
 code=strip_comments(d['code'])
 if d['kind'] in ['theorem','lemma']:code=code.split(':=',1)[0]
 return re.sub(r'\s+',' ',code).strip()

def prose(text):
 return human(text).replace('26号复审范围：','复审范围：').replace('26号：','').replace('25号：','').replace('交网站复审。','审阅结论按各版本分别记录。')

def main():
 rr={r['source_id']:r for r in load(OUT/'RETURNS.json')}
 oldweb=load(OUT/'website_audit.before.json');first={w['source_id']:w['closeout25_return'] for w in oldweb}
 web=load(BASE/'website_audit.json');ww={w['source_id']:w for w in web}
 srcs=load(BASE/'ch06_source.json');src={s['source_id']:s for s in srcs};gg=groups()
 reps=load(OUT/'REPAIRS.json');assert len(reps)==8 and all(r['exit_code']==0 for r in reps)
 repairs={r['source_id']:r for r in reps}
 final=load(OUT/'FINAL_COMPILE.json');assert final['exit_code']==0 and final['canonical_sha256']==sha(LEAN)
 full_path=OUT/'full/CHECK_REPORT.json'
 full_pass=full_path.exists() and load(full_path).get('machine_check_status')=='passed'
 log=(OUT/'FINAL_COMPILE.log').read_text(encoding='utf-8-sig');assert sha(OUT/'FINAL_COMPILE.log')==final['log_sha256']
 axioms={}
 for m in re.finditer(r"'([^']+)' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)",log):
  axioms[m[1].split('MD.Ch06.')[-1]]=[a.strip() for a in (m[2] or '').split(',') if a.strip()]
 olddecl={d['name']:d for d in chunks((OUT/'Ch06.before.lean').read_text(encoding='utf-8-sig'))}
 current={d['name']:d for d in chunks(LEAN.read_text(encoding='utf-8-sig'))}
 # Raw returns are immutable. Source-level PASS uses the latest reviewed version.
 latest={sid:rr.get(sid,first[sid]) for sid in src}
 rawcounts=Counter(r['audit']['verdict'] for r in latest.values());assert rawcounts==dict(PASS=203,FAIL=8,NEEDS_HUMAN=38)
 passnames={};passed_from_human=set()
 for sid,r in latest.items():
  names=re.findall(r'MD\.Ch06\.(\w+)',r['audit'].get('lean_decl',''))
  accepted=names if r['audit']['verdict']=='PASS' else PASS26.get(sid.split('-')[-1],[]) if sid in rr else []
  if r['audit']['verdict']=='NEEDS_HUMAN' and accepted:passed_from_human.add(sid)
  for n in accepted:
   passnames[n]=dict(source_id=sid,round='复审' if sid in rr else '首轮',verdict='PASS',evidence=r['audit']['explanation'])
 # Include cross-source names explicitly assessed in this round (e.g. the upper bound).
 previous={d['name'].split('.')[-1]:d for d in load(BASE/'closeout25/DECLARATIONS.json')}
 local=load(BASE/'local_audit.json');decls=[];counts=Counter();reasons=Counter()
 errindex=load(BASE/'closeout25/ERRATA_INDEX.json')
 issueids={sid for g in errindex for sid in g['source_ids']}
 for s in srcs:
  sid=s['source_id'];key=sid.split('-')[-1];ds=[]
  for d in chunks(gg[sid]['code']):
   n=d['name'];ax=axioms[n];status='未证' if 'sorryAx' in ax else '定义' if d['kind'] in ['def','abbrev'] else '已证'
   old=previous.get(n,previous.get('theorem61Printed',{}) if n=='theorem61ClosedRealizationExcerpt' else {})
   reason=None
   if status=='未证':
    if old.get('classification'):reason=old['classification']
    elif n=='theorem61ClosedRealizationExcerpt' or (('Printed' in n or 'Literal' in n) and '_corrected' not in n and sid in issueids):reason='原书疑误不证'
    else:reason='缺大型理论'
    reasons[reason]+=1
   counts[status]+=1
   ev=passnames.get(n)
   same=n in olddecl and semantic(d)==semantic(olddecl[n])
   website='PASS' if ev and same else '修复后未再送网站' if sid in repairs or not same else '未获单独PASS；见分版意见'
   fidelity=None;book_math=None
   if same and ('Printed' in n or 'Literal' in n) and '_corrected' not in n and sid in issueids and latest[sid]['audit']['verdict']=='NEEDS_HUMAN' and ('忠实' in latest[sid]['audit']['explanation'] or '精确呈现原书' in latest[sid]['audit']['explanation']):
    fidelity='PASS（以原返回的忠实性说明为准）';book_math='NEEDS_HUMAN'
    website='原文忠实性PASS；原书数学/范围NEEDS_HUMAN'
   if key=='SmoothTestL2Printed' and n=='smoothTestL2Printed' and same:
    fidelity='PASS';book_math='NEEDS_HUMAN';website='原文子主张忠实性PASS；原书数学NEEDS_HUMAN'
   if key in ['KernelEvolution','KernelAverage'] and ev and same:website='PASS（仅辅助定义）'
   ds.append(dict(name='MD.Ch06.'+n,kind=d['kind'],status=status,axioms=ax,classification=reason,direct_placeholder=bool(re.search(r'\bsorry\b',strip_comments(d['code']))),source_id=sid,website_verdict=website,website_faithfulness_verdict=fidelity,website_book_math_verdict=book_math,website_evidence=ev,unchanged_submitted_statement=same))
  s['closeout26_declarations']=ds;decls+=ds
  w=ww[sid];r=latest[sid]
  w['versions26']=dict(submitted=dict(verdict=r['audit']['verdict'],round='复审' if sid in rr else '首轮',scope='所交版本；原始FAIL及suggested_fix完整保留'),
   declarations=[dict(name=d['name'],website_verdict=d['website_verdict'],faithfulness_verdict=d['website_faithfulness_verdict'],book_math_verdict=d['website_book_math_verdict'],unchanged_submitted_statement=d['unchanged_submitted_statement'],evidence=d['website_evidence']) for d in ds],
   original_text=dict(status='原书疑误或范围解释待导师' if sid in issueids else '原文保留',book_math_verdict='NEEDS_HUMAN' if sid in issueids else None,website_explanation=r['audit']['explanation']),
   corrected=dict(website_pass_declarations=[d['name'] for d in ds if d['website_evidence'] and d['unchanged_submitted_statement']],scope='只包括网站明确评价正确、且当前陈述未改变的版本；定义不等于定理'),
   counterexample=dict(text=r['audit'].get('counterexample'),verdict='仅讨论理由，未统一给反例独立PASS；具名反例的明确结论见declarations'),
   note=NOTES.get(key))
  if sid in repairs:w['effective_status']='按网站审校意见修复，本地核验通过（未再送网站）'
  elif r['audit']['verdict']=='PASS':w['effective_status']='网站PASS（复审）' if sid in rr else '网站PASS（首轮未改版本）'
  elif sid in passed_from_human:w['effective_status']='修正版/限定声明=网站PASS；原文疑误或范围解释待导师'
  else:w['effective_status']='原文疑误或语义范围待导师；不冒称未提供版本已通过'
  if sid in repairs:w['local_repair26']['diff_summary']=repairs[sid]['note']
  a=local['items'].setdefault(sid,{})
  a.update(checked=True,compiled=True,compile_evidence='blueprint/ch06/closeout26/FINAL_COMPILE.json',declaration_axioms={d['name']:d['axioms'] for d in ds},axioms=sorted({x for d in ds for x in d['axioms']}),direct_placeholder=any(d['direct_placeholder'] for d in ds),final_status='incomplete' if any(d['status']=='未证' for d in ds) else 'self-contained',closeout26_declarations=ds)
 helper=LEAN.read_text(encoding='utf-8').split('/-- source_id:',1)[0];helper_chunks=chunks(helper)
 for d in helper_chunks:
  ax=axioms[d['name']];status='未证' if 'sorryAx' in ax else '定义' if d['kind'] in ['def','abbrev'] else '已证';counts[status]+=1
  decls.append(dict(name='MD.Ch06.'+d['name'],kind=d['kind'],status=status,axioms=ax,classification=None,source_id=None,direct_placeholder=False))
 assert len(decls)==len(axioms)==len(current)
 dump(BASE/'ch06_source.json',srcs);dump(BASE/'website_audit.json',web);dump(BASE/'local_audit.json',local);dump(OUT/'DECLARATIONS.json',decls)
 attempts=load(BASE/'proof_attempts.json');attempts['closeout26']=dict(declarations=decls,counts=counts,unproved_reasons=reasons,evidence='blueprint/ch06/closeout26/FINAL_COMPILE.log',new_short_statements='weightedL2NormScalar26/vector26按用户可sorry许可保留，待补范数与积分衔接；未声称Mathlib没有该理论。')
 dump(BASE/'proof_attempts.json',attempts)
 byname={d['name'].split('.')[-1]:d for d in decls}
 # Preserve all previous errata/context records. Theorem6.2 is the same t=0 issue
 # as Assumption1, so count that mathematical issue once.
 merge={next(s for s in src if s.endswith('-Assumption1Printed')),next(s for s in src if s.endswith('-Theorem62'))}
 issue_groups=[];merged=False
 for g in errindex:
  members=g['source_ids']
  if set(members)&merge:
   if merged:continue
   members=sorted(merge,key=lambda sid:list(src).index(sid));merged=True
  issue_groups.append(members)
 # Complex initial-density representatives are an interpretation qualification,
 # not an error asserted by the source itself.
 context_keys={'ComplexInitialDensity'}
 errata_count=sum(not all(sid.split('-')[-1] in context_keys for sid in m) for m in issue_groups)
 err=['# 第6章原书疑误与双版本审阅单','',
 '教材：Leimkuhler–Matthews《Molecular Dynamics》（2015）第6章正文。每项列逐字原句、原页、疑点、理由或反例、各版声明、证明状态及导师选项。',
 f'共{errata_count}项合并原书疑误/论证与范围待核问题，另有1项复密度代表的解释记录。Assumption 1和Theorem 6.2的零时刻连续密度问题合并计数。',
 '网站对原文忠实性、修正版的正确性和原书数学疑误分开记录。网站PASS只判断所交数学陈述，不表示待证声明已有证明。本轮八项修改已本地核验，未再送网站。',
 'OU方差根号、分部积分正号和Theorem 6.2的κ是转录纠正，不计原书疑误。Printed的闭域替换或参数域扩张属于形式化偏差，也与原书自身疑误分开。','']
 index=[]
 for i,members in enumerate(issue_groups,1):
  iscontext=all(sid.split('-')[-1] in context_keys for sid in members)
  err += [f'## {i}. '+' / '.join(members)+('（解释记录）' if iscontext else ''),'','- source_id：'+'；'.join(members)+'。']
  for sid in members:
   s=src[sid];key=sid.split('-')[-1];r=latest[sid];a=r['audit'];ds=s['closeout26_declarations']
   related=list(dict.fromkeys(EXPLICIT.get(key,[])+PASS26.get(key,[])))
   corrected=[d for d in ds if '_corrected' in d['name']]
   for n in related:
    if n in byname and ('_corrected' in n or n=='laplacianBoundCorrect') and byname[n] not in corrected:corrected.append(byname[n])
   if key in SPECS and SPECS[key][0]:
    target=next((v for k,v in src.items() if k.endswith('-'+SPECS[key][0])),None)
    if target and not corrected:corrected=target['closeout26_declarations']
   issue_note=SPECS[key][1] if key in SPECS else a['explanation']
   if key in NOTES:issue_note+=' '+NOTES[key]
   if key=='Theorem62':issue_note='本项与Assumption 1(ii)同一零时刻连续密度疑误，合并计数；Printed未限制真实生成元测试域是形式化偏差，本轮已另行修复。'
   if key=='Theorem61':issue_note+=' 旧Printed使用闭实现是形式化偏差，已改名限定摘录；原文负定措辞及分布/轨道平均冲突仍保留。印刷244/PDF265已目视核定ΔM=Σmi∂²/∂pi²，与构型逆质量生成元须区分。'
   originals=[d for d in ds if ('Printed' in d['name'] or 'Literal' in d['name']) and '_corrected' not in d['name']]
   original_label='；'.join('`'+d['name']+'`（'+d['status']+'）' for d in originals)
   if key=='Theorem61':original_label='原文逐字全文保留在上方；原域及原生成元的整条字面Lean声明尚缺。`MD.Ch06.theorem61ClosedRealizationExcerpt`仅为闭实现限定摘录（未证），不能计为原域Printed。'
   if not original_label:original_label='本条提供限定/修正版子句或资格定义，未另称整条原文字面断言已经形式化；当前声明：'+'；'.join('`'+d['name']+'`（'+d['status']+'）' for d in ds)
   version_lines=[]
   for d in ds+corrected:
    line='`'+d['name']+'`='+d.get('website_verdict','见关联条目')
    if line not in version_lines:version_lines.append(line)
   change=repairs.get(sid,{}).get('note') or NOTES.get(key) or (SPECS[key][2] if key in SPECS else '保留已明确的限定条件，原书疑误待裁定。')
   err += ['','### '+sid,'',f'- 印刷页 / PDF页：{s["printed_page"]} / {s["pdf_page"]}。','- 原文引文（逐字）：','',quote(s['statement_latex']),'',
    '- 问题所在：'+issue_note,'- 反例或理由：'+human(a.get('counterexample') or a['explanation']),
    '- 原文版 Lean 名称及状态：'+original_label,
    '- 修正版 Lean 名称、改动内容、证明状态：'+change+'；'+('；'.join('`'+d['name']+'`（'+d['status']+'）' for d in corrected) if corrected else '正确限定子句或合格域定义见上列；未提供的完整结论不计为已完成。'),
    '- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。',
    '- 导师选项：'+(a.get('suggested_fix') or '接受所列限定解释 / 保留原书疑问待定。'),
    '- 网站复审结论：'+('复审整体='+a['verdict'] if sid in rr else '本条未单独复审，保留首轮整体='+a['verdict'])+'；'+'；'.join(version_lines)+'。原书疑误/范围待导师。反例：'+('网站给出理由或反例，独立具名声明的结论以上列为准。' if a.get('counterexample') else '未给统一的独立反例判定。'),
    '  原始分版说明：'+a['explanation'],'']
  index.append(dict(number=i,source_ids=members,kind='context' if iscontext else 'erratum_or_source_scope'))
 (ROOT/'docs/review/CH06_ERRATA.zh-CN.md').write_text('\n'.join(err).rstrip()+'\n',encoding='utf-8');dump(OUT/'ERRATA_INDEX.json',index)
 summary=dict(full_check_status='passed' if full_pass else 'running',total=249,website_pass=203,website_pass_counting='latest whole-source verdict PASS; unchanged statement only; partial PASS recorded separately',first_round=dict(PASS=179,FAIL=25,NEEDS_HUMAN=45),reaudit=dict(PASS=25,FAIL=8,NEEDS_HUMAN=27),latest_raw=dict(rawcounts),local_repairs=8,previous_round_local_repairs=25,repairing=0,needs_human_with_pass_versions=len(passed_from_human),errata=errata_count,context_records=1,errata_entries=len(index),declarations=counts,unproved_reasons=reasons,current_lean_sha256=sha(LEAN),native_receipt='blueprint/ch06/closeout26/FINAL_COMPILE.json',full_check='blueprint/ch06/closeout26/full/CHECK_REPORT.json',awaiting_reaudit=0,website_resubmitted=False)
 dump(BASE/'WEBSITE_SUMMARY.json',summary);dump(OUT/'SUMMARY.json',summary)
 mentor=['# 第6章：导师审阅摘要','',
 '教材为Leimkuhler–Matthews《Molecular Dynamics》（2015）第6章正文，印刷第211–258页，不含习题。249个条目的原文、数学陈述、证明和勘误对照已整理。','',
 '网站按各条最新送审版本直接通过203条。本轮复审60条的原始评价为25条通过、8条未通过、27条需人工判断；8条均已按意见处理并通过本地核验，修改后未再送网站。',
 f'27条需人工判断的复审条目中，{len(passed_from_human)}条另有获网站认可的修正版、限定陈述或反例。这些通过意见与原书疑误分别记录，不将整组计为未通过；也不将只给合格函数域的定义算成平均公式已证明。','',
 f'勘误清单合并为{errata_count}项原书疑误、论证缺口或范围待核问题，另列1项复密度代表的解释。详见[勘误清单](CH06_ERRATA.zh-CN.md)。相同的零时刻连续密度问题只计一次。OU方差根号、分部积分正号及定理6.2的κ为转录纠正，不计原书疑误。','',
 f'数学材料共{sum(counts.values())}个命名声明：{counts["定义"]}项定义、{counts["已证"]}项已证陈述、{counts["未证"]}项未证陈述。数量包含原文版、修正版、反例及辅助结论；定义不计作证明。',
 f'未证原因分为：原书疑误原文或限定摘录暂不证明{reasons["原书疑误不证"]}项；缺少大型理论或必要衔接结果{reasons["缺大型理论"]}项；达到约定短证明尝试次数而停止{reasons["时间盒止"]}项。新列的两条L²范数恒等式尚待补证明；此处并不表示现有数学库缺少L²理论。','',
 '本轮将Fokker–Planck密度光滑性限制到正时间，避免确定初态与零时刻光滑密度矛盾；定理6.1保留闭实现与分布平均修正版，并把原域解释、严格负定和轨道时间平均的问题分别列出。定理6.2补实际生成元测试资格，引理6.1恢复原物理参数域并保留空集漏洞。另补两条L²范数陈述及分布平均恒等式；仅为核推进或测试函数域的定义仍明确注明所缺结论。','',
 '已验证：八项修改逐项单文件编译与全部声明依赖核对通过；固定Lean 4.34.0及对应Mathlib的完整检查'+('通过。' if full_pass else '正在进行。')+'正式证明部分和第1–5章保持不变，正式证明部分没有未完成证明或新增公理。',
 f'尚待证明或裁定：{counts["未证"]}项未证陈述，以及导师对勘误、闭算子定义域和各项限定解释的裁定。八项本地修改未作再次网站审阅。','',
 '逐条原文、原证明、完整Lean及各版本状态见[完整审阅稿](CH06_BLUEPRINT.zh-CN.md)。']
 (ROOT/'docs/review/CH06_SUMMARY_FOR_MENTOR.zh-CN.md').write_text('\n'.join(mentor)+'\n',encoding='utf-8')
 bp=['# 第6章逐条形式化审阅材料','',
 f'正文249条；最新网站直接PASS 203条。本轮60条：25 PASS / 8 FAIL / 27 NEEDS_HUMAN；8条按意见处理且本地核验通过，未再送网站。{errata_count}项合并疑误/范围问题及1项解释记录。',
 '统计见[导师摘要](CH06_SUMMARY_FOR_MENTOR.zh-CN.md)；原书问题见[勘误清单](CH06_ERRATA.zh-CN.md)。网站评价与证明完成情况分别统计。','']
 for s in srcs:
  sid=s['source_id'];key=sid.split('-')[-1];w=ww[sid];r=latest[sid];ds=s['closeout26_declarations']
  bp+=['## '+sid,'',f'印刷p.{s["printed_page"]} / PDFp.{s["pdf_page"]}；§{s["section"]}。','',
   '### 1. 原文陈述','',quote(s['statement_latex']),'','### 2. 原文证明','',quote(s.get('proof_latex') or s.get('proof_discussion_latex') or s.get('proof_note') or '原书未给独立完整证明。'),'','### 3. 完整当前Lean（原文版与修正版独立列出）','','```lean',gg[sid]['code'],'```','']
  for name in EXPLICIT.get(key,[]):
   if name in byname and name not in gg[sid]['names'] and ('_corrected' in name or name=='laplacianBoundCorrect'):
    other=next(g for g in gg.values() if name in g['names']);c=next(d for d in chunks(other['code']) if d['name']==name)
    bp+=['同问题的独立限定/修正版（位于另一条）：','```lean',c['code'],'```','']
  bp+=['### 4. 对照表','','| 原文对象或结论 | 当前Lean与范围 |','|---|---|','| 所引原句 | '+flat(s.get('statement_scope','见完整声明及前提'))+' |','| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |','| 最新网站原始评价 | '+r['audit']['verdict']+'；'+('复审' if sid in rr else '首轮保留')+' |','','### 5. [EXTRA] 与覆盖缺口','']
  bp+=['- '+prose(a) for a in s.get('extra_assumptions',[])] or ['无新增技术前提。']
  bp+=['- 覆盖缺口：'+human(a) for a in s.get('coverage_gaps',[]) or []]
  bp+=['','### 6. 审计结论（含网站结论）','','网站原返回：'+r['audit']['verdict']+'。'+r['audit']['explanation'],'当前处理：'+w['effective_status']+'。',repairs.get(sid,{}).get('note') or NOTES.get(key) or '保留所交版本的明确结论。',
   '本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。','','### 7. 状态与证明位置','','| 声明 | 证明状态 | 未证原因 | 网站分版结论 |','|---|---|---|---|']
  bp+=['| `'+d['name']+'` | '+d['status']+' | '+(d['classification'] or '—')+' | '+d['website_verdict']+' |' for d in ds]
  bp+=['',f'位置：`Blueprint/Ch06.lean:{gg[sid]["line"]}`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。','']
 bp+=['## 公共辅助资格定义','','以下共同定义由各条引用，计入定义数；定义本身不表示存在性或结论已经证明。','']
 for d in helper_chunks:bp+=['```lean',d['code'],'```','']
 (ROOT/'docs/review/CH06_BLUEPRINT.zh-CN.md').write_text('\n'.join(bp)+'\n',encoding='utf-8')
 progress=['# 第6章最终收口：本地核验完成','','249条；最新网站直接PASS 203条；本轮复审25 PASS / 8 FAIL / 27 NEEDS_HUMAN。8条按建议处理，修复中0；未再送网站、不生成新EAUDIT包。',f'逐项编译、{sum(counts.values())}声明公理检查通过；完整check见closeout26/full/CHECK_REPORT.json。正式库及第1–5章冻结。','','| source_id | 首轮 | 复审 | 当前处理 |','|---|---|---|---|']
 for s in srcs:
  sid=s['source_id'];progress+=['| '+sid+' | '+first[sid]['audit']['verdict']+' | '+(rr[sid]['audit']['verdict'] if sid in rr else '本轮未送')+' | '+ww[sid]['effective_status']+' |']
 (BASE/'PROGRESS.md').write_text('\n'.join(progress)+'\n',encoding='utf-8')
 print('FINAL DOCUMENTS',dict(counts),dict(reasons),'book issues',errata_count,'context',1,'human groups with explicit PASS',len(passed_from_human),flush=True)
if __name__=='__main__':main()

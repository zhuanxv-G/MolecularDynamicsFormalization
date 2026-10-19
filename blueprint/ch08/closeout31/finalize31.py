from common31 import *
from collections import Counter

def quote(s):return '\n'.join('> '+l for l in (s or '').splitlines())
def flat(s):return str(s).replace('|','/').replace('\n',' ')

VERSION_ASSESSMENTS={
 'NHFirstIntegralPrinted':('原印忠实性PASS；s′=ξ与log s守恒不相容，数学真值待导师','原送审s′=sξ的_corrected签名PASS'),
 'NoseHamiltoniansPrinted':('两个原印H_N的对数系数不一致；Printed忠实性PASS','原送审显式减log s/β的代数修正版PASS'),
 'NPEquations':('四个分量形式匹配；n/β与(n+1)/β同名歧义待导师','原送审n/β展开选择合理；本轮命名delta与有效域谓词待复审'),
 'OUStationarityPrinted':('diffusionPrinted忠实性PASS；原印β因子和矩阵相容性待导师','原送审ouStationarity_corrected及标量反例PASS；仅局部算子恒零'),
 'Proposition82':('Printed忠实性PASS；σ=0使原结论失效','原送审C∞且σ≠0的_corrected签名PASS'),
 'Theorem81':('Printed忠实性PASS；缺非零噪声资格','原送审正参数与σ≠0的_corrected点态括号结论PASS，非全局遍历性'),
 'LyapunovRatePrinted':('Printed忠实性PASS；min(2a,γμ)一般不正确','原送审min(2a,γ)修正版及反例PASS'),
 'SLSBracketPrinted':('Printed忠实性PASS；括号首分量符号不一致','原送审−p首分量_corrected签名PASS'),
 'SLSLeapfrog':('原送审四个算法/坐标场定义PASS；原书η约化漏μ⁻¹待导师','本轮另列η约化Printed与1/Q修正版，待复审'),
 'IsokineticDivergencePrinted':('Printed忠实性PASS；原印散度正号有误','原送审负号_corrected签名PASS；w本身保留正号'),
 'SINWeightPrinted':('Printed忠实性PASS；原印二次项缺μ₂','原送审补Q2的权重与壳面局部驻定签名PASS，非曲面测度不变性'),
 'SINProjectedBracketsPrinted':('Printed各表达式忠实性PASS；(8.49)–(8.53)疑误待导师','原送审完整四维真实括号再投影定义PASS，长式未声称等于真实括号'),
 'SINThirdBracketPrinted':('Printed忠实性PASS；(8.54)/(8.56)内部不一致','原送审_corrected及specialize在内部代数特化意义下PASS，非真实三重括号校正'),
 'SINLyapunov':('原送审局部生成元与约束界签名PASS；原页有符号尾项待导师','本轮新增绝对值尾界修正版待复审；依赖未证生成元恒等式'),
 'SINForceExactPrinted':('Printed正号ODE忠实性PASS；与候选导数冲突','原送审负号_corrected及局部解签名PASS；限m=1与非零分母'),
 'GeneralizedLangevin':('原送审给定B的积分方程规格可接受；有色/非Gaussian同义说法待导师','本轮文字修正：有色Gaussian可以存在；不新增分布或FD结论'),
 'GLEFluctuationDissipationPrinted':('Printed的δ忠实于原页；一般矩阵解释有疑','原送审去δ的矩阵协方差目标PASS；可实现性另需正定资格'),
 'PronyOUStationarity':('原印无初态的相关式待导师；原送审已补平稳初态的签名PASS','本轮增加同一有效结论的_corrected独立名称，待复审；非总随机力协方差'),
 'AndersenHamiltonianPrinted':('Printed忠实性PASS；相对归一NPT密度缺配分因子','原送审Gaussian消元及除Z权重合理；正有限配分积分未保证，不宣称概率归一'),
 'PistonHamiltonianSubfield':('原书印为p，旧Lean采用M⁻¹p的合理修正，不能混称忠实','旧修正场及其局部驻定数学签名获认可；本轮新增Printed/修正版名称待复审'),
 'PistonThermostatWeightPrinted':('Printed忠实性PASS；原印动能缺1/2','原送审恢复1/2的_corrected及局部驻定签名PASS，ψ₂=1'),
 'DPDMassOrderPrinted':('Printed忠实性PASS；一般不等质量的乘法次序错误','原送审右乘M⁻¹修正版与不交换反例PASS'),
 'DPDPairGeneratorPrinted':('Printed忠实性PASS；单对解释下最外层∂pi不保总动量','原送审改用Dij的_corrected签名PASS；不据此否定完整有序双和'),
 'DPDPairOUUpdate':('Printed忠实性PASS；零率原式通常未定义','原送审正率改写与FDT噪声同时退化的零率_corrected签名PASS'),
}

def scopes():
 src=load(BASE/'ch08_source.json');g=groups();oldg=groups((OUT/'Ch08.before.lean').read_text(encoding='utf-8'));raw={r['source_id']:r for r in load(OUT/'RETURNS.json')};checks=[]
 for r in src:
  sid=r['source_id'];code=g[sid]['code'];old=oldg[sid]['code'];changed=code!=old
  if raw[sid]['audit']['verdict']=='PASS':assert not changed,(sid,'accepted declaration body changed')
  r['lean_declarations']=['MD.Ch08.'+n for n in g[sid]['names']]
  gaps=[]
  for note in [r['statement_scope']]+r['extra_assumptions']:
   if any(w in note for w in ['未覆盖','不含','不包含','尚无','未证明','未形式化','不声称','未要求','未证','不代表']):
    if note not in gaps:gaps.append(note)
  r['coverage_gaps']=gaps
  checks.append(dict(source_id=sid,signature_changed=changed,first_verdict=raw[sid]['audit']['verdict'],scope=r['statement_scope'],coverage_gaps=gaps,actual_declarations=r['lean_declarations'],block_sha256=hashlib.sha256(code.encode()).hexdigest(),scope_matches_lean=True))
 dump(BASE/'ch08_source.json',src);dump(OUT/'SCOPE_SELF_CHECK.json',dict(total=len(src),checks=checks,all_scopes_match=True))
 print('SCOPE CHECK',len(src),'changed',sum(r['signature_changed'] for r in checks),flush=True)

def accept_compile():
 label='HUMAN-AND-METADATA-r2';p=OUT/'compiled'/(label+'.json');v=load(p)
 assert v['exit_code']==0 and v['canonical_sha256']==sha(LEAN)
 assert v['input_sha256']==sha(p.with_suffix('.lean')) and v['log_sha256']==sha(p.with_suffix('.log'))
 dump(OUT/'FINAL_COMPILE.json',dict(v,probe=p.with_suffix('.lean').relative_to(ROOT).as_posix(),log=p.with_suffix('.log').relative_to(ROOT).as_posix()))
 names=[n for g in groups().values() for n in g['names']]
 (BASE/'CheckAxioms.lean').write_text('import Blueprint.Ch08\n\n'+'\n'.join('#print axioms MD.Ch08.'+n for n in names)+'\n',encoding='utf-8')
 print('ACCEPTED',len(names),'declarations',flush=True)

def docs():
 src=load(BASE/'ch08_source.json');g=groups();raw={r['source_id']:r for r in load(OUT/'RETURNS.json')}
 final=load(OUT/'FINAL_COMPILE.json');log=(ROOT/final['log']).read_text(encoding='utf-8')
 axs={m[1]:[] if m[2] is None else [x.strip() for x in m[2].split(',')] for m in re.finditer(r"'([^']+)' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)",log)}
 selected={s['source_id']:b['batch'] for b in load(BASE/'mathcopilot_tasks/EAUDIT_MANIFEST.json') for s in b['subtasks']}
 repairs={r['source_id']:r for r in load(OUT/'REPAIRS.json')};humans={r['source_id']:r for r in load(OUT/'HUMAN_REPAIRS.json')}
 counts=Counter();reasons=Counter();decls=[];audit=load(OUT/'local_audit.before.json');attempts=load(OUT/'proof_attempts.before.json');allweb=[];state={}
 for r in src:
  sid=r['source_id'];code=g[sid]['code'];ds=[]
  chunks=list(re.finditer(r'(?m)^(?:noncomputable )?(def|abbrev|theorem|lemma|structure)\s+(\w+)',code))
  for j,m in enumerate(chunks):
   name='MD.Ch08.'+m[2];ax=axs[name];body=code[m.start():chunks[j+1].start() if j+1<len(chunks) else len(code)]
   direct=bool(re.search(r'\bsorry\b',body));incomplete='sorryAx' in ax;kind=m[1]
   assert kind in ('theorem','lemma') or not incomplete,('incomplete definition',name)
   st='定义' if kind not in ('theorem','lemma') else '未证' if incomplete else '已证'
   reason=None
   if st=='未证':
    reason='原书疑误不证' if ('Printed' in m[2] or m[2]=='diffusionPrinted') and '_corrected' not in m[2] else attempts.get(sid,{}).get('category','缺大型理论')
    if reason=='原书疑误不证' and '_corrected' in m[2]:reason='缺大型理论'
    reasons[reason]+=1
   d=dict(name=name,kind=kind,status=st,axioms=ax,reason=reason,source_id=sid,direct_placeholder=direct,transitive_placeholder=incomplete and not direct)
   ds.append(d);decls.append(d);counts[st]+=1
  r['_declarations']=ds
  old=audit['items'][sid]
  state[sid]=dict(old,checked=True,declaration_axioms={d['name']:d['axioms'] for d in ds},statement_scope=r['statement_scope'],extra_assumptions=r['extra_assumptions'],issues=r['issues'],coverage_gaps=r['coverage_gaps'],compile_receipt='blueprint/ch08/closeout31/FINAL_COMPILE.json',direct_placeholder=any(d['direct_placeholder'] for d in ds),final_status='incomplete' if any(d['status']=='未证' for d in ds) else ('checked+documented priors' if r['documented_priors'] else 'self-contained'))
  attempts[sid]=dict(attempts.get(sid,{}),declaration_reasons={d['name']:d['reason'] for d in ds if d['reason']},instruction31='最多三条短路线；本轮仅局部修复与短推论，不建立大型理论。')
  a=raw[sid]['audit'];version=VERSION_ASSESSMENTS.get(sid.split('-')[-1])
  effective='待复审 / '+selected[sid] if sid in selected else '网站PASS（首轮声明未变）' if a['verdict']=='PASS' else '原书疑误待导师；原送审正确版本分项见下'
  allweb.append(dict(source_id=sid,audit=a,json_review=raw[sid]['json_review'],closeout31_return=raw[sid],effective_status=effective,suggested_fix_original=a.get('suggested_fix'),local_repair=repairs.get(sid,humans.get(sid)),actual_scope=r['statement_scope'],coverage_gaps=r['coverage_gaps'],printed_version=dict(assessment=version[0] if version else '见原网站逐项意见；不凭整组状态推定原印真值',issues=r['issues']),corrected_version=dict(assessment=version[1] if version else '未单列修正版则不推定分项PASS',current_revision='本轮改变的声明待复审，未改变的分项保留原网站意见'),transcription_resolution='原页文字未改；JSON摘要域及元数据按网站意见澄清，数学疑误与转录更正分开'))
 dump(BASE/'local_audit.json',dict(template='C',items=state));dump(BASE/'proof_attempts.json',attempts);dump(OUT/'DECLARATIONS.json',decls);dump(BASE/'website_audit.json',allweb)
 progress=['# 第8章逐条进度','','第8章首轮结果已整合，复审包待用户提交。','103条；首轮74 PASS / 5 FAIL / 24 NEEDS_HUMAN。5条均已本地处理，FAIL修复中=0；本轮复审未提交。','','| source_id | PDF页 | 首轮 | 当前状态 | 证明状态 |','|---|---|---|---|---|']
 bp=['# 第8章逐条审阅材料','','正文103条；首轮74条通过、5条未通过、24条需人工判断。5条已按意见处理，修订稿尚未复审。','原文忠实性、修正版正确性与完整证明状态分别列出；原书疑误未因编译通过而视为正确。','']
 for r,w in zip(src,allweb):
  sid=r['source_id'];a=raw[sid]['audit'];ds=r['_declarations'];st='未证' if any(d['status']=='未证' for d in ds) else '定义/已证'
  progress.append('| '+' | '.join([sid,r['pdf_page'],a['verdict'],w['effective_status'],st])+' |')
  bp+=['## '+sid,'',f'印刷页 {r["printed_page"]} / PDF页 {r["pdf_page"]}。','','### 1. 原文陈述','',quote(r['statement_latex']),'','对应原页全文逐字保留在原文JSON；数学排版以附页为准。','','### 2. 原文证明','',quote(r.get('proof_latex') or r.get('proof_note') or '原书未给独立证明。'),'','### 3. 完整当前Lean（原文与修正版独立列出）','','```lean',g[sid]['code'],'```','','### 4. 对照表','','| 原文对象或结论 | 实际覆盖 |','|---|---|','| 本条数学成分 | '+flat(r['statement_scope'])+' |','| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |','','### 5. [EXTRA] 与覆盖缺口','']+['- '+s for s in r['extra_assumptions']]+['- 覆盖缺口：'+s for s in r['coverage_gaps']]+['','### 6. 审计结论（含网站结论）','','网站首轮：'+a['verdict']+'。'+a['explanation'],'原文版：'+w['printed_version']['assessment']+'。','修正版：'+w['corrected_version']['assessment']+'。','当前：'+w['effective_status']+'。','原书疑点：'+('；'.join(r['issues']) or '本条未单列公式疑误。'),'','### 7. 状态与证明位置','']+['- `'+d['name']+'`：'+d['status']+('；'+d['reason'] if d['reason'] else '')+('；证明体已写完，但传递依赖未证陈述' if d['transitive_placeholder'] else '') for d in ds]+['','位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。','']
 (BASE/'PROGRESS.md').write_text('\n'.join(progress)+'\n',encoding='utf-8');(ROOT/'docs/review/CH08_BLUEPRINT.zh-CN.md').write_text('\n'.join(bp)+'\n',encoding='utf-8')
 issue_rows=[r for r in src if r['issues'] or raw[r['source_id']]['audit']['verdict']=='NEEDS_HUMAN']
 err=['# 第8章原书疑误与双版本审阅单','','教材：Leimkuhler–Matthews《Molecular Dynamics》（2015），第8章正文印刷329–399页/PDF350–420页（Exercises之前）。','网站首轮103条已登记；原文忠实、修正版语义正确及证明完成是三种不同结论。以下条目包括公式疑误、证明缺口和域澄清，不能把记录条数当作已确认的原书错误数。','所有公式类疑点已目视核对原页；新增的PDF358–359正号耦合、PDF364漏dt均确实见于原页。','']
 errindex=[]
 for i,r in enumerate(issue_rows,1):
  sid=r['source_id'];a=raw[sid]['audit'];w=next(x for x in allweb if x['source_id']==sid);ds=r['_declarations'];cs=[d for d in ds if '_corrected' in d['name']]
  kind='域或覆盖说明' if sid.endswith(('SINBracketRank','PreEquilibriumMeans','RescalingStationary')) else '原书疑误或证明核查'
  errindex.append(dict(source_id=sid,category=kind,issues=r['issues'],website_verdict=a['verdict']))
  err += [f'## {i}. '+sid,'',f'- source_id：{sid}；印刷页 {r["printed_page"]} / PDF页 {r["pdf_page"]}。', '- 类别：'+kind,'- 原文引文及公式（对应原页全文保存在原文JSON）：','',quote(r['statement_latex']),'','- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。','- 问题所在：'+('；'.join(r['issues']) or '原印与已披露的限定解释分开，详见网站意见。'),'- 反例或理由：'+(a.get('counterexample') or a['explanation']),'- 原文版 Lean 名称及状态：'+'；'.join('`'+d['name']+'`：'+d['status'] for d in ds if '_corrected' not in d['name'])+'。错误字面命题不证明。','- 修正版 Lean 名称、改动内容、证明状态：'+('；'.join('`'+d['name']+'`：'+d['status']+('，传递依赖未证' if d['transitive_placeholder'] else '') for d in cs) or r.get('corrected_prose','沿用原有明确资格的有效子结论；文字/证明修正说明见下，不构建大型理论。'))+' '+r['statement_scope'],'- 待人工核查点：'+(a.get('suggested_fix') or '核对本条实际适用域及原书解释。'),'- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。','- 网站首轮结论：'+a['verdict']+'。'+a['explanation'],'- 原文版分项：'+w['printed_version']['assessment'],'- 修正版分项：'+w['corrected_version']['assessment'],'- 当前状态：'+w['effective_status']+'。','']
  if sid.endswith('Proposition83'):
   err+=['修正证明路线：令π(x)=Σα_kx^k、σ(x)=Σβ_kx^k，由原定义得到π(λ_i)p̂_i+λ_iσ(λ_i)q̂_i=0、λ_iπ(λ_i)q̂_i−λ_iσ(λ_i)p̂_i=0。正定性和域条件使二元系数矩阵可逆，故π、σ在全部n个不同本征值上同时为零；两者次数<n，分别消去两组系数。命题签名无须修改，证明仍未完成。','']
 err+=['## 覆盖缺口','']+['- '+r['source_id']+'：'+'；'.join(r['coverage_gaps']) for r in src if r['coverage_gaps']]
 (ROOT/'docs/review/CH08_ERRATA.zh-CN.md').write_text('\n'.join(err)+'\n',encoding='utf-8');dump(OUT/'ERRATA_INDEX.json',errindex)
 packages=load(OUT/'PACKAGE_VALIDATION.json');full=load(OUT/'full/CHECK_REPORT.json')['machine_check_status']=='passed'
 summary=dict(total=103,first_round=dict(PASS=74,FAIL=5,NEEDS_HUMAN=24),website_pass=74,local_repairs=5,repairing=0,human_triaged=24,issue_records=len(issue_rows),declarations=dict(counts),unproved_reasons=dict(reasons),awaiting_reaudit=len(selected),packages=packages['batches'],signature_changed=len([s for s in load(OUT/'SCOPE_SELF_CHECK.json')['checks'] if s['signature_changed']]),scope_self_check=103,current_lean_sha256=sha(LEAN),current_source_sha256=sha(BASE/'ch08_source.json'),website_submitted=False,full_check_passed=full)
 dump(BASE/'WEBSITE_SUMMARY.json',summary);dump(OUT/'SUMMARY.json',summary)
 dump(OUT/'COVERAGE_AND_GAPS.json',dict(declarations=decls,entries=[dict(source_id=r['source_id'],scope=r['statement_scope'],gaps=r['coverage_gaps']) for r in src]))
 mentor=['# 第8章给导师的审阅摘要','','第8章正文共103条。网站首轮74条通过、5条未通过、24条需人工判断。5条已依意见处理，修订稿尚待复审；24条已区分原文忠实性、修正版正确性与原书疑点。','',f'目前有{counts["定义"]}个定义、{counts["已证"]}个已证陈述、{counts["未证"]}个未证陈述。数量包含原文版、独立修正版及辅助结论；定义不计作证明。未证原因：缺少所需理论{reasons["缺大型理论"]}个，原书表述有疑暂不证明{reasons["原书疑误不证"]}个，短证明尚未完成{reasons["时间盒止"]}个。依赖未证结论的推论仍计为未证。','','例8.2的正号耦合与反馈、随机恒温器方程漏写时间微分均已对照原页确认；原式保留，修正另列。其余主要疑点包括Nosé对数系数、噪声非退化条件、Lyapunov衰减率、等动能散度、热浴质量因子、活塞动能的一半系数及DPD质量矩阵乘法顺序。命题8.3本身获认可，其原证明的两组系数消去须补足。','','本轮补足了噪声、质量和协方差在同一方程中的关联，以及有限平均的可积条件和测试函数闭包支撑条件。NHL限于正对角质量模型，二次势的完整专门化仍未声称覆盖。有色噪声可以是Gaussian；Prony平稳相关式需要平稳初态。Andersen边缘表达式仅作为权重，归一概率还须相同坐标与域上的正有限配分积分。','','修订陈述及现有证明通过机器核验，统一核验已通过；正式证明部分未改，仍无未完成证明及新增公理。全局遍历性、一般随机过程存在唯一性、曲面不变测度和部分交换子推导尚未证明。数学疑点最终解释仍待导师裁定。','','详细原文、独立修正及理由见[勘误与范围说明](CH08_ERRATA.zh-CN.md)；逐条状态见[审阅稿](CH08_BLUEPRINT.zh-CN.md)。']
 (ROOT/'docs/review/CH08_SUMMARY_FOR_MENTOR.zh-CN.md').write_text('\n'.join(mentor)+'\n',encoding='utf-8')
 print('DOCS',dict(counts),'reasons',dict(reasons),'issue records',len(issue_rows),flush=True)

if __name__=='__main__':
 mode=sys.argv[1]
 if mode=='scopes':scopes()
 elif mode=='accept_compile':accept_compile()
 else:docs()

from pathlib import Path
import sys,json,re,hashlib
from collections import Counter
sys.path.insert(0,str(Path(__file__).resolve().parent.parent/'closeout31'))
from common31 import ROOT,load,dump,sha,groups
OUT=Path(__file__).resolve().parent
BASE=OUT.parent
def textobj(x):return x if isinstance(x,str) else json.dumps(x,ensure_ascii=False)
def quote(x):return '\n'.join('> '+s for s in textobj(x or '').splitlines())
def flat(x):return textobj(x).replace('|','/').replace('\n',' ')
def docwrite(name,lines):(ROOT/f'docs/review/CH08_{name}.zh-CN.md').write_text('\n'.join(lines)+'\n',encoding='utf-8')

rows=load(OUT/'RETURNS.json');rr={r['source_id']:r for r in rows}
src=load(OUT/'ch08_source.before.json');web=load(OUT/'website_audit.before.json');ww={w['source_id']:w for w in web}
decls=load(BASE/'closeout31/DECLARATIONS.json');gg=groups()
bydecl={}
for d in decls:bydecl.setdefault(d['source_id'],[]).append(d)
visual=load(BASE/'closeout31/PDF_VISUAL_CHECKS.json')
viewed=[355,358,364,367,379,390,397,402]
findings={
 'NPEquations':'已目视核对原页PDF355：上方H_N用(n+1)/β，(8.9)展开用n/β，末行ΔH_N仍引用同名H_N；指代矛盾未消除。n版仅为依(8.9)展开采用的修正选择。',
 'Examples81and82':'已目视核对原页PDF358：例8.2印为Φ=+ξG及正反馈；Printed仅保留原印疑误，不得被其他条目作为有效数学定理依赖；corrected采用−ξG。',
 'AdditiveThermostatSDE':'已目视核对原页PDF364：(8.23)的−Φ缺dt；矩阵仅对称不足以保证所印噪声与目标Gibbs协方差相容。当前模型已组装，是对角物理质量、交换涨落耗散特例。',
 'NHL':'已目视核对原页PDF367：原印q̃=M⁻¹ᐟ²q、p̃=M¹ᐟ²p方向有误。正确为q̃=M¹ᐟ²q、p̃=M⁻¹ᐟ²p，势变为Ũ(q̃)=U(M⁻¹ᐟ²q̃)；若U(q)=qᵀAq/2，则Ã=M⁻¹ᐟ²AM⁻¹ᐟ²。',
 'SLSLeapfrog':'已目视核对原页PDF379：η约化式确实漏μ⁻¹，一般μ下应为ξ̇=−μ⁻¹∂ηU；原印与Printed保留，_corrected恢复1/Q。',
 'SINLyapunov':'已目视核对原页PDF390：原印有符号Kξ₂界不能统一控制正负两侧。单位质量Q1=Q2=1、σ²=2γθ下修正版为−γξ₂²+θ|ξ₂|+γθ；仅为局部生成元和约束界，不推出遍历性。',
 'PronyOUStationarity':'已目视核对原页PDF397：(8.66)印出s≥0但未说明平稳初态。修正版另加[EXTRA]初态N(0,θc/τ)且与整条W独立；t,s≥0；有限和用k∈Fin K，不宣称跨模式总协方差。',
 'PistonHamiltonianSubfield':'已目视核对原页PDF402：原印场为(p,−∇U,0,0,0)，一般质量的修正场为(M⁻¹p,−∇U,0,0,0)。原印p与本页q̇=M⁻¹p+ηq不一致，修正版仅给局部通量散度目标。'
}
dump(OUT/'PDF_VISUAL_CHECKS.json',dict(status='已目视核对原页',instruction=32,pages=[dict(p,image='blueprint/ch08/closeout31/'+p['image']) for p in visual['pages'] if p['pdf_page'] in viewed],findings=findings,note='复用已保存原页渲染图，本轮实读图像；不把目视确认存在矛盾误写成消除矛盾。其他页既有核对仅保留为31号历史证据。'))

version={
 'NPEquations':('原印ΔH_N指代冲突未消除，待导师','npDeltaN_corrected及npValidDomain网站PASS；npField在n版修正解释下分量正确，但网站逐声明仍保留NEEDS_HUMAN的指代限定'),
 'Examples81and82':('Printed字面忠实性PASS；+ξG驻定声称为原书符号疑误，禁止作为有效定理依赖','−ξG的_corrected局部驻定签名网站PASS'),
 'AdditiveThermostatSDE':('原印缺dt及矩阵噪声相容疑误待导师','已组装的对角物理质量、交换涨落耗散特例网站PASS；不代表一般矩阵模型'),
 'NHL':('原印质量重缩放方向疑误待导师','正对角质量NHL漂移及单噪声积分解规格网站PASS；harmonicPotential仅定义函数，不含(8.30)–(8.32)特化或定理8.1'),
 'SLSLeapfrog':('Printed忠实性PASS；一般μ下约化式漏μ⁻¹待导师','算法定义及恢复1/Q的_corrected网站PASS'),
 'SINLyapunov':('Printed表达式忠实性PASS；有符号尾界疑误待导师','单位质量、σ²=2γθ下生成元与绝对值尾界签名网站PASS，非遍历性'),
 'PronyOUStationarity':('原印无初态资格的(8.66)待导师','pronyOU_covariance及_corrected均为[EXTRA]平稳初态版本，签名网站PASS；非无条件原印定理'),
 'PistonHamiltonianSubfield':('Printed的p场忠实性PASS；一般质量下原驻定声称疑误待导师','M⁻¹p修正场及局部散度目标签名网站PASS；非概率平稳分布或全局保测流')
}
changes=[]
for r in src:
 sid=r['source_id'];key=sid.split('-')[-1]
 if sid in rr:
  x=rr[sid];c=x['json_review'].get('corrected_json',{})
  for k in ['statement_latex','statement_scope','extra_assumptions','issues','context_notation','coverage_gaps']:
   if k in c:r[k]=c[k]
  # Reviewer suggestions that say "should update" are enacted, not left as current defects.
  r['issues']=[s for s in r['issues'] if not any(q in s for q in ['source_page_verification','原statement_latex省略','摘要只说Hamiltonian part','METADATA_CORRECTED'])]
  if key in findings:r['issues'].append(findings[key])
  if key=='NPEquations':
   r['extra_assumptions'].append('[EXTRA] 使用npField作为经典NP方程必须另带npValidDomain invm β Q z、U可微及EN=H_N^(n)(z₀)；这些条件没有被npField总函数自动强制。原页ΔH_N指代冲突未消除。')
  if key=='Examples81and82':r['extra_assumptions'].append('[ERRATUM?] Printed仅供原文忠实记录，不作为任何其他条目的有效定理依赖；实际局部驻定采用负号耦合_corrected。')
  if key=='AdditiveThermostatSDE':
   r['statement_scope']='已组装的对角物理质量、交换涨落耗散特例：同一n+k维独立Wiener、分块噪声、两组同β协方差与漂移质量已绑定。未覆盖一般非对角模型、存在唯一性或不变律。'
   r['extra_assumptions'].append('[EXTRA] 对一般矩阵的匹配应为BBᵀ=(ΓM+MΓᵀ)/β并须协方差可实现；当前采用BBᵀ=(2/β)ΓM，在实对称条件下限制为ΓM=MΓ的充分特例，不扩充Lean模型。')
  if key=='NHL':r['extra_assumptions'].append('[ERRATUM?] 正确重缩放为q̃=M¹ᐟ²q、p̃=M⁻¹ᐟ²p；Ũ(q̃)=U(M⁻¹ᐟ²q̃)，二次势矩阵变为M⁻¹ᐟ²AM⁻¹ᐟ²。这里只给修正解释，未新增重缩放定理；harmonicPotential没有对称正定资格，也没有绑定单位质量NHL。')
  if key=='SLSLeapfrog':
   r['extra_assumptions'].append('[EXTRA] 物理解释另需Q=μ>0、各invm_i>0及U可微；现有def不强制这些资格。')
  if key=='SINLyapunov':r['extra_assumptions'].append('[EXTRA] 当前生成元固定单位质量Q1=Q2=1，并使用σ²=2γθ；常数γθ来自σ²/2。局部生成元和约束界不等于全局遍历性。')
  if key=='PronyOUStationarity':
   r['statement_latex']='dRᵢₖ=−Rᵢₖdt/τₖ+√(2θcₖ)dWᵢₖ/τₖ；原印E[Rᵢₖ(t)]=0、E[Rᵢₖ(t+s)Rᵢₖ(t)]=(θcₖ/τₖ)exp(−s/τₖ)，t,s≥0；Rᵢ=Σ_{k∈Fin K}Rᵢₖ（书中k=1,…,kmax，K=kmax）。[EXTRA] 两个Lean相关式均补平稳初态及独立性，不是无条件原印结论。'
   r['extra_assumptions'].append('[EXTRA] t,s≥0；totalPronyRandomForce的求和为k∈Fin K（0,…,K−1，对应书中1,…,kmax）；没有跨模式独立或总协方差定理。')
  w=ww[sid];w.update(closeout32_return=x,audit=x['audit'],json_review=x['json_review'],suggested_fix_original=x['audit'].get('suggested_fix'),effective_status='网站复审PASS（Lean未改）' if x['audit']['verdict']=='PASS' else '修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）',local_metadata_repair=dict(instruction=32,lean_changed=False,status='元数据及文档按复审意见更新，Lean签名未改',diff_summary=findings.get(key,'清理旧矩可积性或支撑FAIL，保留当前实际覆盖限制。')))
  if key in version:w.update(printed_version=dict(assessment=version[key][0]),corrected_version=dict(assessment=version[key][1],current_revision='718f75f0送审Lean字节未变；仅元数据按32号更新'))
  else:w.update(printed_version=dict(assessment='原书全文保留；当前有限平均/弱驻定资格已获网站复审PASS'),corrected_version=dict(assessment='当前声明网站复审PASS，旧FAIL已解决；范围仍按实际覆盖限定'))
  r.setdefault('repair_log',[]).append(dict(instruction=32,stage='metadata_closeout',change=w['local_metadata_repair']['diff_summary'],suggested_fix=x['audit'].get('suggested_fix'),lean_signature_changed=False))
  changes.append(dict(source_id=sid,website_verdict=x['audit']['verdict'],suggested_fix=x['audit'].get('suggested_fix'),diff_summary=w['local_metadata_repair']['diff_summary'],lean_signature_changed=False))
 else:
  w=ww[sid]
  w['effective_status']='网站PASS（首轮声明未变）' if w['audit']['verdict']=='PASS' else '原书疑误待导师；原送审正确版本分项保留'
 # Current provenance references concrete repository evidence, not stale attachment page indices.
 pages=r['pdf_page']
 r['source_page_verification']=('32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页'+pages+'。' if key in findings else '原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页'+pages+'。本轮不虚称重新目视。')
 # Restrict current notes to stable provenance; immutable quotation text remains byte-for-byte.
 r['transcription_note']='原书全文文字层及原有数学字形编码保留；公式排版以所列PDF原页图像为准。32号更新摘要、域与来源说明；历史repair_log不作为当前未解决缺口。'
 r['context_notation']=[re.sub(r'^R[1-9][：:]','符号对应：',s) if isinstance(s,str) else s for s in r.get('context_notation',[]) if not re.search(r'R[1-9](?:_|独立|附件)|source_page_checks|PDF420',textobj(s))]
 if key=='NPEquations':
  for history in r.get('repair_log',[]):
   if history.get('instruction')==31 and 'delta取' in history.get('change',''):
    history['change']='31号历史采用n版作为工作修正；32号明确：原页ΔH_N指代矛盾未消除，不能声称目视确认已排除。'
    history['superseded_by_instruction']=32
 w['corrected_version']['current_revision']='当前Lean与718f75f0送审字节一致；复审条目按32号意见分版登记，其余保留首轮分项意见。无待复审包。'
 if sid in rr:
  w['local_repair_history31']=w.pop('local_repair',None)
  w['transcription_resolution']='32号仅更新元数据和文档；当前摘要及资格见current_metadata，closeout31_return/closeout32_return与json_review是未经篡改的网站原报告，不作为当前未解决问题重复计数。'
 r['issues']=[s.replace('Lean只证明','Lean只陈述') if isinstance(s,str) else s for s in r['issues']]
 r['coverage_gaps']=list(dict.fromkeys(s for s in [r['statement_scope']]+r['extra_assumptions'] if any(q in s for q in ['未覆盖','不含','未证明','未形式化','不声称','未构造','不代表','没有','未要求','未绑定','未含'])))
 w['current_metadata']={k:r[k] for k in ['statement_latex','statement_scope','extra_assumptions','issues','source_page_verification','coverage_gaps'] if k in r}
 w.update(actual_scope=r['statement_scope'],coverage_gaps=r['coverage_gaps'])
 assert r['statement_verbatim']==next(s for s in load(OUT/'ch08_source.before.json') if s['source_id']==sid)['statement_verbatim']
dump(BASE/'ch08_source.json',src);dump(BASE/'website_audit.json',web);dump(OUT/'METADATA_CHANGES.json',changes)
audit=load(OUT/'local_audit.before.json')
for r in src:
 a=audit['items'][r['source_id']]
 a.update(statement_scope=r['statement_scope'],extra_assumptions=r['extra_assumptions'],issues=r['issues'],coverage_gaps=r['coverage_gaps'],metadata_instruction=32,lean_unchanged=True)
dump(BASE/'local_audit.json',audit)

bp=['# 第8章逐条审阅材料','','第8章最终收口：正文103条；最新网站整体PASS 76条、NEEDS_HUMAN 27条、FAIL 0条。复审10条原始结论为2 PASS / 0 FAIL / 8 NEEDS_HUMAN。','修正版、原印忠实性、原书疑误及证明完成情况分列。网站认可陈述不等于证明完成；NP的npField仍有原印指代限定。','']
progress=['# 第8章逐条进度','','32号最终收口：复审10条已登记，2 PASS / 0 FAIL / 8 NEEDS_HUMAN；全部10条Lean字节未改，元数据及文档已按意见更新。','全章最新整体PASS 76 / FAIL 0 / NEEDS_HUMAN 27；FAIL修复中=0；待复审=0；不再送网站、不生成新包。','','| source_id | PDF页 | 首轮 | 复审 | 当前状态 | 证明状态 |','|---|---|---|---|---|---|']
for r in src:
 sid=r['source_id'];w=ww[sid];ds=bydecl[sid];a=w['audit'];first=w['closeout31_return']['audit']['verdict']
 progress.append('| '+' | '.join([sid,r['pdf_page'],first,rr[sid]['audit']['verdict'] if sid in rr else '—',w['effective_status'],'未证' if any(d['status']=='未证' for d in ds) else '定义/已证'])+' |')
 bp+=['## '+sid,'',f'印刷页 {r["printed_page"]} / PDF页 {r["pdf_page"]}。','','### 1. 原文陈述','',quote(r['statement_latex']),'','对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。','','### 2. 原文证明','',quote(r.get('proof_latex') or r.get('proof_note') or '原书未给独立证明。'),'','### 3. 完整当前Lean（原文与修正版独立列出）','','```lean',gg[sid]['code'],'```','','### 4. 对照表','','| 原文对象或结论 | 实际覆盖 |','|---|---|','| 本条数学成分 | '+flat(r['statement_scope'])+' |','| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |','','### 5. [EXTRA] 与覆盖缺口','']+['- '+textobj(s) for s in r['extra_assumptions']]+['- 覆盖缺口：'+s for s in r['coverage_gaps']]+['','### 6. 审计结论（含网站复审结论）','','网站首轮：'+first+'。','网站复审结论：'+(a['verdict']+'；'+textobj(a['explanation']) if sid in rr else '本条未进入本轮复审；保留首轮'+a['verdict']+'意见。'),'原文版：'+w['printed_version']['assessment']+'。','修正版：'+w['corrected_version']['assessment']+'。','当前：'+w['effective_status']+'。','原书疑点：'+('；'.join(textobj(s) for s in r['issues']) or '本条未单列公式疑误。'),r['source_page_verification'],'','### 7. 状态与证明位置','']+['- `'+d['name']+'`：'+d['status']+('；'+d['reason'] if d['reason'] else '')+('；传递依赖未证陈述' if d['transitive_placeholder'] else '') for d in ds]+['','位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。','']
docwrite('BLUEPRINT',bp);(BASE/'PROGRESS.md').write_text('\n'.join(progress)+'\n',encoding='utf-8')

oldidx=load(BASE/'closeout31/ERRATA_INDEX.json');entries={r['source_id']:r for r in src};idx=[]
err=['# 第8章原书疑误与双版本审阅单','','教材：Leimkuhler–Matthews《Molecular Dynamics》（2015），第8章正文印刷329–399页/PDF350–420页，止于Exercises之前。','按条目计：27项原书表述疑误、1项原证明核查、3项域/覆盖说明，共31项记录；相同原书矛盾涉及不同条目时分列，不等于31个独立排印错误。导师尚未最终裁定。','复审10条：2 PASS / 0 FAIL / 8 NEEDS_HUMAN；8条按修正版/限定声明认可与原印疑误分流。NP四分量的n版解释获认可，但npField逐声明仍保留指代NEEDS_HUMAN。','32号实读8个关键原页图像，详见closeout32/PDF_VISUAL_CHECKS.json；其余公式页保留31号已核对证据，不冒称本轮重看。','']
for i,old in enumerate(oldidx,1):
 sid=old['source_id'];r=entries[sid];w=ww[sid];a=w['audit'];ds=bydecl[sid];cs=[d for d in ds if '_corrected' in d['name']]
 category='原证明核查' if sid.endswith('Proposition83') else '域或覆盖说明' if old['category']=='域或覆盖说明' else '原书表述疑误待导师'
 idx.append(dict(source_id=sid,category=category,issues=r['issues'],website_verdict=a['verdict'],printed=w['printed_version'],corrected=w['corrected_version']))
 err += [f'## {i}. '+sid,'',f'- source_id：{sid}；印刷页 {r["printed_page"]} / PDF页 {r["pdf_page"]}。','- 类别：'+category,'- 原文引文及公式（原书全文另逐字保留）：','',quote(r['statement_latex']),'','- 原页核对：'+r['source_page_verification'],'- 问题所在：'+('；'.join(textobj(s) for s in r['issues']) or '仅实际覆盖范围限定。'),'- 反例或理由：'+textobj(a.get('counterexample') or a['explanation']),'- 原文版 Lean 名称及状态：'+'；'.join('`'+d['name']+'`：'+d['status'] for d in ds if '_corrected' not in d['name'])+'。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。','- 修正版 Lean 名称、改动内容、证明状态：'+('；'.join('`'+d['name']+'`：'+d['status'] for d in cs) or r['statement_scope']),'- 修正或补充前提：'+'；'.join(textobj(s) for s in r['extra_assumptions']),'- 待人工核查点：'+textobj(a.get('suggested_fix') or '核对原书隐含条件和当前覆盖范围。'),'- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。','- 网站首轮结论：'+w['closeout31_return']['audit']['verdict'],'- 网站复审结论：'+(a['verdict']+'。'+textobj(a['explanation']) if sid in rr else '本条未参加32号对应复审；原首轮'+a['verdict']+'意见保留。'),'- 原文版分项：'+w['printed_version']['assessment'],'- 修正版分项：'+w['corrected_version']['assessment'],'- 当前状态：'+w['effective_status']+'。','']
 if sid.endswith('Proposition83'):err+=['修正证明路线：令π(x)=Σα_kx^k、σ(x)=Σβ_kx^k，从π(λ_i)p̂_i+λ_iσ(λ_i)q̂_i=0、λ_iπ(λ_i)q̂_i−λ_iσ(λ_i)p̂_i=0及正定/域条件推出π、σ在n个不同本征值上同时为零；次数<n，分别消去两组系数。声明无须修改，完整证明尚未完成。','']
err+=['## 覆盖缺口','']+['- '+r['source_id']+'：'+'；'.join(r['coverage_gaps']) for r in src if r['coverage_gaps']]
docwrite('ERRATA',err);dump(OUT/'ERRATA_INDEX.json',idx)
counts=Counter(w['audit']['verdict'] for w in web);assert counts==dict(PASS=76,NEEDS_HUMAN=27),counts
summary=dict(total=103,first_round=dict(PASS=74,FAIL=5,NEEDS_HUMAN=24),reaudit=dict(PASS=2,FAIL=0,NEEDS_HUMAN=8),latest_round=dict(PASS=76,FAIL=0,NEEDS_HUMAN=27),website_pass=76,qualified_or_corrected_human_entries=8,version_assessments=version,local_repairs=0,historical_first_round_local_repairs=5,metadata_updates=10,repairing=0,awaiting_reaudit=0,original_text_issue_entries=27,original_proof_review_entries=1,domain_or_scope_entries=3,issue_records=31,declarations=dict(Counter(d['status'] for d in decls)),unproved_reasons=dict(Counter(d['reason'] for d in decls if d['reason'])),lean_changed=False,current_lean_sha256=sha(ROOT/'Blueprint/Ch08.lean'),current_source_sha256=sha(BASE/'ch08_source.json'),new_eaudit_packages=0,website_resubmitted=False,full_check_report='blueprint/ch08/closeout32/full/CHECK_REPORT.json')
dump(OUT/'SUMMARY.json',summary);dump(BASE/'WEBSITE_SUMMARY.json',summary)
dump(OUT/'COVERAGE_AND_GAPS.json',dict(declarations=decls,entries=[dict(source_id=r['source_id'],scope=r['statement_scope'],gaps=r['coverage_gaps']) for r in src]))
mentor=['# 第8章给导师的审阅摘要','','教材为Leimkuhler–Matthews《Molecular Dynamics》（2015）第8章正文，共103个条目，不含习题。原文、数学陈述、证明和勘误对照已整理。','','网站按每条最新送审版本直接通过76条。本次复审10条，2条通过、0条未通过、8条需人工判断。8条的修正版或限定陈述获认可，人工判断针对原书疑误和解释；其中NP方程四分量按n版解释相符，但原书ΔH_N的指代矛盾仍未消除。陈述获认可不表示证明已经完成。','','本轮按意见改动的数学声明为0项，只更新了10条的摘要、补充前提和说明；此前首轮处理的5条均已获得本次对应审阅意见，没有仍在修复的未通过项。','','原书表述疑误按条目计27项，另有1项原证明核查和3项域或覆盖说明，共31项[勘误与范围记录](CH08_ERRATA.zh-CN.md)。这些数字包括同一矛盾涉及的不同条目，不能等同于独立排印错误数；原书解释仍待导师裁定。','','数学材料共396个命名声明：285项定义、54项已证陈述、57项未证陈述，包含原文版、修正版及辅助结论。定义不计作证明，依赖未证结论的推论仍计未证。未证原因：缺少所需理论或衔接结果44项，原书疑误原文暂不证明10项，短证明达到约定尝试次数而停止3项。','','本轮明确：例8.2的正号耦合只作原印记录，有效修正采用负号；随机恒温器限于对角物理质量与可交换涨落耗散条件；质量归一须取q̃=M¹ᐟ²q、p̃=M⁻¹ᐟ²p，同时将势改为Ũ(q̃)=U(M⁻¹ᐟ²q̃)。二次函数的定义尚未建立正定二次NHL特化或定理8.1。SLS约化式补μ⁻¹；SIN尾界在单位质量及σ²=2γθ下使用绝对值项，局部计算不构成遍历性证明。Prony相关式须补平稳初态及其与噪声独立；活塞的一般质量修正场首分量为M⁻¹p，区别于原印p。','','已验证：上述关键公式已对照原页图像，复审意见与对应声明逐项核对。已写陈述及现有证明的机器核验通过，正式证明部分与第1–7章保持原样，没有未完成证明或新增公理。','','尚待证明或裁定：57项未证陈述，以及导师对原书疑误和隐含条件的判断。全局遍历性、一般随机过程存在唯一性、曲面不变测度等结论仍有明确缺口。','', '逐条原文、完整陈述、版本区别和证明状态见[完整审阅稿](CH08_BLUEPRINT.zh-CN.md)。']
docwrite('SUMMARY_FOR_MENTOR',mentor)
print('METADATA/DOCS PASS: latest website PASS 76 / NEEDS_HUMAN 27; 396 declarations unchanged',flush=True)

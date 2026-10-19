from repair31 import *

def main():
 source=load(BASE/'ch08_source.json');rows=load(OUT/'RETURNS.json');gg=groups();before={s['source_id']:s for s in load(OUT/'ch08_source.before.json')}
 # Apply only the source-review fields, preserving all original page text and
 # append-only provenance; local FAIL repairs take precedence over stale advice.
 for row in rows:
  sid=row['source_id'];r=next(s for s in source if s['source_id']==sid);c=row['json_review'].get('corrected_json')
  if not isinstance(c,dict):continue
  for field in ['transcription_note','source_page_verification','statement_latex']:
   if field in c:r[field]=c[field]
  for field in ['context_notation','extra_assumptions','issues']:
   for value in c.get(field,[]):
    if not isinstance(value,str):value=json.dumps(value,ensure_ascii=False)
    if value not in r[field]:r[field].append(value)
  if row['audit']['verdict']=='PASS' and c.get('statement_scope')!=before[sid].get('statement_scope') and 'statement_scope' in c:
   r['statement_scope']=c['statement_scope']
  r['repair_log'].append(dict(instruction=31,stage='json_review',status=row['json_review']['status'],issue_codes=row['json_review'].get('issue_codes',[]),change='合并经原页和现有签名核对的元数据更正；原页全文未改。'))
 repairs=[]
 for row in rows:
  if row['audit']['verdict']!='NEEDS_HUMAN':continue
  sid=row['source_id'];key=sid.split('-')[-1];r=next(s for s in source if s['source_id']==sid);old=gg[sid]['code'];new=old;notes=[]
  if key=='NPEquations':
   prefix='''/- 修正版采用(8.9)展开中的n/β版本，区别于前文(n+1)/β的同名H_N。 -/
def npDeltaN_corrected (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (z : Phase n × (ℝ × ℝ)) : ℝ :=
  kineticTwice invm z.1.2/(2*z.2.1^2) + z.2.2^2/(2*Q) + U z.1.1 +
    (n : ℝ)/β*Real.log z.2.1 - EN

def npValidDomain (invm : Vec n) (β Q : ℝ) (z : Phase n × (ℝ × ℝ)) : Prop :=
  (∀ i, 0 < invm i) ∧ 0 < β ∧ 0 < Q ∧ 0 < z.2.1

'''
   new=prefix+new.replace('let delta := kineticTwice invm z.1.2/(2*s^2) + π^2/(2*Q) + U z.1.1 + (n : ℝ)/β*Real.log s - EN','let delta := npDeltaN_corrected invm U β Q EN z')
   r['statement_scope']='NP四漂移分量、n/β版本的命名能量差及正质量、β,Q,s>0有效域谓词；npField仍为总函数，未证明Hamilton方程。'
   notes=['已目视核对原页PDF355：delta取H_N^(n)−E_N，不能与上式(n+1)/β版本混同。','[EXTRA] npValidDomain明确列有效物理域；使用npField作NP方程时必须另具此资格，总函数自身不强制。']
  elif key=='SLSLeapfrog':
   new+='''

/-- 原印η约化方程，ξ导数未含μ⁻¹；保留原书字面式。 -/
def slsReducedPrinted (invm : Vec n) (U : Vec n → ℝ) (q0 p : Vec n)
    (z : ℝ × ℝ) : ℝ × ℝ :=
  (z.2, -deriv (fun η : ℝ ↦ U (q0+η • (fun i ↦ invm i*p i))) z.1)

/-- 修正版：恢复热浴质量因子1/Q，对应(8.36)的η方向导数。 -/
def slsReduced_corrected (invm : Vec n) (U : Vec n → ℝ) (q0 p : Vec n)
    (Q : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  (z.2, -deriv (fun η : ℝ ↦ U (q0+η • (fun i ↦ invm i*p i))) z.1/Q)'''
   notes=['已目视核对原页PDF379：η约化式的ξ导数漏μ⁻¹，新增Printed与恢复1/Q的_corrected；Q>0、正质量与U可微为物理域。分裂映射原有定义未改。']
   r['statement_scope']='原有半kick–drift–半kick与坐标场定义，另列原印η约化场和恢复1/Q的修正版；体积保持、误差阶及η变换推导未证明。'
  elif key=='SINLyapunov':
   new+='''

/-- 原页带有符号的线性尾项，只保留其表达式。 -/
def sinLyapunovTailPrinted (θ γ C : ℝ) (z : Vec 4) : ℝ :=
  -γ*z 3^2+C*z 3+γ*θ

/-- 修正版：对两侧尾部均适用的绝对值界。 -/
theorem sinLyapunovTail_corrected (θ γ : ℝ) (hθ : 0 < θ) (hγ : 0 < γ)
    (F : ℝ → ℝ) (z : Vec 4) (hz : sinConstraint 1 z=θ) :
    sinGenerator θ γ F (fun x ↦ x 3^2/2) z ≤
      -γ*z 3^2+θ*|z 3|+γ*θ := by
  have hk : sinConstraint 1 z ≠ 0 := by rw [hz]; exact ne_of_gt hθ
  rw [sinGenerator_lyapunov θ γ hθ hγ F z hk]
  have hb := sinConstraint_bathBound θ z hz
  rcases le_total 0 (z 3) with h | h
  · rw [abs_of_nonneg h]
    nlinarith [mul_nonneg (sub_nonneg.mpr hb) h]
  · rw [abs_of_nonpos h]
    nlinarith [mul_nonneg (sq_nonneg (z 2)) (neg_nonneg.mpr h)]'''
   notes=['已目视核对原页PDF390：有符号Cξ₂尾界不能统一控制两侧；工作修正版为−γξ₂²+θ|ξ₂|+γθ。它依赖尚未证明的局部生成元恒等式，不代表遍历性证明。']
   r['statement_scope']='局部生成元恒等式、约束上的热浴界、原印有符号尾项表达式与绝对值尾界修正版；不含遍历性充分性。'
  elif key=='GeneralizedLangevin':
   notes=['已目视核对原页PDF395：colored-noise后的non-Gaussian不是同义解释。有色Gaussian过程存在（如平稳OU）；原句保留，修正说明为“有色性指跨时相关，Gaussian性另定”。此处属文字修正，不引入无关定理。','[EXTRA] generalizedLangevin仅为给定加性驱动B的积分方程，噪声分布、有色性及FD未在本定义内强制，由另条规格给出。']
   r['corrected_prose']='有色噪声可以是Gaussian；有色性与非Gaussian性不互相蕴含。本条仅给定加性驱动的积分方程。'
  elif key=='PronyOUStationarity':
   theorem=old[old.index('theorem pronyOU_covariance '):old.index('def totalPronyRandomForce')].strip()
   theorem=theorem.replace('theorem pronyOU_covariance ', 'theorem pronyOU_covariance_corrected ').replace(':= by\n  sorry',':= pronyOU_covariance P W R c τ θ hR t s ht hs')
   new+='\n\n/-- 修正版显式使用已定义的平稳Gaussian初态及与W独立资格；原印未写该前提。 -/\n'+theorem
   notes=['已目视核对原页PDF397：(8.66)未声明平稳初态；保留原句，_corrected明确引用stationaryPronyOU的Gaussian初态和整条W独立性。总随机力只定义有限和，未证跨模式独立或总协方差。']
  elif key=='PistonHamiltonianSubfield':
   new+='''

/-- 原印Hamiltonian子场：第一分量为p，忠实保留其一般质量疑误。 -/
def pistonHamiltonianPartPrinted (U : Vec n × ℝ → ℝ)
    (z : PistonState n) : PistonState n :=
  ((z.1.2,-gradient (fun q ↦ U (q,z.2 0)) z.1.1),0)

/-- 修正版第一分量为M⁻¹p；现有驻定目标已采用此场。 -/
def pistonHamiltonianPart_corrected (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (z : PistonState n) : PistonState n := pistonHamiltonianPart invm U z'''
   notes=['已目视核对原页PDF402：文字子场印为(p,−∇U,0,0,0)，一般质量应为(M⁻¹p,−∇U,0,0,0)或另限单位质量。旧pistonHamiltonianPart及其驻定目标属于合理修正，新增Printed与_corrected明确区分。']
   r['statement_scope']='原印p子场、M⁻¹p修正子场及修正子场光滑复合权的局部驻定目标；不把修正场说成逐字原印场。'
  elif key=='AndersenHamiltonianPrinted':
   notes=['[EXTRA] andersenMarginal_corrected仅是除以参数Z的权重，不声称自动归一。若作概率密度，须在相同坐标和V>0域上可积，且Z为相同权重的正有限配分积分；任意Z>0不足。']
  elif key=='IsokineticDivergencePrinted':
   notes=['已目视核对原页PDF383–384：散度与∇w·f等式须同时改负号，w=(n−1)U/K的正号保留。']
  elif key=='SINThirdBracketPrinted':
   notes=['_corrected只修正(8.54)在p=0的内部代数特化，不能据此声称Printed长式等于真实三重括号。']
  elif key=='SINProjectedBracketsPrinted':
   notes=['已目视核对原页PDF388：(8.49)–(8.53)及“any pair”/平行论据需导师核查；修正版仅以完整四维真实括号再投影为准，不把改下标当作长式校正。']
  elif key=='Theorem81':
   notes=['[EXTRA] 当前_corrected为σ独立非零的括号结论；如解释为物理NHL，还须σ²=2γθ/Q。未推到全局遍历性。']
  elif key=='DPDPairOUUpdate':
   notes=['[EXTRA] 零率分支仅用于涨落耗散使噪声同时退化的情形；不用于任意独立非零扩散的零漂移OU。物理转移需正约化质量、正温度、a,t≥0及独立标准正态R。']
  for note in notes:
   if note not in r['extra_assumptions']:r['extra_assumptions'].append(note)
   if '已目视' in note and 'issues' not in note and note not in r['issues']:r['issues'].append(note)
  r['repair_log'].append(dict(instruction=31,stage='human_triage',change='；'.join(notes) or '原印忠实、原书真值与正确限定版分开登记，签名不变。',suggested_fix=row['audit']['suggested_fix']))
  r['lean_declarations']=['MD.Ch08.'+n for n in re.findall(r'(?m)^(?:noncomputable )?(?:def|abbrev|theorem|lemma|structure)\s+(\w+)',new)]
  repairs.append(dict(source_id=sid,signature_changed=new!=old,notes=notes,website_explanation=row['audit']['explanation']))
  gg[sid]['code']=new
 # Metadata-only clarifications do not change accepted PASS declaration bodies.
 text=LEAN.read_text(encoding='utf-8')
 for r in reversed(source):text=replace_group(text,r['source_id'],gg[r['source_id']]['code'],r)
 LEAN.write_text(text,encoding='utf-8');dump(BASE/'ch08_source.json',source);dump(OUT/'HUMAN_REPAIRS.json',repairs)
 compiler=LeanCompiler()
 try:check(compiler,'HUMAN-AND-METADATA')
 finally:compiler.close()
 print('HUMAN TRIAGED',len(repairs),'changed',sum(r['signature_changed'] for r in repairs),flush=True)

if __name__=='__main__':main()

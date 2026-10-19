from common31 import *
import difflib
from lsp31 import LeanCompiler

def replace_group(text,sid,code,record):
 g=groups(text)[sid]
 head='/-- source_id: '+sid+' · 印刷p.'+record['printed_page']+' / PDFp.'+record['pdf_page']
 head+='\n[SCOPE] '+record['statement_scope']
 head+=''.join('\n[EXTRA] '+s for s in record['extra_assumptions'])
 head+=''.join('\n[ERRATUM?] '+s for s in record['issues'])+' -/'
 return text[:g['start']]+head+'\n'+code.strip()+'\n\n'+text[g['end']:]

def check(compiler,label):
 text=LEAN.read_text(encoding='utf-8')
 names=re.findall(r'(?m)^(?:noncomputable )?(?:def|abbrev|theorem|lemma|structure)\s+(\w+)',text)
 content=text+'\n'+'\n'.join('#print axioms MD.Ch08.'+n for n in names)+'\n'
 p=OUT/'compiled'/(label+'.lean');p.write_text(content,encoding='utf-8')
 r=compiler.check(content,label,p)
 assert r['exit_code']==0,label
 return r

def main():
 source=load(BASE/'ch08_source.json');returns=load(OUT/'RETURNS.json')
 compiler=LeanCompiler();repairs=[]
 try:
  for row in returns:
   if row['audit']['verdict']!='FAIL':continue
   sid=row['source_id'];key=sid.split('-')[-1];r=next(s for s in source if s['source_id']==sid)
   text=LEAN.read_text(encoding='utf-8');old=groups(text)[sid]['code'];new=old
   if key=='Examples81and82':
    new=new.replace('theorem generalizedFeedback_stationary ', '/-- 原文正号组合的驻定声称；原书疑误，保留字面版，不作为有效定理。 -/\ntheorem generalizedFeedback_stationaryPrinted ')
    corrected=old[old.index('theorem generalizedFeedback_stationary '):].replace('generalizedFeedback_stationary ', 'generalizedFeedback_stationary_corrected ').replace('gradient H z.1 + z.2 • G z.1','gradient H z.1 - z.2 • G z.1')
    new+='\n\n/-- 修正版：仅将耦合改为负号，反馈保留原式；原文例8.2另存。 -/\n'+corrected
    r['issues'].append('已目视核对原页PDF358–359：例8.2确实印为正号耦合与正反馈，驻定声称有符号疑误，不是转录错误。')
    r['statement_scope']='原印一般G与构型反馈、正号组合Printed驻定声称，以及负号耦合的局部驻定修正版；不含全局过程不变性。'
    note='generalizedFeedback/configurationalFeedback忠实保留原式；corrected将Φ改为−ξG。构型反馈在正号耦合下同样须反号。'
   elif key=='AdditiveThermostatSDE':
    new+='''

/-- 两组噪声共用一个n+k维独立Wiener过程，分块只作用于p和ξ。 -/
def thermostatBlockNoise {k : ℕ}
    (B : Matrix (Fin n) (Fin n) ℝ) (Bhat : Matrix (Fin k) (Fin k) ℝ)
    (j : Fin (n+k)) : Phase n × Vec k :=
  if hj : j.val < n then
    ((0,fun i ↦ B i ⟨j.val,hj⟩),0)
  else ((0,0),fun i ↦ Bhat i ⟨j.val-n,by omega⟩)

/-- 正对角物理质量特例的统一积分解规格；两组协方差与实际漂移使用同一质量。
不含一般非对角物理质量，也不声称由此已证明存在、唯一或不变分布。 -/
def stochasticThermostatSolution {k : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → Vec (n+k)) (X : ℝ → Ω → Phase n × Vec k)
    (x0 : Phase n × Vec k) (invm : Vec n) (U : Vec n → ℝ)
    (Φ : Phase n × Vec k → Vec n) (g : Phase n × Vec k → Vec k)
    (Γ B : Matrix (Fin n) (Fin n) ℝ)
    (Mhat Γhat Bhat : Matrix (Fin k) (Fin k) ℝ) (β : ℝ) : Prop :=
  (∀ i, 0 < invm i) ∧ ContDiff ℝ 1 U ∧
  fluctuationDissipation (Matrix.diagonal (fun i ↦ (invm i)⁻¹)) Γ B β ∧
  fluctuationDissipation Mhat Γhat Bhat β ∧
  additiveSDE P (n+k) W X x0 (stochasticThermostatDrift invm U Φ g Γ Γhat)
    (thermostatBlockNoise B Bhat)'''
    r['statement_scope']='常噪声积分SDE模板与正对角物理质量的统一恒温器解规格；同一n+k维独立Wiener、分块噪声、两组协方差和漂移质量已绑定。未含一般非对角物理质量、存在唯一性或不变律。'
    r['issues'].append('已目视核对原页PDF364：(8.23)的−Φ项确实漏dt；漂移解释补dt。矩阵不交换时原平方根噪声与驻定协方差未必相容。')
    note='[EXTRA] 正逆质量、C¹势；物理质量固定为diag(invm⁻¹)，Mhat为热浴协方差质量；两组涨落耗散均绑定同一β及实际阻尼。未构造矩阵平方根，未证明确定性热浴保权或完整过程不变性。'
   elif key=='NHL':
    r['statement_scope']='仅正对角质量、无约束Nd=n的NHL漂移与单ξ噪声积分解规格；harmonicPotential仅定义二次函数。一般矩阵质量、单位质量二次专门化声明及原书重缩放均未覆盖。'
    note='[EXTRA/覆盖缺口] invm_i,β,Q,γ均正；不宣称覆盖一般M或已把isNHLSolution特化到正定二次势(8.30)–(8.32)。原印重缩放疑误另列。'
    r['issues'].append('已目视核对原页PDF367：原印q̃=M⁻¹ᐟ²q、p̃=M¹ᐟ²p不产生单位质量方程；正确方向相反并须同步变换势。')
   elif key=='PreEquilibriumMeans':
    new=new.replace('def preEquilibriumDensity (ρ', 'def preEquilibriumDensity (invm : Vec n) (ρ').replace('  ∀ t, 0 ≤ t → probabilityDensity volume (ρ t)', '''  (∀ i, 0 < invm i) ∧ ∀ t, 0 ≤ t →
    probabilityDensity volume (ρ t) ∧
    Integrable (fun z : Phase n × ℝ ↦ kineticTwice invm z.1.2 * ρ t z) volume ∧
    Integrable (fun z : Phase n × ℝ ↦ z.2 * ρ t z) volume''')
    r['statement_scope']='任意随时间概率密度的两项有限平均与正质量、加权可积资格；preEquilibriumDensity仅是历史名称，未要求或覆盖NHL Fokker–Planck演化、闭合方程及局部稳定性。'
    note='[EXTRA] 每个t≥0同时要求两项加权函数Integrable，故均值不是不可积时的总化积分。NHL Fokker–Planck演化未形式化，名称不代表完整预平衡动力学资格。'
   elif key=='RescalingStationary':
    new=new.replace('∀ z ∈ Function.support f, z.2 ≠ 0','∀ z ∈ tsupport f, z.2 ≠ 0')
    r['statement_scope']='闭包支撑tsupport避开零动量的光滑紧支撑测试函数弱驻定目标；零动量边界及半群不变性未覆盖。'
    note='havoid现对tsupport f量化，与HasCompactSupport的闭包支撑一致；未扩大到闭包接触p=0的测试函数。'
   else:raise AssertionError(key)
   r['extra_assumptions'].append(note)
   r['repair_log'].append(dict(instruction=31,website_verdict='FAIL',suggested_fix=row['audit']['suggested_fix'],change=note))
   r['lean_declarations']=['MD.Ch08.'+n for n in re.findall(r'(?m)^(?:noncomputable )?(?:def|abbrev|theorem|lemma|structure)\s+(\w+)',new)]
   LEAN.write_text(replace_group(text,sid,new,r),encoding='utf-8');dump(BASE/'ch08_source.json',source)
   (OUT/(key+'.diff')).write_text(''.join(difflib.unified_diff(old.splitlines(True),new.splitlines(True),fromfile='first-round',tofile='repaired')),encoding='utf-8')
   receipt=check(compiler,key)
   repairs.append(dict(source_id=sid,signature_changed=new!=old,change=note,suggested_fix=row['audit']['suggested_fix'],receipt=key,compile='PASS',axioms='PASS'))
   dump(OUT/'REPAIRS.json',repairs);print('REPAIRED',key,flush=True)
 finally:compiler.close()

if __name__=='__main__':main()

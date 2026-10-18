from common25 import *
from repair25 import replace_group,check
import difflib

EXCERPT_KEYS={'IndependentPartition','StationaryInvariant','LangevinCanonicalMixing','Definition61','LangevinHormander','LangevinTransitionDensity','Lemma61Nonempty','LangevinGeometricErgodicity','LangevinTimeAverage','WeightedH1','Proposition64Printed','Proposition64Relative'}
MISSING_CORRECTED={'BathTaylor','CanonicalCDFPrinted','FiniteDomainPrinted','PartitionInversePrinted','Proposition62','DiffusiveTaylorPrinted','BathReductionPrinted','FPPolynomialAdjoint','SmoothTestL2Printed'}
SCOPE_KEYS={'Proposition61','RiemannTags','SelfStratonovichIntegral','MemoryKernelDeltaMeaning','BathForceWeakLimitMeaning','FPEquation','BrownianSymmetry','BrownianRealEigenvalue','BrownianClosedSelfAdjoint','BrownianCompactResolvent','Theorem62','Lemma61Printed','ComplexInitialDensity'}

NOTES={
 'IndependentPartition':'只补regularEnergy的真实定义体；不因未摘录而认定原书有错，不删正则前提。',
 'Proposition61':'所交为显式加强条件的温度恒等式；原证明除以球体积后取极限只给0=0，保留原证明并登记缺口；原下标和体积元依网站原页修订，未认证原论证。',
 'RiemannTags':'原书文字1≤k≤ν与求和0≤k<ν冲突；本条数学修正版统一0≤k<ν，原句保留。',
 'SelfStratonovichIntegral':'仅覆盖真实时间中点和的均方结论；原单步O(√dt)推理未控制总误差，不能当成完整证明；所需Brownian桥残差估计未补建。',
 'MemoryKernelDeltaMeaning':'旧_corrected只加正质量并非有效修复：固定1/k平均使|ψk|≤1，不可能收敛到正质量Dirac。此谓词在当前归一化下不可实现；原启发式与两版资格定义均留存，待确认时间/振幅重标度及单边边界因子；不把资格定义计成极限定理。',
 'BathForceWeakLimitMeaning':'两版补概率空间与连续路径随机变量可测性；Printed是力路径、corrected是正力时间积分；物理标度和极限是否可实现仍待导师，不把弱收敛资格谓词当存在定理。',
 'FPEquation':'补X联合可测和相对W自然历史适应、扩散被积过程的适应平方可积资格；未建立严格网格解到标准适应Itô解的完整桥接，仍未证明。',
 'StationaryInvariant':'补实际Chapter06Review.invariantKernel及其kernelEvolution定义体；不以MD.Ch06同名定义替代。',
 'LangevinCanonicalMixing':'补所选真实路径的存在规格和初值/积分方程；范围仅周期、单位质量及已列全局Lipschitz力，不声称一般非周期Langevin结论。',
 'BrownianSymmetry':'本条仅为周期光滑核心上的形式对称配对；核心对称不推出伴随域相等。闭实现自伴另见BrownianClosedSelfAdjoint，原C₀²域解释待签核。',
 'BrownianRealEigenvalue':'[ERRATUM?]原引文negative definite应为半负定，常数零模反例与BrownianNegativeDefinitePrinted共用；本条只证明已给实特征参数≤0，不冒称全部复谱实性。',
 'BrownianClosedSelfAdjoint':'明确采用周期紧环面的Gibbs L²图闭包/最大复图实现；此域修正替换原C₀²核心域，不能把核心上的形式对称当原域自伴，待人工签核。',
 'BrownianCompactResolvent':'仅断言紧torus上的闭实现具有紧预解式；原一般C₀²措辞未覆盖，域与紧配置假设需人工签核。',
 'Theorem62':'主版与corrected补真实半群漂移估计；弱平稳测试限真实右导数且有局部可积差商支配，排除derivWithin总定义默认值。Printed保留原有疑误版不证；Harris桥接及统一阈值仍缺大型理论，未声称原全定理已认证。',
 'Definition61':'补textbookIteratedBracket定义体；原含漂移版仅为原书括号秩定义，密度用途必须用噪声起始的抛物型修正版。',
 'LangevinHormander':'scope仅实际Langevin向量场括号rank；密度结论由LangevinTransitionDensity承接，补全部迭代括号定义。',
 'LangevinTransitionDensity':'补actual_path_solution_exists完整存在类型及所选解满足初值/积分方程的规格；不把缺摘录误记原书问题。',
 'Lemma61Printed':'Printed收回单位质量周期相空间，保留包括空集的原全称开集断言及原书疑误；非空修正版独立保留，真实核存在规格补入复审包。',
 'Lemma61Nonempty':'补所选解存在规格；目标开集非空修正保持。',
 'LangevinGeometricErgodicity':'补真实选解规格；可测观察量范围严格为点态多项式权界类，不写成任意仅加权可积函数。',
 'LangevinTimeAverage':'补实际选解存在、真实积分方程、唯一性、限制及同一全时随机过程一致性的完整声明类型；有限窗选择不能仅凭choose名称认定相容。',
 'WeightedH1':'补坐标伴随测试表达式及memLp_two完整规格；明确位置β∂U、动量βp项及分部积分符号，补摘录不算原书勘误。',
 'Proposition64Printed':'保留原flat/Gibbs坐标混用疑误和非Gibbs恒通量反例；补H¹伴随测试表达式，修正版本由Proposition64Relative独立保存。',
 'Proposition64Relative':'补H¹坐标伴随测试表达式与memLp规格；相对Gibbs密度采用闭Hilbert adjoint，唯一模常数，不是flat Gibbs倍数。',
 'ComplexInitialDensity':'仅为给定复L²候选的概率资格辅助定义；本征关系、Reλ<0及平衡态识别须在使用处另列，单一非实模式须共轭配对后再查非负性，不能覆盖任意α的原句。',
}

def main():
 rows=load(OUT/'RETURNS.json');changes=[]
 pending=OUT/'HUMAN_PREPARED.json'
 if not pending.exists():
  text=LEAN.read_text(encoding='utf-8');before=text
  for r in rows:
   if r['audit']['verdict']!='NEEDS_HUMAN':continue
   sid=r['source_id'];key=sid.split('-')[-1];g=groups(text)[sid];code=g['code'];new=code
   note=NOTES.get(key,'原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。')
   if key=='BathForceWeakLimitMeaning':
    new=code.replace('  IsPreBrownianReal', '''  IsProbabilityMeasure P ∧
  (∀ k T, Measurable (forcePaths k T)) ∧ (∀ T, Measurable (wienerPaths T)) ∧
  IsPreBrownianReal''')
   elif key=='FPEquation':
    new=code.replace('  ContDiff ℝ ∞ a →', '''  Measurable (Function.uncurry X) →
  (∀ t, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (X t)) →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun t sample ↦ b (X t sample)) →
  ContDiff ℝ ∞ a →''',1)
   elif key=='Lemma61Printed':
    target=next(g for sid2,g in groups(text).items() if sid2.endswith('-Lemma61Nonempty'))['code']
    new=target.split('/-- 修正版',1)[0].strip().replace('theorem lemma61Nonempty','theorem lemma61Printed',1)
    new=new.replace(' (hCN : C.Nonempty)','')
    new=new.split(' := by',1)[0]+' := by\n  sorry'
   elif key=='Theorem62':
    original=code[:code.index('/-- 【原书疑误】采用印刷Assumption1')]
    printed=code[code.index('/-- 【原书疑误】采用印刷Assumption1'):]
    anchor='    MolecularDynamics.Chapter06Review.assumption1 ν K {x | φ x ≤ threshold α δ} →'
    drift='''    (∀ (t : ℝ≥0) (x : D), Integrable φ (K t x) ∧
      MolecularDynamics.Chapter06Review.kernelAverage K φ t x ≤
        Real.exp (-α*(t : ℝ))*φ x+δ/α) →
'''
    original=original.replace(anchor,drift+anchor)
    test='''        (∀ x, HasDerivWithinAt
          (fun t : ℝ ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x)
          (MolecularDynamics.Chapter06Review.kernelGenerator K f x) (Ici 0) 0) →
        (∃ ε : ℝ, 0 < ε ∧ ∃ bound : D → ℝ, Integrable bound μ ∧
          ∀ t ∈ Ioo (0 : ℝ) ε, ∀ x,
            |(MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x-f x)/t| ≤ bound x) →
'''
    original=original.replace('        Integrable (MolecularDynamics.Chapter06Review.kernelGenerator K f) μ →',test+'        Integrable (MolecularDynamics.Chapter06Review.kernelGenerator K f) μ →')
    new=original+printed
   if new!=code:text=replace_group(text,sid,new)
   m=re.search(r'/-- source_id:\s*'+re.escape(sid)+r'(?=\s|·)[\s\S]*?-/',text)
   text=text[:m.end()-2]+'[EXTRA] 25号：'+note+'\n'+text[m.end()-2:]
   changes.append(dict(source_id=sid,note=note,signature_changed=new!=code,category='摘录缺失' if key in EXCERPT_KEYS or key in MISSING_CORRECTED else '范围/签名需签核' if key in SCOPE_KEYS else '原书疑误'))
  LEAN.write_text(text,encoding='utf-8')
  (OUT/'HUMAN.diff').write_text(''.join(difflib.unified_diff(before.splitlines(True),text.splitlines(True),fromfile='before',tofile='after')),encoding='utf-8')
  dump(pending,changes)
 else:changes=load(pending)
 # Complete current signatures for corrected variants living under another source_id.
 selected={r['source_id'] for r in rows if r['audit']['verdict']=='FAIL'}
 selected.update(r['source_id'] for r in rows if r['audit']['verdict']=='NEEDS_HUMAN' and r['source_id'].split('-')[-1] in EXCERPT_KEYS|MISSING_CORRECTED|SCOPE_KEYS)
 source=load(BASE/'ch06_source.json')
 order=[s['source_id'] for s in source]
 dump(OUT/'REAUDIT_SELECTION.json',dict(source_ids=[s for s in order if s in selected],reason='25 FAIL plus missing project/corrected excerpts and signature/scope qualifications',human_triage=changes))
 receipt=check('HUMAN-final')
 dump(OUT/'HUMAN_REPAIRS.json',dict(items=changes,receipt=receipt))
 print('HUMAN triage complete',len(changes),'reaudit',len(selected),flush=True)
if __name__=='__main__':main()

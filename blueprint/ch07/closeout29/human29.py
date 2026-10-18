from repair29 import *

NOTES={
 'StrongWeakComparison':'仅覆盖α=1、Lipschitz测试类且有相应矩条件的定量蕴涵；一般强弱阶关系需测试类与矩条件，原书措辞待裁定。',
 'PartitionPrinted':'原文Z⁻¹与配分积分的字面断言及反例独立保留；修正版取Z为积分且正有限，已证概率密度归一化。',
 'OUExactUpdate':'只覆盖正确(7.3)和转移随机表示；原页前导乘数exp(−γt)应为exp(−γ(t+h))，文字笔误不影响(7.3)。',
 'SPVPrinted':'Printed保留原页q_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。',
 'SPVLargeFriction':'固定h的大摩擦单步极限及相应代数关系；未声称联合h/γ极限的一致性或完整采样不一致性。',
 'BBKStarMomentSystemPrinted':'保留三条原印矩方程及修正系数；原页混合矩重复ψ因子已目视确认，未从相关噪声过程重新证明整组矩方程。',
 'PerturbedErrorExpansion':'(7.14)作为待证严格双参数渐近目标；不变测度选择、矩与统一余项资格不足，原书此处是形式展开而非已证严格估计。',
 'PerturbedErrorOrders':'固定γ>0时(7.14)的余项足以推出(7.15)阶；γ一致常数或整个误差在γ→∞消失另需控制ε³h²项，不将固定γ和一致γ结论混淆。',
 'GeMarsdenRestriction':'只定义全部光滑第一积分全局依赖H、任意时间重参数和辛保能蕴涵目标；未连结精确哈密顿流、非退化时间变换及定理适用域，未声明Ge–Marsden定理已形式化。',
 'StationaryModifiedPDE':'仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。',
 'SpectralQualification':'Printed的simpleEigenvalue仅几何单重；修正版是较弱点谱目标并补零核方向唯一，不含完整谱、孤立性或有限代数重数，绝非紧预解式谱定理。',
 'PerturbativeSolvabilityCaution':'仅rhs属于线性映射值域的目标定义；没有ρf结构、零质量相容性、闭生成元域或半群/谱隙，原文预期不作定理。',
 'TripleCommutatorPrinted':'字面式忠实保留缺β；单位质量修正版和实际双交换子恒等式独立，数值系数反例只是代数反例，网站给四次势的数学反例另记。',
 'ConjugateSymmetricCorrections':'两条候选修正函数关系、给定二阶传递系数后的代数消项、原印展开及二阶截断修正版；不含真实分裂不变分布传递、L1ρ或实际误差系数识别。',
 'OUKernelQualification':'原印裸前向OU核为常数的错误命题保留；修正版为Gibbs共轭及动量Gaussian L²中的核刻画，中心化推论另加概率及零均值。',
 'FirstReciprocalCorrection':'一阶候选及PDE、条件Gaussian平均和原印联合归一密度的动量积分；二者不是同一算子；f2,2、(7.35)/(7.36)通量与可解性未覆盖。',
 'OverdampedSolvabilityOperators':'M/N和候选函数定义以及β≠0下代数改写；Gibbs共轭与裸前向算子区分，未含平均识别、相容性、核唯一或零均值结论。',
 'LimitMethodAccuracy':'瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。',
 'ConstrainedLangevin':'原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。',
 'ConstrainedCanonicalErgodicity':'delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。',
 'HyperbolicPhaseTransform':'仅实η≠0、|h/η|<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。',
 'UnderdampedPhasePrinted':'字面三角式及+arctan修正版、任意实a/r的恒等式；模型代入须0≤γ<2Ω及ηhat>0，未由此声称全稳定定理。',
 'FrictionThresholdPrinted':'字面错误阈值、保留隐式条件的修正版、Ω≥1有理化/渐近/包络充分性；简化成γ区间须保留高根上界，数值反例不是完整Lean势模型反例。',
 'HamiltonianSamplingObstruction':'保能流、子水平集不变和非平凡能量分布的保测概率资格定义；非遍历性及Liouvillian谱隙/多稳态定理未覆盖，不排除固定能壳遍历。',
}

def process(row):
 sid=row['source_id'];key=sid.split('-')[-1];text=LEAN.read_text(encoding='utf-8');old=groups(text)[sid]['code'];new=old
 if key=='SpectralQualification':
  pos=new.index('def spectralConclusionPrinted_corrected')
  new=new[:pos]+new[pos:].replace('  ρ ≠ 0 ∧ L ρ = 0 ∧ ∀ eigen : ℂ,','  ρ ≠ 0 ∧ L ρ = 0 ∧\n  (∀ v : E, L v = 0 → v ∈ Submodule.span ℂ ({ρ} : Set E)) ∧\n  ∀ eigen : ℂ,',1)
 if key=='SPVPrinted':
  new+='''

/-- 两个总化映射的物理适用域；γ=0另需定义η=h，此处不含该延拓。 -/
def spvQualification (m : V n) (γ θ h : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ 0 ≤ h
'''
 if key=='OUKernelQualification':
  new+='''

theorem ouKernelCentered_corrected (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ)
    (hβ : 0 < β) (hf : ContDiff ℝ ⊤ f)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hi : Integrable f (productGibbs (fun _ ↦ 1) U β))
    (hL2 : ∀ q, MemLp (fun p ↦ f (q,p)) 2 (momentumGibbs (fun _ ↦ 1) β))
    (hzero : phaseO (fun _ ↦ 1) 1 β (gibbsWeight (fun _ ↦ 1) U β*f) = 0)
    (hmean : ∫ x, f x ∂productGibbs (fun _ ↦ 1) U β = 0) :
    ∃ ν : V n → ℝ, (∀ q p, f (q,p)=ν q) ∧
      Integrable ν (positionGibbs U β) ∧ (∫ q, ν q ∂positionGibbs U β)=0 := by
  sorry'''
 if key=='FirstReciprocalCorrection':
  new=new.replace('  ∫ p, f (q,p)*gibbsWeight (fun _ ↦ 1) U β (q,p)',
    '  ∫ p, f (q,p)*(gibbsWeight (fun _ ↦ 1) U β (q,p)/\n    (∫ x : Phase n, gibbsWeight (fun _ ↦ 1) U β x))')
  new+='''

def conjugatedPhaseH (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ) (x : Phase n) : ℝ :=
  phaseH U (gibbsWeight (fun _ ↦ 1) U β*f) x/gibbsWeight (fun _ ↦ 1) U β x

def jointGibbsQualification (U : V n → ℝ) (β : ℝ) : Prop :=
  0 < β ∧ Integrable (gibbsWeight (fun _ ↦ 1) U β) volume ∧
  0 < ∫ x : Phase n, gibbsWeight (fun _ ↦ 1) U β x
'''
 if key=='LimitMethodAccuracy':
  new+='''

def limitAccuracyInfiniteTime_corrected (error : ℝ → ℝ → ℝ) (longtime : ℝ → ℝ) : Prop :=
  (∀ h, 0 < h → Tendsto (fun T ↦ error (h^2/2) T) atTop (𝓝 (longtime h))) ∧
  limitAccuracyPrinted_corrected longtime
'''
 if key=='ConstrainedLangevin':
  new+='''

/-- 限制到单位质量、常正交投影的线性约束修正版；未声称一般非线性情形。 -/
def constrainedLangevin_corrected {l : ℕ} (P : Measure Ω) (C : Matrix (Fin l) (Fin n) ℝ)
    (proj : Matrix (Fin n) (Fin n) ℝ) (U : V n → ℝ) (γ θ : ℝ)
    (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n) (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 U ∧
  proj*proj=proj ∧ proj.transpose=proj ∧ C*proj=0 ∧
  (∀ v : V n, C *ᵥ v=0 → proj *ᵥ v=v) ∧
  C *ᵥ x0.1=0 ∧ C *ᵥ x0.2=0 ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  (∀ sample i T, 0 ≤ T →
    IntervalIntegrable (fun s ↦ (X s sample).2 i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -(proj *ᵥ gradient U (X s sample).1) i-γ*(X s sample).2 i) volume 0 T) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    C *ᵥ (X t sample).1=0 ∧ C *ᵥ (X t sample).2=0 ∧
    (∀ i, (X t sample).1 i=x0.1 i+∫ s in (0 : ℝ)..t, (X s sample).2 i) ∧
    ∀ i, (X t sample).2 i=x0.2 i+
      (∫ s in (0 : ℝ)..t, -(proj *ᵥ gradient U (X s sample).1) i-γ*(X s sample).2 i)+
      Real.sqrt (2*γ*θ)*(proj *ᵥ (W t sample-W 0 sample)) i
'''
 if key=='ConstrainedCanonicalErgodicity':
  new+='''

def constrainedCanonicalQualification {l : ℕ} (ν : Measure (Phase n))
    (m : V n) (g : V n → V l) (U : V n → ℝ) (β : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < β ∧ ContDiff ℝ 2 g ∧ constrainedReference ν m g ∧
  Integrable (gibbsWeight m U β) ν ∧ (0 < ∫ x, gibbsWeight m U β x ∂ν)
'''
 source=load(BASE/'ch07_source.json');r=next(x for x in source if x['source_id']==sid)
 extra=[x for x in r['extra_assumptions'] if not (key=='PerturbedErrorOrders' and '余项' in x)]
 extra.append('29号覆盖限定：'+NOTES[key]);issues=list(r['issues'])
 if key=='OUExactUpdate':issues.append('已目视核对原页PDF289：前导乘数印作exp(−γt)，应为exp(−γ(t+h))；(7.3)与当前更新公式正确，不改。')
 if key=='SymmetricRHS':issues.append('Fredholm充分性缺少空间、域及相容资格。')
 r.update(statement_scope=NOTES[key],extra_assumptions=extra,issues=issues,
  lean_declarations=['MD.Ch07.'+n for n in re.findall(r'(?m)^(?:def|theorem|lemma|abbrev)\s+(\w+)',new)])
 r['repair_log'].append(dict(instruction=29,website_verdict='NEEDS_HUMAN',suggested_fix=row['audit']['suggested_fix'],actual_scope=NOTES[key],signature_changed=new!=old))
 LEAN.write_text(replace_group(text,sid,new,extra,issues),encoding='utf-8');dump(BASE/'ch07_source.json',source)
 diff=''.join(difflib.unified_diff(old.splitlines(True),new.splitlines(True)))
 (OUT/('HUMAN-'+key+'.diff')).write_text(diff,encoding='utf-8')
 result=dict(source_id=sid,signature_changed=new!=old,scope=NOTES[key],diff=diff,
  printed_version='原书表述保留；公式类已目视核对原页',corrected_version='见独立_corrected或限定目标；不将较弱目标称为完整修正')
 dump(OUT/('HUMAN-'+key+'-PREPARED.json'),result)
 return result

def main():
 from lsp29 import LeanCompiler
 compiler=LeanCompiler();rows=[]
 try:
  for row in load(OUT/'RETURNS.json'):
   if row['audit']['verdict']!='NEEDS_HUMAN':continue
   label='HUMAN-'+row['source_id'].split('-')[-1];saved=OUT/(label+'-PREPARED.json')
   item=load(saved) if saved.exists() else process(row)
   if item['signature_changed']:check(label,compiler)
   rows.append(item);dump(OUT/'HUMAN_REPAIRS.json',rows)
  check('HUMAN-final',compiler)
 finally:compiler.close()

if __name__=='__main__':main()

from common29 import *
import difflib

def replace_group(text,sid,new,extra=None,issues=None):
 g=groups(text)[sid]
 head=text[g['start']:g['body_start']]
 if extra is not None or issues is not None:
  first=head.splitlines()[0].removesuffix(' -/')
  head=first+''.join('\n[EXTRA] '+x for x in (extra or []))+''.join('\n[ERRATUM?] '+x for x in (issues or []))+' -/'
 return text[:g['start']]+head+'\n'+new.strip()+'\n\n'+text[g['end']:]

SCOPES={
 'WordConvention':'九字母OABOAOBAO的确定性单步映射、四次O更新与计数；独立噪声序列的概率资格由vectorNormalSequence另列。',
 'ConjugateIteration':'一般复合迭代恒等式、OABA定义及带噪声序号的OABA/BAOAB精确代数移位关系；不包含不变测度转移或遍历性。',
 'NonsymmetricExactMoments':'正质量和稳定范围内AOAB/BAOA不变概率的两个方差、精确混合矩；固定参数下混合矩为O(h)的量化界另列。',
 'GibbsComposition':'只覆盖两个已给定共同固定点映射的末尾组合恒等式；未识别实际H/O生成元、Gibbs测度及其半群。',
 'DivergenceFreeInvariant':'只覆盖C¹向量场的散度乘积恒等式和可微第一积分的链式法则；不包含归一Gibbs测度或全局流保测。',
 'JSplitting':'有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。',
 'CoordinateJSplitting':'两个总化辅助定义、正质量光滑势资格和冻结势单坐标导数关系；不含分段求积、转折点或一自由度全局流。',
 'OperatorOrderReversal':'拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。',
 'TaylorRemainder':'标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。',
 'OBAModifiedOperator':'OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。',
 'CommutatorPermutationRelations':'所列七个抽象交换子关系；(7.23)四个零均值解的关系未覆盖，需要同一方程、核唯一性与域。',
 'GibbsDerivativeIdentities':'所列五个Gibbs权微分恒等式；未覆盖本段交换子等式及其他OU中间式。',
 'FirstCorrectionTablePrinted':'恢复原页正号后的六个候选函数与六个PDE；常数仍任意，零均值选择义务独立登记。旧corrected名称只作兼容。',
 'OverdampedFirstOrderCaution':'固定h>0及固定噪声的AOAB逐路径大摩擦单步极限，带正质量；六种XYZ不一致性及有效时标一致性未覆盖。',
 'BiasedDoubleWellExact':'双阱Gibbs的两个精确积分及γ=2时第二积分消项；推广到任意β>0；真实算法O(h²)和中间积分推导未覆盖。',
 'EvenDensityPerturbation':'偶形式系数定义与二阶必要代数方程；修正项零均值、Fredholm兼容性和充分可解性未覆盖。',
 'SymmetricRHS':'单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。',
 'ReciprocalFrictionExpansion':'仅未中心化形式层级的定义；任意β的总化表达式不表示物理Gaussian资格。(7.31)级数、ε=1/γ方程、逐阶可积零均值未覆盖。',
 'OUHermiteIdentities':'所列OU/Hermite微分恒等式，显式补H(ρν)=−p·∇νρ的中间式；无核唯一性或Fredholm可解性。',
 'HighFrictionCorrectionTable':'四种候选、其代数共轭、c的实际Gibbs期望与中心化资格定义；双渐近只为抽象目标，真实平稳均值识别未覆盖。',
 'BAOABMarginalCancellation':'Gaussian条件动量消项和归一位置Gibbs资格下的构型消项；真实数值平稳平均及(7.37)双渐近余项未覆盖。',
 'SuperconvergenceScope':'积分分部的配置消项及其纯动量观测乘积消项；fromBound仅代数辅助，真实BAOAB先大摩擦后h→0的四阶结论未覆盖。',
 'MomentumRedrawLimit':'正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。',
 'BAOABLimitMethod':'带显式尾kick初值的BAOAB位置消元及双噪声LM在τ=h²/2的重标度等式；不含长期精度。',
 'ColoredNoiseAndExtension':'邻接噪声定义与协方差、扩展状态映射及可测Markov核定义；过程相对过去的新噪声独立性/Markov定理未覆盖，位置非Markov不作全称断言。',
 'ConstrainedHOSplitting':'H/O总化漂移、O扩散，以及两段各自受约束积分解规格；组合仍为代数辅助，未构造随机核及两次独立噪声组合。',
 'ApproximateGeodesicOrder':'仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。',
 'SpectralRadiusStability':'实二阶矩阵的闭单位圆谱判据及实际multipleX在γη资格下的双曲条件等价；不含Gaussian驱动有限方差平稳性。',
}

def repair(row,text):
 sid=row['source_id'];key=sid.split('-')[-1];old=groups(text)[sid]['code'];new=old
 if key=='WordConvention':
  new='''def oabaobaoPrinted (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 4 → V n) : Phase n → Phase n :=
  ouStep m γ θ (h/4) (R 3) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  ouStep m γ θ (h/4) (R 2) ∘ driftStep m (h/3) ∘
  ouStep m γ θ (h/4) (R 1) ∘ kickStep U (h/2) ∘
  driftStep m (h/3) ∘ ouStep m γ θ (h/4) (R 0)

/-- 恢复原页的兼容名称；原书此处没有计数勘误。 -/
def oabaobaoPrinted_corrected (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 4 → V n) : Phase n → Phase n := oabaobaoPrinted m U γ θ h R

theorem oabaobaoCount : (["O","A","B","O","A","O","B","A","O"] : List String).count "O" = 4 := by decide'''
 elif key=='ConjugateIteration':
  new+='''

def conjugateNoiseS (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (z : Phase n × ℕ) : Phase n × ℕ :=
  ((kickStep U (h/2) ∘ driftStep m (h/2) ∘ ouStep m γ θ h (R z.2)) z.1,z.2+1)

def conjugateNoiseT (m : V n) (U : V n → ℝ) (h : ℝ)
    (z : Phase n × ℕ) : Phase n × ℕ :=
  ((driftStep m (h/2) ∘ kickStep U (h/2)) z.1,z.2)

theorem oaba_baoab_noiseShift (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (k : ℕ) :
    (fun z : Phase n × ℕ ↦ (oaba m U γ θ h (R z.2) z.1,z.2+1))^[k+1] =
      conjugateNoiseT m U h ∘
      (fun z : Phase n × ℕ ↦ (baoab m U γ θ h (R z.2) z.1,z.2+1))^[k] ∘
      conjugateNoiseS m U γ θ h R := by
  sorry'''
 elif key=='NonsymmetricExactMoments':
  new=new.replace('momentQ μ = θ/Ω^2 ∧ momentP μ = θ*m := by','momentQ μ = θ/Ω^2 ∧ momentP μ = θ*m ∧\n    (∫ x, x.1*x.2 ∂μ) = (if flip then -θ*h/2 else θ*h/2) := by')
  new+='''

theorem nonsymmetricMixedMoment_order (θ : ℝ) (flip : Bool) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ if flip then -θ*h/2 else θ*h/2) (fun h : ℝ ↦ h) := by
  sorry'''
 elif key=='JSplitting':
  new+='''

theorem jField_finiteDecomposition {K : ℕ} (J : Fin K → Matrix (Fin n) (Fin n) ℝ)
    (H : V n → ℝ) (hJ : ∀ k i j, J k i j = -J k j i) :
    jField (∑ k, J k) H = fun x ↦ ∑ k, jField (J k) H x := by
  sorry'''
 elif key=='CoordinateJSplitting':
  new+='''

def coordinateJQualification (m : V n) (U : V n → ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ ContDiff ℝ 2 U

theorem frozenPotential_deriv (m : V n) (U : V n → ℝ)
    (hq : coordinateJQualification m U) (q : V n) (i : Fin n) :
    deriv (frozenPotential U q i) (q i) = gradient U q i := rfl'''
 elif key=='OperatorOrderReversal':
  new+='''

theorem fourStage_duality {E : Type*} [AddCommGroup E] [Module ℝ E]
    (pair : E → E → ℝ) (A B C D a b c d : Module.End ℝ E)
    (hA : ∀ x y, pair (A x) y = pair x (a y))
    (hB : ∀ x y, pair (B x) y = pair x (b y))
    (hC : ∀ x y, pair (C x) y = pair x (c y))
    (hD : ∀ x y, pair (D x) y = pair x (d y)) (x y : E) :
    pair (A (B (C (D x)))) y = pair x (d (c (b (a y)))) := by
  rw [hA,hB,hC,hD]'''
 elif key=='TaylorRemainder':
  new+='''

theorem propagatedObservable_remainder {E : Type*} (P : ℝ → (E → ℝ) → E → ℝ)
    (φ : E → ℝ) (z : E) (k : ℕ)
    (htime : ContDiff ℝ (k+1) (fun t ↦ P t φ z)) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ P h φ z-∑ j ∈ Finset.range (k+1),
        h^j/(Nat.factorial j : ℝ)*iteratedDeriv j (fun t ↦ P t φ z) 0)
      (fun h ↦ h^(k+1)) := taylorRemainder_bound _ k htime'''
 elif key=='FirstCorrectionTablePrinted':
  new=new.replace('else if s = 2 ∨ s = 3 ∨ s = 4 then -β/2*(γ*U x.1-v-c)',
    'else if s = 2 ∨ s = 3 then -β/2*(γ*U x.1-v-c)\n  else if s = 4 then -β/2*(γ*U x.1+v-c)')
 elif key=='OverdampedFirstOrderCaution':
  new=new.replace('(hh : 0 < h) (hθ : 0 < θ) (hU', '(hm : ∀ i, 0 < m i) (hh : 0 < h) (hθ : 0 < θ) (hU')
 elif key=='BiasedDoubleWellExact':
  new+='''

theorem doubleWellCritical_integral (β : ℝ) (hβ : 0 < β) :
    (∫ x, doubleWellObservable x*doubleWellBOACorrection β 2 x ∂doubleWellGibbs β) = 0 := by
  simpa using (doubleWellExact β 2 hβ).2'''
 elif key=='OUHermiteIdentities':
  anchor='    phaseH U (fun x ↦ ρ x*ν x.1) =\n      O '
  new=new.replace(anchor,'    phaseH U (fun x ↦ ρ x*ν x.1) =\n      (fun x ↦ -(∑ i, x.2 i*gradient ν x.1 i)*ρ x) ∧\n'+anchor)
 elif key=='HighFrictionCorrectionTable':
  new+='''

def highFrictionMeanLaplacian (U : V n → ℝ) (β : ℝ) : ℝ :=
  ∫ q, laplacian U q ∂positionGibbs U β

def highFrictionCenteredQualification (U : V n → ℝ) (β : ℝ) : Prop :=
  0 < β ∧ IsProbabilityMeasure (positionGibbs U β) ∧
  Integrable (laplacian U) (positionGibbs U β) ∧
  ∀ s : Fin 4, Integrable (highFrictionCorrection s U β (highFrictionMeanLaplacian U β))
    (productGibbs (fun _ ↦ 1) U β) ∧
    (∫ x, highFrictionCorrection s U β (highFrictionMeanLaplacian U β) x
      ∂productGibbs (fun _ ↦ 1) U β) = 0'''
 elif key=='BAOABMarginalCancellation':
  new=new.replace('(hβ : 0 < β)\n    (hint', '(hβ : 0 < β)\n    (hprob : IsProbabilityMeasure (positionGibbs U β))\n    (hint')
 elif key=='SuperconvergenceScope':
  new+='''

theorem oabaoMomentumCancellation (U χ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hf : Integrable (highFrictionOABAO U β) (positionGibbs U β))
    (hχ : Integrable χ (momentumGibbs (fun _ ↦ 1) β))
    (hc : ∫ q, highFrictionOABAO U β q ∂positionGibbs U β = 0) :
    (∫ x, χ x.2*highFrictionOABAO U β x.1 ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry'''
 elif key=='MomentumRedrawLimit':
  new=new.replace('(hh : 0 < h) (hθ : 0 < θ)', '(hm : ∀ i, 0 < m i) (hh : 0 < h) (hθ : 0 < θ)')
  new+='''

theorem redrawMomentum_law (P : Measure Ω) (m : V n) (θ : ℝ) (R : Ω → V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ)
    (hR : HasLaw R (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)) P) :
    HasLaw (fun sample ↦ redrawMomentum m θ (R sample)) (momentumGibbs m θ⁻¹) P := by
  sorry'''
 elif key=='BAOABLimitMethod':
  new+='''

theorem lmStepH_rescale (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 ≤ θ) (hh : 0 ≤ h) :
    lmStepH m U θ h R S q = lmStep m U θ (h^2/2) R S q := by
  sorry'''
 elif key=='ColoredNoiseAndExtension':
  new+='''

def lmExtendedKernel (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (hstep : Measurable (fun z : (V n × V n) × V n ↦
      lmExtendedStep m U θ τ z.2 z.1)) : Kernel (V n × V n) (V n × V n) :=
  (Kernel.id.prod (Kernel.const (V n × V n) (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)))).map
    (fun z ↦ lmExtendedStep m U θ τ z.2 z.1)
'''
 elif key=='ConstrainedHOSplitting':
  new+='''

def constrainedONoise (m : V n) (γ θ : ℝ) (j : Fin n) : Phase n :=
  (0,fun i ↦ if i=j then Real.sqrt (2*γ*θ*m i) else 0)

def constrainedHIntegralStep {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (X : ℝ → Phase n) (Λ : ℝ → V l) (x0 : Phase n) (T : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ ContDiff ℝ 2 g ∧ ContDiff ℝ 1 U ∧ 0 ≤ T ∧
  ContinuousOn X (Icc 0 T) ∧ X 0=x0 ∧
  (∀ t ∈ Icc 0 T, X t ∈ cotangentConstraint m g) ∧
  ∀ i, IntervalIntegrable (fun t ↦ (X t).2 i/m i) volume 0 T ∧
    IntervalIntegrable (fun t ↦ -gradient U (X t).1 i-
      constraintReaction g (X t).1 (Λ t) i) volume 0 T ∧
    ∀ t ∈ Icc 0 T,
      (X t).1 i=x0.1 i+∫ s in (0 : ℝ)..t, (X s).2 i/m i ∧
      (X t).2 i=x0.2 i+∫ s in (0 : ℝ)..t,
        -gradient U (X s).1 i-constraintReaction g (X s).1 (Λ s) i

/-- O乘子冲量允许含随机部分；不把它限为有限变差的λdt。 -/
def constrainedOIntegralStep {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n)
    (reactionImpulse : ℝ → Ω → V n) (x0 : Phase n) (T : ℝ) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 g ∧ 0 ≤ T ∧
  (∀ t ∈ Icc 0 T, ∀ᵐ sample ∂P, X t sample ∈ cotangentConstraint m g) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Icc 0 T) ∧
    X 0 sample=x0 ∧ reactionImpulse 0 sample=0) ∧
  (∀ sample i, IntervalIntegrable (fun t ↦ -γ*(X t sample).2 i) volume 0 T) ∧
  ∀ t ∈ Icc 0 T, ∀ᵐ sample ∂P,
    (X t sample).1=x0.1 ∧ ∀ i,
      (X t sample).2 i=x0.2 i+(∫ s in (0 : ℝ)..t, -γ*(X s sample).2 i)-
        reactionImpulse t sample i+Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i)
'''
 elif key=='SpectralRadiusStability':
  new+='''

theorem multipleX_spectral_hyperbolic (Ω γ h : ℝ) (η : ℂ)
    (hγ : 0 < γ) (hh : 0 < h)
    (hη : η^2=(γ : ℂ)^2-4*(Ω : ℂ)^2) (hne : η ≠ 0) :
    characteristicUnitDisk (multipleX Ω γ h) ↔ hyperbolicStability γ h η := by
  sorry'''
 assert key in SCOPES,key
 return new,SCOPES[key]

def prepare(row):
 sid=row['source_id'];key=sid.split('-')[-1];text=LEAN.read_text(encoding='utf-8');g=groups(text)[sid]
 new,scope=repair(row,text)
 source=load(BASE/'ch07_source.json');r=next(x for x in source if x['source_id']==sid)
 before=dict(r);extra=list(r['extra_assumptions']);issues=list(r['issues'])
 extra.append('29号覆盖限定：'+scope)
 if key=='WordConvention':
  r['statement_latex']=r['statement_latex'].replace('OABAOBAO','OABOAOBAO').replace('3N_c','4N_c')
  needle=r'\mathcal U_{h/3}^A\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/3}^A'
  r['statement_latex']=r['statement_latex'].replace(needle,r'\mathcal U_{h/3}^A\circ\mathcal U_{h/4}^O\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/3}^A')
  extra=[x for x in extra if not any(w in x for w in ['h/3修','三次O','3个O','三处O','3个h/4','3个h/3'])]
  issues=[];extra.append('PDF291已目视核对：原书九字母OABOAOBAO、四次O(h/4)、4N_c均正确；撤销转录造成的假疑误。')
 if key=='FirstCorrectionTablePrinted':
  issues=[];extra.append('PDF314–315已目视核对原页：(7.25c)括号内为+v；旧负号是转录错误，撤销原书疑误。')
  r['statement_latex']=re.sub(r'(f_\{1,\[AOB\]\}[^\n]*)',lambda m:m[0].replace('U(q)-p^T','U(q)+p^T'),r['statement_latex'])
 r.update(statement_scope=scope,extra_assumptions=extra,issues=issues,
  lean_declarations=['MD.Ch07.'+n for n in re.findall(r'(?m)^(?:def|theorem|lemma|abbrev)\s+(\w+)',new)])
 r['repair_log'].append(dict(instruction=29,website_verdict='FAIL',suggested_fix=row['audit']['suggested_fix'],actual_scope=scope,signature_changed=new!=g['code']))
 text=replace_group(text,sid,new,extra,issues);LEAN.write_text(text,encoding='utf-8');dump(BASE/'ch07_source.json',source)
 diff=''.join(difflib.unified_diff(g['code'].splitlines(True),new.splitlines(True),fromfile='submitted',tofile='repaired'))
 (OUT/(key+'.diff')).write_text(diff,encoding='utf-8')
 dump(OUT/(key+'-PREPARED.json'),dict(source_id=sid,signature_changed=new!=g['code'],scope=scope,before=before,after=r,diff=diff))
 return key

def check(label,compiler):
 text=LEAN.read_text(encoding='utf-8');names=re.findall(r'(?m)^(?:def|abbrev|theorem|lemma|structure)\s+(\w+)',text)
 probe=OUT/'compiled'/(label+'.lean');probe.parent.mkdir(exist_ok=True)
 content=text+'\n'+'\n'.join('#print axioms MD.Ch07.'+n for n in names)+'\n';probe.write_text(content,encoding='utf-8')
 saved=probe.with_suffix('.json')
 if saved.exists():
  r=load(saved)
  if r['exit_code']==0 and r['input_sha256']==sha(probe) and r['log_sha256']==sha(probe.with_suffix('.log')):return r
 # An identical didChange produces no Lean processing event. Reuse the exact
 # complete source+axiom snapshot across labels instead of waiting for one.
 for other in (OUT/'compiled').glob('*.json'):
  if other.name.endswith(('-RUNNING.json','-binding.json','-lsp-events.json')):continue
  rr=load(other);otherlog=other.with_suffix('.log')
  if rr.get('exit_code')==0 and rr.get('input_sha256')==sha(probe) and otherlog.exists() and rr.get('log_sha256')==sha(otherlog):
   probe.with_suffix('.log').write_bytes(otherlog.read_bytes())
   rr=dict(rr,reused_exact_snapshot=str(other.relative_to(ROOT)),canonical_sha256=sha(LEAN))
   dump(saved,rr);print('REUSED EXACT SOURCE',label,flush=True);return rr
 if compiler is not None:
  r=compiler.check(content,label,probe)
 else:
  from local_compile import compile_recorded
  r,output,reused=compile_recorded(['lake','env','lean',str(probe.relative_to(ROOT))],ROOT,probe,probe.with_suffix('.log'),saved,reuse_failure=False)
  r.update(canonical_sha256=sha(LEAN),mode='native single-file compiler',declarations=names)
  dump(saved,r)
  if r['exit_code']:print(output.decode('utf-8',errors='replace')[-10000:],flush=True)
 if r['exit_code']:raise RuntimeError('Compiler failed: '+label)
 print('PASS',label,len(names),'axiom outputs',flush=True)
 return r

def main():
 from lsp29 import LeanCompiler
 compiler=LeanCompiler();repairs=[]
 try:
  for row in load(OUT/'FAIL_QUEUE.json'):
   key=row['source_id'].split('-')[-1]
   if not (OUT/(key+'-PREPARED.json')).exists():prepare(row)
   oldprobe=OUT/'compiled'/(key+'.lean');saved=oldprobe.with_suffix('.json')
   valid=False
   if saved.exists() and oldprobe.exists():
    rr=load(saved)
    valid=rr['exit_code']==0 and rr['input_sha256']==sha(oldprobe) and rr['log_sha256']==sha(oldprobe.with_suffix('.log')) and groups(oldprobe.read_text(encoding='utf-8'))[row['source_id']]['code']==groups()[row['source_id']]['code']
   receipt=rr if valid else check(key,compiler)
   if valid:print('REUSED',key,flush=True)
   repairs.append(dict(source_id=row['source_id'],receipt=key,checked=True,**{k:v for k,v in load(OUT/(key+'-PREPARED.json')).items() if k in ['signature_changed','scope','diff']}))
   dump(OUT/'REPAIRS.json',repairs)
 finally:compiler.close()

if __name__=='__main__':main()

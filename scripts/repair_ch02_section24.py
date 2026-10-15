"""Chapter 2.4 repairs: explicit qualifications, conclusions, and open choices."""
from website_repair_batch import prepare,verify,commit_section
from eaudit_review_tasks import declarations
from integrate_website_returns import ROOT,read

def run(section):
    ds=declarations(2);edits={};human={};eaudits=[]
    def current(key):return ds['MD-'+section+'-'+key]['block']
    def change(key,code,category,note,**kw):
        edits['MD-'+section+'-'+key]=dict(code=code,category=category,note=note,**kw)
    if section=='2.4.1':
        eaudit='EAUDIT14';pages=[105,106,107]
    elif section=='2.4.2':
        human['MD-2.4.2-CompositionOrder']='原文typically及高于min的例子未被当前下界覆盖，且局部阶逐点常数不能直接用于移动初值；选项：导师确定通常/确切阶的范围后补邻域一致阶及辛Euler→Verlet严格升阶实例／将本条完整拆分并交叉映射现有Verlet条目。当前签名保持，不能把下界静默当作整句。'
        eaudit='EAUDIT16';pages=[107]
    elif section=='2.4.3':
        change('HarmonicSplit',current('HarmonicSplit').replace('(Ω : ℝ) (U : ℝ → ℝ)',
          '(Ω : ℝ) (_hΩ : Ω ≠ 0) (U : ℝ → ℝ) (_hU : Differentiable ℝ U)'),
          'A','保留原除法闭式，频率非零落实为证明参数；U全域经典可微为更新点导数的充分[EXTRA]，未擅加Ω=0延拓。')
        eaudit='EAUDIT17';pages=[107,108]
    elif section=='2.4.4':
        change('ImplicitLocal',current('ImplicitLocal').replace('IsOpen U ∧ IsOpen V ∧ x ∈ U ∧ g h x ∈ V ∧',
          'IsOpen U ∧ IsOpen V ∧ x ∈ U ∧ g h x ∈ V ∧ MapsTo (g h) U V ∧'),
          'B','补g_h(U)⊆V，连同原左右逆完整表达局部微分同胚；不声称全域可解。')
        change('BackwardEulerSolve',current('BackwardEulerSolve')+'''

theorem backwardEulerResidual_zero_iff (f : E → E) (h : ℝ) (z w : E) :
    backwardEulerResidual f h z w = 0 ↔ w = z + h • f w := by
  sorry

def backwardEulerMapRelation (f : E → E) (h : ℝ) (G : E → E) : Prop :=
  ∀ z, G z = z + h • f (G z)''','B','保留残差并补零点与隐式更新等价、给定G满足的映射方程；不假设任意f,h都有唯一解。')
        eaudit='EAUDIT18';pages=[108,109]
    elif section=='2.4.5':
        human['MD-2.4.5-ConjugateLimits']='equivalent stability是否包括Lyapunov稳定/吸引性双向等价，还是仅随后共同极限例子，需确定范围；选项：补指定稳定性定义及等价／批准缩为共同极限例子。当前已证签名保持。'
        change('EulerConjugacy',current('EulerConjugacy')+'''

theorem eulerConjugacy_homeomorph (n : ℕ) (m : Fin n → ℝ)
    (_hm : ∀ i, 0 < m i) (U : Q n → ℝ)
    (_hF : Continuous (textbookPotentialForce U)) (h : ℝ) :
    ∃ χ : SymplecticCoordinates n ≃ₜ SymplecticCoordinates n,
      (∀ z, χ z = textbookMomentumKick (textbookPotentialForce U) (-h/2) z) ∧
      (∀ z, χ.symm z = textbookMomentumKick (textbookPotentialForce U) (h/2) z) ∧
      coordinateVerlet m (textbookPotentialForce U) h =
        χ.symm ∘ textbookSymplecticEuler m U h ∘ χ := by
  sorry''','B','原代数恒等式及证明完整保留；补正质量、连续力资格下的真实Homeomorph见证、双向kick及共轭方向。新结论暂sorry。')
        change('Processing',current('Processing')+'''

def processingData (χ : ℝ → E ≃ₜ E) (B G : ℝ → E → E)
    (F : Flow ℝ E) (f : E → E) (r s : ℕ) : Prop :=
  0 < s ∧ s < r ∧
  (∀ t z, HasDerivAt (fun u ↦ F u z) (f (F t z)) t) ∧
  (∀ h, G h = textbookProcessedMethod χ B h) ∧
  methodLocalOrder G (fun h ↦ F h) r ∧ methodLocalOrder B (fun h ↦ F h) s ∧
  ¬ methodLocalOrder B (fun h ↦ F h) (s+1)''','B','保留预/后处理算法；补实际ODE流与共轭、正低阶s<r、高阶G及低阶B相对同一精确流F的局部阶资格，¬s+1明确低阶而非仅下界；不以共轭误差结论为假设。')
        change('ProcessingIterates',current('ProcessingIterates'),'B',
          '本条明确仅承担算法与G迭代的精确恒等式；同一原句的r阶及低阶资格完整归MD-2.4.5-ProcessingOrder，保留原句不删并记录跨条映射。',
          scope='仅预处理/迭代/后处理与G的精确迭代恒等式；同一所引原句的阶数结论及低阶资格由MD-2.4.5-ProcessingOrder完整承担。')
        change('ProcessingOrder',current('ProcessingOrder').replace('(τ : ℝ) (r : ℕ)',
          '''(τ : ℝ) (_hτ : 0 < τ) (r s : ℕ) (_hs : 0 < s) (_hsr : s < r)
    (F : Flow ℝ E) (f : E → E) (_hdata : processingData χ B G F f r s)
    (_hγ : ∀ t, γ t = F t (γ 0))
    (_hB : ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      oneStepMaxError B (τ/ν) γ ν ≤ C*(τ/ν)^s)'''),
          'A','补正时间窗与低阶B的s阶误差资格及0<s<r；原G高阶假设和两项误差转移结论、已证证明均保留。processingData另给严格低阶的一般方法资格。')
        eaudit='EAUDIT19';pages=[110]
    else:raise ValueError(section)
    sources=read(ROOT/'blueprint/ch02/ch02_source.json');web={w['source_id']:w for w in read(ROOT/'blueprint/ch02/website_audit.json')}
    source_only=[s['source_id'] for s in sources if s['section']==section and s['source_id'] not in edits and s['source_id'] not in human and web[s['source_id']]['json_review']['status']=='CORRECTED']
    # 2.4.1 has nine independent source corrections; obey the eight-item limit.
    if section=='2.4.1':
        for e,ids in [('EAUDIT14',source_only[:8]),('EAUDIT15',source_only[8:])]:
            prepare(2,e,section,{},pages=pages,source_only=ids);verify(2,e);eaudits.append(e)
    else:
        prepare(2,eaudit,section,edits,pages=pages,source_only=source_only,human=human)
        verify(2,eaudit);eaudits.append(eaudit)
    commit_section(2,section,eaudits)

if __name__=='__main__':
    import sys
    run(sys.argv[1])

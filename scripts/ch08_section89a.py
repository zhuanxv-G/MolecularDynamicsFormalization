from ch08_data import add

add('TotalMomentum','8.9',386,r'''With central conservative forces ΣᵢFᵢ=0, Nosé dynamics gives d p_tot/dt=−ξ p_tot. Zero total momentum is formally invariant.''',
'''abbrev ParticleConfig (N d : ℕ) := Fin N → Vec d
abbrev ParticlePhase (N d : ℕ) := ParticleConfig N d × ParticleConfig N d
def totalMomentum {N d : ℕ} (p : ParticleConfig N d) : Vec d := ∑ i, p i
theorem noseTotalForce {N d : ℕ} (F p : ParticleConfig N d) (ξ : ℝ)
    (hF : totalMomentum F=0) :
    totalMomentum (fun i ↦ F i-ξ • p i) = -ξ • totalMomentum p := by
  simp only [totalMomentum,Finset.sum_sub_distrib,← Finset.smul_sum] at *
  rw [hF]; simp
theorem noseTotalForce_zero {N d : ℕ} (F p : ParticleConfig N d) (ξ : ℝ)
    (hF : totalMomentum F=0) (hp : totalMomentum p=0) :
    totalMomentum (fun i ↦ F i-ξ • p i)=0 := by rw [noseTotalForce F p ξ hF,hp,smul_zero]''',extra=['只证明瞬时总力恒等式；沿连续轨道的零动量不变需要ODE唯一性，有限精度“飞冰块”属经验现象，列缺口。'],scope='总动量定义和Nosé瞬时总力/零总动量时总力为零。')

add('DPDSoftPotential','8.9.1','387–388',r'''rᵢⱼ=|qᵢ−qⱼ|, eᵢⱼ=(qᵢ−qⱼ)/rᵢⱼ. Fᶜᵢⱼ=α(1−rᵢⱼ/r_c)eᵢⱼ for rᵢⱼ<r_c, zero otherwise; φ_DPD=(αr_c/2)(1−r/r_c)² below cutoff, U=Σᵢ<ⱼφ(rᵢⱼ). (8.80)–(8.84).''',
'''def pairDistance {N d : ℕ} (q : ParticleConfig N d) (i j : Fin N) : ℝ :=
  Real.sqrt (dot (q i-q j) (q i-q j))
def pairDirection {N d : ℕ} (q : ParticleConfig N d) (i j : Fin N) : Vec d :=
  (pairDistance q i j)⁻¹ • (q i-q j)
def dpdSoftPotential (α rc r : ℝ) : ℝ := if r < rc then α*rc/2*(1-r/rc)^2 else 0
def dpdPairConservative {N d : ℕ} (α rc : ℝ) (q : ParticleConfig N d) (i j : Fin N) : Vec d :=
  if pairDistance q i j < rc then (α*(1-pairDistance q i j/rc)) • pairDirection q i j else 0
def dpdPotential {N d : ℕ} (α rc : ℝ) (q : ParticleConfig N d) : ℝ :=
  ∑ i, ∑ j ∈ Finset.univ.filter (fun j ↦ i < j), dpdSoftPotential α rc (pairDistance q i j)
def dpdConservative {N d : ℕ} (α rc : ℝ) (q : ParticleConfig N d) : ParticleConfig N d :=
  fun i ↦ ∑ j ∈ Finset.univ.filter (fun j ↦ j ≠ i), dpdPairConservative α rc q i j
def particleGradient {N d : ℕ} (U : ParticleConfig N d → ℝ) (q : ParticleConfig N d) : ParticleConfig N d :=
  fun i a ↦ fderiv ℝ U q (Pi.single i (Pi.single a 1))
theorem dpdConservative_gradient {N d : ℕ} (α rc : ℝ) (hα : 0 ≤ α) (hrc : 0 < rc)
    (q : ParticleConfig N d) (hnocoll : ∀ i j, i ≠ j → 0 < pairDistance q i j)
    (hcut : ∀ i j, i ≠ j → pairDistance q i j ≠ rc) :
    dpdConservative α rc q = -particleGradient (dpdPotential α rc) q := by
  sorry''',equations=['8.80','8.81','8.82','8.83','8.84'],extra=['d维Euclidean距离由坐标平方和开方，避免Pi最大范数；只在非碰撞且离开截断接缝的有效域声明梯度关系。N、d为物理正整数，mᵢ>0在动力学资格另列。'],missing='非碰撞距离求导和有限无序对势梯度。',scope='软势、保守成对力/总力与光滑有效域的梯度目标；完整SDE见后条。')

add('DPDPairForces','8.9.1',388,r'''Fᴰᵢⱼ=−γ ωᴰ(rᵢⱼ)(eᵢⱼ·vᵢⱼ)eᵢⱼ, Fᴿᵢⱼ=σ ωᴿ(rᵢⱼ)θᵢⱼeᵢⱼ, ωᴿ(r)=1−r/r_c below cutoff. vᵢⱼ=pᵢ/mᵢ−pⱼ/mⱼ. (8.85)–(8.87).''',
'''def dpdWeightR (rc r : ℝ) : ℝ := if r < rc then 1-r/rc else 0
def relativeVelocity {N d : ℕ} (m : Fin N → ℝ) (p : ParticleConfig N d) (i j : Fin N) : Vec d :=
  (m i)⁻¹ • p i-(m j)⁻¹ • p j
def dpdPairDissipative {N d : ℕ} (m : Fin N → ℝ) (γ : ℝ) (wD : ℝ → ℝ)
    (q p : ParticleConfig N d) (i j : Fin N) : Vec d :=
  (-γ*wD (pairDistance q i j)*dot (pairDirection q i j) (relativeVelocity m p i j)) • pairDirection q i j
def dpdPairRandom {N d : ℕ} (σ : ℝ) (wR : ℝ → ℝ) (q : ParticleConfig N d)
    (i j : Fin N) (R : ℝ) : Vec d := (σ*wR (pairDistance q i j)*R) • pairDirection q i j
def dpdDissipative {N d : ℕ} (m : Fin N → ℝ) (γ : ℝ) (wD : ℝ → ℝ)
    (q p : ParticleConfig N d) : ParticleConfig N d :=
  fun i ↦ ∑ j ∈ Finset.univ.filter (fun j ↦ j ≠ i), dpdPairDissipative m γ wD q p i j
def pairImpulseVector {N d : ℕ} (i j : Fin N) (v : Vec d) : ParticleConfig N d :=
  Pi.single i v-Pi.single j v
def dpdNoise {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (σ : ℝ) (wR : ℝ → ℝ)
    (q : ParticleConfig N d) (k : Fin K) : ParticlePhase N d :=
  (0,pairImpulseVector (pairs k).1 (pairs k).2
    ((σ*wR (pairDistance q (pairs k).1 (pairs k).2)) • pairDirection q (pairs k).1 (pairs k).2))''',kind='definition',equations=['8.85','8.86','8.87'],extra=['白噪声θᵢⱼ不作为逐点函数使用；随机力的实际意义是下一条无序对独立Wiener驱动、双方相反的扩散向量。总化r=0只作辅助，在动力学中要求非碰撞。'],scope='全部成对/总耗散力、软随机权与成对守恒扩散方向。')

add('DPDPairWiener','8.9.1','388–389',r'''θᵢⱼ=θⱼᵢ; E θᵢⱼ=0 and E[θᵢⱼ(t)θₖₗ(t′)]=(δᵢₖδⱼₗ+δᵢₗδⱼₖ)δ(t−t′). Distinct unordered pairs are independent. (8.88).''',
'''def pairEnumeration {N K : ℕ} (pairs : Fin K → Fin N × Fin N) : Prop :=
  (∀ k, (pairs k).1 < (pairs k).2) ∧ Function.Injective pairs ∧
  ∀ i j, i < j → ∃ k, pairs k=(i,j)
def pairNoiseIncrement {N K : ℕ} (pairs : Fin K → Fin N × Fin N)
    (W : ℝ → Ω → Vec K) (s t : ℝ) (i j : Fin N) (sample : Ω) : ℝ :=
  ∑ k, if pairs k=(i,j) ∨ pairs k=(j,i) then W t sample k-W s sample k else 0
theorem pairNoiseIncrement_symmetric {N K : ℕ} (pairs : Fin K → Fin N × Fin N)
    (W : ℝ → Ω → Vec K) (s t : ℝ) (i j : Fin N) :
    pairNoiseIncrement pairs W s t i j=pairNoiseIncrement pairs W s t j i := by
  sorry
theorem pairNoiseIncrement_covariance {N K : ℕ} (P : Measure Ω)
    (pairs : Fin K → Fin N × Fin N) (he : pairEnumeration pairs)
    (W : ℝ → Ω → Vec K) (hW : independentWiener P K W)
    (s t : ℝ) (hs : 0 ≤ s) (hst : s ≤ t) (i j k l : Fin N) (hij : i ≠ j) (hkl : k ≠ l) :
    (∫ sample, pairNoiseIncrement pairs W s t i j sample*pairNoiseIncrement pairs W s t k l sample ∂P)=
      if (i=k ∧ j=l) ∨ (i=l ∧ j=k) then t-s else 0 := by
  sorry''',equations=['8.88'],extra=['只对无序对使用独立标准Wiener；Wᵢⱼ=Wⱼᵢ由同一坐标实现，不能把有序对全部设独立。Dirac白噪声公式通过有限时间增量协方差表达。'],missing='标准向量Wiener增量的有限和协方差与无序对枚举桥接。',scope='对称噪声增量和对应所印δ协方差的积分版本。')

add('DPDIntegralSystem','8.9.1',389,r'''dq=M⁻¹pdt, dp=−∇Udt−Δ(q)pdt+Σ(q)dW. (8.90).''',
'''def strictItoIntegral8 (P : Measure Ω) (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ k, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T k) 2 P) ∧ MemLp Y 2 P ∧
  Tendsto (fun k ↦ ∫ sample, (MolecularDynamics.Chapter06Review.itoLeftSum W g T k sample-Y sample)^2 ∂P)
    atTop (𝓝 0)
def multiplicativeSDE8 {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [MeasurableSpace E] [BorelSpace E] (P : Measure Ω) (r : ℕ)
    (W : ℝ → Ω → Vec r) (X : ℝ → Ω → E) (x0 : E) (a : E → E) (B : E → Fin r → E) : Prop :=
  independentWiener P r W ∧ Measurable (Function.uncurry X) ∧ (∀ j, Measurable (fun x ↦ B x j)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  ∀ T, 0 ≤ T → (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 T) ∧
    ∀ ell : E →L[ℝ] ℝ, ∃ Y : Fin r → Ω → ℝ,
      (∀ j, strictItoIntegral8 P (fun s sample ↦ W s sample j)
        (fun s sample ↦ ell (B (X s sample) j)) T (Y j)) ∧
      ∀ᵐ sample ∂P, ell (X T sample-x0-(∫ s in (0 : ℝ)..T, a (X s sample)))=∑ j, Y j sample
def dpdDrift {N d : ℕ} (m : Fin N → ℝ) (α rc γ : ℝ) (wD : ℝ → ℝ)
    (z : ParticlePhase N d) : ParticlePhase N d :=
  ((fun i ↦ (m i)⁻¹ • z.2 i),dpdConservative α rc z.1+dpdDissipative m γ wD z.1 z.2)
def isDPDSolution {N d K : ℕ} (m : Fin N → ℝ) (α rc γ σ θ : ℝ) (wD wR : ℝ → ℝ)
    (pairs : Fin K → Fin N × Fin N) (P : Measure Ω) (W : ℝ → Ω → Vec K)
    (X : ℝ → Ω → ParticlePhase N d) (x0 : ParticlePhase N d) : Prop :=
  0 < N ∧ 0 < d ∧ (∀ i, 0 < m i) ∧ 0 < rc ∧ 0 ≤ α ∧ 0 ≤ γ ∧ 0 < θ ∧
  (∀ r, wD r=(wR r)^2) ∧ σ^2=2*γ*θ ∧ pairEnumeration pairs ∧
  (∀ t, 0 ≤ t → ∀ᵐ sample ∂P, ∀ i j, i ≠ j → 0 < pairDistance (X t sample).1 i j) ∧
  multiplicativeSDE8 P K W X x0 (dpdDrift m α rc γ wD)
    (fun z ↦ dpdNoise pairs σ wR z.1)''',kind='definition',equations=['8.90'],extra=['实际多维独立Wiener、共同自然历史适应、联合可测、路径连续、漂移可积、所有网格左和及积分代表L²均明示。','选择强L²、非碰撞解类；不声称与所有弱解等价，也不建立SDE存在唯一或Markov半群。'],scope='配置依赖扩散的真实积分解规格及正质量/涨落耗散/无序噪声资格。')

add('DPDCanonicalLeaf','8.9.1',389,r'''ωᴰ=(ωᴿ)², σ²=2γk_BT. The canonical density is restricted to fixed total momentum π by δ(Σp−π). (8.89).''',
'''def dpdFluctuationDissipation (γ σ θ : ℝ) (wD wR : ℝ → ℝ) : Prop :=
  0 ≤ γ ∧ 0 < θ ∧ σ^2=2*γ*θ ∧ ∀ r, wD r=(wR r)^2
def momentumLeaf {N d : ℕ} (π : Vec d) : Set (ParticlePhase N d) :=
  {z | totalMomentum z.2=π}
def particleHamiltonian {N d : ℕ} (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ)
    (z : ParticlePhase N d) : ℝ := (∑ i, dot (z.2 i) (z.2 i)/(2*m i))+U z.1
def momentumCanonical {N d : ℕ} (ν : Measure (ParticlePhase N d)) (m : Fin N → ℝ)
    (U : ParticleConfig N d → ℝ) (β : ℝ) : Measure (ParticlePhase N d) :=
  ν.withDensity (fun z ↦ ENNReal.ofReal (Real.exp (-β*particleHamiltonian m U z)/
    (∫ x, Real.exp (-β*particleHamiltonian m U x) ∂ν)))
def momentumCanonicalQualification {N d : ℕ} (ν : Measure (ParticlePhase N d))
    (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ) (β : ℝ) (π : Vec d) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < β ∧ ν (momentumLeaf π)ᶜ=0 ∧
  Integrable (fun z ↦ Real.exp (-β*particleHamiltonian m U z)) ν ∧
  (0 < ∫ z, Real.exp (-β*particleHamiltonian m U z) ∂ν) ∧
  IsProbabilityMeasure (momentumCanonical ν m U β)''',kind='definition',equations=['8.89'],extra=['Dirac乘积解释为指定动量叶上的参考测度，未伪造Lebesgue密度；参考测度需另指定几何/周期体积。','只是权重与概率资格目标；DPD保持该测度、流体力学保持及高密度一维遍历性的大型定理均列缺口。'],scope='涨落耗散资格、动量约束叶及其可归一canonical测度定义。')

add('DPDMassOrderPrinted','8.9.1',389,r'''For dp=−∇Udt−Δ(q)pdt+Σ(q)dW, the book gives Δ=M⁻¹ΣΣᵀ/(2k_BT).''',
'''def dpdMatrixFDPrinted {s r : ℕ} (M Γ : Matrix (Fin s) (Fin s) ℝ)
    (B : Matrix (Fin s) (Fin r) ℝ) (θ : ℝ) : Prop := Γ=(1/(2*θ)) • (M⁻¹*(B*B.transpose))
def dpdMatrixFD_corrected {s r : ℕ} (M Γ : Matrix (Fin s) (Fin s) ℝ)
    (B : Matrix (Fin s) (Fin r) ℝ) (θ : ℝ) : Prop := Γ=(1/(2*θ)) • ((B*B.transpose)*M⁻¹)
theorem dpdMassOrder_counterexample :
    (!![1,0;0,(1/2 : ℝ)]) * (!![1,-1;-1,1]) ≠
      (!![1,-1;-1,1]) * (!![1,0;0,(1/2 : ℝ)]) := by
  intro h
  have hh := congrArg (fun A : Matrix (Fin 2) (Fin 2) ℝ ↦ A 0 1) h
  norm_num [Matrix.mul_apply,Fin.sum_univ_two] at hh''',verdict='NEEDS_HUMAN',issues=['已目视核对原页PDF410：对动量漂移−Δp、动量协方差k_BT M，应为Δ=ΣΣᵀM⁻¹/(2k_BT)；原印左乘仅在相应矩阵可交换（如等质量）时一致。两粒子不等质量的矩阵反例已证。'],extra=['M应正定、θ>0；本条记录两个矩阵关系目标与不交换反例，不声称由形式关系自动得到不变概率。'],scope='原印/校正的质量矩阵次序及具体代数反例。')

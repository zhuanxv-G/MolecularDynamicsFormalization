from ch08_data import add

add('PairwiseNoseHoover','8.9.3',394,r'''dqᵢ=pᵢdt/mᵢ, dpᵢ=Fᶜᵢdt+ξ F̃ᴰᵢdt, dξ=Gdt; G=Q⁻¹Σᵢ<ⱼωᴰ(rᵢⱼ)[(vᵢⱼ·eᵢⱼ)²−θ/mred]. (8.108),(8.109).''',
'''abbrev PNHLState (N d : ℕ) := ParticlePhase N d × ℝ
def pairwiseFeedback {N d : ℕ} (m : Fin N → ℝ) (θ Q : ℝ) (wD : ℝ → ℝ)
    (q p : ParticleConfig N d) : ℝ :=
  (∑ i, ∑ j ∈ Finset.univ.filter (fun j ↦ i < j), wD (pairDistance q i j)*
    ((dot (relativeVelocity m p i j) (pairDirection q i j))^2-θ/reducedMass8 (m i) (m j)))/Q
def pnhDrift {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d :=
  (((fun i ↦ (m i)⁻¹ • z.1.2 i),
    dpdConservative α rc z.1.1+z.2 • dpdDissipative m 1 wD z.1.1 z.1.2),
   pairwiseFeedback m θ Q wD z.1.1 z.1.2)
def isPNHSolution {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q : ℝ) (wD : ℝ → ℝ)
    (X : ℝ → PNHLState N d) : Prop :=
  0 < N ∧ 0 < d ∧ (∀ i, 0 < m i) ∧ 0 < rc ∧ 0 < θ ∧ 0 < Q ∧
  ∀ t, 0 ≤ t → HasDerivWithinAt X (pnhDrift m α rc θ Q wD (X t)) (Ici 0) t''',kind='definition',equations=['8.108','8.109'],extra=['Q为原文μ，F̃ᴰ是γ=1的相对速度耗散；排除i=j，物理轨道另需非碰撞且ωᴰ≥0。','只落盘实际ODE规格；Galilean不变性、总动量沿轨道守恒、存在唯一性及遍历性列缺口。'],scope='PNH场、反馈和正质量/正热浴质量的ODE规格。')

add('PairwiseCanonicalWeight','8.9.3',394,r'''ρ̂β=Ẑ⁻¹exp(−βH(q,p))exp(−βQξ²/2), on accessible fixed-momentum space. (8.110).''',
'''def pairwiseWeight {N d : ℕ} (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ)
    (β Q : ℝ) (z : PNHLState N d) : ℝ :=
  Real.exp (-β*particleHamiltonian m U z.1)*Real.exp (-β*Q*z.2^2/2)
def pairwiseCanonicalDensity {N d : ℕ} (ν : Measure (PNHLState N d))
    (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ) (β Q : ℝ) (z : PNHLState N d) : ℝ :=
  pairwiseWeight m U β Q z/(∫ x, pairwiseWeight m U β Q x ∂ν)
def pairwiseCanonicalQualification {N d : ℕ} (ν : Measure (PNHLState N d))
    (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ) (β Q : ℝ) (π : Vec d) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < β ∧ 0 < Q ∧ ν {z | totalMomentum z.1.2 ≠ π}=0 ∧
  Integrable (pairwiseWeight m U β Q) ν ∧ (0 < ∫ z, pairwiseWeight m U β Q z ∂ν) ∧
  probabilityDensity ν (pairwiseCanonicalDensity ν m U β Q)''',kind='definition',equations=['8.110'],extra=['ν是需指定的动量叶参考测度；正有限配分积分和概率资格显式列出。','这里只定义权重及归一目标，不把任意支持在动量叶上的测度称为PNH不变测度。完整不变性和归一存在理论列缺口。'],scope='动量约束下扩展Gibbs权、配分积分和概率密度资格。')

add('PairwiseNHLSDE','8.9.4',395,r'''PNHL adds dξ=(G−γ̂ξ)dt+σ̂dW, σ̂²=2γ̂θ/Q, to PNH. W is standard Wiener. (8.111),(8.112).''',
'''def pnhlDrift {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d :=
  ((pnhDrift m α rc θ Q wD z).1,pairwiseFeedback m θ Q wD z.1.1 z.1.2-γ*z.2)
def pnhlNoise {N d : ℕ} (σ : ℝ) (_ : Fin 1) : PNHLState N d := ((0,0),σ)
def isPNHLSolution {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ σ : ℝ) (wD : ℝ → ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → PNHLState N d)
    (x0 : PNHLState N d) : Prop :=
  0 < N ∧ 0 < d ∧ (∀ i, 0 < m i) ∧ 0 < rc ∧ 0 < θ ∧ 0 < Q ∧ 0 ≤ γ ∧
  σ^2=2*γ*θ/Q ∧ (∀ r, 0 ≤ wD r) ∧
  (∀ t, 0 ≤ t → ∀ᵐ sample ∂P, ∀ i j, i ≠ j → 0 < pairDistance (X t sample).1.1 i j) ∧
  additiveSDE P 1 W X x0 (pnhlDrift m α rc θ Q γ wD) (pnhlNoise σ)''',kind='definition',equations=['8.111','8.112'],extra=['实际一维标准Wiener由通用积分解规格明示；扩散仅作用ξ。','未证明该非碰撞解类存在、唯一、保测或遍历；“改善遍历性”是动机不是已证结论。'],scope='带正质量资格、涨落耗散关系及真实独立标准Wiener的PNHL积分解规格。')

add('PairwiseNHLGenerator','8.9.4',395,r'''PNHL splits A,B,C,D,O, with C:ξF̃ᴰ, D:G∂ξ, O:−γ̂ξ∂ξ+σ̂²∂ξ²/2. LPNHL=LA+LB+LC+LD+LO. (8.113),(8.114).''',
'''def pnhlA {N d : ℕ} (m : Fin N → ℝ) (z : PNHLState N d) : PNHLState N d := (dpdA m z.1,0)
def pnhlB {N d : ℕ} (α rc : ℝ) (z : PNHLState N d) : PNHLState N d := (dpdB α rc z.1,0)
def pnhlC {N d : ℕ} (m : Fin N → ℝ) (wD : ℝ → ℝ) (z : PNHLState N d) : PNHLState N d :=
  ((0,z.2 • dpdDissipative m 1 wD z.1.1 z.1.2),0)
def pnhlD {N d : ℕ} (m : Fin N → ℝ) (θ Q : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d := ((0,0),pairwiseFeedback m θ Q wD z.1.1 z.1.2)
def pnhlO {N d : ℕ} (γ : ℝ) (z : PNHLState N d) : PNHLState N d := ((0,0),-γ*z.2)
def pnhlGenerator {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ σ : ℝ) (wD : ℝ → ℝ)
    (f : PNHLState N d → ℝ) (z : PNHLState N d) : ℝ :=
  firstOrder8 (pnhlA m) f z+firstOrder8 (pnhlB α rc) f z+firstOrder8 (pnhlC m wD) f z+
    firstOrder8 (pnhlD m θ Q wD) f z+additiveGenerator (pnhlO γ) (pnhlNoise σ 0) f z
theorem pnhlDrift_split {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : pnhlDrift m α rc θ Q γ wD z=
      pnhlA m z+pnhlB α rc z+pnhlC m wD z+pnhlD m θ Q wD z+pnhlO γ z := by
  ext <;> simp [pnhlDrift,pnhDrift,pnhlA,pnhlB,pnhlC,pnhlD,pnhlO,dpdA,dpdB,sub_eq_add_neg]
theorem pairwiseWeight_localStationary {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ σ : ℝ)
    (hm : ∀ i, 0 < m i) (hrc : 0 < rc) (hθ : 0 < θ) (hQ : 0 < Q)
    (hγ : 0 ≤ γ) (hσ : σ^2=2*γ*θ/Q) (z : PNHLState N d)
    (hq : ∀ i j, i ≠ j → 0 < pairDistance z.1.1 i j)
    (hcut : ∀ i j, i ≠ j → pairDistance z.1.1 i j ≠ rc) :
    -textbookDivergence (fun x ↦ pairwiseWeight m (dpdPotential α rc) θ⁻¹ Q x •
      pnhlDrift m α rc θ Q γ (fun r ↦ (dpdWeightR rc r)^2) x) z+
      σ^2/2*deriv (deriv (fun s ↦ pairwiseWeight m (dpdPotential α rc) θ⁻¹ Q (z.1,s))) z.2=0 := by
  sorry''',equations=['8.113','8.114'],extra=['驻定式只为非碰撞、离开截断界面的局部光滑目标；全局保测需边界、半群等理论。','没有以漂移分解恒等式替代驻定或遍历性证明；两者分别列状态。'],missing='成对相对速度散度、软势梯度和扩展Gibbs权的局部Fokker–Planck计算。',scope='五子场、形式生成元、漂移分解；扩展权的局部驻定目标。')

add('PNHLSplittingAlgorithms','8.9.4',396,r'''PNHL-S: A½B½C½D½OD½C½B½A½; PNHL-N: A½B½C½D½OD½C½A½B½.''',
'''def pnhlAStep {N d : ℕ} (m : Fin N → ℝ) (h : ℝ) (z : PNHLState N d) : PNHLState N d :=
  (((fun i ↦ z.1.1 i+(h/m i) • z.1.2 i),z.1.2),z.2)
def pnhlBStep {N d : ℕ} (α rc h : ℝ) (z : PNHLState N d) : PNHLState N d :=
  ((z.1.1,z.1.2+h • dpdConservative α rc z.1.1),z.2)
def pnhlDStep {N d : ℕ} (m : Fin N → ℝ) (θ Q h : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d :=
  (z.1,z.2+h*pairwiseFeedback m θ Q wD z.1.1 z.1.2)
def pnhlOStep {N d : ℕ} (θ Q γ h R : ℝ) (z : PNHLState N d) : PNHLState N d :=
  (z.1,Real.exp (-γ*h)*z.2+Real.sqrt (θ/Q*(1-Real.exp (-2*γ*h)))*R)
def pnhlPairCStep {N d : ℕ} (i j : Fin N) (m : Fin N → ℝ) (h : ℝ)
    (wD : ℝ → ℝ) (z : PNHLState N d) : PNHLState N d :=
  let mr := reducedMass8 (m i) (m j)
  let e := pairDirection z.1.1 i j
  let u := dot e (relativeVelocity m z.1.2 i j)
  let du := u*(Real.exp (-z.2*wD (pairDistance z.1.1 i j)*h/mr)-1)
  ((z.1.1,dpdPairMomentumStep i j e mr du z.1.2),z.2)
def pnhlSComposition {E : Type*} (A B C D O : ℝ → E → E) (h : ℝ) : E → E :=
  A (h/2) ∘ B (h/2) ∘ C (h/2) ∘ D (h/2) ∘ O h ∘ D (h/2) ∘ C (h/2) ∘ B (h/2) ∘ A (h/2)
def pnhlNComposition {E : Type*} (A B C D O : ℝ → E → E) (h : ℝ) : E → E :=
  A (h/2) ∘ B (h/2) ∘ C (h/2) ∘ D (h/2) ∘ O h ∘ D (h/2) ∘ C (h/2) ∘ A (h/2) ∘ B (h/2)''',kind='algorithm',extra=['O需θ,Q>0、γ,h≥0及R独立标准正态；A/B/D给实际子步。C仅给逐对精确更新，全C需有序逐对近似，未冒称精确全流。','两组合保留原印因子顺序；不证明全方法弱阶、不变分布误差或非对称方法更优的经验结论。'],scope='A/B/D/O实际更新、单对C更新和S/N的原印外层组合；全C指数与误差理论列缺口。')

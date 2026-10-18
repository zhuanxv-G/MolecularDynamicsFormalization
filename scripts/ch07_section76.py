from ch07_data import add, EXCLUDED

add('GibbsComposition','7.6',282,
r'''The flows of each of these systems individually preserves the Gibbs distribution: denoting the Fokker-Planck operators associated to these flows by $\mathcal L_H^\dagger$ and $\mathcal L_O^\dagger$ we have
\[\mathcal L_H^\dagger\rho_\beta=0,\qquad\mathcal L_O^\dagger\rho_\beta=0,\]
and hence
\[\exp(t\mathcal L_H^\dagger)\rho_\beta=\exp(t\mathcal L_O^\dagger)\rho_\beta=\rho_\beta.\]
For a scheme $[HO]$, we have
\[\exp(h\mathcal L_O^\dagger)[\exp(h\mathcal L_H^\dagger)\rho_\beta]=\exp(h\mathcal L_O^\dagger)\rho_\beta=\rho_\beta.\]''',
'''theorem gibbsComposition {E : Type*} (P Q : E → E) (ρ : E)
    (hP : P ρ = ρ) (hQ : Q ρ = ρ) : (Q ∘ P) ρ = ρ := by
  simp only [Function.comp_apply, hP, hQ]''',
extra=['只覆盖末尾不变对象的组合恒等式；P/Q可取实际测度推前或已定义的传播子。H/O各自Gibbs不变性由前面独立陈述承担，生成元零蕴含半群固定点还需半群域理论。'],
scope='传播子共同固定点的组合推论；前两条生成元及半群识别未新增证明。')

add('DivergenceFreeInvariant','7.6',282,
r'''Given any divergence free vector field $f$, we have
\[-\nabla\cdot(f\rho)=-f\cdot\nabla\rho,\]
thus $\mathcal L_f^\dagger\rho=-\mathcal L_f\rho$.
If $\mathcal L_f$ preserves a first integral $I$, then $\mathcal L_f$ preserves any distribution which is a function of $I$. It follows that any energy-preserving, divergence free vector field will always preserve the Gibbs distribution.''',
'''def lieField (f : V n → V n) (ρ : V n → ℝ) (x : V n) : ℝ :=
  (fderiv ℝ ρ x) (f x)
def divergenceField (f : V n → V n) (x : V n) : ℝ :=
  ∑ i, coordDerivative (fun y ↦ f y i) x i
def forwardField (f : V n → V n) (ρ : V n → ℝ) (x : V n) : ℝ :=
  -∑ i, coordDerivative (fun y ↦ f y i*ρ y) x i
theorem divergenceFreeInvariant (f : V n → V n) (ρ : V n → ℝ)
    (hf : ContDiff ℝ 1 f) (hρ : ContDiff ℝ 1 ρ)
    (hdiv : ∀ x, divergenceField f x = 0) : ∀ x, forwardField f ρ x = -lieField f ρ x := by
  sorry
theorem firstIntegral_density (f : V n → V n) (I : V n → ℝ) (g : ℝ → ℝ)
    (hI : Differentiable ℝ I) (hg : Differentiable ℝ g)
    (hfirst : ∀ x, lieField f I x = 0) : ∀ x, lieField f (g ∘ I) x = 0 := by
  intro x
  rw [lieField, fderiv_comp x (hg (I x)) (hI x)]
  simp only [ContinuousLinearMap.comp_apply]
  change (fderiv ℝ g (I x)) (lieField f I x) = 0
  rw [hfirst x, map_zero]''',
extra=['微分对象C¹，第一积分和散度为实际导数；密度非负及归一化需g另行满足，此微分恒等式不把任意g都称概率密度。','不变生成元到全局流不变测度仍需完整流/输运桥，见HamiltonianGibbs。'],
missing='散度乘积法则与坐标导数求和需短桥；全局流测度输运另列。')

add('GeMarsdenRestriction','7.6',282,
r'''All symplectic methods preserve the volume, but for a system with no first integrals except the energy, it is known from a theorem of Ge and Marsden [400] that a symplectic method cannot preserve the system energy exactly (unless the symplectic method is itself a time-reparameterization of the exact solution).''',
'''def onlyEnergyIntegrals (H : V n → ℝ) (f : V n → V n) : Prop :=
  ∀ I : V n → ℝ, ContDiff ℝ ⊤ I → (∀ x, lieField f I x = 0) →
    ∃ g : ℝ → ℝ, I = g ∘ H
def timeReparametrizes {E : Type*} (G flow : ℝ → E → E) : Prop :=
  ∃ τ : ℝ → E → ℝ, ∀ h x, G h x = flow (τ h x) x
def geMarsdenConclusion {k : ℕ}
    (H : MolecularDynamics.SymplecticCoordinates k → ℝ)
    (G flow : ℝ → MolecularDynamics.SymplecticCoordinates k → MolecularDynamics.SymplecticCoordinates k) : Prop :=
  MolecularDynamics.Chapter02Review.symplecticIntegrator G →
  (∀ h x, H (G h x) = H x) → timeReparametrizes G flow''',kind='definition',
extra=['原文引用的Ge–Marsden定理未列非可积性、局部性及精确流的全部技术条件；仅定义其非可积性和结论形式，未把geMarsdenConclusion宣称为真。','辛映射体积保持和Ge–Marsden结论均列入本条覆盖缺口，不能把该定义当成定理已证。'],
scope='原文数学主张已登记；Lean给出结论形式和第一积分资格，尚缺可核定的完整定理前提与定理陈述。',verdict='NEEDS_HUMAN')

add('JSplitting','7.6','282–283',
r'''Let $J$ be the skew-symmetric canonical symplectic structure matrix. The idea is to consider a splitting of $J$ into a finite number $K$ of skew-symmetric matrices $J_i$, $i=1,\ldots,K$. This induces a splitting of the Hamiltonian vector field into $K$ vector fields $f_i=J_i\nabla H$. Each of these vector fields preserves $H$ and, because they are themselves Hamiltonian, their flows are also volume-preserving. Assuming each such vector field is exactly integrable, the system dynamics may be approximated by composing the flow maps for each vector field.''',
'''def jField (J : Matrix (Fin n) (Fin n) ℝ) (H : V n → ℝ) (x : V n) : V n :=
  fun i ↦ ∑ j, J i j * gradient H x j
theorem jSplitting_energy (J : Matrix (Fin n) (Fin n) ℝ) (H : V n → ℝ)
    (hJ : ∀ i j, J i j = -J j i) (hH : ContDiff ℝ 2 H) :
    ∀ x, lieField (jField J H) H x = 0 ∧ divergenceField (jField J H) x = 0 := by
  sorry
theorem composition_preservesEnergy {E : Type*} (F G : E → E) (H : E → ℝ)
    (hF : ∀ x, H (F x) = H x) (hG : ∀ x, H (G x) = H x) :
    ∀ x, H ((F ∘ G) x) = H x := by
  intro x
  rw [Function.comp_apply, hF, hG]''',
extra=['Ji取常系数反对称矩阵，H为C²；一般退化Ji并非标准坐标辛矩阵，但能量/散度两个实际导数结论仍有意义。','体积保持需要已存在的完整光滑流；本条不新建流存在及Liouville理论。'],
missing='反对称二次型为零、混合偏导对称与坐标散度的短桥；全局流体积保持另列。')

add('CoordinateJSplitting','7.6',283,
r'''As an example of such a $J$-splitting, we may take $K=N_c$ with each $J_i$ to be defined by the components of the canonical symplectic structure matrix having to do with the $i$th position and momentum pair, thus the equations of motion for the $i$th vector field become
\[\dot q_i=p_i/m_i,\qquad \dot p_i=-\frac{\partial U}{\partial q_i}(\bar q_1,\ldots,\bar q_{i-1},q_i,\bar q_{i+1},\ldots,\bar q_{N_c}),\]
where components with a bar over them are fixed during the calculation. Any such 1-dof Hamiltonian system is formally integrable (albeit in quadratures).''',
'''def coordinateJField (m : V n) (U : V n → ℝ) (i : Fin n) (x : Phase n) : Phase n :=
  (fun j ↦ if j = i then x.2 i/m i else 0,
   fun j ↦ if j = i then -gradient U x.1 i else 0)
def frozenPotential (U : V n → ℝ) (q : V n) (i : Fin n) (r : ℝ) : ℝ :=
  U (Function.update q i r)''',kind='definition',
extra=['完整记录冻结坐标的一自由度向量场；形式quadrature可积性的分支、转折点及积分反演尚未形式化，明确列入覆盖缺口。'])
EXCLUDED.append({'section':'7.6','printed_page':'283','reason':'实现困难、一般计算不推荐、并行实现适用性等算法实践评论，不作数学待证对象。'})

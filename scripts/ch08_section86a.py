from ch08_data import add
add('IsokineticField','8.6','361–362',r'''q̇=M⁻¹p, ṗ=F(q)-[pᵀM⁻¹F(q)/(pᵀM⁻¹p)]p; K(p)=pᵀM⁻¹p is constant.''',
'''def isoMultiplier (invm p F : Vec n) : ℝ :=
  (∑ i, invm i*p i*F i)/kineticTwice invm p
def isoField (invm : Vec n) (F : Vec n → Vec n) (z : Phase n) : Phase n :=
  (fun i ↦ invm i*z.2 i, fun i ↦ F z.1 i-isoMultiplier invm z.2 (F z.1)*z.2 i)
theorem isoKinetic_balance (invm p F : Vec n) (hK : kineticTwice invm p ≠ 0) :
    (∑ i, invm i*p i*(F i-isoMultiplier invm p F*p i)) = 0 := by
  simp only [mul_sub, Finset.sum_sub_distrib]
  have hsum : (∑ i, invm i*p i*(isoMultiplier invm p F*p i)) =
      isoMultiplier invm p F*kineticTwice invm p := by
    simp only [kineticTwice, Finset.mul_sum]
    apply Finset.sum_congr rfl; intro i hi; ring
  rw [hsum, isoMultiplier, div_mul_cancel₀ _ hK, sub_self]''',equations=['8.37','8.38'],extra=['正质量、K>0作为物理有效域；本条实际证明瞬时动能平衡，不将之扩大为全局解存在性。'],scope='无约束向量场与瞬时动能导数的代数消去；沿解的完整第一积分列缺口。')
add('IsokineticProjector','8.6',362,r'''H=p(pᵀM⁻¹p)⁻¹pᵀM⁻¹; H²=H, Hp=p.''',
'''def isoProjection (invm p : Vec n) (v : Vec n) : Vec n :=
  fun i ↦ p i*((∑ j, invm j*p j*v j)/kineticTwice invm p)
theorem isoProjection_self (invm p : Vec n) (hK : kineticTwice invm p ≠ 0) :
    isoProjection invm p p = p := by
  have hs : (∑ j, invm j*p j*p j) = kineticTwice invm p := by
    simp only [kineticTwice]; apply Finset.sum_congr rfl; intro i hi; ring
  ext i; simp [isoProjection, hs, hK]
theorem isoProjection_idempotent (invm p : Vec n) (hK : kineticTwice invm p ≠ 0)
    (v : Vec n) : isoProjection invm p (isoProjection invm p v) = isoProjection invm p v := by
  sorry''',extra=['分母K非零；范围为span(p)的完整线性映射子空间等式列覆盖缺口。'],missing='有限和提取标量后的投影复合代数短证明。')
add('IsokineticDivergencePrinted','8.6','362–363',r'''ρ=e^{-w(q,p)}Φ(K(p)); div f_iso=(N_c-1)pᵀM⁻¹F/(pᵀM⁻¹p), w=(N_c-1)U/K.''',
'''def isoAnsatz (w : Phase n → ℝ) (Φ : ℝ → ℝ) (invm : Vec n) (z : Phase n) : ℝ :=
  Real.exp (-w z)*Φ (kineticTwice invm z.2)
theorem isoDivergencePrinted (invm : Vec n) (F : Vec n → Vec n)
    (hF : ContDiff ℝ 1 F) (z : Phase n) (hK : kineticTwice invm z.2 ≠ 0) :
    textbookDivergence (isoField invm F) z = ((n:ℝ)-1)*isoMultiplier invm z.2 (F z.1) := by
  sorry
theorem isoDivergence_corrected (invm : Vec n) (F : Vec n → Vec n)
    (hF : ContDiff ℝ 1 F) (z : Phase n) (hK : kineticTwice invm z.2 ≠ 0) :
    textbookDivergence (isoField invm F) z = -((n:ℝ)-1)*isoMultiplier invm z.2 (F z.1) := by
  sorry''',equations=['8.39'],issues=['已目视核对原页PDF383–384：ṗ=F-λp的散度应为-(N_c-1)λ，所印正号与后续w=(N_c-1)U/K也冲突。'],verdict='NEEDS_HUMAN',extra=['Φ为正光滑非零函数时称权重；使用K≠0域上的实际散度。'],missing='Printed散度符号疑误不证；修正版需商法则与有限维散度。')
add('IsokineticGibbsShell','8.6',363,r'''ρ=Z⁻¹exp(-(N_c-1)U/K)δ[K-K₀]; K₀=β⁻¹(N_c-1) gives the configurational Gibbs distribution.''',
'''def isokineticShell (invm : Vec n) (K0 : ℝ) : Set (Phase n) := {z | kineticTwice invm z.2=K0}
def isoShellWeight (U : Vec n → ℝ) (invm : Vec n) (z : Phase n) : ℝ :=
  Real.exp (-((n:ℝ)-1)*U z.1/kineticTwice invm z.2)
theorem isoShell_gibbsFactor (U : Vec n → ℝ) (invm : Vec n) (β : ℝ)
    (hn : 1 < n) (hβ : 0 < β) (z : Phase n)
    (hz : z ∈ isokineticShell invm (((n:ℝ)-1)/β)) :
    isoShellWeight U invm z = Real.exp (-β*U z.1) := by
  have hn' : (n:ℝ)-1 ≠ 0 := by exact ne_of_gt (by exact_mod_cast Nat.sub_pos_of_lt hn)
  change kineticTwice invm z.2 = ((n:ℝ)-1)/β at hz
  unfold isoShellWeight
  rw [hz]
  congr 1
  field_simp
  <;> ring''',extra=['δ是曲面测度的广义记号，未把Dirac分布写成Lebesgue密度；本条只证明壳面上构型权重化简，曲面测度归一/边缘分布不变性列覆盖缺口。'],scope='动能壳与Gibbs因子的逐点关系；不声称完整曲面概率测度定理。')
add('StochasticIsokinetic','8.6.1','364–365',r'''dq=pdt, dp=(F-λp)dt, dξ₁=(-λξ₁-ξ₂ξ₁)dt, dξ₂=μ₂⁻¹(μ₁ξ₁²-k_BT)dt-γξ₂dt+σdW; p²+μ₁ξ₁²/2=k_BT.''',
'''def sinConstraint (Q1 : ℝ) (z : Vec 4) : ℝ := z 1^2+Q1*z 2^2/2
def sinMultiplier (Q1 : ℝ) (F : ℝ → ℝ) (z : Vec 4) : ℝ :=
  (z 1*F (z 0)-Q1*z 2^2*z 3/2)/sinConstraint Q1 z
def sinDrift (Q1 Q2 θ γ : ℝ) (F : ℝ → ℝ) (z : Vec 4) : Vec 4 :=
  let λ := sinMultiplier Q1 F z
  ![z 1, F (z 0)-λ*z 1, -λ*z 2-z 3*z 2, (Q1*z 2^2-θ)/Q2-γ*z 3]
def isSINSolution (Q1 Q2 θ γ : ℝ) (F : ℝ → ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → Vec 4) (x0 : Vec 4) : Prop :=
  0 < Q1 ∧ 0 < Q2 ∧ 0 < θ ∧ 0 < γ ∧ sinConstraint Q1 x0=θ ∧
  additiveSDE P 1 W X x0 (sinDrift Q1 Q2 θ γ F)
    (fun _ ↦ ![0,0,0,Real.sqrt (2*γ*θ/Q2)])
theorem sinConstraint_balance (Q1 Q2 θ γ : ℝ) (F : ℝ → ℝ) (z : Vec 4)
    (hK : sinConstraint Q1 z ≠ 0) :
    2*z 1*(sinDrift Q1 Q2 θ γ F z) 1+Q1*z 2*(sinDrift Q1 Q2 θ γ F z) 2=0 := by
  simp [sinDrift, sinMultiplier, sinConstraint] at *
  field_simp
  <;> nlinarith''',kind='definition',equations=['8.40','8.41','8.42','8.43','8.44'],extra=['热浴变量ξ₁,ξ₂∈ℝ，各质量、温度、摩擦正；随机噪声只在ξ₂；约束正值排除奇点。'])
add('SINWeightPrinted','8.6.1',365,r'''w=(U+ξ₂²/2)/(p²+μ₁ξ₁²/2); integration over the isokinetic surface gives the Gibbs configurational density.''',
'''def sinWeightPrinted (U : ℝ → ℝ) (Q1 : ℝ) (z : Vec 4) : ℝ :=
  Real.exp (-(U (z 0)+z 3^2/2)/sinConstraint Q1 z)
def sinWeight_corrected (U : ℝ → ℝ) (Q1 Q2 : ℝ) (z : Vec 4) : ℝ :=
  Real.exp (-(U (z 0)+Q2*z 3^2/2)/sinConstraint Q1 z)
theorem sinWeight_stationary_corrected (U : ℝ → ℝ) (Q1 Q2 θ : ℝ)
    (hU : ContDiff ℝ 2 U) (hQ1 : 0 < Q1) (hQ2 : 0 < Q2) (hθ : 0 < θ)
    (z : Vec 4) (hz : sinConstraint Q1 z=θ) :
    textbookDivergence
      (fun x ↦ sinWeight_corrected U Q1 Q2 x • sinDrift Q1 Q2 θ 0 (fun q ↦ -deriv U q) x) z = 0 := by
  sorry''',issues=['已目视核对原页PDF386：ξ₂方程含μ₂⁻¹，而w的ξ₂二次项缺μ₂；一般μ₂时应为μ₂ξ₂²/2。'],verdict='NEEDS_HUMAN',extra=['仅证明正约束面处的实际通量散度陈述；曲面概率测度、边缘分布和遍历性列缺口。'],missing='原文权重仅逐字保留不证；修正版通量散度的商法则计算。')

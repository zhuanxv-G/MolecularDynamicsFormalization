from ch07_data import add
add('BBKStar','7.4.2','277–278',
r'''Example 7.2 Consider the variant of the BBK integrator that recycles the random number between steps:
Brünger-Brooks-Karplus with post-step re-use of random number (BBK*)
\[p_{n+1/2}=(1-h\gamma/2)p_n-(h/2)\nabla U(q_n)+\tfrac12\sqrt{2k_BTh\gamma}M^{1/2}R_n,\]
\[q_{n+1}=q_n+hM^{-1}p_{n+1/2},\qquad
p_{n+1}=[p_{n+1/2}-(h/2)\nabla U(q_{n+1})+\tfrac12\sqrt{2k_BTh\gamma}M^{1/2}R_{n+1}]/(1+h\gamma/2),\]
where $R_n$ is a vector of normal random numbers with zero mean and unit variance.''',
'''def bbkStarTrajectory (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (x0 : Phase n) : ℕ → Phase n
  | 0 => x0
  | k+1 => bbk m U γ θ h (R k) (R (k+1)) (bbkStarTrajectory m U γ θ h R x0 k)

def bbkStarNoise (κ1 κ2 κ3 R S : ℝ) : ℝ × ℝ := (κ1*R,κ2*R+κ3*S)''',kind='definition',label='Example 7.2',
extra=['R序列需独立同分布标准正态；状态与当前R因上一步重用相关，不再假设独立。矩阵及κ常数由BBKLinearForm给出。'])
add('BBKStarCorrelations','7.4.2',278,
r'''Denoting the entries of $\Psi^{\rm BBK*}$ by $\psi_{ij}$ we have
\[\mathbb E(\mu_{n,2}p_n)=\mathbb E((\kappa_2R_n+\kappa_3R_{n+1})(\psi_{21}q_{n-1}+\psi_{22}p_{n-1}+\kappa_2R_{n-1}+\kappa_3R_n))=\kappa_2\kappa_3.\]
Additionally it is easily shown that
\[\mathbb E(\mu_{n,1}q_n)=\mathbb E(\mu_{n,2}q_n)=0,\quad \mathbb E(\mu_{n,1}p_n)=\kappa_1\kappa_3,\]
with $\mathbb E(\mu_{n,1}^2)=\kappa_1^2$, $\mathbb E(\mu_{n,1}\mu_{n,2})=\kappa_1\kappa_2$, $\mathbb E(\mu_{n,2}^2)=\kappa_2^2+\kappa_3^2$.''',
'''theorem bbkStarCorrelations (P : Measure Ω) [IsProbabilityMeasure P]
    (R S Qold Pold : Ω → ℝ) (a b c d κ1 κ2 κ3 : ℝ)
    (hR : HasLaw R (gaussianReal 0 1) P) (hS : HasLaw S (gaussianReal 0 1) P)
    (hind : IndepFun (fun sample ↦ (Qold sample,Pold sample)) (fun sample ↦ (R sample,S sample)) P)
    (hRS : IndepFun R S P) (hq : MemLp Qold 2 P) (hp : MemLp Pold 2 P) :
    let q := fun sample ↦ a*Qold sample+b*Pold sample
    let p := fun sample ↦ c*Qold sample+d*Pold sample+κ3*R sample
    let u := fun sample ↦ κ1*R sample
    let v := fun sample ↦ κ2*R sample+κ3*S sample
    (∫ sample, v sample*p sample ∂P) = κ2*κ3 ∧
    (∫ sample, u sample*q sample ∂P) = 0 ∧
    (∫ sample, v sample*q sample ∂P) = 0 ∧
    (∫ sample, u sample*p sample ∂P) = κ1*κ3 ∧
    (∫ sample, (u sample)^2 ∂P) = κ1^2 ∧
    (∫ sample, u sample*v sample ∂P) = κ1*κ2 ∧
    (∫ sample, (v sample)^2 ∂P) = κ2^2+κ3^2 := by
  sorry''',
extra=['Qold/Pold代表吸收R_{n-1}后仍独立于未来R_n,R_{n+1}的旧状态组合；不把当前p与R_n假设独立。','所有分量L²和未来独立资格明示；此抽象局部模型覆盖所列七个相关矩。'],
missing='需要实际独立随机变量的乘积积分和Gaussian矩展开；不建设历史扩展Markov链理论。')
add('BBKStarMomentSystemPrinted','7.4.2','278–279',
r'''Thus taking expectations of (7.8)–(7.10) and substituting in the constants gives
\[Q=\psi_{11}^2Q+\psi_{12}^2P+2\psi_{11}\psi_{12}C+2\psi_{12}\kappa_1 2\psi_{12}\kappa_1\kappa_3+\kappa_1^2,\]
\[P=\psi_{21}^2Q+\psi_{22}^2P+2\psi_{21}\psi_{22}C+2\psi_{22}\kappa_2 2\psi_{22}\kappa_2\kappa_3+\kappa_2^2+\kappa_3^2,\]
\[C=\psi_{11}\psi_{21}Q+\psi_{12}\psi_{22}P+(\psi_{11}\psi_{22}+\psi_{12}\psi_{21})C+\kappa_1\kappa_2+\psi_{12}\kappa_2\kappa_3+\psi_{22}\kappa_1\kappa_3.\]''',
'''def bbkStarMomentSystemPrinted (a b c d κ1 κ2 κ3 Q P C : ℝ) : Prop :=
  Q=a^2*Q+b^2*P+2*a*b*C+2*b*κ1*2*b*κ1*κ3+κ1^2 ∧
  P=c^2*Q+d^2*P+2*c*d*C+2*d*κ2*2*d*κ2*κ3+κ2^2+κ3^2 ∧
  C=a*c*Q+b*d*P+(a*d+b*c)*C+κ1*κ2+b*κ2*κ3+d*κ1*κ3

def bbkStarMomentSystemPrinted_corrected (a b c d κ1 κ2 κ3 Q P C : ℝ) : Prop :=
  Q=a^2*Q+b^2*P+2*a*b*C+2*b*κ1*κ3+κ1^2 ∧
  P=c^2*Q+d^2*P+2*c*d*C+2*d*κ2*κ3+κ2^2+κ3^2 ∧
  C=a*c*Q+b*d*P+(a*d+b*c)*C+κ1*κ2+b*κ2*κ3+d*κ1*κ3

theorem bbkStarExtraFactor_counterexample : (2*(1:ℝ)*1*2*1*1*1) ≠ 2*1*1*1 := by norm_num''',kind='definition',
issues=['已目视核对PDF299／印刷278：前两条方程交叉项重复印出2ψ12κ1与2ψ22κ2；按前面已列相关矩，应分别为2ψ12κ1κ3和2ψ22κ2κ3。原文与修正方程均保留。'],
extra=['PDF300续接第三条方程；此处定义保留方程组全部三式，不把修正方程定义计作概率推导已证。'],verdict='NEEDS_HUMAN')
add('BBKStarStationary','7.4.2',279,
r'''Finally, solving the simultaneous equations gives the stationary observed averages as
\[\langle q^2\rangle_h^{\rm BBK*}=\frac{k_BT}{\Omega^2}(1-\frac{\Omega^2h^2}{4m})^{-1},\qquad
\langle p^2\rangle_h^{\rm BBK*}=k_BTm(1+\frac{\gamma h}2)^{-1},\qquad
\langle qp\rangle_h^{\rm BBK*}=0.\]''',
'''theorem bbkStarStationaryAlgebra (m Ω γ θ h Q P C : ℝ)
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m)
    (hsys : bbkStarMomentSystemPrinted_corrected
      (bbkMatrix m Ω γ h).1 (bbkMatrix m Ω γ h).2.1
      (bbkMatrix m Ω γ h).2.2.1 (bbkMatrix m Ω γ h).2.2.2
      (Real.sqrt (θ*γ*h^3/(2*m)))
      (Real.sqrt (2*θ*γ*h*m)/(2+γ*h)*(1-h^2*Ω^2/(2*m)))
      (Real.sqrt (2*θ*γ*h*m)/(2+γ*h)) Q P C) :
    Q = θ/Ω^2*(1-Ω^2*h^2/(4*m))⁻¹ ∧
    P = θ*m*(1+γ*h/2)⁻¹ ∧ C = 0 := by
  sorry''',
extra=['只陈述修正后的矩方程组求解；一般平稳分布导出此方程需BBKStarCorrelations及历史模型，未声称整条分布理论完成。'],
scope='给定正确矩方程的代数求解及全部三矩值；未证明BBK*长期收敛。',missing='含平方根的非退化线性系统求解超过本轮短证明；保留未证。')

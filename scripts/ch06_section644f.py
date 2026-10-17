"""Complete Fredholm and both genuine kernel claims; no sealed proof restore."""
from ch06_data import add,proposition,NS
add('FredholmAlternative','6.4.4',257,[122],r'''The Fredholm Alternative says that, for a linear operator $A$ with compact resolvent, we have one of the following two conditions:
• $A\varphi=g$ has a solution.
• There is a function $y$ with $A^*y=0$ and $\langle y,g\rangle\ne0$.''',proposition('fredholm_statement','fredholmAlternative'),extra=['[EXTRA]实际稠密域闭Hilbert partialoperator图、actual adjoint以及shift1的完整紧resolvent（含逆的存在/唯一）；全部g可解当且仅当adjoint kernel正交，没有假设目标可解性。'],missing='缺一般closed partialoperator的Fredholm alternative现成完整桥接；不建设大型谱理论。')
add('BackwardKernelConstants','6.4.4',257,[123],r'''In our case, $A=\mathcal L_{LD}^*$. The only solutions of $\mathcal L_{LD}y=0$ (conserved quantities of Langevin dynamics) are the constants.''',proposition('kernelConstant_statement','backwardKernelConstants'),extra=['[EXTRA]真实Gibbs加权Lp²闭backward operator图的全部粗域元素；不能用已证C0固定观测量特例替代。'],missing='rough加权Hilbert generator kernel尚缺完整桥接；CanonicalKernelConstant封存长证明不恢复。')
add('ForwardKernelGibbs','6.4.4',257,[123],r'''If we have two solutions $\varphi_1,\varphi_2$ of $\mathcal L_{LD}^*\varphi=g$, then their difference $w$ must be a solution of $\mathcal L_{LD}^*w=0$ and the only such solution is a constant multiple of the Gibbs density $\rho_\beta$.''','''theorem forwardKernelGibbs : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β γ : ℝ) (hβ : 0 < β),
  0 < γ → ∀ w : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    MolecularDynamics.Chapter06Review.flatForwardWeak U β γ
      (textbookLangevinCanonicalWeakH1Value U hU hp β hβ w) 0 →
    ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
      textbookLangevinCanonicalWeakH1Value U hU hp β hβ w x=c*textbookLangevinCanonicalDensity U β x := by
  sorry''',extra=['[EXTRA]完整原flat forward弱PDE与真实H1类，全部stationary modes为Gibbs倍数；相对加权adjoint kernel对应常数而非Gibbs，不能混同二者。'],missing='缺flat forward弱域与实际adjoint/relative坐标转换、kernel识别；不恢复封存长证明。')
add('WeightedFunctionNorm','6.4.4',256,[119,120],r'''\[\|f\|_{L^2(\mu)}^2=\int_D f^2\mu(d\omega).\]''','''def weightedFunctionNorm {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) : ℝ := ‖f‖^2''',kind='definition',extra=['[EXTRA]实际Lp² AE类范数；Mathlib的eLpNorm定义为真实二阶积分，不把任意非可积函数的默认Bochner积分当范数。'])
add('WeightedVectorNorm','6.4.4',257,[120],r'''For a vector function $w:D\to\mathbb R^{N_c}$, we have
\[\|w\|_{L^2(\mu)}^2=\sum_{i=1}^{N_c}\|w_i\|_{L^2(\mu)}^2.\]''','''def weightedVectorNorm {n r : ℕ} (U : (Fin n → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (w : Fin r → Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) : ℝ := ∑ i, ‖w i‖^2''',kind='definition',extra=['[EXTRA]完整任意维度的所有真实L²分量，弱导数族使用同一实际Gibbs测度；不遗漏向量范数定义。'])

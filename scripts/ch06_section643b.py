"""Inactive draft: full theorem 6.1 stays incomplete; actual spectral bridges are separate."""
import re
from ch06_data import add,copied,proposition,D
from ch06_section643 import PARAMS,brownian_copy
add('BrownianDiscreteSpectrum','6.4.3',250,[92],r'''In particular, it has a compact resolvent [360]; this can be shown to imply that the spectrum consists only of a countable collection of eigenvalues, i.e. that the operator has a discrete spectrum.''','''theorem brownianDiscreteSpectrum '''+PARAMS+''' :
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ, z.im=0) ∧
  ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ,
    ∃ N : Set ℂ, IsOpen N ∧ z ∈ N ∧
      N ∩ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ={z} := by
  refine ⟨textbookBrownianGibbsGeneratorComplexSpectrum_countable m hm U hU hPU β hβ, ?_, ?_⟩
  · exact fun z hz ↦ textbookBrownianGibbsGeneratorComplexSpectrum_im_zero m hm U hU hPU β hβ z hz
  · exact fun z hz ↦ textbookBrownianGibbsGeneratorComplexSpectrum_isolated m hm U hU hPU β hβ z hz''',extra=['[EXTRA]实际闭Gibbs复L²域的全谱，非另选某有限模式；包含可数、实值与每个点孤立。'],prior=['MolecularDynamics.textbookBrownianGibbsGeneratorComplexSpectrum_countable','MolecularDynamics.textbookBrownianGibbsGeneratorComplexSpectrum_im_zero','MolecularDynamics.textbookBrownianGibbsGeneratorComplexSpectrum_isolated'])
add('BrownianSpectralGap','6.4.3',251,[94],r'''$\mathcal L$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $\sigma(\mathcal L)\subset(-\infty,-\alpha]$ for some $\alpha>0$.''','''theorem brownianSpectralGap '''+PARAMS+''' :
  ∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ,
    z ≠ 0 → z.im=0 ∧ z.re ≤ -α := by
  refine ⟨textbookBrownianGibbsCoercivityRate m U hU hPU β,
    textbookBrownianGibbsCoercivityRate_pos m U hU hPU β hβ, ?_⟩
  intro z hz hn
  exact ⟨textbookBrownianGibbsGeneratorComplexSpectrum_im_zero m hm U hU hPU β hβ z hz,
    textbookBrownianGibbsGeneratorComplexSpectrum_gap m hm U hU hPU β hβ z hn hz⟩''',extra=['[EXTRA]现成实际全闭谱；正谱隙从真实Poincaré常数得出，不把目标谱隙作前提。'],prior=['MolecularDynamics.textbookBrownianGibbsCoercivityRate_pos','MolecularDynamics.textbookBrownianGibbsGeneratorComplexSpectrum_gap','MolecularDynamics.textbookBrownianGibbsGeneratorComplexSpectrum_im_zero'])
theorem61=r'''Theorem 6.1 Define the generator of Brownian dynamics by
\[\mathcal Lf\stackrel{\rm def}=-M^{-1}\nabla U^T\nabla f+\beta^{-1}\Delta_Mf.\]
Suppose that $U$ is smooth with periodic boundary conditions $\mathcal Q=\mathbb T^{N_c}$ ($\mathbb T^{N_c}$ an $N_c$-dimensional torus). Then, with respect to the space $C_0^2(\rho_\beta)$ with inner product $\langle f,g\rangle_\beta$ as defined above, we have:
1. $\mathcal L$ is self-adjoint, negative definite, with spectrum consisting of discrete eigenvalues on the half line $(-\infty,0]$.
2. $\mathcal L$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $\sigma(\mathcal L)\subset(-\infty,-\alpha]$ for some $\alpha>0$.
3. averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $\varphi$, we have
\[|\bar\varphi(t)-\operatorname{Av}_\beta(\varphi)|\le K\|\varphi\|_\beta e^{-\alpha t};\]
for some positive $K$ and $\alpha$, where recall $\bar\varphi(t)$ denotes the time average of $\varphi$ defined in (5.6).'''
add('Theorem61','6.4.3','250–251',[93],theorem61,proposition('theorem61_statement','theorem61'),kind='theorem',label='Theorem 6.1',extra=['[EXTRA]明确采用现成闭复Gibbs-L²实现、非正谱和完整离散/谱隙；第三部分选择实际演化分布平均，并限定真实非负质量1的L²初始相对密度。全部条款保留，不用部分桥接代替整个定理。'],issues=['原C₀²核心域、自伴闭实现及negative definite术语需要签核；原末句时间平均与前句分布平均冲突。原一般初始分布未证明，本条技术范围限定另行披露。'],verdict='NEEDS_HUMAN',missing='无现成整个原Thm6.1域/严格负定/时间平均完整桥接；保持sorry，不恢复封存长证明。各已证子条款单独登记。')
add('Theorem61TimeAveragePrinted','6.4.3',251,[93],theorem61,'''
theorem theorem61TimeAveragePrinted '''+PARAMS+''' {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) :
  ∀ x : UnitAddTorus (Fin Nc), ∃ K α : ℝ, 0 < K ∧ 0 < α ∧
    ∀ f : textbookPeriodicSmoothSpace Nc, ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t →
      |t⁻¹*(∫ s in (0 : ℝ)..t,
          textbookConfigurationTorusObservable f
            (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ x B s sample)) -
        (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
          K*‖textbookPeriodicSmoothEmbedding U hU hPU β f‖*Real.exp (-α*t) := by
  sorry''',kind='theorem',label='Theorem 6.1(3) printed time average',verdict='NEEDS_HUMAN',issues=['保留原5.6轨道时间平均读法；通常随机时间平均并无原指称指数路径误差界。原文未说明随机量的概率资格，不能改成分布平均后冒称原结论已证。'],extra=['[EXTRA]实际Brownian全时torus过程、任意点初值、AE路径资格和t>0明确；原C∞紧支检验在紧torus周期表示。'],missing='原时间平均/演化分布平均冲突待导师；不证明字面指数轨道界。')
avg=copied('MolecularDynamics/Chapter06/BrownianProbabilityDensityAverage.lean','textbookBrownianDensityAverage_smooth_exponential','brownianEnsembleExponential')
avg=re.sub(r'\bN\b','Nc',avg);avg=re.sub(r'\bhp\b','hPU',avg)
avg=avg.replace('theorem brownianEnsembleExponential','theorem brownianEnsembleExponential '+PARAMS+'''
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (P : Measure Ω) (hB : textbookIsWienerVector B P)''',1)
add('BrownianEnsembleExponential','6.4.3',251,[95],r'''averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $\varphi$, we have
\[|\bar\varphi(t)-\operatorname{Av}_\beta(\varphi)|\le K\|\varphi\|_\beta e^{-\alpha t}.\]''',avg,extra=['[EXTRA]选择实际演化分布平均；真实Wiener/kernel和非负质量1的L²初始相对密度，所有光滑周期检验同时受界。范围限定不覆盖singular点初始law，不是原轨道时间平均证明。'],prior=['MolecularDynamics.textbookBrownianDensityAverage_smooth_exponential'])
add('BrownianNegativeDefinitePrinted','6.4.3',250,[90,93],r'''so that $\langle f,\mathcal Lf\rangle\le0$ so the operator is negative definite and can only have non-positive eigenvalues.''','''theorem brownianNegativeDefinitePrinted '''+PARAMS+''' :
  ∀ f : (Fin Nc → ℝ) → ℝ, ContDiff ℝ ∞ f → textbookUnitPeriodicPotential f →
    (¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0) →
      brownianWeightedInner U β f (textbookBrownianGenerator m U β f) < 0 := by
  sorry''',verdict='NEEDS_HUMAN',issues=['常数非零函数给零二次型，严格负定字面不成立；原非正谱正确子结论独立保留。'],extra=['[EXTRA]明确严格负定含全部非零周期光滑L²函数的读法。'],missing='字面严格负定被常数核反驳，不能证明。')
density=r'''The solution $p(t)$ to the Ornstein-Uhlenbeck equation, for any finite time $t$, is always normally distributed
\[\rho(p,t)=\exp\left[-\frac{(p-\mu(t))^2}{2\sigma(t)^2}\right];\tag{6.44}\]
where
\[\mu(t)=p_0e^{-\gamma t};\qquad\sigma^2(t)=k_BT m[1-e^{-2\gamma t}].\tag{6.45}\]'''
add('OUDensityPrinted','6.4.2',248,[86],density,copied(D,'ouDensityPrinted'),kind='definition',label='(6.44)–(6.45)',verdict='NEEDS_HUMAN',issues=['(6.44)遗漏(2πσ²(t))⁻¹/²归一化系数；t=0为Dirac，不能声称每个有限t都是非退化Lebesgue密度。'],extra=['[EXTRA]定义中使用通用噪声σ，取σ=√(2γkBTm)即6.45；t=0资格另记录。'],missing='字面式只为未归一权重；不证明它是概率密度。')
add('OUDensityCorrect','6.4.2',248,[86],density,copied(D,'ouDensity'),kind='definition',label='(6.44) correction',extra=['[EXTRA]补归一化系数，正γ/温度/质量且t>0使用；仅实际密度公式定义，原OU严格law结论在§6.3.2保留，不计密度积分或过程law已证。'])

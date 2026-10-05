# 下一批：实际periodic smooth domain上的Brownian线性算子

当前BrownianHilbertCore候选真实sameµ Hilbert embedding/inner/norm/generator image及fullsupport/injectivity已local05零diagnostic，统一验收进行中；此批不证明domain dense或closed self-adjoint realization。

下一目标文件MolecularDynamics/Chapter06/BrownianSmoothDomain.lean。定义actual Submodule ℝ ((FinNc→ℝ)→ℝ)，carrier为literal ContDiff ℝ∞ f ∧ original integer lattice periodicity；真实zero/add/scalar闭性来自ContDiff.add/const_smul和actual periodicity，无替换测试空间或有限Fourier特例。实际Frechet partial的add/scalar线性必须由HasFDerivAt推出，二阶partial同样真实；由literal generator sums/m_i^-1推generator的map_add/map_smul。original U C∞/periodic已推actual generator ContDiff/periodicity，所以generator maps this actual smooth space into itself。

定义actual Hilbert embedding LinearMap，用前批sameµ toLp；真实MemLp.toLp_add/const_smul可复用，AE coeFn_add/coeFn_smul也可直接验证。前批actual L2 embedding injectivity真证明，不能把域injectivity或samegenerator relation作新假设。固定mathlib Algebra/Module/Submodule/Equiv.lean 实际LinearEquiv.ofInjective把smooth Submodule等同于range embedding；ofInjective_apply与ofInjective_symm_apply给real inverse consistency。由equiv.symm→actual smooth generator→same embedding构造range⊂L²上的真实LinearMap到L²，证明对每个实际smooth lift输出正是同一actual L2 image（proven evaluation，不只compatible抽象relation）；由已验收Dirichlet/形式对称/nonpositive迁入该domain，actual constant-one vector∈domain且zero mode norm1。

Dense range、operator closure/self-adjointness、compact resolvent/discrete spectrum、Poincare-gap、actual semigroup/expectation未完成；range是actual domain但尚未證稠密，不能称已完成essential selfadjoint/closed generator。Mathlib toLp()是实际函数AE类，fullsupport+quotient continuity已消除continuous周期lift歧义；当前所有mass/β保持原模型条件。

后续Poincare路线需actual Fourier coordinate derivative identity、normalized Haar Parseval（UnitAddTorus.hasSum_sq_mFourierCoeff）与actual Gibbs正density upper/lower比较；不是假设gap。Dense smooth core可考虑actual mFourier的finite sums real/imag周期lift及StoneWeierstrass+ContinuousMap.toLp dense range，但必须真实证明这些tests属于同一smooth space和same Gibbs L²，不能用finite truncation替原domain。

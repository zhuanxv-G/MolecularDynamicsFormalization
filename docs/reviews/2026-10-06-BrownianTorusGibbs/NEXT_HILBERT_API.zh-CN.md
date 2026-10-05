# 下一批：实际加权Hilbert L2元素与同一Brownian smooth core

当前actual cube→normalized Haar→withDensity true Gibbs probability链与Dirichlet/symmetric/nonpositive已证明。本批不声称closed selfadjoint realization。下一文件MolecularDynamics/Chapter06/BrownianHilbertCore.lean。

固定实际API：Topology.Constructions IsOpenQuotientMap.piMap；Topology.Algebra.Group.Quotient 的to_additive QuotientAddGroup.isOpenQuotientMap_mk；IsQuotientMap.continuous_iff。实际Π quotientπ每coordinate continuous open surjective，可derivesame torus observable continuous from real f continuous及前批actual lift identity，不假设quotient observable continuity。注意可测equiv代表本身在boundary非连续，而periodic observable真实连续。无需更换代表/model。

MeasureTheory.Function.LpSpace.ContinuousFunctions 的ContinuousMap.memLp (𝕜'=ℝ) actual compact torus+finite probability measure给MemLp p（p=2）。显式此前Gibbs probability theorem建立finite instance，MemLp.toLp把同一个实际observable变为actual Lp ℝ 2 μ；MemLp.coeFn_toLp给same μ AE equality。Function.L2Space 的L2.inner_def，真实real scalar inner展开后积分与前批μ pairing相符；same Brownian generator C∞及periodic已proved，deriveactual L² generator image/formal inner symmetry/nonpositive，不把Dirichlet identity当输入、不声称全L² bounded operator。

后续仍需真实periodic smooth subspace/dense core、well-defined unbounded realization/closed selfadjoint、compact resolvent、Poincare/gap和semigroup expected convergence。Fourier/AddCircleMulti实际hasSum_sq_mFourierCoeff给actual L² normalized Haar Parseval，若走Poincare须证明真实coordinate derivative Fourier law与Gibbs upper/lower density bounds，不能假设gap。此为必要依赖规划，尚未完成任何该新Hilbert结果。原5.6真实期望意义已确定；负责人语义pending不阻塞独立proof。

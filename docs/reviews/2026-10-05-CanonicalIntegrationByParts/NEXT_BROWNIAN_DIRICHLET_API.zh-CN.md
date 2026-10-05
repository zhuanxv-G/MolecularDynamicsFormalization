# 下一正文目标：Theorem6.1周期Brownian Dirichlet形式

已目视原印刷250–251/PDF271–272（父工作区tmp/pdfs/chapter6-brownian/page-271.png与page-272.png），邻页252文本核对。原生成元 Lf=−M⁻¹∇U·∇f+β⁻¹Δ_M f；M质量必须保持一般正对角，不将原模型限定单位质量。位置域真实有限维torus或其相同周期lift的完整基本域；不可用紧支R^n测试函数冒充torus证明。

第一批实际目标：完整周期基本域积分边界抵消，actual weighted scalar Gibbs derivative，actual full generator weighted Dirichlet identity；原印刷250的未编号证明必须落实。固定mathlib MeasureTheory/Integral/DivergenceTheorem.lean 的任意有限坐标rectangle divergence真实API可将每个opposite face周期相等逐项cancel，需先核对全部量词/API，再编译真实证明。禁止把IBP/负性/对称性藏入假设。

定理整体仍未完成：正式Hilbert L²(ρ) unbounded operator realization/self-adjoint closed extension、compact resolvent/discrete spectrum、实际Poincare/spectral gap、actual stochastic/semigroup convergence。积分对称identity只给formal symmetry，不能冒称已经证明closed operator self-adjointness。原书第三点一面写time-dependent distribution averages，一面明确引用5.6的轨道time average；需要原5.6与两种average逐项语义核对，不能静默替换指数不等式量词。此次仅记录尚待分析的语义问题，没有证明反例或结论错误。

Proposition6.1本批完整候选机器验收已完成，负责人uniform weighted flux bound/替代证明语义签核继续pending，不阻塞此独立正文目标。

后续原页澄清：实际(5.6)印刷190/PDF211已经目视，确为time t的演化分布期望；轨道无限时间平均另见(5.9)。此前average语义疑虑已解析，后续按真实期望收敛推进。

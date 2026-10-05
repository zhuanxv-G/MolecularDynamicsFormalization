# 原页 Hamiltonian-power Lyapunov 证明与正确修正（机器验收通过，语义签核 pending）

原页：印刷253–254/PDF274–275，已目视教材工作区 tmp/chapter6-lyapunov/page-274.png 与 page-275.png。所属正文6.4.4，是 Theorem6.2 的 Lyapunov 依赖；未把整个几何遍历定理计为完成。

## 真实模型与证明

单位质量、UnitAddTorus(Fin Nc)位置与实数动量；势能 U 是实际 C∞ 整数格点周期函数，1≤U(q)。原页更强的 1<Umin 也满足该条件。上界从真实紧基本立方体导出，没有假设待证的 Lyapunov 界。

LangevinLyapunov.lean 用真实 H=½Σp_i²+U(q)、φ=H^l 与实际一阶漂移方向导数/动量二阶导数定义 differential expression。逐项证明 H 的摩擦耗散−γΣp_i²、真实 H^l 链式求导、完整动量 Laplacian、正确界与低阶幂吸收。γ>0、l≥1时实际构造δ>0，得到 Lφ≤−γlφ+δ；没有把此结论装入假设。σ²/2 保留，物理σ=√(2γβ⁻¹)、β>0给真实系数γβ⁻¹。

LangevinPeriodicLyapunov.lean 证明实际projection为open quotient、Hamiltonian power代表独立/任意lift一致与连续/正性；‖p‖sup²≤2φ、compact torus×真实动量闭球给所有能量次水平集紧致，再推出沿cocompact逃逸φ趋于无穷。书中动能的Euclidean平方精确表示为Σp_i²，Lean finite product norm用sup范数，二者的必要控制关系已证明。periodic differential expression在任意real lift上的值相同。

## 原页错误与语义待签核

原 printed253/PDF274 的 Δp H^l≤l(l+Nc−1)H^(l−1) 缺少 factor2，不能记作原式已证明。真实两次 scalar HasDerivAt/deriv 的 Nc=1、l=2、常周期 U=2、p=4 反例已内核验证：52>40。实际一般 Laplacian 是 l(l−1)H^(l−2)Σp²+Nc lH^(l−1)，正确必要界系数为2l(l−1)+Nc l。修正后的主 Lyapunov 结论仍成立。

一般算子行末 Δp φ 与前面的 f 不一致；后页省略 thermal 因子；周期有界域同时写 U(q)→∞ 的措辞也保留为原页疑点。修正方案和原 Nonempty-open 问题的负责人签核仍 pending。本批不声称真实 Markov semigroup generator 等于该 differential expression：适应性、Markov/transition density与Harris Theorem6.2 仍须补。

## 固定版本与验收

Lean4.34.0 / mathlib5ed2965256430c3649e86755f9576b54eca72435；full-check01于2026-10-05T18:00:20.0624216+08:00至2026-10-05T18:07:24.8927420+08:00退出0，9049jobs、零Lean警告、1015逐项公理审计仅propext/Classical.choice/Quot.sound，132输入与全部raw logs SHA256实查一致。新增30public完整名称见 PUBLIC_DECLARATIONS.json，均覆盖#check与#print axioms。真实literal differential operator/compactness证明完整；负责人的最终教材语义复核单独pending。

## 可复核局部失败保留

local01–local11及periodic-local01–03和两个module builds原始日志均保留。初期noncomputable与函数beta、Pi.single显式类型、真实有限和接口、general-TVS/Pi normed实例的convert!归约，以及compact sublevel membership显式化均已修复。local11和periodic-local03最终零警告通过；完整验收输入以本批132项实际SHA为准，不复用旧源码成功作为本批证明。

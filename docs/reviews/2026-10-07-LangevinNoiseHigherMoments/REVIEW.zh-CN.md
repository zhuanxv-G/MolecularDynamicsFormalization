# Theorem 6.2 依赖：真实噪声偶次矩与实际 Hamiltonian 幂可积性

本批对应印刷251–254/PDF272–275的原(6.47)与原H^l Lyapunov证明必要矩依赖。原PDF哈希本批重新核对一致，视觉核对复用相同PDF的272、273页；不宣称本批新增274、275页视觉检查。9个公开声明只实现原正整数l所需的2l阶矩，不独立交付任意Lp理论。

同一真实Wiener连续路径版本的坐标Gaussian law及标准Gaussian sqrt(time)缩放给出真实偶次范数矩的连续时间表达式。实际联合可测性、逐点Gaussian有限阶矩和Fubini证明∫₀ᵀ‖Bᵢ(s)‖^(2l)ds对P可积，不以目标时间矩作假设。连续区间的真实norm-power Jensen界通过固定版ConvexOn.map_set_average_le证明，并核对实际区间正有限测度与平均归一化。

从上一已验真实noise坐标平方界出发，对B²应用Jensen并使用正项幂和不等式，推出原ξ坐标的2l阶norm矩可积；指定有限T，包括T=0。γ≥0明确，未声称精确OU方差/高次Gaussian law或timeuniform矩。l≥1时仅将此必要矩转到所需2l空间，再合成真实向量并证明物理(∑ξᵢ²)^l可积。sup norm仅用于真实支配不等式，没有替代物理坐标平方和定义。

同一原periodic all-time process的实际阻尼动量界、原force常数和已证明噪声2l矩推实际momentum2l及物理(∑pᵢ²)^l可积。原U≥1、真实周期势能界和实际下降H^l连续性进一步推出H^l(ZT)可积。通过同一actualκ的global law和integrable_map_measure得到原kernel H^l可积。没有过程矩输入或漂移结论假设。

local01–02原始诊断保留：整数ENNReal乘积自动参数推断、∞型歧义、绝对值平方改写方向和continuous toNNReal名称。固定mathlib4.34已迁移的Basic.ENNReal声明用于显式p/natCast_ne_top，保持默认资源。local03全部9退出0、零error/Leanwarning、空日志，Draft与正式源逐字节SHA一致。DEP108/NOT117等待full-check01统一验收。

高次H^l的真正kernel收缩漂移、连续时间生成元身份/字面Assumption2、density存在、Harris完整结论、负责人语义继续pending；l1 fixedtime漂移已有前一独立验收，不能用 E H 的界向错误方向替代 E H^l。下一用真正路径界加已验高次噪声矩证明各l≥1的实际能量幂漂移。

full-check01 passed：9143 jobs/2386公理声明/226exact inputs；10checks退出0、全部input/rawlog SHA匹配、9public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。same实际ξ的2l矩/物理square sum^l及originalH^l对actualprocess与κ可积已机器验证，owner semanticpending，Theorem6.2整体未完成。

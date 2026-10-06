# Theorem 6.1：原 Gibbs 无界闭生成元的整个实谱
原文印刷 250–251 / PDF 271–272。固定原正质量 m、C∞ 整数周期势能 U、β>0，以及同一个原 Gibbs 概率测度上的整个实 Hilbert Lp 空间；不把定义域、可逆性或纯点谱作为前提。
本批 11 项公开声明。原生成元 A 的实预解集使用实际有界两侧图逆定义：B x 位于真正闭定义域且 A(Bx)=ℓ Bx−x；对整个真实图 (x,y)，B(ℓx−y)=x。ℓ=1 的逆由已接受的真正 R=(1−A)⁻¹ 提供。
证明 ℓ−A 有这种有界逆，当且仅当有界桥算子 Fℓ=id+(ℓ−1)R 是 unit。一个方向由实际图逆 B 构造 K=id−(ℓ−1)B，逐点证明 FℓK=KFℓ=id；反向使用 Fℓ 真正的两侧有界逆 K，构造 B=RK，再用 R 两侧实际图逆证明 B 两条要求。没有用单侧逆或在无限维 CLM 环中假定 Dedekind finiteness。
ℓ≠1 时，Fℓ=(1−ℓ)·((1−ℓ)⁻¹ id−R)，非零实标量的 algebraMap 是真正 unit。由此得到原无界 A 的整个实际实谱与 R 的 Mathlib Banach 实谱的精确双向对应。紧 R 的 Fredholm 定理及真正 eigenspace 对应证明原 A 的每个实谱点恰为真正非零特征空间，不把点谱界直接当作全谱界。
整个 A 实谱非正；除零外全部 ℓ≤−κ，κ 来自原 Gibbs 强制性而非假设；真正归一化常数模给 0 实际属于整个 A 实谱。任意实际有界移位图逆 B=R·(id−(ℓ−1)B)，因此每个这样的预解算子都紧。
局部诊断保存：local01 初始两项通过；local02 由较早 store 快照漏 include hm hβ 及用 rw 回写 x 导致同时改动 K x，修正绑定与单个减数的 congrArg 后 local03 桥等价三项退出 0 空日志。local04 发现谱因子负号错误以及 Units scalar 的 SMulCommClass 实例缺失；改为正确因子 (1−ℓ)，用实标量 algebraMap unit 的乘法消去后 local05 全十项退出 0 空日志。加全移位逆紧性后 local06 十一项退出 0 空日志；正式 local07 同样零警告退出 0。API 两组 15 项固定版本均通过，默认资源和 linter；无 sorry/admit、新项目公理、unsafe 或资源限制绕过。
DEP060 / NOT069 统一验收中。当前对象是原无界 A 的整个实谱；未声明其复化整个复谱。有限/余有限离散及可数有序谱枚举、真正 Markov 正性与 SDE 概率期望式 (5.6) 识别、原 C²/C∞ core 最终负责人语义签核仍待完成。Theorem 6.1 和 CORE_SCOPE 整体未完成；native Goal usageLimited，但普通额度允许，按授权在本地继续。
full-check01 passed：9095 jobs/1716公理声明/178exact inputs；10checks退出0、全部input/rawlog SHA匹配、11 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

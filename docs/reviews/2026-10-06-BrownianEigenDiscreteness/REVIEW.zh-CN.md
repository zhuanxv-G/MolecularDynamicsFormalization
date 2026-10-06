# Theorem 6.1：原 Gibbs 生成元整个实谱的闭离散性与有限谱层
原文印刷 250–251 / PDF 271–272。保留 m_i>0、原 U C∞ 整数周期、β>0、同一个原 Gibbs 测度上的 entire real Hilbert Lp。10 项公开声明全部由已接受的真正紧 R=(1−A)⁻¹、完整原 A 本征基和实际全实谱得到。
有限预解权重层证明没有把有限性、可数性或无限维当作假设。R 作用于所有单位本征基向量的像包含于真正紧集 K；正交系数给任意两个 ε 阈值以上模式之间距离≥ε。K 的 ε/3 有限小球覆盖把每个模式送到一个覆盖中心，三角不等式保证送法单射，因此真实模式层有限（包含特征值重数）。
由有限阈值层推 R 权重沿整个基索引 cofinite 趋于零；每个下界 a 以上 A 模式层有限，使用阈值 (2+|a|)⁻¹ 和真正非正性。由这些有限层得到本征值沿 cofinite 趋于−∞；univ 被自然数下界层覆盖，从而基索引可数，无 countability 假设。
全谱恰等于真正完整本征基的特征值投影 range：任意实际谱点有非零特征向量，完整 repr 保证一个真实系数非零；actual graph coefficient 强制其本征值等于该 basis mode 值。反向实际每个基向量 norm=1、进入原图。由此得到整个实际 A 实谱的有限下界层与可数性。
闭离散性直接在通常实数拓扑证明：点附近 Ioi(ℓ−1) 中只可能有有限谱层，去掉其余有限点的闭集获得真实单点谱邻域；非谱点用同一有限层的补集获得补谱开邻域。因此没有任何有限实数积点，不只声称点谱集合离散。
允许 Nc=0；没有声明索引一定无限，有限索引上的 cofinite 可为底滤子，不能把这些结论当作 ℕ 无限序列趋−∞。正维无限性和有序自然数枚举仍待继续。
局部诊断全部保存：local01 实内积未给 𝕜 和 center 子类型距离、弃用 Set.mem_setOf_eq；改 explicit ℝ/ambient center 和 mem_ofPred_eq 后 local02 前两项零警告 0。local03 protected ne_bot_iff 缺子空间以及集合成员目标，local04 投影 lambda 尚未 change；修正显式子空间和目标形式后 local05 全八项零警告 0。local06 Finite.diff 改名且隐式 t/obtain rfl 消去错误变量；用 sdiff (t:={ℓ}) 与 subst r 后 local07 十项退出0空日志，正式 local08 相同。四组25固定API通过；默认资源/linter，无 sorry/admit、新公理、unsafe 或限制绕过。
DEP061 / NOT070 统一验收中。真正整实谱及离散可数已证明；正维无限性和有序谱枚举、复谱、Markov 正性/SDE 概率期望 (5.6) 识别、C²/C∞ core 负责人最终教材语义仍缺。Theorem6.1 与 CORE_SCOPE 整体未完成。仅本地继续；native Goal usageLimited、ordinary quota可用。
full-check01 passed：9096 jobs/1726公理声明/179exact inputs；10checks退出0、全部input/rawlog SHA匹配、10 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

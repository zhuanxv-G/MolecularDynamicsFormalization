# 引理6.1周期Langevin模型必要的真实解存在性

原页：印刷255--256/PDF276--277。目标是补周期模型依赖，未作为独立一般化交付。

- 真实全局状态Lipschitz、逐点时间连续的driven field：构造 δ=1/(2(K+1)) 的统一局部长度。真实compact时间区间上 f(t,x₀) 界 M，选实际球半径 a=2δM+1、实际field范数界 Ka+M，验证完整 IsPicardLindelof。
- 用有限网格从0延到每个指定T。实际piecewise路径在接点值相同，左右导数均为f(τ,ατ)；Iic/Ici导数的union证明真正HasDerivAt。未假定延拓、解存在或有界轨迹。
- ContinuousOn W(Icc0T)通过projIcc实际延拓，噪声无需可微。构造q=α.fst、p=α.snd+σW，真正FTC得到原Bochner积分方程。
- 真实unit lattice周期C∞势能的既有compact cube证明给global forceLip，再从实际real解投影构造periodic积分解。任意T≥0、任意γ/σ，质量固定1、unit torus、有限Nc含0维。
- 当前只是每个给定连续驱动路径的实际解存在。还未构造AE可测随机解、全时段一致版本/适应性/生成元或Harris条件；全CORE_SCOPE和负责人最终语义签核pending。

验收：full-check01退出0，9043jobs、957项声明审计仅基础三公理、126项输入及全部原始日志SHA256实查一致、4public完全名称覆盖、零Lean警告。local01接口诊断保留，local02退出0；不是以假定随机终点可测替代解构造。

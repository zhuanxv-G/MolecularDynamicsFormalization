# 谐振子显式连续流本地语义复核

- 对照教材印刷27/PDF50已查看的公式：q(t)=cos(Ωt)q₀+sin(Ωt)p₀/Ω，p(t)=-Ωsin(Ωt)q₀+cos(Ωt)p₀。单位质量、统一标量频率Ω≠0；任意有限n（含0）。不声称一般频率矩阵或线性系统指数公式已证明。
- 两分量真实HasDerivAt证明给q'=p及p'=-Ω²q，定义内初值由sin0/cos0推出。IsGlobalMechanicalFlowOn在全相空间univ成立，力的C1唯一性导出全实时间复合和逆；不是把群律作为解存在假设。
- (t,z)联合连续性直接由cos/sin与连续向量运算证明，实际填充mathlib Flow结构的连续性、复合和零时刻字段。这只是该显式谐振子的连续流，不替代一般势垒选择族尚缺的初值连续依赖。
- 势能harmonicPotential=ΣᵢΩ²qᵢ²/2；真实Frechet/梯度导数为Ω²q，力等于负梯度，Hamiltonian不变由已经证明的实际机械ODE能量守恒推出。
- Ω=0时书中含1/Ω公式须另行处理为自由粒子；当前形式化显式排除0，未用总除法默认值假装成立。全书及§1.5.1仍未完成。
- 独立attempt03退出0，八项关键声明仅propext/Classical.choice/Quot.sound。正式full-check02已通过（8955jobs、310声明审计、固定输入SHA稳定），负责人最终独立语义签核pending，新远端CI未运行。

自由粒子候选attempt02已退出0，六项关键声明仅允许三项基础公理。q₀+tM⁻¹p₀/常动量对总质量算子ODE成立，正质量物理解释另行限定；联合连续性与Flow字段真实证明，零势能Hamiltonian由静态定义直接不变。正式full-check01的失败为模块说明/import顺序，不属于数学证明失败；已修正，含两模块的新full-check02已退出0。

"""Explicit chapter-wide scope review; no mathematical statements are broadened."""
SCOPES={
'ExtendedDensity':'乘积权定义及辅助因子积分为1时的边缘积分等式；不额外证明概率正性或一般流不变性。',
'NoseHoover':'正参数资格、动能平方和、NH实际向量场及全实时间ODE规格。',
'NHFirstIntegralPrinted':'第一积分候选、原印s导数与修正s导数各自对应的沿解零导数目标；原印版不证。',
'NHTimestepReversible':'五段单步的反演等式及负步长左逆两个目标；未建立误差阶数。',
'NoseHamiltoniansPrinted':'两个原印Hamiltonian定义、所印等式目标及减去对数差项后的代数修正。',
'NPEquations':'四个NP漂移分量的实际定义；从Hamiltonian求导得到这些分量未证。',
'GeneralThermostat':'常矩阵一般热浴场及矩阵反对称资格的定义；不声称已证驻定或采样。',
'ThermostatCriterion':'给定正参数与光滑性后，局部Liouville驻定与所列标量散度条件的等价目标。',
'Examples81and82':'单热浴一般G反馈及构型反馈公式、一般G的局部驻定目标；Example8.1由NH另条覆盖。',
'TemperatureIdentity':'紧支撑G的Gibbs积分分部目标及温度比值定义；一般边界衰减条件和比值推导未另证。',
'Proposition81':'两个标量热浴的局部Liouville驻定相加命题；不含多维热浴或全局流保测性。',
'NHChains':'任意正链长的完整NH链场及Gaussian权局部驻定目标；不含遍历性。',
'ArrheniusRate':'Arrhenius指数速率公式定义及A≥0时非负性；不含亚稳跃迁率渐近定理或温度单调性。',
'OUStationarityPrinted':'协方差匹配的完整OU局部驻定目标；所印扩散抵消的标量特例及数值反例。',
'LiftedThermostat':'一般单热浴提升场的实际加性Wiener积分解规格。',
'Proposition82':'所印及补σ≠0后的真实Lie括号张成命题；不含解存在、平滑转移核或遍历性。',
'Lemma81':'线性向量场C、D在实际Lie生成空间中的归属；Lean零起始索引对应原文正索引。',
'Proposition83':'指定模态域内的2n个实际线性场值线性无关；不扩大到例外零模态。',
'Theorem81':'所印及补参数资格后的NHL点态Hörmander条件；不含由其推出全局几何遍历性。',
'ZeroModeInvariant':'模态域的补集表达及连续热浴路径驱动的模态ODE零模态不变。',
'NHLGenerator':'实际加性扩散的Fréchet形式生成元、Lyapunov候选及漂移界性质的定义。',
'LyapunovCalculation':'实际NHL生成元作用于平移二次能量的目标及标量平方不等式；未据此证明遍历。',
'LyapunovRatePrinted':'所印与修正衰减系数、两版漂移界目标及所印界的正参数数值反例。',
'NHLTimestep':'实际九阶段NHL单步映射、OU随机输入及独立标准正态序列资格；不含整体稳定性。',
'NHLWeakStationary':'归一概率密度的弱驻定积分式目标；Markov半群不变性、唯一性和遍历性未覆盖。',
'PreEquilibriumMeans':'两项瞬时分布平均及随时间非负归一密度的资格；局部稳定性和闭合方程未覆盖。',
'VelocityRescaling':'实际漂移扩散、Φ有效性和原始Φ对应Ψ的化简目标；没有完整乘性SDE解规格。',
'RescalingStationary':'支撑避开零动量的测试函数弱驻定目标；零动量边界与半群不变性未覆盖。',
'SLS':'完整SLS加性SDE积分解规格、噪声方向与确定性子场定义。',
'SLSBracketPrinted':'第一漂移/热浴括号的原印与符号修正目标；二重括号在Hörmander另条处理。',
'SLSHormander':'单位参数实际SLS场与噪声方向的点态Lie张成目标；不含几何遍历性。',
'SLSConservation':'确定性SLS子场的局部驻定及零散度目标；完整SDE概率不变、独立第一积分未另证。',
'IsokineticProjector':'实际投影定义、固定p及幂等性目标；完整像空间刻画未覆盖。',
'IsokineticDivergencePrinted':'一般光滑力的原印/符号修正散度目标及权重ansatz；w方程和概率不变另列缺口。',
'StochasticIsokinetic':'实际SIN漂移、正参数Wiener积分解和瞬时约束平衡；约束沿全路径保持未另证。',
'SINWeightPrinted':'原印及补热浴质量的权重、正约束面局部驻定目标；曲面边缘分布及遍历性未覆盖。',
'PronyKernel':'正指数系数/记忆时间资格、Prony核定义及非负性；不包含过程极限。',
}

def apply_scope_review(records):
    for r in records:
        if r['statement_scope']=='本条列出的数学对象与结论全部；上下文见逐字原页。':
            key=r['source_id'].split('-')[-1]
            assert key in SCOPES,('Missing explicit scope',key)
            r['statement_scope']=SCOPES[key]
        if r['source_id']=='MD-8.9.1-DPDIntegralSystem':
            r['numbered_equations']=['8.80','8.81','8.90']

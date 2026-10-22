# 第7章原书疑误与双版本审阅单

教材：Leimkuhler–Matthews《Molecular Dynamics》（2015）第7章正文。
共29项原书疑误、论证缺口或范围待核记录；其中最新网站返回需人工判断27条，另含保留的范围核查和受约束分裂乘子解释。记录数不等于已确认排印错误数。
网站复审35条已到齐。签名/修正版通过与原文疑误分别记录；8条复审人工项有明确的修正版或限定签名通过意见，2条只认可已披露范围的定义，未把完整谱论或遍历定理写成已通过。
转录纠正：PDF291的九字母OABOAOBAO、PDF315(7.25c)括号内正号均已目视核对原页；旧漏字和误符号不计为原书勘误。

## 1. MD-7.2-StrongWeakComparison

- source\_id：MD-7.2-StrongWeakComparison；印刷页 265 / PDF页 286。
- 原文引文（逐字）：

> It is easy to see that methods with high strong order give us high weak order too, but the converse is generally false.

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：原文论证范围或技术资格需选定；不直接断言公式错误。
- 反例或理由：若不限定测试类：在单点概率空间令X=0、X\_h=h，L¹强误差为h；取φ(x)=sqrt(|x|)，弱误差为sqrt(h)，不保留阶1。反向反例见声明中的等权±1耦合，强误差为2而所有弱差为0。
- 原文版 Lean 名称及状态：`MD.Ch07.strongWeakLipschitz`：已证；`MD.Ch07.weakDoesNotImplyStrong`：已证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：保留限定定义或子结论；没有独立完整修正版定理。 仅覆盖α=1、Lipschitz测试类且有相应矩条件的定量蕴涵；一般强弱阶关系需测试类与矩条件，原书措辞待裁定。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留原文；标注[ERRATUM?]测试类与矩条件待确认，并把正向Lean覆盖明确记为α=1的Lipschitz定量推论。
- 网站首轮结论：NEEDS\_HUMAN。正向strongWeakLipschitz的完整签名是L≥0、全局Lipschitz且f(X)、f(Y)、|X−Y|可积时的一阶绝对误差控制，不是原句对任意测试函数类、任意α的收敛阶结论。反向声明正确：等权±1、X=id、Y=−id使所有测试函数期望相等而E|X−Y|=2；它给出耦合层面的反例，未构造一个完整数值方法族。已披露覆盖缺口，但原书无条件措辞仍须人工限定。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。见网站逐项原文意见；不把较弱目标当完整修正

## 2. MD-7.2-PartitionPrinted

- source\_id：MD-7.2-PartitionPrinted；印刷页 266 / PDF页 287。
- 原文引文（逐字）：

> and $Z_{\rm can}$ is the canonical partition function

$$
Z_{\rm can}^{-1}=\int_D\exp(-\beta H(q,p))d\omega,
$$


> ensuring the integral of $\rho_\beta$ is unity.

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：已目视核对原页PDF287／印刷266：原书确为Z\_can^{-1}=积分，和紧接的归一化断言不相容；不是转录错误。
- 反例或理由：D为单点，ν(D)=1/2，H=0、Z=2，配分积分=1/2=Z⁻¹；密度总积分=(1/2)(1/2)=1/4≠1。
- 原文版 Lean 名称及状态：`MD.Ch07.partitionPrinted`：未证；`MD.Ch07.partitionPrinted_counterexample`：已证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch07.partitionPrinted_corrected`：已证 原文Z⁻¹与配分积分的字面断言及反例独立保留；修正版取Z为积分且正有限，已证概率密度归一化。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留Printed版并标[ERRATUM?]；修正版取Z\_can=配分积分，附正性及可积性。
- 网站首轮结论：NEEDS\_HUMAN。partitionPrinted忠实保留Z⁻¹=配分积分及其归一化结论，应按Printed规则判断忠实性而非强求错误命题成立。该原书结论数学上错误，须人工确认。partitionPrinted\_counterexample的1/4≠1正确但只是测度反例的代数核心；partitionPrinted\_corrected用Z=配分积分并显式要求正性和可积性，其非负、可积、总质量1三项结论正确。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。原送审\_corrected三项归一密度结论正确

## 3. MD-7.3-OUExactUpdate

- source\_id：MD-7.3-OUExactUpdate；印刷页 268 / PDF页 289。
- 原文引文（逐字）：

> Integrating from $t$ to $t+h$ and multiplying by $\exp(-\gamma t)$, we arrive at the solution

$$
p(t+h)=e^{-\gamma h}p(t)+\sqrt{k_BT(1-e^{-2\gamma h})}M^{1/2}Z,\tag{7.3}
$$


> where $Z$ is a vector of independent, standard normal random variables.

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：已目视核对原页PDF289：前导乘数印作exp(−γt)，应为exp(−γ(t+h))；(7.3)与当前更新公式正确，不改。
- 反例或理由：ouMomentum的衰减exp(−γh)、噪声方差θ(1−exp(−2γh))m\_i正确。ouTransitionLaw对每个固定t≥0、h>0存在标准独立坐标向量Z，与p(t)独立并几乎处处给出更新；γ=0时噪声系数为0仍可由W区间增量提供Z。原书前导文字的乘数exp(−γt)疑为笔误，应为exp(−γ(t+h))；公式(7.3)本身正确，需人工确认该原书疑误。
- 原文版 Lean 名称及状态：`MD.Ch07.ouMomentum`：定义；`MD.Ch07.ouTransitionLaw`：未证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：保留限定定义或子结论；没有独立完整修正版定理。 只覆盖正确(7.3)和转移随机表示；原页前导乘数exp(−γt)应为exp(−γ(t+h))，文字笔误不影响(7.3)。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留原文并标[ERRATUM?]前导文字乘数；不改动正确的(7.3)及更新签名。
- 网站首轮结论：NEEDS\_HUMAN。ouMomentum的衰减exp(−γh)、噪声方差θ(1−exp(−2γh))m\_i正确。ouTransitionLaw对每个固定t≥0、h>0存在标准独立坐标向量Z，与p(t)独立并几乎处处给出更新；γ=0时噪声系数为0仍可由W区间增量提供Z。原书前导文字的乘数exp(−γt)疑为笔误，应为exp(−γ(t+h))；公式(7.3)本身正确，需人工确认该原书疑误。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。原送审OU更新和转移表示正确，无公式修正需求

## 4. MD-7.3.2-SPVPrinted

- source\_id：MD-7.3.2-SPVPrinted；印刷页 272 / PDF页 293。
- 原文引文（逐字）：

> Stochastic Position Verlet (SPV)

$$
q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\qquad p_{n+1}=e^{-h\gamma}p_n-\eta\nabla U(q_n)+\zeta M^{1/2}R_n,\qquad q_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1}
$$


> where $\eta=(1-e^{-h\gamma})/\gamma$, $\zeta=[k_BT(1-e^{-2\gamma h})]^{1/2}$.

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：已目视核对原页PDF293／印刷272：SPV展示式动量用∇U(q\_n)，而前文说对两部分作对称积分，漂移半步后冻结位置应为q_{n+1/2}；两者分别保留，待导师判断。
- 反例或理由：取一维U(q)=q²/2、m=1、q\_n=0、p\_n≠0及h>0、γ>0。漂移半步后qhalf=h p\_n/2≠0；两个版本的动量差为−η qhalf≠0。因此原印取力点与对称分裂取力点通常不同，并非等价写法。
- 原文版 Lean 名称及状态：`MD.Ch07.spvPrinted`：定义；`MD.Ch07.spvQualification`：定义。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch07.spvPrinted_corrected`：定义 Printed保留原页q\_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。
- 待人工核查点：修正版仅作为对称分裂的候选定义获认可；物理使用须引用spvQualification，γ=0延拓未覆盖。原印取力点仍待导师。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：人工确认原书勘误；原文JSON及spvPrinted保持q\_n。若采纳修正，以独立ERRATUM候选说明q\_n→q_{n+1/2}；γ=0的η=h延拓应另设分支，不能依赖除零总化。
- 网站首轮结论：NEEDS\_HUMAN。spvPrinted 忠实采用 q\_n 计算梯度；spvPrinted\_corrected 改为 qhalf，符合先漂移半步再精确求解冻结位置的 OU/力子步。θ 对应 k\_BT，逐坐标质量为对角 M。两版均未单独限制物理参数，视为代数定义可接受；γ=0 时商的总化值不能代表连续延拓。
- 网站复审结论：NEEDS\_HUMAN。Printed及corrected的输入均为m,U,γ,θ,h,R,x，输出为Phase n；前者忠实原印q\_n，后者实现先A半步、再冻结位置的受力OU整步、再A半步。候选修正符合本页对称分裂的推导，但原印与文字说明存在真实冲突，因此整条保留NEEDS\_HUMAN。spvQualification只是独立Prop，不会自动成为两个def的前提；应在物理解释时显式引用。
- 分版本结论：修正版/限定声明=网站PASS；原文疑误或范围待导师。修正版仅作为对称分裂的候选定义获认可；物理使用须引用spvQualification，γ=0延拓未覆盖。原印取力点仍待导师。

## 5. MD-7.3.2-SPVLargeFriction

- source\_id：MD-7.3.2-SPVLargeFriction；印刷页 272–273 / PDF页 293–294。
- 原文引文（逐字）：

> It is important to note that in the limit of infinite friction, we have $\eta\to0$ independent of the timestep $h$. This suggests that this splitting strategy is unsuitable for large choices of the parameter $\gamma$ as the sampling will become inconsistent: the force will be dominated by the stochastic term, leaving the dynamics to evolve as a random walk.

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：原文论证范围或技术资格需选定；不直接断言公式错误。
- 反例或理由：spvEtaLimit 对每个固定 h>0 断言 γ→+∞ 时 η→0，正确，且未把任意负 h 包含在内。没有陈述分布采样不一致或随机游走极限，extra\_assumptions 已披露此范围。
- 原文版 Lean 名称及状态：`MD.Ch07.spvEtaLimit`：未证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：保留限定定义或子结论；没有独立完整修正版定理。 固定h的大摩擦单步极限及相应代数关系；未声称联合h/γ极限的一致性或完整采样不一致性。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留定性文字，另指定步长/摩擦联合极限、时标、势与采样测试函数后判断不一致性；不得把固定 h 的极限称为对所有 h 的一致极限。
- 网站首轮结论：NEEDS\_HUMAN。spvEtaLimit 对每个固定 h>0 断言 γ→+∞ 时 η→0，正确，且未把任意负 h 包含在内。没有陈述分布采样不一致或随机游走极限，extra\_assumptions 已披露此范围。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。见网站逐项原文意见；不把较弱目标当完整修正

## 6. MD-7.4.2-BBKStarMomentSystemPrinted

- source\_id：MD-7.4.2-BBKStarMomentSystemPrinted；印刷页 278–279 / PDF页 299–300。
- 原文引文（逐字）：

> Thus taking expectations of (7.8)–(7.10) and substituting in the constants gives

$$
Q=\psi_{11}^2Q+\psi_{12}^2P+2\psi_{11}\psi_{12}C+2\psi_{12}\kappa_1 2\psi_{12}\kappa_1\kappa_3+\kappa_1^2,
$$



$$
P=\psi_{21}^2Q+\psi_{22}^2P+2\psi_{21}\psi_{22}C+2\psi_{22}\kappa_2 2\psi_{22}\kappa_2\kappa_3+\kappa_2^2+\kappa_3^2,
$$



$$
C=\psi_{11}\psi_{21}Q+\psi_{12}\psi_{22}P+(\psi_{11}\psi_{22}+\psi_{12}\psi_{21})C+\kappa_1\kappa_2+\psi_{12}\kappa_2\kappa_3+\psi_{22}\kappa_1\kappa_3.
$$



- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：已目视核对PDF299／印刷278：前两条方程交叉项重复印出2ψ12κ1与2ψ22κ2；按前面已列相关矩，应分别为2ψ12κ1κ3和2ψ22κ2κ3。原文与修正方程均保留。
- 反例或理由：取 b=d=κ1=κ2=κ3=1，原印附加项均为4，正确相关项均为2。
- 原文版 Lean 名称及状态：`MD.Ch07.bbkStarMomentSystemPrinted`：定义；`MD.Ch07.bbkStarExtraFactor_counterexample`：已证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch07.bbkStarMomentSystemPrinted_corrected`：定义 保留三条原印矩方程及修正系数；原页混合矩重复ψ因子已目视确认，未从相关噪声过程重新证明整组矩方程。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留原印三式及勘误标记；由相关矩推导 corrected 三式时明确指出原页重复因子。
- 网站首轮结论：NEEDS\_HUMAN。Printed 前两式忠实保留原页相邻重复因子，第三式亦一致。corrected 用条目16及(7.8)–(7.10)恢复 2bκ1κ3、2dκ2κ3，改动正确。counterexample 的实数不等式是 4≠2，正确，说明重复因子不能一般删除为恒等变形；它不是完整随机平稳模型的反例。原文版忠实性 PASS、修正版代数正确性 PASS，原书排印勘误交人工。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。原送审修正版代数正确性PASS

## 7. MD-7.5-PerturbedErrorExpansion

- source\_id：MD-7.5-PerturbedErrorExpansion；印刷页 280 / PDF页 301。
- 原文引文（逐字）：

> We find that truncating the update equations to $O(\epsilon^3)$ is sufficient to explicitly resolve the leading order behavior of the error for these discretization schemes, and we give the differences between observed numerical averages and exact averages below:

$$
\langle q^2\rangle_h^{[ABOBA]}-\langle q^2\rangle=\frac{3h^2\epsilon[48\epsilon-4+3\gamma^2(9\epsilon-1)]}{12\gamma^2+16}+O(\epsilon h^4+\epsilon^3h^2),
$$



$$
\langle q^2\rangle_h^{[BAOAB]}-\langle q^2\rangle=-\frac{9h^2\epsilon^2}{6\gamma^2+8}-\frac{3h^4\epsilon^2[6\gamma^4+19\gamma^2+16]}{8(3\gamma^2+4)^2}+O(\epsilon^2h^6+\epsilon^3h^2),
$$



$$
\langle q^2\rangle_h^{[OBABO]}-\langle q^2\rangle=h^2\left(\frac14+\frac{\epsilon[144\epsilon+81\epsilon\gamma^2-9\gamma^2-12]}{12\gamma^2+16}\right)+O(h^4+\epsilon^3h^2),
$$



$$
\langle q^2\rangle_h^{[OABAO]}-\langle q^2\rangle=-h^2\left(\frac14+\frac{18\epsilon^2}{12\gamma^2+16}\right)+O(h^4+\epsilon^3h^2).\tag{7.14}
$$



- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：原文论证范围或技术资格需选定；不直接断言公式错误。
- 反例或理由：四种 leading 和 remainder 的所有系数、正负号、幂次与(7.14)一致。positivePairLimit 是 (ε,h) 同时从正象限趋零；γ固定且为正。hinv 仅要求最终存在实际平稳 L² 概率分布；结论却给出任意该类族的统一双参数 Big-O。原页说明的是形式截断计算，未提供如此强的严格余项控制，不能以系数抄写一致批准严格定理。
- 原文版 Lean 名称及状态：`MD.Ch07.perturbedLeading`：定义；`MD.Ch07.perturbedRemainder`：定义；`MD.Ch07.positivePairLimit`：定义；`MD.Ch07.perturbedErrorExpansion`：未证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：保留限定定义或子结论；没有独立完整修正版定理。 (7.14)作为待证严格双参数渐近目标；不变测度选择、矩与统一余项资格不足，原书此处是形式展开而非已证严格估计。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留原书公式，将严格双参数估计标记为待人工确认；需要证明相关不变分布存在、选择一致性与足够高矩和余项的统一控制，或降低为明确的形式渐近陈述。
- 网站首轮结论：NEEDS\_HUMAN。四种 leading 和 remainder 的所有系数、正负号、幂次与(7.14)一致。positivePairLimit 是 (ε,h) 同时从正象限趋零；γ固定且为正。hinv 仅要求最终存在实际平稳 L² 概率分布；结论却给出任意该类族的统一双参数 Big-O。原页说明的是形式截断计算，未提供如此强的严格余项控制，不能以系数抄写一致批准严格定理。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。见网站逐项原文意见；不把较弱目标当完整修正

## 8. MD-7.5-PerturbedErrorOrders

- source\_id：MD-7.5-PerturbedErrorOrders；印刷页 280 / PDF页 301。
- 原文引文（逐字）：

> The behavior of the methods can thus be summarized as

$$
|\langle q^2\rangle_h^{[ABOBA]}-\langle q^2\rangle|=O(\epsilon h^2),\qquad |\langle q^2\rangle_h^{[BAOAB]}-\langle q^2\rangle|=O\left(\frac{\epsilon^2h^2}{1+\gamma^2}+\epsilon^2h^4\right),
$$



$$
|\langle q^2\rangle_h^{[OBABO]}-\langle q^2\rangle|=O(h^2),\qquad |\langle q^2\rangle_h^{[OABAO]}-\langle q^2\rangle|=O(h^2).\tag{7.15}
$$


> The twofold surprising result though, is that (a) the leading error of the $[BAOAB]$ scheme has behavior proportional to $\epsilon^2$, while (b) the leading order term of the $[BAOAB]$ scheme is annihilated for large $\gamma$.

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：原文论证范围或技术资格需选定；不直接断言公式错误。
- 反例或理由：0<ε≤1 时 ε³h²≤ε²h²≤(1+γ²)[ε²h²/(1+γ²)+ε²h⁴]；常数依赖固定 γ。
- 原文版 Lean 名称及状态：`MD.Ch07.perturbedErrorScale`：定义；`MD.Ch07.perturbedErrorOrders`：未证；`MD.Ch07.baoabLeading_largeFriction`：未证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：保留限定定义或子结论；没有独立完整修正版定理。 固定γ>0时(7.14)的余项足以推出(7.15)阶；γ一致常数或整个误差在γ→∞消失另需控制ε³h²项，不将固定γ和一致γ结论混淆。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：修正 extra\_assumptions：固定 γ 时(7.14)的余项足以推出(7.15)所列阶；若要求 γ 一致常数或完整误差大摩擦消失，则 ε³h² 项确实不能由当前信息控制。保留严格估计待人工审定。
- 网站首轮结论：NEEDS\_HUMAN。perturbedErrorScale 四种公式对应(7.15)，绝对值与 IsBigO 的固定 γ 正向双参数极限一致。baoabLeading\_largeFriction 只针对 -9h²ε²/(6γ²+8) 的大摩擦极限，正确；不证明完整误差关于 γ 的一致界。extra\_assumptions 中称 ε³h² 余项不足以推出固定 γ 的 ε²h²+ε²h⁴ 界不正确：ε→0 时 ε³≤ε²，且固定 γ 的 1/(1+γ²)>0 是常数。严格平稳分布渐近仍继承条目20的待确认问题。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。见网站逐项原文意见；不把较弱目标当完整修正

## 9. MD-7.6-GeMarsdenRestriction

- source\_id：MD-7.6-GeMarsdenRestriction；印刷页 282 / PDF页 303。
- 原文引文（逐字）：

> All symplectic methods preserve the volume, but for a system with no first integrals except the energy, it is known from a theorem of Ge and Marsden [400] that a symplectic method cannot preserve the system energy exactly (unless the symplectic method is itself a time-reparameterization of the exact solution).

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：原文论证范围或技术资格需选定；不直接断言公式错误。
- 反例或理由：若脱离缺失条件把结论直接当定理：在非平凡相空间取H=0、G为非零平移、flow为恒等族，G辛且保H，却不沿该flow轨道。此例说明缺失关联，并非反驳具备完整条件的Ge–Marsden定理。
- 原文版 Lean 名称及状态：`MD.Ch07.onlyEnergyIntegrals`：定义；`MD.Ch07.timeReparametrizes`：定义；`MD.Ch07.geMarsdenConclusion`：定义。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：保留限定定义或子结论；没有独立完整修正版定理。 只定义全部光滑第一积分全局依赖H、任意时间重参数和辛保能蕴涵目标；未连结精确哈密顿流、非退化时间变换及定理适用域，未声明Ge–Marsden定理已形式化。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：补充明确的哈密顿向量场/精确流关联、定理适用域及时间重参数条件后再给完整定理；不得把当前结论形式当作已成立命题。
- 网站首轮结论：NEEDS\_HUMAN。onlyEnergyIntegrals在Fin n→ℝ上量化全部光滑第一积分，并要求全局分解I=g∘H；g没有光滑性条件。timeReparametrizes允许τ依赖步长和初值且无连续/单调/非退化条件。geMarsdenConclusion只定义“辛且保能量⇒沿给定flow轨道”，未包含onlyEnergyIntegrals，也未约束flow为H的精确流；三个定义没有连成原文限定定理，辛映射保体积亦未陈述。D3–D8的辛条件是C¹且DΦᵀJDΦ=J，含义本身正确。JSON已承认主要缺口，但原书简述的定理技术条件不能由本页确定，保留原文并交人工。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。见网站逐项原文意见；不把较弱目标当完整修正

## 10. MD-7.7.1-StationaryModifiedPDE

- source\_id：MD-7.7.1-StationaryModifiedPDE；印刷页 285–286 / PDF页 306–307。
- 原文引文（逐字）：

> Under the propagation of the numerical scheme (or the discretized dynamics), the Fokker-Planck equation gives us that the evolution of a density of points $\rho$ is given by

$$
\frac\partial{\partial t}\rho(z,t)=\widehat{\mathcal L}^\dagger\rho,
$$


> with the important case of its invariant distribution satisfying the partial differential equation

$$
\widehat{\mathcal L}^\dagger\widehat\rho=0.
$$



- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：原文论证范围或技术资格需选定；不直接断言公式错误。
- 反例或理由：formalDensityEvolution对所有实t用HasDerivAt，且L为有界连续线性算子E→L[ℝ]E；原书Langevin/修改微分算子通常无界并需定义域，时间通常t≥0。stationaryModifiedDensity只是任意代数线性自映射的核条件，无密度资格，也未与前一个L识别。二者作为抽象定义有意义，不能据此确认原离散分布真实满足连续Fokker–Planck演化。原页把离散传播与连续方程直接联结需要形式解释或嵌入条件；JSON已提醒，须人工限定，不能静默改成普遍真实PDE。
- 原文版 Lean 名称及状态：`MD.Ch07.formalDensityEvolution`：定义；`MD.Ch07.stationaryModifiedDensity`：定义。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：保留限定定义或子结论；没有独立完整修正版定理。 仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留原文，明确形式修改方程的地位；若要真实演化，给出半群、生成元定义域、时间区间及嵌入假设，并统一两个定义的算子对象。
- 网站首轮结论：NEEDS\_HUMAN。formalDensityEvolution对所有实t用HasDerivAt，且L为有界连续线性算子E→L[ℝ]E；原书Langevin/修改微分算子通常无界并需定义域，时间通常t≥0。stationaryModifiedDensity只是任意代数线性自映射的核条件，无密度资格，也未与前一个L识别。二者作为抽象定义有意义，不能据此确认原离散分布真实满足连续Fokker–Planck演化。原页把离散传播与连续方程直接联结需要形式解释或嵌入条件；JSON已提醒，须人工限定，不能静默改成普遍真实PDE。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。见网站逐项原文意见；不把较弱目标当完整修正

## 11. MD-7.7.2-SpectralQualification

- source\_id：MD-7.7.2-SpectralQualification；印刷页 289 / PDF页 310。
- 原文引文（逐字）：

> The assumption of validity becomes more credible as we find that the operator $\mathcal L_{LD}^\dagger$ has a compact resolvent and therefore a discrete spectrum, i.e. simple eigenvalues, as discussed in the previous chapter. It will have one zero eigenvalue corresponding to the invariant density $\rho_\beta$ and all the remaining eigenvalues lie in the negative half plane.

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：已目视核对PDF310：原文将discrete spectrum释为simple eigenvalues，这并非一般蕴含。紧预解式至多给离散谱及有限重数，不能直接给单重谱；Langevin谱还需前章所列势函数/空间条件。
- 反例或理由：在E=ℂ³上取L=diag(0,−1,−1)、ρ=e₁。有限维算子具有紧预解式，零特征空间恰为span{ρ}，非零特征值在左半平面，但−1的特征空间是二维，故紧预解式不推出simpleEigenvalue。另取二维零特征值Jordan块可见几何重数1也不保证代数重数1。
- 原文版 Lean 名称及状态：`MD.Ch07.simpleEigenvalue`：定义；`MD.Ch07.printedSpectralConclusion`：定义；`MD.Ch07.spectralConclusionPrinted`：定义。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch07.spectralConclusionPrinted_corrected`：定义 Printed的simpleEigenvalue仅几何单重；修正版是较弱点谱目标并补零核方向唯一，不含完整谱、孤立性或有限代数重数，绝非紧预解式谱定理。
- 待人工核查点：网站仅认可已披露的点谱/几何单重定义；corrected仍是较弱候选Prop，未获完整紧预解式谱定理的PASS，不计为修正版定理通过。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：人工确认原书勘误和simple的含义。完整修正版应明确函数空间、闭算子及其定义域、紧预解式资格、孤立谱与有限代数重数，并以独立条件处理零特征值唯一性和左半平面位置；现有较弱Prop可保留，但不能命名成已验证谱定理。
- 网站首轮结论：NEEDS\_HUMAN。分别审校：simpleEigenvalue定义的是特征空间维数1（几何单重），不是通常谱论的代数单重。printedSpectralConclusion及spectralConclusionPrinted忠实保留“所有特征值单重、0对应ρ、其他实部负”的点谱目标，但没有紧预解式或完整谱的对象，也没有代数重数。_corrected把所有特征空间改为有限维，改掉“离散⇒单重”的错误方向是合理的；然而同时删掉零特征值应为唯一不变密度方向的约束，且有限维几何特征空间不等同于离散谱及有限代数重数。它只是较弱目标谓词，不是已得到的Langevin谱定理，也不是完整修正。由于原书错误及应保留哪些额外结论需人工决定，总判NEEDS\_HUMAN。
- 网站复审结论：NEEDS\_HUMAN。按已披露的范围，三个Printed/别名定义忠实记录原文的“点谱、几何单重”部分，corrected是较弱的点谱候选而不是已经证明的结论。原文“离散谱即单重谱”是实质数学疑误；此外几何单重不能代替代数单重，完整的原书谱论含义仍需人工选定，因此整体NEEDS\_HUMAN，不将源文错误隐改后判PASS。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。网站仅认可已披露的点谱/几何单重定义；corrected仍是较弱候选Prop，未获完整紧预解式谱定理的PASS，不计为修正版定理通过。

## 12. MD-7.7.3-PerturbativeSolvabilityCaution

- source\_id：MD-7.7.3-PerturbativeSolvabilityCaution；印刷页 290 / PDF页 311。
- 原文引文（逐字）：

> It will be difficult to solve the perturbation equation (7.19) in general, although its linearity and the fact that $\mathcal L_{LD}^\dagger$ (with our assumptions) has a compact resolvent (and therefore a discrete spectrum) together imply that if the perturbation can be bounded, then it should be possible to solve for the correction function. We expect that this solution should be stable with respect to perturbation (and exponentially attracting). This also implies global existence (for all positive time) of the semigroup defining the solution of the time-dependent problem. We do not provide such a rigorous result here but simply plunge ahead, in the best tradition of applied mathematics, to obtain a perturbative expansion; verification of our results must therefore be obtained by numerical experiment, a posteriori.

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：原文论证范围或技术资格需选定；不直接断言公式错误。
- 反例或理由：有限维L=diag(0,−1)有紧预解式且其非零谱在负半平面，但rhs=(1,0)不在range(L)，故Lu=rhs不可解；该rhs也可由有界扰动作用于核向量得到。这仅说明缺少相容条件，不能作为原书具备额外守质量条件的具体方案的反例。
- 原文版 Lean 名称及状态：`MD.Ch07.correctionSolvable`：定义。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：保留限定定义或子结论；没有独立完整修正版定理。 仅rhs属于线性映射值域的目标定义；没有ρf结构、零质量相容性、闭生成元域或半群/谱隙，原文预期不作定理。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留原书预期与未证明说明；后续严格版本应在零质量子空间给相容条件和可逆/谱隙资格，另行给生成元与半群定理。
- 网站首轮结论：NEEDS\_HUMAN。correctionSolvable是任意实模线性自映射L下rhs属于range(L)的命题，数学含义正确。但没有ρβf1结构、零质量归一条件、Fredholm相容性、紧预解式/定义域、指数稳定或全局半群存在。JSON明确只登记目标，不证明预期；原书也明确未给严格结果，必须保留并NEEDS\_HUMAN，不能把紧预解式及有界扰动升级为无条件可解性。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。见网站逐项原文意见；不把较弱目标当完整修正

## 13. MD-7.9.1-TripleCommutatorPrinted

- source\_id：MD-7.9.1-TripleCommutatorPrinted；印刷页 299 / PDF页 320。
- 原文引文（逐字）：


$$
[\mathcal L_A^\dagger,\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho_\beta=(2\beta p^T(\nabla^2U)\nabla U-\nabla^3U:p\otimes p\otimes p)\rho_\beta,
$$



$$
[\mathcal L_B^\dagger,\mathcal L_B^\dagger,\mathcal L_A^\dagger]\rho_\beta=-(2\beta p^T(\nabla^2U)\nabla U)\rho_\beta.
$$



- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：已目视核对PDF320／印刷299：首条三重交换子的三阶导数项未带β；后面的PDE却把β乘整个括号，且直接微分给出共同β。原文版与补β修正版独立保留。
- 反例或理由：取n=1、m=1、U(q)=q⁴、β=2、q=p=1，则U′=4，U″=12，U‴=24，hessianGrad=48，cubicThird=24，ρ=e^(−3)。由A=−p∂q、B=U′∂p得[A,[A,B]]f=p²U‴∂p f−2pU″∂q f，作用于ρ得到β(2pU″U′−p³U‴)ρ=144e^(−3)。Printed给(2β·48−24)ρ=168e^(−3)，不同。四次势光滑且Gibbs可归一。
- 原文版 Lean 名称及状态：`MD.Ch07.hessianU`：定义；`MD.Ch07.thirdU`：定义；`MD.Ch07.hessianGrad`：定义；`MD.Ch07.cubicThird`：定义；`MD.Ch07.tripleCommutatorPrinted`：定义；`MD.Ch07.tripleCommutator_factor_counterexample`：已证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch07.tripleCommutatorPrinted_corrected`：定义；`MD.Ch07.tripleCommutator_corrected`：未证（缺大型理论） 字面式忠实保留缺β；单位质量修正版和实际双交换子恒等式独立，数值系数反例只是代数反例，网站给四次势的数学反例另记。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留Printed字面式，在JSON问题登记中保留[ERRATUM?]三阶项缺β；修正版独立标注。若后续要正式反驳字面公式，可用下述光滑可归一势函数，而不只用系数代数。
- 网站首轮结论：NEEDS\_HUMAN。C分项：hessianU、thirdU、hessianGrad、cubicThird的对象、域与求和指标正确；tripleCommutatorPrinted作为字面表达式PASS；_corrected以及其实际双重phaseComm定理在β>0、光滑U、单位质量下PASS。factor\_counterexample的代数断言PASS但并未声称构造势函数。原书首式缺β是真正的数学疑误，按任务要求保留原文并汇总NEEDS\_HUMAN；不能因修正版正确就把字面原书公式判为数学定理通过。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。原送审\_corrected及实际双交换子定理PASS

## 14. MD-7.9.1-SymmetricRHS

- source\_id：MD-7.9.1-SymmetricRHS；印刷页 299 / PDF页 320。
- 原文引文（逐字）：


$$
\mathcal L_{LD}^\dagger(\rho_\beta f_{2,[OABAO]})=\frac\beta{24}(6p^T(\nabla^2U)\nabla U-\nabla^3U:p\otimes p\otimes p)\rho_\beta,
$$



$$
\mathcal L_{LD}^\dagger(\rho_\beta f_{2,[OBABO]})=\frac\beta{24}(2\nabla^3U:p\otimes p\otimes p-6p^T(\nabla^2U)\nabla U)\rho_\beta.
$$


> We can see immediately that the Fredholm alternative holds in both cases, as both equations have right-hand sides that are of odd order in $p$, and hence will average to 0.

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：零均值只验证必要兼容条件；完整Fredholm可解性需要明确函数空间、算子域、核/余核与闭值域资格。
- 反例或理由：零均值只核对一个兼容方向；若不指明算子及域，不能据此排除其他余核或非闭值域障碍。这是资格缺失，非对所列零积分Lean声明的反例。
- 原文版 Lean 名称及状态：`MD.Ch07.symmetricRHS`：定义；`MD.Ch07.symmetricRHS_odd`：已证；`MD.Ch07.symmetricRHS_zeroMean`：未证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：保留限定定义或子结论；没有独立完整修正版定理。 单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。
- 待人工核查点：所列函数、奇性及零积分签名PASS；零均值只是必要兼容条件，函数空间、算子域与核/余核资格仍待确认。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留原文，在issues加入[ERRATUM?]：这里只验证必要零均值；完整Fredholm结论另需函数空间、算子域和核/余核资格。Lean签名无需修改。
- 网站首轮结论：FAIL。C分项：symmetricRHS的两种标量多项式PASS；odd对所有flip,U,β,x成立，PASS；zeroMean带可积性时PASS。完整原文覆盖FAIL：未将多项式乘Gibbs权识别为−L2ρ或LD(ρf2)，也未建立真实原页积分和productGibbs积分的正有限归一化桥。奇性与零均值不构成给定闭算符的Fredholm替代定理。A中的原书充分性措辞另外判NEEDS\_HUMAN，保留而不篡改。
- 网站复审结论：NEEDS\_HUMAN。V n=Fin n→ℝ、Phase n=V n×V n；Hessian/三阶张量按附录D3–D11真实坐标导数定义。flip=false对应OABAO、true对应OBABO；β/24及张量收缩正确。odd声明对全部U、β和x成立，代数奇性无需正则性。zeroMean只加实际productGibbs的可积性，Gaussian动量反射不变足够；即使β≤0发生退化也仍对称，故无须据此判缺β>0。没有断言其为归一概率或完整PDE/Fredholm充分可解性；原书的后者存在函数空间资格疑点。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
- 分版本结论：修正版/限定声明=网站PASS；原文疑误或范围待导师。所列函数、奇性及零积分签名PASS；零均值只是必要兼容条件，函数空间、算子域与核/余核资格仍待确认。

## 15. MD-7.9.1-ConjugateSymmetricCorrections

- source\_id：MD-7.9.1-ConjugateSymmetricCorrections；印刷页 300–301 / PDF页 321–322。
- 原文引文（逐字）：


$$
\widehat\rho_{[ZYOYZ]}=\exp((h/2)\mathcal L_Z^\dagger)\exp((h/2)\mathcal L_Y^\dagger)\exp((h/2)\mathcal L_O^\dagger)\widehat\rho_{[OYZYO]}.
$$



$$
f_{2,[ZYOYZ]}\rho_\beta=f_{2,[OYZYO]}\rho_\beta+\tfrac14\mathcal L_{1,[OYZ]}^\dagger\rho_\beta.
$$



$$
\mathcal L_{1,[OAB]}^\dagger\rho_\beta=\tfrac12\mathcal L_H^\dagger(g\rho_\beta),\qquad \mathcal L_{1,[OBA]}^\dagger\rho_\beta=-\tfrac12\mathcal L_H^\dagger(g\rho_\beta),
$$



$$
\mathcal L_H^\dagger(g\rho_\beta)=\beta(|\nabla U|^2-p^T\nabla^2Up)\rho_\beta,
$$



$$
f_{2,[ABOBA]}=f_{2,[OBABO]}-\tfrac\beta8(|\nabla U|^2-p^T\nabla^2Up),\tag{7.30a}
$$



$$
f_{2,[BAOAB]}=f_{2,[OABAO]}+\tfrac\beta8(|\nabla U|^2-p^T\nabla^2Up).\tag{7.30b}
$$



- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：已目视核对PDF321：所印传播子展开末项为(h²/2)L\_LD，按exp的二阶展开应为(h²/8)(L\_LD)²；该项作用ρβ为零，不改变后续修正关系。
- 反例或理由：取L0为实数上的恒等算符，L1=0，两种截断的二次项分别为h²/2与h²/8，说明不能把两版当成一般相等的算符；在L0ρβ=0时差项确实消失。
- 原文版 Lean 名称及状态：`MD.Ch07.gradNormSq`：定义；`MD.Ch07.hessianQuadratic`：定义；`MD.Ch07.conjugateCorrectionChange`：定义；`MD.Ch07.conjugateCorrections`：定义；`MD.Ch07.conjugateCorrection_coefficient`：已证；`MD.Ch07.conjugateExpansionPrinted`：定义。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch07.conjugateExpansionPrinted_corrected`：定义 两条候选修正函数关系、给定二阶传递系数后的代数消项、原印展开及二阶截断修正版；不含真实分裂不变分布传递、L1ρ或实际误差系数识别。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留Printed；将展开疑误显式标[ERRATUM?]。将真实分裂传递、L1作用ρβ和(7.30)实际误差系数识别列为独立签名，勿用纯代数消项代替。
- 网站首轮结论：NEEDS\_HUMAN。C：V n=Fin n→ℝ，Phase n为位置/动量对；梯度、Hessian及pᵀHess(U)p的下标收缩正确，conjugateCorrections完整记录两条函数等式。coefficient对任意实模E及线性自同态L0,L1量化，在L0(p0)=0、p1=0和明确的二阶传递假设下消项正确。[EXTRA]这些是假设的系数，不是具体分裂传播子的系数识别；ρβ、具体ST/TS不变分布传递及Hamiltonian微分恒等式没有相应完整声明。Printed逐字保留原印，忠实性PASS；_corrected的1/8及平方修正合理，作为二阶截断定义PASS，不能当作完整指数等式。因原印疑误本条综合NEEDS\_HUMAN。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。原送审\_corrected作为二阶截断定义PASS，非完整指数等式

## 16. MD-7.9.2-OUKernelQualification

- source\_id：MD-7.9.2-OUKernelQualification；印刷页 302 / PDF页 323。
- 原文引文（逐字）：

> The first equation at order one tells us that $f_{2,0,[OABAO]}(q,p)$ must be a function of position only, as the kernel of $\overline{\mathcal L}_O^\dagger$ is the set of functions that are constant with respect to $p$. Hence we shall denote $f_{2,0,[OABAO]}(q,p)=\nu(q)$, where $\langle\nu\rangle=0$.

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：已目视核对PDF323：前向OU生成元的核实际是Gaussian密度倍数；对ρβf共轭后，合适L²域中的f才对p为常数。原文此句缺少共轭与定义域限定。
- 反例或理由：n=1、β>0，f(p)=exp(−βp²/2)满足∂p(pf)+β⁻¹∂ppf=0但非常数；常数1反而满足Ō†1=1。此反例针对Printed裸核句，不反驳corrected的ρf共轭与L²核结论。
- 原文版 Lean 名称及状态：`MD.Ch07.ouKernelPrinted`：定义。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch07.ouKernelPrinted_corrected`：未证（缺大型理论）；`MD.Ch07.ouKernelCentered_corrected`：未证（缺大型理论） 原印裸前向OU核为常数的错误命题保留；修正版为Gibbs共轭及动量Gaussian L²中的核刻画，中心化推论另加概率及零均值。
- 待人工核查点：密度共轭与Gaussian L²域的两个修正版签名PASS；裸前向OU核原印疑误待导师。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留ouKernelPrinted字面目标；把corrected标为密度共轭与Gaussian L²域的修正版；中心化结论继续保留额外概率、可积及零均值前提。
- 网站首轮结论：NEEDS\_HUMAN。C：ouKernelPrinted对任意V n→ℝ函数量化，原印核的错误忠实保留，literal忠实性PASS。_corrected作用于ρβf，要求β>0、f全局光滑、每个q的f(q,·)属于动量Gaussian L²，结论对所有q,p给出f(q,p)=ν(q)，该共轭后核陈述正确；Gaussian L²是必要的域限定而非原印已有前提，应标[EXTRA]。结论不含⟨ν⟩=0，原页中心化须另行加上，不能由核自动推出。sorry不影响本次判断。
- 网站复审结论：NEEDS\_HUMAN。ouKernelPrinted逐字面保留裸前向OU核断言，作为Prop而非定理，不因原印错误判转写FAIL。corrected假设β>0、f全相空间C∞、每个q切片在非退化Gaussian L²中，且Ō†(ρf)=0；Gibbs共轭得到β⁻¹Δpf−p·∇pf=0，L²核为常数，光滑性使结论从几乎处处提升为∀q,p。U无需对q光滑，因为本式只对p微分。centered版额外给位置概率、全空间可积与零均值，结论含ν可积及其零均值，未从核条件凭空推出中心化。两修正版陈述合理，原印疑误需人工确认。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
- 分版本结论：修正版/限定声明=网站PASS；原文疑误或范围待导师。密度共轭与Gaussian L²域的两个修正版签名PASS；裸前向OU核原印疑误待导师。

## 17. MD-7.9.2-FirstReciprocalCorrection

- source\_id：MD-7.9.2-FirstReciprocalCorrection；印刷页 303–304 / PDF页 324–325。
- 原文引文（逐字）：


$$
f_{2,1,[OABAO]}=-\tfrac\beta{24}(6p^T(\nabla^2U)\nabla U-\tfrac13\nabla^3U:p\otimes p\otimes p-\tfrac2\beta p^T\nabla_q\Delta_qU)-p^T\nabla\nu-\mu.
$$



$$
\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,2,[OABAO]})=-\mathcal L_H^\dagger(\rho_\beta f_{2,1,[OABAO]}).\tag{7.35}
$$



$$
\int_{\mathcal P}\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,2,[OABAO]})d\omega_p=0,\qquad \int_{\mathcal P}\mathcal L_H^\dagger(\rho_\beta f_{2,1,[OABAO]})d\omega_p=\overline\pi\mathcal L_H^\dagger f_{2,1,[OABAO]}=0,\tag{7.36}
$$


> where $(\overline\pi f)(q)=\int_{\mathcal P}f(q,p)\rho_\beta d\omega_p$.

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：已目视核对PDF324–325：π̄定义带联合ρβ权，后续M公式却使用归一条件动量平均并隐含ρβ共轭。本文区分原文加权积分与修正的条件Gaussian平均，避免遗漏位置密度因子。
- 反例或理由：取n=1、β=1、U(q)=q²/2、f≡1。momentumAveragePrinted f(q)=exp(−q²/2)/√(2π)，momentumAveragePrinted\_corrected f(q)=1，二者不相同。另一方面本项目H†=−p∂q+U′∂p满足H†ρ=0，故H†(ρf)=ρH†f，原印(7.36)这一Hamiltonian乘积等式本身不应被误判为反例；疑点在后续归一化与算子解释。
- 原文版 Lean 名称及状态：`MD.Ch07.firstReciprocalCorrection`：定义；`MD.Ch07.momentumAverage`：定义；`MD.Ch07.momentumAveragePrinted`：定义；`MD.Ch07.firstReciprocalCorrection_pde`：未证；`MD.Ch07.conjugatedPhaseH`：定义；`MD.Ch07.jointGibbsQualification`：定义。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch07.momentumAveragePrinted_corrected`：定义 一阶候选及PDE、条件Gaussian平均和原印联合归一密度的动量积分；二者不是同一算子；f2,2、(7.35)/(7.36)通量与可解性未覆盖。
- 待人工核查点：所列限定签名PASS；联合权平均与条件平均分别登记。本项目Hρ=0，故H(ρf)=ρHf，撤销把该Hamiltonian乘积等式本身判错的解释；疑点在后续M归一化与算子解释。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留Printed联合权定义，明确它等于位置边际密度乘条件平均；后续纯位置算子M的识别须用条件平均并声明所用算子/共轭。不得简单说H†(ρf)≠ρH†f，因为本项目的Hamiltonian输运恰保持Gibbs权。
- 网站首轮结论：NEEDS\_HUMAN。C：firstReciprocalCorrection和一阶PDE的正负号正确；β>0、U/ν光滑足够，μ任意q函数不会影响OU动量微分。momentumAverage是归一条件Gaussian平均；Printed是Lebesgue动量积分乘未归一gibbsWeight，原书ρβ则为归一联合密度，因此一般还差总配分常数。_corrected作为条件平均定义合理，但与Printed不是同一算符，必须说明位置边际因子及归一常数。完整声明没有f2,2对象、(7.35)、OU通量零积分或(7.36)的相容结论；extra\_assumptions虽承认未证明，实际缺的是签名而非证明。
- 网站复审结论：NEEDS\_HUMAN。候选f₂,₁=−β·primitive/24−p·∇ν−μ，与原印一致；PDE的完整结论Ō(ρf₂,₁)+H(ρν)=+symmetricRHSρ=−wρ，符号正确，所加β>0及U、ν C∞合理。Printed是带全相空间配分函数的联合归一密度积分；corrected是独立Gaussian条件平均，不是同一算子。conjugatedPhaseH=H(ρf)/ρ，ρ严格正可除。jointGibbsQualification只定义β>0、可积及配分函数正，不是证明其成立。二阶方程和通量条件已列未覆盖。本项目Hamiltonian输运满足Hρ=0，因此H(ρf)=ρHf；不能将(7.36)该等式本身判错。真正的原书疑点在随后M的归一化与算子解释，需保留该限定。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
- 分版本结论：修正版/限定声明=网站PASS；原文疑误或范围待导师。所列限定签名PASS；联合权平均与条件平均分别登记。本项目Hρ=0，故H(ρf)=ρHf，撤销把该Hamiltonian乘积等式本身判错的解释；疑点在后续M归一化与算子解释。

## 18. MD-7.9.2-OverdampedSolvabilityOperators

- source\_id：MD-7.9.2-OverdampedSolvabilityOperators；印刷页 304 / PDF页 325。
- 原文引文（逐字）：

> We abbreviate

$$
\mathcal M\psi(q)=\overline\pi\mathcal L_H^\dagger\mathcal L_A^\dagger\psi(q) =\overline\pi((\mathcal L_A^\dagger)^2+\mathcal L_B^\dagger\mathcal L_A^\dagger)\psi(q) =\beta^{-1}\Delta_q\psi(q)-\nabla U\cdot\nabla_q\psi(q),
$$



$$
\mathcal N\psi(q)=\overline\pi\mathcal L_H^\dagger(\mathcal L_A^\dagger)^3\psi(q) =\overline\pi((\mathcal L_A^\dagger)^4+\mathcal L_B^\dagger(\mathcal L_A^\dagger)^3)\psi(q) =\tfrac3\beta\mathcal M(\Delta_q\psi(q)).
$$


> Thus we have

$$
\overline\pi\mathcal L_H^\dagger\rho_\beta f_{2,1,[OABAO]}=\tfrac\beta8\mathcal M(|\nabla U|^2-\beta^{-1}\Delta_qU)+\mathcal M\nu,
$$


> and hence by (7.36) we finally obtain $\nu(q)=\tfrac18(\Delta_qU-\beta|\nabla U|^2)$, where $\langle\nu\rangle=0$.

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：原文论证范围或技术资格需选定；不直接断言公式错误。
- 反例或理由：n=1、U=q²/2、β=1、ψ=1，按裸前向定义A†ψ=0，故π̄H†A†ψ=0；而用ψ=q²等非恒定函数时裸H†A†ψ的力项符号为+U′ψ′，与M中的−U′ψ′不符。共轭后的算符才给正确负号。
- 原文版 Lean 名称及状态：`MD.Ch07.overdampedM`：定义；`MD.Ch07.overdampedN`：定义；`MD.Ch07.highFrictionOABAO`：定义；`MD.Ch07.overdampedSolvability_choice`：已证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：保留限定定义或子结论；没有独立完整修正版定理。 M/N和候选函数定义以及β≠0下代数改写；Gibbs共轭与裸前向算子区分，未含平均识别、相容性、核唯一或零均值结论。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：显式区分裸前向算符和Gibbs共轭算符，保持原印并标[ERRATUM?]；补完整M/N识别、相容性及中心化签名，不能将choice称为解的识别定理。
- 网站首轮结论：NEEDS\_HUMAN。C：overdampedM正确记录β⁻¹Δψ−∇U·∇ψ，N正确记录3M(Δψ)/β，候选ν正确。choice仅在β≠0时对所有q证明同一公式的代数改写，真实但远弱于可解性：没有M/N的平均算符识别、相容方程、ν的核唯一性或零均值声明。[EXTRA]β≠0足够代数运算，但物理Gaussian与积分分部需β>0、正则性、可积和边界资格。原印的算符不一致需人工决定采用哪一共轭约定。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。见网站逐项原文意见；不把较弱目标当完整修正

## 19. MD-7.10-ColoredNoiseAndExtension

- source\_id：MD-7.10-ColoredNoiseAndExtension；印刷页 308 / PDF页 329。
- 原文引文（逐字）：

> We can think of the noise process in (7.40) as corresponding to a colored noise which has characteristics that directly depend on the stepsize, although the noise decorrelates in just a couple of timesteps. This is therefore no longer a Markov process, however it can be reformulated as such if one considers the appropriate extended space (or keeping the momenta $p_n$).

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：有色噪声不能单独推出位置过程无例外地非Markov；特定势与初态下位置序列可以仍为Markov。
- 反例或理由：正参数下亦有例外：n=1、m=θ=1、τ>0，U(q)=q²/τ，b=√(τ/2)。令初态q₀=bS、旧噪声为S，S与所有新标准正态Rₖ独立，则LM给qₖ₊₁=−qₖ+b(Rₖ+Rₖ₋₁)。归纳qₖ=bRₖ₋₁（R₋₁=S），故位置序列为独立Gaussian，确为Markov；噪声b(Rₖ+Rₖ₋₁)仍有非零相邻协方差。因此不能由有色噪声推出位置过程无例外地非Markov。
- 原文版 Lean 名称及状态：`MD.Ch07.coloredNoise`：定义；`MD.Ch07.coloredNoise_covariance`：未证；`MD.Ch07.lmExtendedStep`：定义；`MD.Ch07.lmExtendedKernel`：定义；`MD.Ch07.lmExtendedChain`：定义；`MD.Ch07.lmExtendedChain_markov`：未证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：保留限定定义或子结论；没有独立完整修正版定理。 邻接噪声协方差（额外推论）、扩展状态映射和真实Gaussian转移核；给定可测性及每步新噪声对初态/全部过去独立时，扩展过程的Markov集合积分式。位置过程非Markov仅作一般情形说明，不作无例外全称定理。
- 待人工核查点：fresh独立性下Markov集合积分式签名PASS；删去过时的同名缺口。协方差为额外推论，位置非Markov仍需限定。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：删去已过时的Markov定理缺口，登记实际已覆盖的fresh独立性版本；保留一般位置非Markov的说明，不写无例外全称定理，并把协方差明确标[EXTRA]。
- 网站首轮结论：FAIL。C：coloredNoise采用相邻标准独立Gaussian平均，索引(R\_k,R_{k+1})与原页(R\_n,R_{n−1})仅差移位；covariance对概率P、iIndepFun和HasLaw量化，方差1/2、邻接协方差1/4、其余0正确，应标[EXTRA]推导结论。lmExtendedStep把(q,R旧)映射到(lmStep(R新,R旧,q),R新)正确。但未有新噪声独立于过去的过程条件、Markov核/条件分布或扩展Markov性声明；只给一个确定性状态映射不能覆盖原页的核心Markov断言。一般位置过程非Markov也不宜无条件量化。
- 网站复审结论：NEEDS\_HUMAN。coloredNoise=(Rk+Rk+1)/2是对原文相邻噪声的移位记号；独立标准正态使其均值零，二阶矩分别为1/2、1/4、0，故covariance名虽结论写E[ηjηk]仍正确。这是[EXTRA]协方差结论。extendedStep输入状态(q,旧噪声)，输出(lmStep(新,旧,q),新)，Kernel为δ状态×标准Gaussian的可测推前，确为转移核。chain递归k=0起，markov的hfresh要求Rk独立于X0及R0,…,Rk−1，hstep、hX0与vectorNormalSequence足以保证对X0,…,Xk历史中所有可测B的集合积分恒等式；索引Fin(k+1)正确。metadata却仍称Markov定理未覆盖，须订正。原书由有色噪声直接推非Markov也须保留例外资格。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
- 分版本结论：修正版/限定声明=网站PASS；原文疑误或范围待导师。fresh独立性下Markov集合积分式签名PASS；删去过时的同名缺口。协方差为额外推论，位置非Markov仍需限定。

## 20. MD-7.10-LimitMethodAccuracy

- source\_id：MD-7.10-LimitMethodAccuracy；印刷页 308 / PDF页 329。
- 原文引文（逐字）：

> We would expect that this scheme should have an $O(h^4)=O(\tau^2)$ error in configurational averages. For averages computed in finite time, work in [224] has shown that (7.40) does indeed give a first order error, albeit one that vanishes exponentially fast in time as the simulation progresses. Hence for suitably long simulations, the observed error will be $O(h^2)$.

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：已目视核对PDF329：本段前面以τ为实际过阻尼步长并称长期二阶，末句却写O(h²)。若仍沿用τ=h²/2，应区分长期O(τ²)=O(h⁴)和有限时一阶O(τ)=O(h²)；原文符号存在歧义。
- 反例或理由：抽象误差e(τ,T)=e^(−T)τ+τ²满足所定义的瞬态上界；任意固定有限T，代入τ=h²/2仍有非零h²项；先T→∞则仅剩h⁴/4。故固定“足够长”T不能给h→0时的严格四阶，需先长期极限或T随h增长。
- 原文版 Lean 名称及状态：`MD.Ch07.lmTransientErrorBound`：定义；`MD.Ch07.limitAccuracyPrinted`：定义；`MD.Ch07.limitAccuracy_rescale`：已证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch07.limitAccuracyPrinted_corrected`：定义；`MD.Ch07.limitAccuracyInfiniteTime_corrected`：定义 瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。
- 待人工核查点：限定定义和长期极限连接签名PASS；h⁴仅在先取长期极限的解释下适用，不表示固定有限时间四阶或真实LM误差界已证。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：原文末句保留并标[ERRATUM?]；若h仍指Langevin步长，长期误差写O(h⁴)=O(τ²)，固定有限时间写O(h²)=O(τ)。把h⁴修正版始终连接到InfiniteTime\_corrected的longtime。
- 网站首轮结论：NEEDS\_HUMAN。C：Printed忠实保留h²幂次，PASS；_corrected给h⁴合理对应无限时间不变平均，但必须限定该error为长期误差，不能直接用于固定有限T。lmTransientErrorBound正确记录C(e^(−aT)τ+τ²)的一种充分界，正C/a/δ及所有小τ、T≥0的量词明确，属于[EXTRA]精确定量目标；原书文字本身不保证该统一界。rescale恒等式正确。缺少LM真实平均误差与error的联系、势/观测/初值条件和实际误差满足该界的签名。
- 网站复审结论：NEEDS\_HUMAN。瞬态界的量词是存在统一C>0、衰减率>0、δ>0，∀0<τ<δ及∀T≥0，界C(e^(−λT)τ+τ²)；它只是error的性质定义。Printed保留h→0正侧的O(h²)，corrected改为O(h⁴)，rescale代数式τ²=h⁴/4正确。InfiniteTime\_corrected显式把固定h先T→∞的longtime接到O(h⁴)，防止把固定有限T误判四阶。任何声明都未证明真实LM误差满足瞬态界。原书末句符号歧义保留，孤立corrected定义应仅在长期语境中解释。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
- 分版本结论：修正版/限定声明=网站PASS；原文疑误或范围待导师。限定定义和长期极限连接签名PASS；h⁴仅在先取长期极限的解释下适用，不表示固定有限时间四阶或真实LM误差界已证。

## 21. MD-7.12-ConstrainedLangevin

- source\_id：MD-7.12-ConstrainedLangevin；印刷页 317 / PDF页 338。
- 原文引文（逐字）：


$$
dq=M^{-1}pdt,\tag{7.43}
$$



$$
dp=-\nabla U(q)dt-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\tag{7.44}
$$



$$
0=g(q).\tag{7.45}
$$


> The vector of $l$ constraints is given by $g:\mathbb R^{N_c}\to\mathbb R^l$ and $\lambda$ is an $l$-dimensional vector of Lagrange multipliers. $W$ is a vector of standard Wiener processes, with the usual friction parameter $\gamma>0$. Permissible phase points lie in the co-tangent bundle defined by the constraint and hidden constraint

$$
g(q)=0,\qquad g'(q)M^{-1}p=0.
$$



- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：原文论证范围或技术资格需选定；不直接断言公式错误。
- 反例或理由：n=l=1、m=1、g(q)=q、U=0且γ,θ>0。约束与隐藏约束迫使q=p=0；原印动量式要求∫₀ᵗΛs ds=√(2γθ)(Wt−W0)，左侧有限变差，右侧Brownian有正二次变差，不可能。修正版取C=1、proj=0时投影噪声为零，没有此冲突。
- 原文版 Lean 名称及状态：`MD.Ch07.constraintJacobian`：定义；`MD.Ch07.constraintReaction`：定义；`MD.Ch07.hiddenConstraint`：定义；`MD.Ch07.cotangentConstraint`：定义；`MD.Ch07.constrainedLangevin`：定义。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch07.constrainedLangevin_corrected`：定义 原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。
- 待人工核查点：单位质量线性约束投影修正版签名PASS；原印有限变差乘子模型不声称一般存在。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：原版作为字面解类保留并标[ERRATUM?]，不声称一般存在。corrected保留单位质量线性约束的投影模型并标[EXTRA]范围限制；一般非线性情形需随机乘子反作用及相应几何处理。
- 网站首轮结论：NEEDS\_HUMAN。C：Jacobian、反力求和、g′M⁻¹p=0和约束相空间定义正确；vectorWiener确含概率、联合Gaussian、标准协方差、连续路径和坐标过程独立。积分式的m\_i、γ、θ、W增量及初值无误。[EXTRA]正质量/温度、C²约束、自然W历史适应、确定初值及逐sample可积都是对解类的额外限制，非原页已给定全部资格。关键问题：Λ被限定为普通时间可积过程，反力只有有限变差∫g′ᵀΛds，无法抵消标准环境W的法向Brownian分量而保持隐藏约束；若原书λdt意指随机冲量，当前定义就不忠实于通常约束Langevin。若严格照字面则继承原印问题，不能据此断言有解。
- 网站复审结论：NEEDS\_HUMAN。V n、V l、Jacobian(j,i)、Reaction=JacobianᵀΛ及hiddenConstraint中的p\_i/m\_i均对应原式；θ=kBT，质量为正对角质量而非一般非对角矩阵，是[EXTRA]范围限制。vectorWiener的联合Gaussian、零均值、min协方差、连续路径和坐标独立规格确为标准向量Wiener。原版限定正时间，X和Λ适应W的自然历史、X路径连续/确定初值几乎处处，漂移逐路径可积，∀t≥0几乎处处满足完整约束和两个积分方程；λ确以dt积分，仅保留原印解类，不宣称存在。corrected仅单位质量、线性齐次约束Cq=0：proj自伴幂等、Cproj=0且恒等于ker C，故正是到ker C的正交投影；投影力和噪声、摩擦−γp与两条约束一致，修正合理。原印一般非退化噪声与有限变差反作用难以保持隐藏约束，应加[ERRATUM?]。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
- 分版本结论：修正版/限定声明=网站PASS；原文疑误或范围待导师。单位质量线性约束投影修正版签名PASS；原印有限变差乘子模型不声称一般存在。

## 22. MD-7.12-ConstrainedCanonicalErgodicity

- source\_id：MD-7.12-ConstrainedCanonicalErgodicity；印刷页 317 / PDF页 338。
- 原文引文（逐字）：

> In the infinite time limit, we have that solution trajectories of constrained Langevin (7.43)–(7.45) sample $\widetilde\rho_\beta$ ergodically, such that

$$
\lim_{T\to\infty}\frac1T\int_0^T\phi(q(t),p(t))dt=\int_{\mathcal D}\phi(q,p)\widetilde\rho_\beta d\omega,
$$


> where $\widetilde\rho_\beta$ is the normalized constrained canonical distribution

$$
\widetilde\rho_\beta=Z^{-1}\exp(-\beta H(q,p))\delta[g(q)]\delta[g'(q)M^{-1}p],
$$


> for normalizing constant $Z$ and where $\delta[z]:=\prod_i\delta[z_i]$ for a vector $z$.

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：原文论证范围或技术资格需选定；不直接断言公式错误。
- 反例或理由：ergodicity：n=l=1，m=β=1，g(q)=q²−1，U(q)=q²/2。约束相空间只有(q,p)=(1,0),(−1,0)；g′在约束集非零。环境delta参考在两点各有质量1/4，归一化canonical在两点各有质量1/2，配分积分正有限。连续受约束轨道不能换分支，φ(q,p)=q的时间平均为±1，canonical平均为0。因此这些参考/配分资格仍不足以推出遍历性。此处轨道按通常允许随机约束冲量的意义解释。；reference\_ambiguity：n=2,m=(1,1)，g(q)=(1+q₁²)q₂，U=(q₁²+q₂²)/2。在约束q₂=p₂=0上，环境delta乘积参考是(1+q₁²)^(−2)dq₁dp₁；换成等价约束g₀(q)=q₂则为dq₁dp₁。前者的Gram因子g′M⁻¹g′ᵀ=(1+q₁²)²可抵消该差别。故若dω指环境Lebesgue体积，原印密度不能自动等于普通水平Langevin的canonical密度；若dω另含换算因子，需明确。；scope：不是对四个def的反例；反驳的是把这些定义或资格当成原印完整遍历定理。
- 原文版 Lean 名称及状态：`MD.Ch07.constrainedCanonical`：定义；`MD.Ch07.constrainedReference`：定义；`MD.Ch07.constrainedErgodicAverages`：定义；`MD.Ch07.constrainedCanonicalQualification`：定义。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：保留限定定义或子结论；没有独立完整修正版定理。 delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。
- 待人工核查点：四个参考与遍历目标定义的限定范围获认可；没有完整受约束SDE遍历定理，几何参考体积和连通/不可约资格仍待导师。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留原印公式并标[ERRATUM?]；明确dω及delta/几何体积换算，另列动力学解、连通/满秩/不可约等所需资格。继续把现有四个def标成“参考与遍历目标”，不得声称已建立SDE遍历性。本次只登记，不改工程。
- 网站首轮结论：NEEDS\_HUMAN。C：constrainedReference用(πε)^(−l)对2l个标量约束同时正则化，常数和ε幂正确，且显式要求支撑于cotangentConstraint；作为所印delta乘积的弱极限目标是忠实的。constrainedCanonical接受任意ν，未要求它满足constrainedReference、配分积分正有限或β>0，因此并非自动归一约束canonical。constrainedErgodicAverages仅是对任意P/X/μ的遍历目标定义，没有将μ连接到该canonical、也没有X满足约束SDE的前提或相应蕴涵声明。原书delta参考测度与自然约束相空间体积的Jacobian因子和遍历性条件需人工处理；extra\_assumptions的提醒不足以连接这些签名。
- 网站复审结论：NEEDS\_HUMAN。四个声明作为已缩小范围的定义基本忠实且内部合理，但没有完整的受约束SDE遍历结论。原书无条件遍历采样及delta参考的解释存在实质疑问，必须依任务规则保留原印并判NEEDS\_HUMAN；本判定不是因没有补证明或因sorry。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。四个参考与遍历目标定义的限定范围获认可；没有完整受约束SDE遍历定理，几何参考体积和连通/不可约资格仍待导师。

## 23. MD-7.12-ConstrainedHOSplitting

- source\_id：MD-7.12-ConstrainedHOSplitting；印刷页 318 / PDF页 339。
- 原文引文（逐字）：

> We could instead consider splitting the dynamics up and performing the integration using a splitting method. One uses

$$
H_c:\quad dq=M^{-1}pdt,\quad dp=-\nabla U(q)dt-g'(q)^T\lambda dt,\quad g(q)=0,
$$



$$
O_c:\quad dq=0,\quad dp=-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\quad g(q)=0.
$$


> We solve these two pieces symmetrically, where the constrained Hamiltonian part is solved over a step $h$, in between two solves of the Ornstein-Uhlenbeck SDE with stepsize $h/2$.

- 原页核对：已目视核对原页PDF339（本轮）；原印Hc/Oc都写λdt，O步含Wiener噪声。
- 问题所在：原印λdt若理解为普通有限变差反作用，无法抵消约束法向Wiener噪声；保留原文，采用可含随机部分的reactionImpulse作为限定解释，待导师确认。
- 反例或理由：type\_level\_witness：令l=1、g(q)恒为1，则cotangentConstraint为空。两个MapQualification的∀x∈cotangentConstraint均真，甚至可令P=0、W=0并任取H/O；QualifiedComposition仍接受hH/hO，但P.prod P=0并非概率、W也非Wiener。故最后类型并不无条件规定其注释所称的乘积概率空间。即使限定非空约束及合规输入，也仍须补联合可测性来处理随机初值。；random\_initial\_state\_gap：对每个确定x有P(N\_x)=0并不单独给出{(ω,x):ω∈N\_x}的乘积可测性。现有O资格允许零测例外依赖x，且没有(sample,x)联合可测性；因此对独立的随机x使用Fubini/条件分布缺少必要前提。这是规格缺口，不声称每个具体O-H-O算法都会失败。；printed\_multiplier：n=l=1，g(q)=q，m=γ=θ=1，x0=(0,0)。cotangentConstraint迫使q\_t=p\_t=0；O积分方程要求reactionImpulse\_t=√2 W\_t，它不是普通有限变差的∫λ\_s ds。Lean允许随机冲量合理，原印λdt若按普通有限变差读取则不成立。
- 原文版 Lean 名称及状态：`MD.Ch07.constrainedHField`：定义；`MD.Ch07.constrainedOField`：定义；`MD.Ch07.constrainedHOComposition`：定义；`MD.Ch07.constrainedONoise`：定义；`MD.Ch07.constrainedHIntegralStep`：定义；`MD.Ch07.constrainedOIntegralStep`：定义；`MD.Ch07.constrainedHMapQualification`：定义；`MD.Ch07.constrainedOMapQualification`：定义；`MD.Ch07.constrainedHOQualifiedComposition`：定义；`MD.Ch07.constrainedHOQualifiedComposition_measurable`：已证；`MD.Ch07.constrainedHOOutputLaw`：定义；`MD.Ch07.constrainedHOOutput_hasLaw`：已证；`MD.Ch07.constrainedHOOutputLaw_probability`：已证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：保留限定定义或子结论；没有独立完整修正版定理。 H/O漂移、O扩散、逐确定初值的约束积分解规格；资格独立要求概率测度及Wiener噪声，H对初值可测、O对样本与初值联合可测。对h≥0及合规确定初值明确P.prod P上的O-H-O输出、可测性和推前概率分布。随机初值条件解、几乎处处约束保持与完整条件转移核识别尚未建立。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：若继续声称随机组合已覆盖，应在资格中明确P为概率、对初值和样本的联合可测性，指定P.prod P，并把h≥0、合规初值下的输出及随机初值条件解规格列明。或按corrected\_json将范围明确缩回逐初值解规格与代数合成，不声称已完成独立随机核组合。保留原印λ并标[ERRATUM?]，记录冲量解释。本次不改Lean。
- 网站首轮结论：FAIL。C：HField正确记录dq=M⁻¹p与−∇U−g′ᵀλ，OField只记录dq=0和−γp−g′ᵀλ的漂移。composition在任意类型E及任意映射H/O上实现右至左O半步、H全步、O半步，顺序正确。然而完整Oc噪声√(2γkBTM)dW没有参数或扩散对象，本条也没有H/O满足各自受约束方程、g=0及隐藏约束保持的资格。映射E→E还不能直接表达随机OU核及两次独立新噪声；不能以extra\_assumptions中“前条噪声”替代本条缺失的连接签名。FAIL是完整对象/结论缺项，不要求实际流的存在证明。
- 网站复审结论：FAIL。漂移、扩散、分段积分解及O-H-O时间次序核对正确，且hH/hO确已连接分段规格。FAIL限于本条声明要覆盖的独立随机映射组合：规格只逐确定初值可测，没有H/O联合可测性，也未指定P.prod P上的输出随机变量/条件分布。两个坐标的函数不足以保证随机初值下的有效组合。另有原印λdt解释疑义，因此A部分仍NEEDS\_HUMAN。
- 分版本结论：按网站审校意见修复，本地核验通过（未再送网站）。见网站逐项原文意见；不把较弱目标当完整修正

## 24. MD-7.12-MidpointStabilityPrinted

- source\_id：MD-7.12-MidpointStabilityPrinted；印刷页 319 / PDF页 340。
- 原文引文（逐字）：

> The Lagrange multiplier $\lambda_{n+1/4}$ (and likewise $\lambda_{n+1}$) can be obtained by solving the linear system

$$
g'(q_n)M^{-1}[(1-h\gamma/4)p_n+\sqrt{h\gamma k_BTM}R_n-g'(q_n)^T\lambda_{n+1/4}]=0,
$$


> which is easily computed once the $R_n$ vector is evaluated in the step, and gives us a stability criterion

$$
\gamma h<4.\tag{7.46}
$$



- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：已目视核对PDF340／印刷319：所印γh<4保留为原书给出的限制。它保证中点OU放大因子为正；OU线性绝对稳定性本身对γh≥0均成立。原文没有写充要关系，不能把本条当作已确认的原书错误。完整耦合Verlet仍有独立步长限制。
- 反例或理由：multiplierLinearSystem与D7展开后正是原式，无遗漏的分母；中点求解产生的公共因子不影响零约束。Printed仅定义a<4，未伪造充要稳定性。corrected对所有a≥0给出单独OU放大因子绝对值≤1，counterexample在a=8给出同一性质且8不小于4，均正确。不能用这个例子否定整套Verlet算法的充分限制，EXTRA对此区分正确。
- 原文版 Lean 名称及状态：`MD.Ch07.multiplierLinearSystem`：定义；`MD.Ch07.midpointAmplification`：定义；`MD.Ch07.midpointStabilityPrinted`：定义；`MD.Ch07.midpointStability_counterexample`：已证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch07.midpointStabilityPrinted_corrected`：已证 仅覆盖 multiplierLinearSystem, midpointAmplification, midpointStabilityPrinted, midpointStabilityPrinted\_corrected, midpointStability\_counterexample 所列对象、量词、前提和结论。范围说明：multiplierLinearSystem与D7展开后正是原式，无遗漏的分母；中点求解产生的公共因子不影响零约束。Printed仅定义a<4，未伪造充要稳定性。corrected对所有a≥0给出单独OU放大因子绝对值≤1，counterexample在a=8给出同一性质且8不小于4，均正确。不能用这个例子否定整套Verlet算法的充分限制，EXTRA对此区分正确。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留原文条件；补充结果明确标成OU单模态绝对稳定性。
- 网站首轮结论：PASS。multiplierLinearSystem与D7展开后正是原式，无遗漏的分母；中点求解产生的公共因子不影响零约束。Printed仅定义a<4，未伪造充要稳定性。corrected对所有a≥0给出单独OU放大因子绝对值≤1，counterexample在a=8给出同一性质且8不小于4，均正确。不能用这个例子否定整套Verlet算法的充分限制，EXTRA对此区分正确。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：网站PASS（首轮签名未改）。见网站逐项原文意见；不把较弱目标当完整修正

## 25. MD-7.13-SpectralRadiusStability

- source\_id：MD-7.13-SpectralRadiusStability；印刷页 324 / PDF页 345。
- 原文引文（逐字）：

> The stability of the method therefore depends solely on the spectral radius of the matrix $X$. This gives a stability condition

$$
\left|\frac{\eta-h}{\eta}e^{(\eta-\gamma)h/2}+\frac{\eta+h}{\eta}e^{(-\eta-\gamma)h/2}\right|\le1+e^{-\gamma h}.
$$


> Multiplying by $e^{\gamma h/2}$ gives

$$
|\cosh(\eta h/2)+(h/\eta)\sinh(-\eta h/2)|\le\cosh(\gamma h/2).
$$



- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：原文论证范围或技术资格需选定；不直接断言公式错误。
- 反例或理由：generic\_noisy\_unit\_root：X=diag(1,d)，0<d<1，Y=I，Rn为独立标准Gaussian。det X=d，|tr X|=1+d，characteristicUnitDisk成立；第一坐标是随机游走，若初始二阶矩有限，则Var(z\_n,1)=Var(z\_0,1)+n。因此闭圆盘条件不能保证随机长期二阶矩稳定。不是对spectralRadiusStability的反例。；actual\_multipleX\_boundary：亦可在实际multipleX族取Ω=0,γ=η=1，令h*>0满足h*tanh(h*/2)=2。函数h*tanh(h/2)严格递增，从0趋于∞，故该h*存在唯一。此时hyperbolicStability恰取等号，tr X=−(1+e^(−h*))，特征根为−1和−e^(−h*)。原页OU噪声的协方差在h*>0时正定（F=[[0,1],[0,−1]]的噪声响应含(1−e^(−s),e^(−s))，不落在固定一维子空间），乘可逆slowMatrix后仍正定；−1左特征方向因此有逐步方差增长，不能有有限二阶矩平稳分布。；scope：以上反驳的是不区分随机稳定性含义的原印叙述；对四条限定Lean声明没有发现反例。
- 原文版 Lean 名称及状态：`MD.Ch07.characteristicUnitDisk`：定义；`MD.Ch07.spectralRadiusStability`：未证；`MD.Ch07.hyperbolicStability`：定义；`MD.Ch07.multipleX_spectral_hyperbolic`：未证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：保留限定定义或子结论；没有独立完整修正版定理。 实二阶矩阵的闭单位圆谱判据及实际multipleX在γη资格下的双曲条件等价；不含Gaussian驱动有限方差平稳性。
- 待人工核查点：四条闭单位圆谱声明签名PASS；不可把≤边界等同Gaussian噪声下有限二阶矩平稳性，η=0另留缺口。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留原印≤及两条现有等价签名，标[ERRATUM?]并明确其仅是闭单位圆谱判据；另把Gaussian噪声激发方向下的二阶矩平稳性与严格谱半径<1条件分开。显式标[EXTRA]的γ/h/非零复η资格，临界η=0另列极限式。本次不补任何证明。
- 网站首轮结论：FAIL。characteristicUnitDisk量化所有复特征根的模≤1；对实2×2矩阵且0<det<1，与|tr|≤1+det等价，抽象定理签名正确。hyperbolicStability只定义不等式；没有把multipleX、traceFormula、η²关系及η≠0联结到该条件的等价定理，故原条完整结论尚缺桥梁。EXTRA已说明此缺口，不能替代完整形式化。谱边界不等于Gaussian驱动的平稳有限方差条件。
- 网站复审结论：NEEDS\_HUMAN。四条Lean声明的对象、域、全部假设与结论均核对正确；在0<det X<1及γ>0,h>0,η²=γ²−4Ω²,η≠0的前提下，两个等价定理的签名成立。若只看明确缩小的确定性谱范围，可判PASS。全条依任务“原书数学疑误保留并判NEEDS\_HUMAN”的规则，仍需人工界定原印随机系统中的稳定性；不能把闭圆盘条件当成有限方差平稳性，也不能因sorry判FAIL。
- 分版本结论：修正版/限定声明=网站PASS；原文疑误或范围待导师。四条闭单位圆谱声明签名PASS；不可把≤边界等同Gaussian噪声下有限二阶矩平稳性，η=0另留缺口。

## 26. MD-7.13-HyperbolicPhaseTransform

- source\_id：MD-7.13-HyperbolicPhaseTransform；印刷页 324 / PDF页 345。
- 原文引文（逐字）：

> For $\gamma>0$, we can simplify to

$$
\left|\cosh\left(\frac{\eta h}{2}-\operatorname{atanh}\left(\frac h\eta\right)\right)\sqrt{1-\frac{h^2}{\eta^2}}\right|\le\cosh(\gamma h/2).
$$



- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：原文论证范围或技术资格需选定；不直接断言公式错误。
- 反例或理由：例如γ=3、Ω=√2则η=1，取h=2有h/η=2；γ>0成立，但实atanh(2)与实平方根分支不能实现所印变换。
- 原文版 Lean 名称及状态：`MD.Ch07.hyperbolicPhase`：定义；`MD.Ch07.hyperbolicPhase_identity`：已证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：保留限定定义或子结论；没有独立完整修正版定理。 仅实η≠0、|h/η|<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留原文，并明确标[EXTRA]实η≠0及|h/η|<1；复域版本另指定sqrt/artanh分支，或直接保留双曲表达。
- 网站首轮结论：NEEDS\_HUMAN。hyperbolicPhase\_identity对实η≠0及|h/η|<1的等式正确，额外实域前提明确且必要；展开cosh差公式即得cosh(a)−r sinh(a)。它没有覆盖纯虚η或实|h/η|≥1，也未给整个稳定不等式的全参数等价声明。不能由这个有效的受限等式确认原书对所有γ>0的措辞。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。见网站逐项原文意见；不把较弱目标当完整修正

## 27. MD-7.13-UnderdampedPhasePrinted

- source\_id：MD-7.13-UnderdampedPhasePrinted；印刷页 325 / PDF页 346。
- 原文引文（逐字）：

> We consider the case with $\gamma\ll\Omega$, allowing us to write $\eta=i\widehat\eta$ for $\widehat\eta\in\mathbb R$, and

$$
\left|\cos\left(\frac{\widehat\eta h}{2}-\operatorname{atanh}\left(\frac h{\widehat\eta}\right)\right)\sqrt{1+\frac{h^2}{\widehat\eta^2}}\right|\le\cosh(\gamma h/2).
$$



- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：已目视核对PDF346／印刷325：从η=iη̂化为实余弦时应使用+arctan(h/η̂)，所印-atanh(h/η̂)的函数与符号均不符。修正版从cos(a)-r sin(a)的标准幅相恒等式得到。
- 反例或理由：符号错误可直接从cos(a+arctan r)展开验证：其sin(a)项为负；若改成a−arctan r则该项为正。原书的atanh也不能给出所需cos/sin幅值。
- 原文版 Lean 名称及状态：`MD.Ch07.underdampedPhasePrinted`：定义；`MD.Ch07.underdampedPhase_identity`：已证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch07.underdampedPhasePrinted_corrected`：定义 字面三角式及+arctan修正版、任意实a/r的恒等式；模型代入须0≤γ<2Ω及ηhat>0，未由此声称全稳定定理。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保持Printed原样并标[ERRATUM?]；修正版使用+arctan，模型使用时另加0≤γ<2Ω及η̂=√(4Ω²−γ²)>0。
- 网站首轮结论：NEEDS\_HUMAN。Printed定义忠实表达字面公式。corrected定义以及对任意实a,r的underdampedPhase\_identity均正确：cos(a)−r sin(a)=√(1+r²)cos(a+arctan(r))。这是代入η=iη̂后应得形式；η̂>0及η̂²=4Ω²−γ²的模型衔接未在该独立三角恒等式内声明。EXTRA正确承认这一点。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。原送审\_corrected和三角恒等式正确

## 28. MD-7.13-FrictionThresholdPrinted

- source\_id：MD-7.13-FrictionThresholdPrinted；印刷页 325 / PDF页 346。
- 原文引文（逐字）：

> The minimum required friction for stability can be found by considering the case of small timestep. This gives a bound

$$
\frac1{\sqrt{4\Omega^2-\gamma^2}}\le\frac\gamma2,
$$


> which gives a stability condition for all step sizes $h$ as long as

$$
\gamma\ge\Omega\sqrt{2-2\sqrt{1-\Omega^{-4}}}\ge\sqrt2/\Omega.
$$


> Therefore we expect that the minimum friction value required for stability for all timesteps $h>0$, scales with the value of inverse $\Omega$.

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：已目视核对PDF346：最后链式下界√2/Ω不成立。将精确阈值有理化得√(2/(Ω²+√(Ω⁴-1)))，大Ω时约1/Ω；√2/Ω可作更保守的充分选择而非精确阈值下界。Ω²=5/4时精确阈值平方=1，小于2/Ω²=8/5。
- 反例或理由：取Ω=√5/2，Ω²=5/4，则精确阈值平方=2/(5/4+3/4)=1，而(√2/Ω)²=8/5>1，所印下界不成立。此外包络斜率条件等价γ²∈[2Ω²−2√(Ω⁴−1),2Ω²+2√(Ω⁴−1)]，不能只保留下界。
- 原文版 Lean 名称及状态：`MD.Ch07.frictionThresholdPrinted`：定义；`MD.Ch07.frictionBoundPrinted`：定义；`MD.Ch07.frictionThreshold_rationalized`：未证；`MD.Ch07.frictionThreshold_allSteps`：未证；`MD.Ch07.frictionThreshold_asymptotic`：未证；`MD.Ch07.frictionThreshold_squared_counterexample`：已证。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch07.frictionThresholdPrinted_corrected`：定义；`MD.Ch07.frictionBoundPrinted_corrected`：定义 字面错误阈值、保留隐式条件的修正版、Ω≥1有理化/渐近/包络充分性；简化成γ区间须保留高根上界，数值反例不是完整Lean势模型反例。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留[ERRATUM?]；对Ω≥1阈值满足1/Ω≤阈值≤√2/Ω，大Ω渐近1/Ω；若陈述包络条件的充要γ范围，须保留高根上界。
- 网站首轮结论：NEEDS\_HUMAN。Printed定义及frictionBoundPrinted忠实保留错误链。rationalized在Ω≥1时正确；allSteps在Ω≥1、0<γ<2Ω及小步长包络斜率条件下推出所有h≥0的包络，正确；asymptotic极限为1正确。corrected的frictionBound保留隐式条件，避免仅用γ≥低根而漏掉高根上界。squared\_counterexample只有1<8/5的数值真命题，并未将其联结至Ω=√5/2的根式，所以不是Lean中完整的原命题反例；EXTRA已说明。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。原送审有理化、隐式包络范围及渐近正确；数值反例范围有限

## 29. MD-7.1-HamiltonianSamplingObstruction

- source\_id：MD-7.1-HamiltonianSamplingObstruction；印刷页 262 / PDF页 283。
- 原文引文（逐字）：

> Note that deterministic methods (e.g. Hamiltonian dynamics itself) can sometimes be used for molecular sampling, but without stochastic perturbation, such methods are not rigorously ergodic, since the Liouvillian operator does not possess a spectral gap and does not provide a unique stationary solution.

- 原页核对：已目视核对原页（沿用29号原页图像及核对记录；本轮不改原文公式）。
- 问题所在：原文论证范围或技术资格需选定；不直接断言公式错误。
- 反例或理由：能量守恒不排除固定能量壳上的遍历；因此不能由子水平集不变推出所有参考概率空间都非遍历。
- 原文版 Lean 名称及状态：`MD.Ch07.energyConservingFlow`：定义；`MD.Ch07.energySublevel_invariant`：已证；`MD.Ch07.energyObstructionQualified`：定义。定义只记录目标，不等于原书结论已证。
- 修正版 Lean 名称、改动内容、证明状态：保留限定定义或子结论；没有独立完整修正版定理。 保能流、子水平集不变和非平凡能量分布的保测概率资格定义；非遍历性及Liouvillian谱隙/多稳态定理未覆盖，不排除固定能壳遍历。
- 待人工核查点：请核对原文公式的解释、所选函数空间/算子域与结论适用范围。
- 导师选项：默认保留原印并采用已注明的限定解释或独立修正版；也可指定更强对象和条件。网站建议：保留原文并标需人工限定；限定到具有非平凡能量分布的保测概率空间，登记非遍历性结论缺口；谱理论另须指定函数空间、算子与平稳解意义。
- 网站首轮结论：NEEDS\_HUMAN。energyConservingFlow具有F0=id、全实时间流合成律及保能；energySublevel\_invariant对任意a,t给出原像集合相等，正确。Qualified补上概率、测度保持及一个可测且质量严格介于0和1的能量子水平集，足以解释全相空间遍历障碍，但它只是资格定义，不是非遍历性定理；尤其没有Liouvillian定义域、谱隙或多个平稳解的声明。statement\_scope已经诚实缩小，不据此声称整段谱理论已形式化。
- 网站复审结论：本条不在35条复审中，沿用首轮分版本意见。
- 分版本结论：原文疑误或范围待导师；限定定义与分版本意见另列。见网站逐项原文意见；不把较弱目标当完整修正

## 覆盖缺口汇总

- MD-7.3.1-ConjugateIteration：29号覆盖限定：一般复合迭代恒等式、OABA定义及带噪声序号的OABA/BAOAB精确代数移位关系；不包含不变测度转移或遍历性。
- MD-7.3.2-SPVPrinted：29号覆盖限定：Printed保留原页q\_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。
- MD-7.4-BBKLinearForm：完整记录所印矩阵与噪声；从BBK更新代入谐势的代数识别暂未证明，不以定义计为已证识别。
- MD-7.4.1-StationaryMomentSystem：只讨论已存在的平稳分布矩，初值分布趋平稳及长时间平均的遍历收敛未证明。
- MD-7.4.1-Table71：只陈述已存在平稳概率的矩；长期收敛和遍历解释另列缺口。
- MD-7.6-GibbsComposition：29号覆盖限定：只覆盖两个已给定共同固定点映射的末尾组合恒等式；未识别实际H/O生成元、Gibbs测度及其半群。
- MD-7.6-DivergenceFreeInvariant：29号覆盖限定：只覆盖C¹向量场的散度乘积恒等式和可微第一积分的链式法则；不包含归一Gibbs测度或全局流保测。
- MD-7.6-JSplitting：29号覆盖限定：有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。
- MD-7.6-CoordinateJSplitting：完整记录冻结坐标的一自由度向量场；形式quadrature可积性的分支、转折点及积分反演尚未形式化，明确列入覆盖缺口。
- MD-7.7.1-OperatorOrderReversal：29号覆盖限定：拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。
- MD-7.7.1-StationaryModifiedPDE：29号覆盖限定：仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。
- MD-7.7.1-TaylorRemainder：29号覆盖限定：标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P\_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。
- MD-7.7.2-OBAModifiedOperator：29号覆盖限定：OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。
- MD-7.7.2-SpectralQualification：只记录原文谱结论的精确目标命题，不宣称为定理；一般闭无界Langevin生成元、定义域及紧预解式资格未覆盖。
- MD-7.8.1-CommutatorPermutationRelations：实际线性作用与Oρ=0,(A+B)ρ=0明示。修正函数的符号关系还需统一零均值和核唯一性；本条只证明/陈述交换子与右端项关系，函数关系列缺口。；29号覆盖限定：所列七个抽象交换子关系；(7.23)四个零均值解的关系未覆盖，需要同一方程、核唯一性与域。
- MD-7.8.1-GibbsDerivativeIdentities：29号覆盖限定：所列五个Gibbs权微分恒等式；未覆盖本段交换子等式及其他OU中间式。
- MD-7.8.1-PositionMomentumCorrections：六个算法分别给符号；大摩擦O(γ)的解释来自明确线性γ项，随γ,h的统一误差界未证明。
- MD-7.8.1-OverdampedFirstOrderCaution：29号覆盖限定：固定h>0及固定噪声的AOAB逐路径大摩擦单步极限，带正质量；六种XYZ不一致性及有效时标一致性未覆盖。
- MD-7.8.2-BiasedDoubleWellExact：29号覆盖限定：双阱Gibbs的两个精确积分及γ=2时第二积分消项；推广到任意β>0；真实算法O(h²)和中间积分推导未覆盖。
- MD-7.9-EvenDensityPerturbation：29号覆盖限定：偶形式系数定义与二阶必要代数方程；修正项零均值、Fredholm兼容性和充分可解性未覆盖。
- MD-7.9.1-SymmetricRHS：29号覆盖限定：单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。
- MD-7.9.1-ConjugateSymmetricCorrections：Lean证明给定真实二阶传递系数的消项，(7.30)完整作为两关系的命题定义；ST/TS指数系数识别、Hamiltonian微分及实际两组修正系数识别仍列缺口。
- MD-7.9.2-ReciprocalFrictionExpansion：29号覆盖限定：仅未中心化形式层级的定义；任意β的总化表达式不表示物理Gaussian资格。(7.31)级数、ε=1/γ方程、逐阶可积零均值未覆盖。
- MD-7.9.2-FirstReciprocalCorrection：给出全部f2,1公式并陈述其一阶PDE；二阶可解相容性需OU积分通量消失及实际域条件，尚未证明。；29号覆盖限定：一阶候选及PDE、条件Gaussian平均和原印联合归一密度的动量积分；二者不是同一算子；f2,2、(7.35)/(7.36)通量与可解性未覆盖。
- MD-7.9.2-OverdampedSolvabilityOperators：29号覆盖限定：M/N和候选函数定义以及β≠0下代数改写；Gibbs共轭与裸前向算子区分，未含平均识别、相容性、核唯一或零均值结论。
- MD-7.9.2-HighFrictionCorrectionTable：29号覆盖限定：四种候选、其代数共轭、c的实际Gibbs期望与中心化资格定义；双渐近只为抽象目标，真实平稳均值识别未覆盖。
- MD-7.9.3-BAOABMarginalCancellation：29号覆盖限定：Gaussian条件动量消项和归一位置Gibbs资格下的构型消项；真实数值平稳平均及(7.37)双渐近余项未覆盖。
- MD-7.9.3-SuperconvergenceScope：29号覆盖限定：积分分部的配置消项及其纯动量观测乘积消项；fromBound仅代数辅助，真实BAOAB先大摩擦后h→0的四阶结论未覆盖。
- MD-7.10-MomentumRedrawLimit：29号覆盖限定：正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。
- MD-7.10-ColoredNoiseAndExtension：一般位置过程非Markov需额外非退化参数与初态；此处未作无条件断言。
- MD-7.10-LimitMethodAccuracy：29号覆盖限定：瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。
- MD-7.11.1-VelocityAutocorrelationDefinition：已证的缩放恒等式说明动量观测被缩放时自相关改变；扩散系数与Einstein关系的等价仍需混合与积分极限理论，未证明。
- MD-7.12-ConstrainedLangevin：定义保留存在给定乘子过程的积分解，不证明一般约束SDE存在唯一。状态及乘子适应W自然历史，状态路径连续与初值完整；一般强解存在唯一仍未证明。；29号覆盖限定：原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。
- MD-7.12-ConstrainedCanonicalErgodicity：29号覆盖限定：delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。
- MD-7.12-ConstrainedHOSplitting：未建立随机初值代入后的条件积分解、几乎处处约束保持及完整条件转移核识别；未构造分段解存在唯一性、Oc半群律或约束Gaussian不变性。
- MD-7.12.1-ApproximateGeodesicOrder：29号覆盖限定：仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。
- MD-7.13-SpectralRadiusStability：正摩擦正h给0<det<1；γ=0、Jordan边界、临界η=0均需另审。trace到双曲式的代数/指数桥未证明。
- MD-7.13-HyperbolicPhaseTransform：29号覆盖限定：仅实η≠0、|h/η|<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。
- MD-7.1-HamiltonianSamplingObstruction：29号覆盖限定：保能流、子水平集不变和非平凡能量分布的保测概率资格定义；非遍历性及Liouvillian谱隙/多稳态定理未覆盖，不排除固定能壳遍历。

# 第6章原书疑误与双版本审阅单

教材：Leimkuhler–Matthews《Molecular Dynamics》（2015）第6章正文。每项列逐字原句、原页、疑点、理由或反例、各版声明、证明状态及导师选项。
共32项合并原书疑误/论证与范围待核问题，另有1项复密度代表的解释记录。Assumption 1和Theorem 6.2的零时刻连续密度问题合并计数。
网站对原文忠实性、修正版的正确性和原书数学疑误分开记录。网站PASS只判断所交数学陈述，不表示待证声明已有证明。本轮八项修改已本地核验，未再送网站。
OU方差根号、分部积分正号和Theorem 6.2的κ是转录纠正，不计原书疑误。Printed的闭域替换或参数域扩张属于形式化偏差，也与原书自身疑误分开。

## 1. MD-6.1.2-BathTaylor

- source\_id：MD-6.1.2-BathTaylor。

### MD-6.1.2-BathTaylor

- 印刷页 / PDF页：216 / 237。
- 原文引文（逐字）：

> Since $`Z_B(E-s)=\exp(S_B(E-s)/k_B)`$, and $`s\ll E`$, we (naively) apply the mean value theorem to $`S_B`$ to obtain

$$
S_B(E-s)=S_B(E)-S'_B(\xi)s,
$$


> and from $`S'_B(\xi)=1/T`$, we obtain

$$
Z_B(E-s)\propto\exp(-\beta s).
$$



- 问题所在：取S(E)=E²、E=kB=1、β=2、s=1，原两端分别为e⁻¹和e⁻²。 修正版只是全局恒定熵导数（仿射熵）特例，未给一般热浴近似误差界。
- 反例或理由：S(e)=e²，energy=kB=s=1，β=2；比值为e^(-1)，所断言右端为e^(-2)。
- 原文版 Lean 名称及状态：`MD.Ch06.bathBoltzmannPrinted`（未证）；`MD.Ch06.bathBoltzmannPrinted_counterexample`（已证）
- 修正版 Lean 名称、改动内容、证明状态：修正版只是全局恒定熵导数（仿射熵）特例，未给一般热浴近似误差界。；`MD.Ch06.bathBoltzmannPrinted_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留Printed疑误；修正版明确命名为恒定熵导数特例，或另给带二阶余项的近似式。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.bathBoltzmannPrinted`=未获单独PASS；见分版意见；`MD.Ch06.bathBoltzmannPrinted_counterexample`=PASS；`MD.Ch06.bathBoltzmannPrinted_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：bathBoltzmannPrinted：中值部分在C²前提下正确；第二合取把只在energy处给定的导数扩张成全区间精确指数比，不是中值定理的推论。作为Printed，保留原书启发式而标NEEDS\_HUMAN，不因其错误直接判签名FAIL。bathBoltzmannPrinted\_counterexample：exp(-1)≠exp(-2)正确，代入S(e)=e²、energy=kB=s=1、β=2即见原断言失败。bathBoltzmannPrinted\_corrected：所有e处deriv S e=kB*β且S可微、kB>0，足以推出任意实数s的精确比值；是正确的全局仿射熵限定版，但并非一般热浴近似的误差估计。

## 2. MD-6.1.2-CanonicalCDFPrinted

- source\_id：MD-6.1.2-CanonicalCDFPrinted。

### MD-6.1.2-CanonicalCDFPrinted

- 印刷页 / PDF页：216 / 237。
- 原文引文（逐字）：

> On the other hand the probability for the active system to have energy $`\leq\alpha`$ is the same as the probability of the bath having energy $`\geq E-\alpha`$, this must be

$$
P(\alpha)=\Pr\{E_B\geq E-\alpha\}\propto\int_0^\alpha Z_B(E-s)ds.
$$


> [The intervening bath-entropy argument is quoted separately in MD-6.1.2-BathTaylor.]
> Thus we have $`P(\alpha)\propto\int_0^\alpha\exp(-\beta s)ds`$.

- 问题所在：取ZA(s)=1+s、ZB(s)=1、E=1、α=1/2，两边分别为5/12和1/2。
- 反例或理由：取ZA(s)=1+s²、ZB=1、energy=1、α=1/2，左比值13/32，右比值1/2；两函数在全实轴连续严格正。
- 原文版 Lean 名称及状态：`MD.Ch06.canonicalCDFPrinted`（未证）
- 修正版 Lean 名称、改动内容、证明状态：能量累计概率的分子分母均保留ZA(s)权重；改为正确累计概率的定义。；`MD.Ch06.canonicalCDFPrinted_corrected`（定义）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：在原文摘录中明确分段；保留原书疑误。在修正版旁注明正可积权重、正总质量和α区间，勿把总化定义当概率定理。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.canonicalCDFPrinted`=原文忠实性PASS；原书数学/范围NEEDS\_HUMAN；`MD.Ch06.canonicalCDFPrinted_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：canonicalCDFPrinted：任意连续、全实轴严格正ZA,ZB，0<α<energy，等同含ZA与不含ZA的两个归一化积分。它精确呈现原书忽略简并度的主张，其数学疑误保留为NEEDS\_HUMAN。canonicalCDFPrinted\_corrected：保留分子分母ZA的定义是正确候选CDF表达式；本定义对任意函数和实α总化，不保证非负、归一、单调或分母非零。作为公式定义PASS；只有在正可积权重及0≤α≤energy时才有概率解释；定义没有证明热浴熵近似后的指数形式。

## 3. MD-6.1.3-FiniteDomainPrinted

- source\_id：MD-6.1.3-FiniteDomainPrinted。

### MD-6.1.3-FiniteDomainPrinted

- 印刷页 / PDF页：218 / 239。
- 原文引文（逐字）：

> If $`U`$ is smooth and the domain $`Q`$ is finite, then clearly both integrals are well defined, so the normalization is sensible.

- 问题所在：Q=(0,1)、U(q)=log q、β=1，权重1/q不可积；U在Q内光滑且Q体积有限。 修正版只给紧域构型权重可积；正体积、正配分函数、动量积分与归一化没有随之成立。
- 反例或理由：n=1，Q=(0,1)，U(x)=log x（域外任意延拓），β=1；U在Q光滑而exp(-U)=1/x不可积。
- 原文版 Lean 名称及状态：`MD.Ch06.finiteDomainPrinted`（未证）
- 修正版 Lean 名称、改动内容、证明状态：修正版只给紧域构型权重可积；正体积、正配分函数、动量积分与归一化没有随之成立。；`MD.Ch06.finiteDomainPrinted_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留Printed疑问；采用紧域连续或有限体积且U有下界的限定版。若声称normalization sensible，还需正体积、正质量及动量Gaussian条件。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.finiteDomainPrinted`=未获单独PASS；见分版意见；`MD.Ch06.finiteDomainPrinted_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：finiteDomainPrinted：将finite解释成可测有限体积，并只要求域内C∞、β>0，不足以保证exp(-βU)可积，原书含糊处需人工确认。finiteDomainPrinted\_corrected：任意维n、紧Q、域上连续U、任意实β，指数权重在Q可积，正确且加强条件已明确。两版都只陈述构型积分的可积性，未陈述动量积分、正配分函数或密度归一化；紧集还可能体积为零。

## 4. MD-6.1.4-CanonicalAveragePrinted

- source\_id：MD-6.1.4-CanonicalAveragePrinted。

### MD-6.1.4-CanonicalAveragePrinted

- 印刷页 / PDF页：220 / 241。
- 原文引文（逐字）：

> Under assumptions on the potential energy as discussed above, and with $`\phi`$ continuous and allowed to grow at most polynomially fast at infinity, we may proceed to define averages with respect to the canonical density $`\rho_\beta`$, namely

$$
\operatorname{Av}_\beta(\phi)=Z_{\rm can}^{-1}\int_D\phi(q,p)\rho_\beta(q,p)d\omega.\tag{6.4}
$$



- 问题所在：若Zcan=2，则原Avβ(1)=1/2；概率平均必须为1。
- 反例或理由：若Z>0且权重可积，Printed平均(1)=1/Z，只有Z=1时为1。例如一自由度H=(q²+p²)/2、β=1有Z=2π，Printed平均(1)=1/(2π)。
- 原文版 Lean 名称及状态：`MD.Ch06.canonicalAveragePrinted`（定义）
- 修正版 Lean 名称、改动内容、证明状态：去掉对已经归一化ρβ的第二次Zcan⁻¹；沿用未归一权重乘一次Zcan⁻¹的定义。；`MD.Ch06.canonicalAveragePrinted_corrected`（定义）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留Printed字面式；采用条目5中单次归一化修正版作标准平均，原书勘误由人工确认。
- 网站复审结论：本条未单独复审，保留首轮整体=NEEDS\_HUMAN；`MD.Ch06.canonicalAveragePrinted`=原文忠实性PASS；原书数学/范围NEEDS\_HUMAN；`MD.Ch06.canonicalAveragePrinted_corrected`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：Printed定义确实在D1已归一密度之外又乘D2的Z倒数；全实相空间、H、β、f的类型一致。作为原书字面定义忠实，不能因其非标准平均而判签名FAIL；原书与(6.3)及p.221用法冲突，须人工处理。修正版已在条目5给出，需分别看待。

## 5. MD-6.1.5-Proposition61

- source\_id：MD-6.1.5-Proposition61。

### MD-6.1.5-Proposition61

- 印刷页 / PDF页：222 / 243。
- 原文引文（逐字）：

> Proposition 6.1 Let $`H`$ be a Hamiltonian defined on the phase space $`\mathbb R^{2N_c}`$ and suppose $`G:\mathbb R^{2N_c}\to\mathbb R^{2N_c}`$ is a smooth ($`C^1`$) vector field with the following properties:

$$
0<|\operatorname{Av}_\beta(G\cdot\nabla H)|<\infty,\quad 0<\operatorname{Av}_\beta(\nabla\cdot G)<\infty,\quad |Ge^{-\beta H}|<\infty.
$$


> Then

$$
k_BT=\frac{\operatorname{Av}_\beta(G\cdot\nabla H)}{\operatorname{Av}_\beta(\nabla\cdot G)}.
$$



- 问题所在：proposition61及proposition61\_corrected签名相同：在2Nc维实相空间，kB,T>0、H,G为C¹、Gibbs权重及散度/能量方向导数乘权重可积、权重乘G统一有界、归一散度平均严格正，推出kB*T为两归一平均之比。GibbsWeight=exp(-βH)、partition=积分、average=Z⁻¹乘加权积分、LieDerivative=fderiv H(G)、divergence=trace(DG)，均吻合。上述加强条件足以用截断IBP证明；两签名PASS。原书仅由边界/体积→0，不能推出未缩放积分相等，故本条整体NEEDS\_HUMAN；不能把调用现有定理当作原书证明通过。
- 反例或理由：若两未缩放积分极限分别为A、B，除以v\_R后无论A是否等于-B都趋零；因此得到0=0不能识别A与B。
- 原文版 Lean 名称及状态：本条提供限定/修正版子句或资格定义，未另称整条原文字面断言已经形式化；当前声明：`MD.Ch06.proposition61`（已证）；`MD.Ch06.proposition61_corrected`（已证）
- 修正版 Lean 名称、改动内容、证明状态：保留已明确的限定条件，原书疑误待裁定。；`MD.Ch06.proposition61_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留原书证明并标出缺口；温度恒等式采用已披露的可积性与统一有界前提及截断证明。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.proposition61`=PASS；`MD.Ch06.proposition61_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：proposition61及proposition61\_corrected签名相同：在2Nc维实相空间，kB,T>0、H,G为C¹、Gibbs权重及散度/能量方向导数乘权重可积、权重乘G统一有界、归一散度平均严格正，推出kB*T为两归一平均之比。GibbsWeight=exp(-βH)、partition=积分、average=Z⁻¹乘加权积分、LieDerivative=fderiv H(G)、divergence=trace(DG)，均吻合。上述加强条件足以用截断IBP证明；两签名PASS。原书仅由边界/体积→0，不能推出未缩放积分相等，故本条整体NEEDS\_HUMAN；不能把调用现有定理当作原书证明通过。

## 6. MD-6.1.5-PartitionInversePrinted

- source\_id：MD-6.1.5-PartitionInversePrinted。

### MD-6.1.5-PartitionInversePrinted

- 印刷页 / PDF页：220 / 241。
- 原文引文（逐字）：

> The associated canonical density is

$$
\rho_\beta=Z_{\rm can}^{-1}\exp\left(-\beta\left[\frac{p^2}{2m}+U(q)\right]\right),
$$


> where

$$
Z_{\rm can}^{-1}=\int_{-\infty}^{\infty}\int_{-\infty}^{\infty}\exp\left(-\beta\left[\frac{p^2}{2m}+U(q)\right]\right)dpdq.
$$



- 问题所在：积分为2时，原式断言1/2=2。
- 反例或理由：n=1,m=1,β=1,U(q)=q²/2，Z为二维标准Gaussian未归一积分2π，Z⁻¹≠Z。
- 原文版 Lean 名称及状态：`MD.Ch06.partitionInversePrinted`（未证）
- 修正版 Lean 名称、改动内容、证明状态：Zcan定义为积分本身；归一密度的结论另见DensityNormalization，避免把定义重述作新定理。；`MD.Ch06.partitionInversePrinted_corrected`（定义）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：原文保留Z\_can^(-1)并标疑误；修正数学式为Z\_can=积分，概率密度再除以正有限Z。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.partitionInversePrinted`=原文忠实性PASS；原书数学/范围NEEDS\_HUMAN；`MD.Ch06.partitionInversePrinted_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：partitionInversePrinted把正质量、β>0且Gibbs权重可积时的积分Z写成Z⁻¹=Z，忠实记录归一因子印刷疑误，数学上一般不成立。维数n由一自由度原文推广到任意n；massHamiltonian的动能分母2m\_i、Phase=位置×动量、全空间体积积分已核对。partitionInversePrinted\_corrected只把积分定义为配分函数，PASS作为定义；未断言该任意参数总化积分正有限，也未证明密度归一化。

## 7. MD-6.2.1-CoarseMarkovPrinted

- source\_id：MD-6.2.1-CoarseMarkovPrinted。

### MD-6.2.1-CoarseMarkovPrinted

- 印刷页 / PDF页：227 / 248。
- 原文引文（逐字）：

> Let $`A(x)`$, $`B(x)`$ and $`C(x)`$ be three events dependent on state variable $`x`$, and let $`t_+\gt t_0\gt t_-`$ be three times, then, for a Markov process $`X(t)`$ we have (using the notation for conditional probability):

$$
\Pr[A(X(t_+))\mid B(X(t_0)),C(X(t_-))]=\Pr[A(X(t_+))\mid B(X(t_0))].
$$



- 问题所在：令当前粗事件为全集，Brownian过去值与未来值仍相关；粗事件未保留完整当前状态。
- 反例或理由：标准Brownian，past=1,present=2,future=3，b=ℝ，a=c=(0,∞)。P(W3>0|W1>0)=1/2+arcsin(1/√3)/π>1/2=P(W3>0)，正条件概率成立。
- 原文版 Lean 名称及状态：`MD.Ch06.coarseMarkovPrinted`（未证）
- 修正版 Lean 名称、改动内容、证明状态：以完整当前状态生成的σ代数写条件期望Markov性质。；`MD.Ch06.coarseMarkovPrinted_corrected`（定义）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留Printed版及ERRATUM?；正确性质应在完整σ(Wpresent)及真实过去过滤下比较条件期望，不能把未约束history的定义当作已证明定理。
- 网站复审结论：本条未单独复审，保留首轮整体=NEEDS\_HUMAN；`MD.Ch06.coarseMarkovPrinted`=原文忠实性PASS；原书数学/范围NEEDS\_HUMAN；`MD.Ch06.coarseMarkovPrinted_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：字面版在真实PreBrownian下量化任意可测事件a,b,c、past<present<future及正条件事件概率，ENNReal比值忠实表达印刷条件概率式。但原书把完整当前状态换成任意粗事件，一般错误，须保留疑误而不因字面忠实判数学正确。

## 8. MD-6.2.2-RiemannTags

- source\_id：MD-6.2.2-RiemannTags。

### MD-6.2.2-RiemannTags

- 印刷页 / PDF页：228 / 249。
- 原文引文（逐字）：

> Recall that the Riemann integral of a continuous function $`g`$ on $`[0,\tau]`$ is the limit of Riemann sums constructed as follows: partition the interval $`[0,\tau]`$ into $`K`$ subintervals each of width $`\delta t=\tau/\nu`$, choose an arbitrary $`t_k`$ from the $`k`$th subinterval, $`1\leq k\leq \nu`$, and evaluate the integral as a limit of the sum of products:

$$
\int_0^\tau g(t)dt=\lim_{\nu\to\infty}\sum_{k=0}^{\nu-1}g(t_k)\delta t.
$$


> We know that this limit does not depend on where the $`t_k`$ are chosen within the subintervals. For example we can take the left or right endpoint of each subinterval or the midpoint.

- 问题所在：riemannTags与riemannTags\_corrected都对任意连续于[0,T]的g、T≥0及所有合法tag族陈述均匀网格Riemann和趋于区间积分。K>0和k<K只用于标签条件，K=0单项不影响atTop极限；T=0也正确。任意端点或内部tag均包含，未降成左端点特例。两个数学签名PASS，但这是统一索引后的版本，原文索引疑误应保留NEEDS\_HUMAN。
- 反例或理由：riemannTags与riemannTags\_corrected都对任意连续于[0,T]的g、T≥0及所有合法tag族陈述均匀网格Riemann和趋于区间积分。K>0和k<K只用于标签条件，K=0单项不影响atTop极限；T=0也正确。任意端点或内部tag均包含，未降成左端点特例。两个数学签名PASS，但这是统一索引后的版本，原文索引疑误应保留NEEDS\_HUMAN。
- 原文版 Lean 名称及状态：本条提供限定/修正版子句或资格定义，未另称整条原文字面断言已经形式化；当前声明：`MD.Ch06.riemannTags`（未证）；`MD.Ch06.riemannTags_corrected`（未证）
- 修正版 Lean 名称、改动内容、证明状态：保留已明确的限定条件，原书疑误待裁定。；`MD.Ch06.riemannTags_corrected`（未证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：原文留存索引混用；数学版明确K=ν且第k格为[kT/K,(k+1)T/K]，0≤k<K。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.riemannTags`=PASS；`MD.Ch06.riemannTags_corrected`=PASS。原书疑误/范围待导师。反例：未给统一的独立反例判定。
  原始分版说明：riemannTags与riemannTags\_corrected都对任意连续于[0,T]的g、T≥0及所有合法tag族陈述均匀网格Riemann和趋于区间积分。K>0和k<K只用于标签条件，K=0单项不影响atTop极限；T=0也正确。任意端点或内部tag均包含，未降成左端点特例。两个数学签名PASS，但这是统一索引后的版本，原文索引疑误应保留NEEDS\_HUMAN。

## 9. MD-6.2.2-Proposition62

- source\_id：MD-6.2.2-Proposition62。

### MD-6.2.2-Proposition62

- 印刷页 / PDF页：229–230 / 250–251。
- 原文引文（逐字）：

> Proposition 6.2 Let $`\nu\delta t=\tau`$ then

$$
\operatorname{l.i.m.}_{\nu\to\infty}\sum_{k=0}^{\nu-1}[(W((k+1)\delta t)-W(k\delta t))^2]=\tau,
$$


> where, for a sequence of random variables, $`A_\nu`$ and a random variable $`B`$, we have

$$
\operatorname{l.i.m.}_{\nu\to\infty}A_\nu=B\iff\lim_{\nu\to\infty}\mathbb E(A_\nu-B)^2=0.
$$


> (This is referred to as convergence in the mean square sense.)

- 问题所在：有序交叉和应系数+1；若仅遍历k<l，则为+2。原写−2且遍历k≠l。独立中心变量的交叉期望恰好为0，故最终结论不受影响。另p.230末句ν→0应为ν→∞。
- 反例或理由：x=y=1时(1+1)²=4，而印刷双变量式1+1-4=-2。
- 原文版 Lean 名称及状态：`MD.Ch06.proposition62Printed`（定义）；`MD.Ch06.proposition62Printed_counterexample`（已证）
- 修正版 Lean 名称、改动内容、证明状态：保持已证二次变差结论；独立记录印刷平方展开与其正确代数式，并注明极限方向。；`MD.Ch06.proposition62_corrected`（已证）；`MD.Ch06.proposition62Expansion_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：仅修正转录多出的Δ；原书负号和ν→0保留并注勘误，数学版采用atTop和正确展开。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.proposition62`=PASS；`MD.Ch06.proposition62_corrected`=PASS；`MD.Ch06.proposition62Printed`=原文忠实性PASS；原书数学/范围NEEDS\_HUMAN；`MD.Ch06.proposition62Expansion_corrected`=PASS；`MD.Ch06.proposition62Printed_counterexample`=原文忠实性PASS；原书数学/范围NEEDS\_HUMAN。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：proposition62及proposition62\_corrected：实际IsPreBrownianReal、T≥0，均匀网格平方增量和的均方误差atTop趋0，签名正确。WienerTime=k*T/K、WienerIncrement为相邻差、QuadraticSum为Fin K平方和，均核对。proposition62Printed定义x²+y²-4xy，忠实记录按有序k≠l理解印刷展开的两变量表达；未将错误式当定理。proposition62Expansion\_corrected的普通平方展开正确；proposition62Printed\_counterexample在x=y=1正确。原书一般代数展开错误虽因独立零均值而不改变期望最终结果，仍需标疑误；末极限应为ν→∞。

## 10. MD-6.2.2-SelfStratonovichIntegral

- source\_id：MD-6.2.2-SelfStratonovichIntegral。

### MD-6.2.2-SelfStratonovichIntegral

- 印刷页 / PDF页：230 / 251。
- 原文引文（逐字）：

> In contrast, the Stratonovich (midpoint) integral (denoted by $`\int_0^\tau\circ dW(t)`$) can be calculated as

$$
\int_0^\tau W(t)\circ dW(t)=\operatorname{l.i.m.}_{\nu\to\infty}\sum_{k=0}^{\nu-1}W(k\delta t+\delta t/2)[W((k+1)\delta t)-W(k\delta t)].
$$


> Writing

$$
W(k\delta t+\delta t/2)=W(\frac{(k+1)\delta t+k\delta t}{2})=\frac12(W((k+1)\delta t)+W(k\delta t))+O(\sqrt{\delta t}),
$$


> allows us to evaluate the integral as

$$
\int_0^\tau W(t)\circ dW(t)=\frac12\operatorname{l.i.m.}_{\nu\to\infty}\sum_{k=0}^{\nu-1}[W((k+1)\delta t)^2-W(k\delta t)^2]=\frac12W(\tau)^2.
$$



- 问题所在：selfStratonovichIntegral及\_corrected在IsPreBrownianReal、T≥0下给出L²见证Y、真实时间中点和的均方收敛及Y=W(T)²/2的AE求值，数学签名PASS。MidpointSum确取2K细网格的2k+1时刻，并非端点值平均。布朗增量Gaussian四阶矩保证各和及极限的资格。原书将单步中点桥差O(sqrt(dt))直接舍掉未控制总和，不能单凭该行作完整证明；两相同定理签名没有解决原书论证缺口。
- 反例或理由：selfStratonovichIntegral及\_corrected在IsPreBrownianReal、T≥0下给出L²见证Y、真实时间中点和的均方收敛及Y=W(T)²/2的AE求值，数学签名PASS。MidpointSum确取2K细网格的2k+1时刻，并非端点值平均。布朗增量Gaussian四阶矩保证各和及极限的资格。原书将单步中点桥差O(sqrt(dt))直接舍掉未控制总和，不能单凭该行作完整证明；两相同定理签名没有解决原书论证缺口。
- 原文版 Lean 名称及状态：本条提供限定/修正版子句或资格定义，未另称整条原文字面断言已经形式化；当前声明：`MD.Ch06.selfStratonovichIntegral`（已证）；`MD.Ch06.selfStratonovichIntegral_corrected`（已证）
- 修正版 Lean 名称、改动内容、证明状态：保留已明确的限定条件，原书疑误待裁定。；`MD.Ch06.selfStratonovichIntegral_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：补回原文积分记号括号；保留启发式缺口，严谨证明应估计整体中点桥残差的L²范数。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.selfStratonovichIntegral`=PASS；`MD.Ch06.selfStratonovichIntegral_corrected`=PASS。原书疑误/范围待导师。反例：未给统一的独立反例判定。
  原始分版说明：selfStratonovichIntegral及\_corrected在IsPreBrownianReal、T≥0下给出L²见证Y、真实时间中点和的均方收敛及Y=W(T)²/2的AE求值，数学签名PASS。MidpointSum确取2K细网格的2k+1时刻，并非端点值平均。布朗增量Gaussian四阶矩保证各和及极限的资格。原书将单步中点桥差O(sqrt(dt))直接舍掉未控制总和，不能单凭该行作完整证明；两相同定理签名没有解决原书论证缺口。

## 11. MD-6.2.2-DeterministicStrobePrinted

- source\_id：MD-6.2.2-DeterministicStrobePrinted。

### MD-6.2.2-DeterministicStrobePrinted

- 印刷页 / PDF页：231 / 252。
- 原文引文（逐字）：

> Finally, we observe that by calculating $`\sigma^2(t_n)`$ and generating random increments $`R_n\sim N(0,\sigma(t_n))`$ we have a discrete representation of the continuous time stochastic process $`Y(t)`$, effectively an exact stroboscopic representation.

- 问题所在：若g≡1，区间[tₙ,tₙ₊₁]增量方差应为tₙ₊₁−tₙ，不能使用累计到tₙ₊₁的方差或把标准差当方差参数。 Printed保留增量/累计边际方差混淆。独立deterministicStrobePrinted\_corrected位于DeterministicStrobeCorrected来源，已本地存在但本次附件未提供，不能冒称复审PASS。
- 反例或理由：g=1、times k=k、Y=W；k=0时实际W(1)-W(0)方差为1，Printed给0。
- 原文版 Lean 名称及状态：`MD.Ch06.deterministicStrobePrinted`（未证）
- 修正版 Lean 名称、改动内容、证明状态：Printed保留增量/累计边际方差混淆。独立deterministicStrobePrinted\_corrected位于DeterministicStrobeCorrected来源，已本地存在但本次附件未提供，不能冒称复审PASS。；`MD.Ch06.deterministicStrobeCorrected`（未证）；`MD.Ch06.deterministicStrobePrinted_corrected`（未证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：修正版应给方差∫_{times k}^{times(k+1)}g²及整个增量族独立性，并实际提供完整声明；原文保留疑误，不把累计边际方差用作步进方差。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.deterministicStrobePrinted`=未获单独PASS；见分版意见；`MD.Ch06.deterministicStrobeCorrected`=PASS；`MD.Ch06.deterministicStrobePrinted_corrected`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：deterministicIntegralProcess为每个T≥0的严格均方积分资格，已核对。deterministicStrobePrinted把第k到k+1观测的增量分布方差写成0到times k的累计∫g²（对sqrt再平方），保留了原书增量/边际混淆。N(0,σ)按标准差理解是额外约定；此前书中W(t)∼N(0,t)使用方差式习惯，更需人工确认。[EXTRA]与statement\_scope声称独立修正版包含相邻区间方差和整族独立性，但本条全部摘录没有任何相应\_corrected声明；不能认证未提供的修正版，coverage\_gaps=[]不实。

## 12. MD-6.3.1-DiffusiveTaylorPrinted

- source\_id：MD-6.3.1-DiffusiveTaylorPrinted。

### MD-6.3.1-DiffusiveTaylorPrinted

- 印刷页 / PDF页：233 / 254。
- 原文引文（逐字）：

> Now we expand the 2nd order term and, working in the diffusion limit, recognize that $`\delta x^2\sim\delta t`$, thus we have

$$
\delta\phi=\phi'(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)+\tfrac12\phi''(X_n)b(X_n,n\delta t)^2\delta t+O(\delta t^{3/2}).
$$



- 问题所在：φ(x)=|x|^(5/2)在0为C²；a=0,b=1时余项为dt^(5/4)，不是O(dt^(3/2))。
- 反例或理由：φ=|x|^(5/2)，x=a=0,b=1；余项dt^(5/4)，除以dt^(3/2)为dt^(-1/4)无界。
- 原文版 Lean 名称及状态：`MD.Ch06.diffusiveTaylorPrinted`（未证）
- 修正版 Lean 名称、改动内容、证明状态：C²加强为C³，使三阶Taylor余项与扩散缩放匹配。；`MD.Ch06.diffusiveTaylorPrinted_corrected`（未证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留Printed并标C²不足；采用C³修正版，或在C²下将余项降为o(dt)。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.diffusiveTaylorPrinted`=原文忠实性PASS；原书数学/范围NEEDS\_HUMAN；`MD.Ch06.diffusiveTaylorPrinted_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：diffusiveTaylorPrinted：任意C² φ、任意实x,a,b，沿dt→0+对增量a*dt+b*sqrt(dt)宣称三阶扩散余项BigO，忠实记录原书J=+1特例但断言过强。diffusiveTaylorPrinted\_corrected：C³提供局部三阶Taylor界，混合二阶项也为O(dt^(3/2))，对固定实x,a,b正确。右滤子和实rpow的指数3/2均正确；b可负；此式只包含J=+1分支，J=-1可用替换b覆盖，但不是显式随机极限定理。

## 13. MD-6.3.1-TimeItoFormula

- source\_id：MD-6.3.1-TimeItoFormula。

### MD-6.3.1-TimeItoFormula

- 印刷页 / PDF页：234 / 255。
- 原文引文（逐字）：

> We also mention that the Itô-Doeblin formula can be easily generalized to functions of the form $`\phi(x,t)`$:

$$
d\phi(X,t)=\phi_t(X,t)+\phi_x(X,t)(a(X,t)dt+b(X,t)dW)+\tfrac12\phi_{xx}(X,t)b(X,t)^2dt.\tag{6.18}
$$



- 问题所在：取φ(x,t)=t，原右端留下常数1而非微分dt；修正公式应为dφ=dt。
- 反例或理由：φ(x,t)=t，a=b=0时正确关系是dφ=dt；Printed右端的时间项为1，缺少形式dt。
- 原文版 Lean 名称及状态：`MD.Ch06.timeItoFormulaPrinted`（定义）
- 修正版 Lean 名称、改动内容、证明状态：原文右端以形式微分占位量记录，时间偏导补dt；完整修正积分公式独立命名。；`MD.Ch06.timeItoFormula_corrected`（未证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留Printed原式，文档编号改为(6.18)；明确主定理是已补dt的积分版本，非字面原式。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.timeItoFormula`=PASS；`MD.Ch06.timeItoFormula_corrected`=PASS；`MD.Ch06.timeItoFormulaPrinted`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：timeItoFormula及timeItoFormula\_corrected签名相同：在与标量版一致的preBrownian、严格SDE、C¹ a,b、C²联合φ、联合可测及自然适应X、被积过程适应平方可积和网格L²/Hölder资格下，给出任意T≥0完整积分公式。方向(1,0)为x偏导，(0,1)为t偏导，二次方向导数给φ\_xx；漂移积分已正确包含φ\_t，初值φ(x0,0)，扩散φ\_x*b，系数b²/2均正确，两数学签名PASS。timeItoFormulaPrinted以dX,dXX形式占位保留漏dt的右端，是表达式定义，不是正确积分定理，其文档误标(6.17)，应为(6.18)。原书疑误与已修正主签名不能混认。

## 14. MD-6.3.3-BathForcePrinted / MD-6.3.3-BathReductionPrinted

- source\_id：MD-6.3.3-BathForcePrinted；MD-6.3.3-BathReductionPrinted。

### MD-6.3.3-BathForcePrinted

- 印刷页 / PDF页：237 / 258。
- 原文引文（逐字）：

> where we define

$$
f(t)=-k^{-1}\sum_{i=1}^k[\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i-\cos(\Omega_i t)Q(0)].
$$



- 问题所在：将(6.26)代回(6.23)，初值项为+k⁻¹Σ[(qᵢ(0)−Q(0))cos+…]；原f定义却有负号。
- 反例或理由：同第28条：单振子初始位移1给实际初始合力+1，印刷f为−1；Printed定义本身忠实，冲突在其代入(6.29)。
- 原文版 Lean 名称及状态：`MD.Ch06.bathForcePrinted`（定义）
- 修正版 Lean 名称、改动内容、证明状态：选择正的初值合力f，使(6.29)保留+f；等价选项是保留原f并将(6.29)改为−f。；`MD.Ch06.bathForce`（定义）；`MD.Ch06.bathForcePrinted_corrected`（定义）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留Printed负号和ERRATUM?；修正版按第28条处理。
- 网站复审结论：本条未单独复审，保留首轮整体=PASS；`MD.Ch06.bathForcePrinted`=PASS；`MD.Ch06.bathForce`=PASS；`MD.Ch06.bathForcePrinted_corrected`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：实际Chapter06Review.bathForce为正k⁻¹和，外取负号得到原页字面f，括号内cos*(q0−Q0)及sin*p0/μ完全对应。k>0及μ>0齐全。作为Printed定义PASS，不能把它与保留+f的修正动力式同时当正确推导。


### MD-6.3.3-BathReductionPrinted

- 印刷页 / PDF页：237 / 258。
- 原文引文（逐字）：


$$
\dot P=-U'(Q)+f(t)-\int_0^t\psi(t-s)P(s)ds.\tag{6.29}
$$



$$
f(t)=-k^{-1}\sum_{i=1}^k[\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i-\cos(\Omega_i t)Q(0)].
$$



- 问题所在：同上一项：原定义f为负合力，却在约化方程中加f。
- 反例或理由：取k=1,μ=1,U=0，Q(t)=(1-cos(sqrt(2)t))/2，q(t)=(1+cos(sqrt(2)t))/2，P=Q′，p=q′。初态Q0=0,q0=1,p0=0；t=0时实际dot P=1，Printed右端=-1。
- 原文版 Lean 名称及状态：`MD.Ch06.bathReductionPrinted`（未证）
- 修正版 Lean 名称、改动内容、证明状态：使用从原Hamilton方程实际代入所得的正合力卷积方程。；`MD.Ch06.bathReductionPrinted_corrected`（未证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留原书f的外负号疑误；采用正bathForce的修正版。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.bathReductionPrinted`=原文忠实性PASS；原书数学/范围NEEDS\_HUMAN；`MD.Ch06.bathReductionPrinted_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：bathReductionPrinted：k>0、μ\_i>0、t≥0、Q,q为C²，dot Q=P、重粒子与热浴坐标的完整动力学均已列出。bathFrequency=1/sqrt(kμ\_i)、memoryKernel=(1/k)Σcos、bathForcePrinted=-bathForce均核对。Printed的力与由dot P=-U′+(1/k)Σ(q\_i-Q)导出的力差一个负号，原版忠实但需NEEDS\_HUMAN。bathReductionPrinted\_corrected保持相同域量词前提，用正bathForce替换，记忆项仍为负卷积，数学上正确；p0/μ\_i与Ω\_i^(-1)因子吻合。

## 15. MD-6.3.3-MemoryKernelDeltaMeaning

- source\_id：MD-6.3.3-MemoryKernelDeltaMeaning。

### MD-6.3.3-MemoryKernelDeltaMeaning

- 印刷页 / PDF页：238 / 259。
- 原文引文（逐字）：

> If sufficient high frequency components are present, then the mass of the memory kernel is typically found to be localized around 0; in such a situation of rapid decay it is found that one may replace the function $`\psi`$ by a Dirac delta function scaled by a positive coefficient $`\gamma`$; we say that the system is Markovian or memory-less in this situation and we replace the delay-differential equation (6.29) by the SDEs

$$
dQ=Pdt;\quad\text{(6.30)}\quad dP=-U'(Q)dt+\sigma dW-\gamma Pdt.\quad\text{(6.31)}
$$



- 问题所在：不限制频率与权重时，可选全部频率固定，余弦记忆核不会自动成为Dirac分布。 两个δ收敛资格在现有1/k归一及γ>0时均不可实现；不能将\_corrected名字解释为已获有效物理极限。需重标度、单边质量和边界约定。
- 反例或理由：选0≤f≤1、f(0)=1、支撑在(-ε,ε)的光滑bump，则所有k的|∫ψ\_k f|≤2ε；若2ε<γ，不可能趋γ。
- 原文版 Lean 名称及状态：本条提供限定/修正版子句或资格定义，未另称整条原文字面断言已经形式化；当前声明：`MD.Ch06.memoryKernelDeltaMeaning`（定义）；`MD.Ch06.memoryKernelDeltaMeaning_corrected`（定义）
- 修正版 Lean 名称、改动内容、证明状态：两个δ收敛资格在现有1/k归一及γ>0时均不可实现；不能将\_corrected名字解释为已获有效物理极限。需重标度、单边质量和边界约定。；`MD.Ch06.memoryKernelDeltaMeaning_corrected`（定义）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：先规定时间/振幅重标度及单边核质量，再定义可实现的δ极限；保留原启发式和当前谓词的不可实现说明。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.memoryKernelDeltaMeaning`=未获单独PASS；见分版意见；`MD.Ch06.memoryKernelDeltaMeaning_corrected`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：memoryKernelDeltaMeaning定义对全部C∞紧支测试f的全实轴分布收敛到γf(0)，γ>0；_corrected再要求所有质量正。两者作为收敛资格的形式表达准确，均非存在或Langevin推导定理。但memoryKernel的1/k归一使所有k,t的绝对值≤1，因此两谓词在γ>0时都不可实现；正质量未修复。[EXTRA]已披露这一点，故保留NEEDS\_HUMAN，不把不可实现资格当有效修正版。全线γδ0与0到t卷积的边界因子尚需约定，(6.30)–(6.31)本身未被定义覆盖。

## 16. MD-6.3.3-BathForceWeakLimitMeaning

- source\_id：MD-6.3.3-BathForceWeakLimitMeaning。

### MD-6.3.3-BathForceWeakLimitMeaning

- 印刷页 / PDF页：237–238 / 258–259。
- 原文引文（逐字）：

> For large $`k`$ and for many choices of the frequencies $`\Omega_i`$ and the initial conditions $`\{q_i(0);p_i(0)\}`$, function $`f(t)`$ will take on the character of a Wiener process; in fact the convergence can be shown in the weak sense. We may even take the initial conditions to be randomly distributed [13,205].

- 问题所在：光滑有限热浴力的极限应区分白噪声与其时间积分Wiener过程；无初始化法则和谱条件不能指定普适法则。 两个定义分别表达力路径及积分力路径的收敛资格；没有断言实现条件存在，也没有初态、频谱标度、σ及紧性定理，网站未认证实际热浴极限。
- 反例或理由：bathForceWeakLimitMeaning：在概率空间、正质量下，将实际Printed力逐点嵌入C([0,T])，要求路径随机变量可测，W为preBrownian并有连续路径代表；对每T>0全部有界连续泛函的期望收敛，确为路径法则弱收敛而非仅边际。_corrected改成正bathForce的0至s时间积分，其余量词不变；这是与dP中的白噪声驱动更相符的候选。没有任何版本断言存在初态/质量族满足；也没有σ幅度或物理标度条件，所以不能认证实际热浴收敛或称“修复完成”。两版定义签名各自表达所说资格，但数学解释保留NEEDS\_HUMAN。
- 原文版 Lean 名称及状态：本条提供限定/修正版子句或资格定义，未另称整条原文字面断言已经形式化；当前声明：`MD.Ch06.bathForceWeakLimitMeaning`（定义）；`MD.Ch06.bathForceWeakLimitMeaning_corrected`（定义）
- 修正版 Lean 名称、改动内容、证明状态：两个定义分别表达力路径及积分力路径的收敛资格；没有断言实现条件存在，也没有初态、频谱标度、σ及紧性定理，网站未认证实际热浴极限。；`MD.Ch06.bathForceWeakLimitMeaning_corrected`（定义）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留原文与两种资格的区别；另行给初态法则、频谱/标度、σ及紧性条件后，才能提出并核验极限定理。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.bathForceWeakLimitMeaning`=未获单独PASS；见分版意见；`MD.Ch06.bathForceWeakLimitMeaning_corrected`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：未给统一的独立反例判定。
  原始分版说明：bathForceWeakLimitMeaning：在概率空间、正质量下，将实际Printed力逐点嵌入C([0,T])，要求路径随机变量可测，W为preBrownian并有连续路径代表；对每T>0全部有界连续泛函的期望收敛，确为路径法则弱收敛而非仅边际。_corrected改成正bathForce的0至s时间积分，其余量词不变；这是与dP中的白噪声驱动更相符的候选。没有任何版本断言存在初态/质量族满足；也没有σ幅度或物理标度条件，所以不能认证实际热浴收敛或称“修复完成”。两版定义签名各自表达所说资格，但数学解释保留NEEDS\_HUMAN。

## 17. MD-6.3.6-FPPolynomialAdjoint

- source\_id：MD-6.3.6-FPPolynomialAdjoint。

### MD-6.3.6-FPPolynomialAdjoint

- 印刷页 / PDF页：241–242 / 262–263。
- 原文引文（逐字）：

> We assume that $`\rho`$ is $`C^\infty`$ for all $`t`$ and that the density tends to zero exponentially fast as $`x\to\pm\infty`$, whereas $`a`$ and $`b`$ are $`C^\infty`$ functions which grow at most polynomially fast in these limits, that is, there are constants $`\eta_a`$, $`\eta_b`$ such that

$$
a(x)=\mathcal O(|x|^{\eta_a}),\quad b(x)=\mathcal O(|x|^{\eta_b}),\quad x\to\pm\infty.
$$


> This condition of polynomial growth of the coefficients is a common assumption in the analysis of SDEs. For future reference we define the space of functions which are $`C^\infty`$ smooth and satisfy the polynomial growth restriction by $`CP^\infty`$:

$$
CP^\infty=\{\phi\in C^\infty\mid\exists\eta\in\mathbb N:\phi(x)=O(|x|^\eta),\ x\to\pm\infty\}.
$$


> For any $`\phi\in CP^\infty`$, the expectation with respect to $`\rho(x,t)`$ is well defined and we have

$$
\mathbb E\phi(X(t))=\langle\phi,\rho\rangle=\int_{-\infty}^{+\infty}\phi(x)\rho(x,t)dx.
$$


> Taking the differential, we obtain an equation for $`\mathbb E d\phi`$ which must be equal to (6.37):

$$
\int_{-\infty}^{+\infty}\phi(x)\frac{\partial\rho}{\partial t}dx=\int_{-\infty}^{+\infty}(\mathcal L\phi)(x)\rho(x,t)dx=\int_{-\infty}^{+\infty}(a(x)\phi'+\tfrac12 b^2(x)\phi''(x))\rho(x,t)dx.
$$


> Using the assumptions given above regarding the exponential rate of decay of the density, it is possible to recast the right hand side as an integral of a product with $`\phi`$. First, we find

$$
\int_{-\infty}^{+\infty}a(x)\phi'(x)\rho(x,t)dx=[\phi(x)a(x)\rho(x,t)]_{-\infty}^{\infty}-\int_{-\infty}^{+\infty}\phi(x)(a(x)\rho(x,t))_x dx=-\int_{-\infty}^{+\infty}\phi(x)(a(x)\rho(x,t))_x dx.
$$


> With two rounds of integration by parts on the term involving $`b(x)`$, we find, using the fact that the boundary terms vanish,

$$
\int_{-\infty}^{+\infty}b^2(x)\phi''(x)\rho(x,t)dx=\int_{-\infty}^{+\infty}\phi(x)(b^2(x)\rho)_{xx}(x,t)dx.
$$


> Finally, putting these results together, we have

$$
\int_{-\infty}^{+\infty}\phi(x)\left[\frac{\partial\rho}{\partial t}+\frac{\partial}{\partial x}(a(x)\rho(x,t))-\frac12\frac{\partial^2}{\partial x^2}(b^2(x)\rho)\right]dx=0.
$$


> If this is to hold for all test functions $`\phi`$, we must have

$$
\frac{\partial\rho}{\partial t}=-\frac{\partial}{\partial x}(a(x)\rho)+\frac12\frac{\partial^2}{\partial x^2}(b^2(x)\rho).
$$


> This partial differential equation is often called the Fokker-Planck equation. The great benefit of the Fokker-Planck equation is that it enables the macroscopic perspective on the solutions of an SDE.
> The Fokker-Planck equation may be written in the compact form

$$
\frac{\partial\rho}{\partial t}=\mathcal L^\dagger\rho,
$$


> where the operator appearing on the right hand side is the adjoint $`\mathcal L^\dagger`$ of the generator of the stochastic process, satisfying the relation

$$
\langle\mathcal L\phi,\rho\rangle=\langle\phi,\mathcal L^\dagger\rho\rangle.
$$



- 问题所在：函数值的多项式增长不控制全部导数；可取振荡频率快速增长的有界光滑函数。
- 反例或理由：光滑有界φ(x)=sin(exp(x⁴))具有多项式函数值界而导数增长超指数；取ρ(x)=exp(-x²)，仅函数值的原书条件不能保证φ′ρ、φ″ρ可积。此例展示缺失资格，不把不可积表达式自动当作普通积分反例数值。
- 原文版 Lean 名称及状态：`MD.Ch06.fpPolynomialAdjointPrinted`（未证）
- 修正版 Lean 名称、改动内容、证明状态：显式约束所需导数的多项式增长和密度导数的指数衰减。；`MD.Ch06.fpPolynomialAdjoint_corrected`（未证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：补回省略原文；保留函数值条件Printed疑问，使用明确导数界的限定版。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.fpPolynomialAdjoint`=PASS；`MD.Ch06.fpPolynomialAdjoint_corrected`=PASS；`MD.Ch06.fpPolynomialAdjointPrinted`=原文忠实性PASS；原书数学/范围NEEDS\_HUMAN。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：fpPolynomialAdjoint及\_corrected：a,b,ρ,φ为C∞；a,b,φ的0至2阶导数逐阶有全局多项式界，ρ的0至2阶导数逐阶有正指数尾；这些明确加强条件保证真正非紧支撑积分可积与所需边界消失，scalarGenerator=aφ′+b²φ″/2、scalarForward=-(aρ)′+(b²ρ)″/2，签名正确。fpPolynomialAdjointPrinted只约束k=0的函数值，忠实于原书CP∞和密度衰减，不能据此控制导数、边界或积分；Printed保留NEEDS\_HUMAN。原文并未证明任意此类测试函数的Lφ可积，不能让Bochner总化积分掩盖问题。

## 18. MD-6.3.3-VariableFrictionCanonicalPrinted

- source\_id：MD-6.3.3-VariableFrictionCanonicalPrinted。

### MD-6.3.3-VariableFrictionCanonicalPrinted

- 印刷页 / PDF页：239 / 260。
- 原文引文（逐字）：

> However, it should be noted that in many types of modelling, the physical nature of the interaction with the solvent bath is neglected and $`\gamma`$ or $`\Gamma(q)`$ are simply viewed as artificial parameters which allow recovery of averages with respect to the canonical distribution.

- 问题所在：M与A=ΓΓᵀ不交换时，A M⁻¹和M⁻¹/² A M⁻¹/²不同；例如M=diag(1,4)、Γ=(1,1)ᵀ。
- 反例或理由：n=2,r=1,m=(1,4),θ=1,U=0,Γ=(1,1)ᵀ常矩阵，p=(1,1)。ΓΓᵀ为全1矩阵。D42/ρ=−pᵀM⁻¹(ΓΓᵀ)p+pᵀM⁻½(ΓΓᵀ)M⁻½p=−1/4，故前向值=−exp(−5/8)/4≠0。
- 原文版 Lean 名称及状态：`MD.Ch06.variableFrictionCanonicalPrinted`（未证）
- 修正版 Lean 名称、改动内容、证明状态：增加ΓΓᵀ与质量矩阵M交换条件；另一个可选修法是修改漂移以匹配噪声协方差。；`MD.Ch06.variableFrictionCanonicalPrinted_corrected`（未证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留原句和疑误；加入条目14的交换前提可获形式stationarity。若要保留任意Γ，可重新设计满足涨落耗散的漂移；不可把原文平均恢复直接提升为遍历采样定理。
- 网站复审结论：本条未单独复审，保留首轮整体=NEEDS\_HUMAN；`MD.Ch06.variableFrictionCanonicalPrinted`=未获单独PASS；见分版意见；`MD.Ch06.variableFrictionCanonicalPrinted_corrected`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：C：量化任意n/r、正m、光滑U/Γ、θ>0以及所有相点，断言D42作用于未归一化exp(−H/θ)为0；对象、Hamiltonian质量分母和全部结论无遗漏。但该Printed全称命题不成立。作为原书canonical目标的必要检验可保留，不能认定数学PASS；也没有证明归一化存在或采样遍历性。[EXTRA]正确提醒必要性，不修复非交换问题。

## 19. MD-6.4.1-FiniteDistribution

- source\_id：MD-6.4.1-FiniteDistribution。

### MD-6.4.1-FiniteDistribution

- 印刷页 / PDF页：245 / 266。
- 原文引文（逐字）：

> A distribution on the state space is typically associated to a row vector $`\psi=(\psi_1,\psi_2,\ldots,\psi_k)`$ with nonzero elements and which is normalized such that

$$
\sum_{i=1}^k\psi_i=1.
$$



- 问题所在：一般概率向量可为(1,0)；nonzero不能作为全部分布的定义。
- 反例或理由：ψ=(1,0)非负且和1，但第二分量不严格正；任务给出的counterexample完整表达此事实。
- 原文版 Lean 名称及状态：`MD.Ch06.finiteDistributionPrinted`（定义）；`MD.Ch06.finiteDistributionPrinted_counterexample`（已证）
- 修正版 Lean 名称、改动内容、证明状态：原nonzero单独保留为严格正权重版本；一般定义采用非负权重、总和1。；`MD.Ch06.finiteDistribution_corrected`（定义）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留原书疑误并加[ERRATUM?]；按本条说明分别保留Printed版和修正版。
- 网站复审结论：本条未单独复审，保留首轮整体=PASS；`MD.Ch06.finiteDistribution`=PASS；`MD.Ch06.finiteDistribution_corrected`=未获单独PASS；见分版意见；`MD.Ch06.finiteDistributionPrinted`=未获单独PASS；见分版意见；`MD.Ch06.finiteDistributionPrinted_counterexample`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：逐个审校：finiteDistribution及\_corrected均为非负且总和1的一般概率向量；finiteDistributionPrinted按概率权重上下文将nonzero保留为严格正且总和1；反例(1,0)确实满足前者且不满足后者。三种对象及counterexample相互吻合。原句含typically，不能无条件把原文认定为错误定义；应保留人审。

## 20. MD-6.4.2-CylinderForwardPrinted

- source\_id：MD-6.4.2-CylinderForwardPrinted。

### MD-6.4.2-CylinderForwardPrinted

- 印刷页 / PDF页：247 / 268。
- 原文引文（逐字）：

> Taking the adjoint, the forward Kolmogorov or Fokker-Planck operator is $`\mathcal L^\dagger`$, acting on a density $`\rho(X)`$ as

$$
\mathcal L^\dagger\rho=-\nabla\cdot(b_0\rho)+\tfrac12\operatorname{Tr}(B^T\phi''B).
$$



- 问题所在：密度前向算子不应依赖独立的检验函数φ；即使ρ固定，改变φ会改变印刷右端。
- 反例或理由：n=r=1,b0=0,B=1,ρ=0,φ(x)=x²；Printed所得常数1，而真正前向算子作用零密度应为0。
- 原文版 Lean 名称及状态：`MD.Ch06.cylinderForwardPrinted`（定义）
- 修正版 Lean 名称、改动内容、证明状态：扩散项中的φ″改为ρ″。；`MD.Ch06.cylinderForwardPeriodic_corrected`（定义）；`MD.Ch06.cylinderForwardPrinted_corrected`（定义）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：转录L^*恢复L^†；Printed保留φ″疑误。数学修正版扩散必须作用ρ，注明周期版的n+n维和光滑周期函数域限制。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.cylinderForwardPrinted`=原文忠实性PASS；原书数学/范围NEEDS\_HUMAN；`MD.Ch06.cylinderForwardPeriodic_corrected`=PASS；`MD.Ch06.cylinderForwardPrinted_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：cylinderForwardPrinted：任意欧氏n维b0、n×r常B、密度ρ和独立测试φ，负散度作用于b0ρ，扩散作用φ并除2，忠实保留原书符号错误，但这是欧氏局部坐标表达式，不是完整一般T^k1×R^k2域。cylinderForwardPrinted\_corrected调用vectorForward，将扩散改为ρ，欧氏辅助定义正确。cylinderForwardPeriodic\_corrected在真实T^n×R^n上按Fin n⊕Fin n坐标方向求周期lift的一、二阶方向导数，用Σ\_j B\_ij B\_kj和1/2给前向密度算子；维数与噪声列维一致，作为光滑周期密度的形式表达式正确。它只覆盖k1=k2=n的Langevin相空间，非原页全部k1,k2；且未在类型内强制光滑/密度资格，不能当算子域或不变性定理。

## 21. MD-6.4.3-BrownianSymmetry / MD-6.4.3-BrownianClosedSelfAdjoint / MD-6.4.3-BrownianCompactResolvent

- source\_id：MD-6.4.3-BrownianSymmetry；MD-6.4.3-BrownianClosedSelfAdjoint；MD-6.4.3-BrownianCompactResolvent。

### MD-6.4.3-BrownianSymmetry

- 印刷页 / PDF页：250 / 271。
- 原文引文（逐字）：

> In this form we see that $`f`$ and $`g`$ appear symmetrically, so we may write

$$
\langle f,\mathcal Lg\rangle_\beta=\langle\mathcal Lf,g\rangle_\beta;
$$


> hence, with respect to the weighted inner product, $`\mathcal L^\dagger=\mathcal L`$. (Note that the adjoint indicated here is quite different than the $`L^2`$ adjoint mentioned previously in connection with the Fokker-Planck operator.)

- 问题所在：A：配对等式及随后L†=L的引文准确，原文的自伴措辞应保留。C：两份Lean签名完全相同，均为PASS的限定配对恒等式：积分在一个基本立方体上，权为exp(−βU)，U、f、g均C∞且单位周期，β≠0；m仅作实系数参数，形式对称本身不需要质量正性。D32–D34及归一配对定义表明取消正的配分函数因子不会改变等式。它们没有表达伴随算子的定义域等于原定义域。原页从对称积分直接说L†=L，但此前给出的C₀²域是否指闭实现并不清楚，不能把正确的核心对称等式当作原域已自伴。corrected版数学陈述通过；整条因原文域解释仍为NEEDS\_HUMAN，而非因证明占位或定义缺失。 两份相同签名只覆盖周期核心的形式配对对称；不覆盖原域与伴随域相等。
- 反例或理由：用于说明域问题而非反驳配对等式：在一维周期环面、U=0时，将d²/dq²仅定义在C∞周期核心上，它对称但尚未闭；其自伴闭实现的定义域为周期H²。
- 原文版 Lean 名称及状态：本条提供限定/修正版子句或资格定义，未另称整条原文字面断言已经形式化；当前声明：`MD.Ch06.brownianSymmetry`（已证）；`MD.Ch06.brownianSymmetry_corrected`（已证）
- 修正版 Lean 名称、改动内容、证明状态：两份相同签名只覆盖周期核心的形式配对对称；不覆盖原域与伴随域相等。；`MD.Ch06.brownianSymmetry_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留原文及域疑问；将本条签名标为形式对称限定版，并由闭Gibbs-L²实现单列自伴结论。不要将两份相同签名计为额外覆盖了原伴随域断言。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.brownianSymmetry`=PASS；`MD.Ch06.brownianSymmetry_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：A：配对等式及随后L†=L的引文准确，原文的自伴措辞应保留。C：两份Lean签名完全相同，均为PASS的限定配对恒等式：积分在一个基本立方体上，权为exp(−βU)，U、f、g均C∞且单位周期，β≠0；m仅作实系数参数，形式对称本身不需要质量正性。D32–D34及归一配对定义表明取消正的配分函数因子不会改变等式。它们没有表达伴随算子的定义域等于原定义域。原页从对称积分直接说L†=L，但此前给出的C₀²域是否指闭实现并不清楚，不能把正确的核心对称等式当作原域已自伴。corrected版数学陈述通过；整条因原文域解释仍为NEEDS\_HUMAN，而非因证明占位或定义缺失。


### MD-6.4.3-BrownianClosedSelfAdjoint

- 印刷页 / PDF页：249–250 / 270–271。
- 原文引文（逐字）：

> Then $`\mathcal L`$ is self-adjoint with respect to this inner product.

- 问题所在：A：印刷249页末的“Then L is self-adjoint with respect to this inner product.”摘录准确。C：两份签名相同且作为修正版均PASS：正对角质量、β>0、C∞单位周期势；对象为归一Gibbs复L²上的实际部分线性算子，结论为完整IsSelfAdjoint。已展开光滑周期空间→L²嵌入→光滑域算子→实图闭包→由实际闭算子特征空间构成的复Hilbert基→最大复图。复图约束的是所有谱系数，并非只在原光滑域验证对称；归一权重的常数缩放不改变自伴关系。原书该句的前置对象是C₀²(μ̄β)，并先取M=I、γ=1；本条采用周期闭实现及正对角质量推广，是明确披露的域修正而非原C₀²域的逐字实现。[EXTRA]已要求人工确认，整条据此为NEEDS\_HUMAN。 限定版正质量、β>0、C∞单位周期势、闭Gibbs复L²实现已获PASS；原C₀²措辞与闭实现的解释仍待导师。
- 反例或理由：一维周期Laplacian限制于C∞周期核心时是对称的；其自伴实现使用更大的周期H²域。核心对称不能消除这个域差别。
- 原文版 Lean 名称及状态：本条提供限定/修正版子句或资格定义，未另称整条原文字面断言已经形式化；当前声明：`MD.Ch06.brownianClosedSelfAdjoint`（已证）；`MD.Ch06.brownianClosedSelfAdjoint_corrected`（已证）
- 修正版 Lean 名称、改动内容、证明状态：限定版正质量、β>0、C∞单位周期势、闭Gibbs复L²实现已获PASS；原C₀²措辞与闭实现的解释仍待导师。；`MD.Ch06.brownianClosedSelfAdjoint_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：人工确认将原书C₀²措辞解释为相应闭实现；继续将现有两份签名标为正确限定版，并保留原域疑问。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.brownianClosedSelfAdjoint`=PASS；`MD.Ch06.brownianClosedSelfAdjoint_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：A：印刷249页末的“Then L is self-adjoint with respect to this inner product.”摘录准确。C：两份签名相同且作为修正版均PASS：正对角质量、β>0、C∞单位周期势；对象为归一Gibbs复L²上的实际部分线性算子，结论为完整IsSelfAdjoint。已展开光滑周期空间→L²嵌入→光滑域算子→实图闭包→由实际闭算子特征空间构成的复Hilbert基→最大复图。复图约束的是所有谱系数，并非只在原光滑域验证对称；归一权重的常数缩放不改变自伴关系。原书该句的前置对象是C₀²(μ̄β)，并先取M=I、γ=1；本条采用周期闭实现及正对角质量推广，是明确披露的域修正而非原C₀²域的逐字实现。[EXTRA]已要求人工确认，整条据此为NEEDS\_HUMAN。


### MD-6.4.3-BrownianCompactResolvent

- 印刷页 / PDF页：250 / 271。
- 原文引文（逐字）：

> In particular, it has a compact resolvent [360]; this can be shown to imply that the spectrum consists only of a countable collection of eigenvalues, i.e. that the operator has a discrete spectrum.

- 问题所在：A：compact resolvent、引用[360]及随后可数离散特征值的原句准确。C：两份紧性签名作为周期闭实现的限定版均PASS。已展开D86–D91：实闭图上的shift为(x,y)↦x−y，逆映射后取第一坐标，所得确为(1−L)⁻¹；复预解式由实部、虚部分别作用该真实预解式并复线性化得到，不是一个仅名为resolvent的任意紧算子。正质量、β>0和紧配置环面是明确前提；没有将紧性本身假设进去。此条签名仅给预解式紧性，离散谱的对应条目为7。原页仍把性质归在C₀²函数空间上；与闭实现、紧配置假设之间的解释差别已在[EXTRA]要求签核，不能由本条自动认证原一般域表述。 只给实际(1−L)⁻¹紧性，离散谱由相邻独立条目承接；不把原域解释自动视为已认证。
- 反例或理由：A：compact resolvent、引用[360]及随后可数离散特征值的原句准确。C：两份紧性签名作为周期闭实现的限定版均PASS。已展开D86–D91：实闭图上的shift为(x,y)↦x−y，逆映射后取第一坐标，所得确为(1−L)⁻¹；复预解式由实部、虚部分别作用该真实预解式并复线性化得到，不是一个仅名为resolvent的任意紧算子。正质量、β>0和紧配置环面是明确前提；没有将紧性本身假设进去。此条签名仅给预解式紧性，离散谱的对应条目为7。原页仍把性质归在C₀²函数空间上；与闭实现、紧配置假设之间的解释差别已在[EXTRA]要求签核，不能由本条自动认证原一般域表述。
- 原文版 Lean 名称及状态：本条提供限定/修正版子句或资格定义，未另称整条原文字面断言已经形式化；当前声明：`MD.Ch06.brownianCompactResolvent`（已证）；`MD.Ch06.brownianCompactResolvent_corrected`（已证）
- 修正版 Lean 名称、改动内容、证明状态：只给实际(1−L)⁻¹紧性，离散谱由相邻独立条目承接；不把原域解释自动视为已认证。；`MD.Ch06.brownianCompactResolvent_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留原文；签核周期闭实现的限定，并明确引用条目7承接离散谱子句。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.brownianCompactResolvent`=PASS；`MD.Ch06.brownianCompactResolvent_corrected`=PASS。原书疑误/范围待导师。反例：未给统一的独立反例判定。
  原始分版说明：A：compact resolvent、引用[360]及随后可数离散特征值的原句准确。C：两份紧性签名作为周期闭实现的限定版均PASS。已展开D86–D91：实闭图上的shift为(x,y)↦x−y，逆映射后取第一坐标，所得确为(1−L)⁻¹；复预解式由实部、虚部分别作用该真实预解式并复线性化得到，不是一个仅名为resolvent的任意紧算子。正质量、β>0和紧配置环面是明确前提；没有将紧性本身假设进去。此条签名仅给预解式紧性，离散谱的对应条目为7。原页仍把性质归在C₀²函数空间上；与闭实现、紧配置假设之间的解释差别已在[EXTRA]要求签核，不能由本条自动认证原一般域表述。

## 22. MD-6.4.3-BrownianNonpositive / MD-6.4.3-BrownianRealEigenvalue / MD-6.4.3-BrownianNegativeDefinitePrinted

- source\_id：MD-6.4.3-BrownianNonpositive；MD-6.4.3-BrownianRealEigenvalue；MD-6.4.3-BrownianNegativeDefinitePrinted。

### MD-6.4.3-BrownianNonpositive

- 印刷页 / PDF页：250 / 271。
- 原文引文（逐字）：

> Moreover, from the calculation above,

$$
\langle f,\mathcal Lf\rangle=-\beta^{-1}\int_{\mathcal Q}\|\nabla f\|^2\bar\rho_\beta d\omega_q;
$$


> so that $`\langle f,\mathcal Lf\rangle\le0`$ so the operator is negative definite and can only have non-positive eigenvalues.

- 问题所在：非零常数函数的梯度为0，二次型等于0；故仅为半负定。
- 反例或理由：f≡1光滑周期非零，但Lf=0，二次型=0。
- 原文版 Lean 名称及状态：本条提供限定/修正版子句或资格定义，未另称整条原文字面断言已经形式化；当前声明：`MD.Ch06.brownianNonpositive`（已证）；`MD.Ch06.brownianNonpositive_corrected`（已证）；`MD.Ch06.brownianNegativeDefinitePrinted_corrected`（已证）
- 修正版 Lean 名称、改动内容、证明状态：采用≤0并区分闭算子实现与光滑核心；严格负定字面另见BrownianNegativeDefinitePrinted。；`MD.Ch06.brownianNonpositive_corrected`（已证）；`MD.Ch06.brownianNegativeDefinitePrinted_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：原文保留并标注半负定；严格负定只能在合适的零均值非零子空间讨论。
- 网站复审结论：本条未单独复审，保留首轮整体=NEEDS\_HUMAN；`MD.Ch06.brownianNonpositive`=未获单独PASS；见分版意见；`MD.Ch06.brownianNonpositive_corrected`=未获单独PASS；见分版意见；`MD.Ch06.brownianNegativeDefinitePrinted_corrected`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：正质量、β>0及周期光滑域下未归一二次型≤0正确。原文negative definite错误，已有[ERRATUM?]保留；本签名仅保留正确的半负定子结论。


### MD-6.4.3-BrownianRealEigenvalue

- 印刷页 / PDF页：250 / 271。
- 原文引文（逐字）：

> so that $`\langle f,\mathcal Lf\rangle\le0`$ so the operator is negative definite and can only have non-positive eigenvalues.

- 问题所在：A：原文确实同时写⟨f,Lf⟩≤0和“negative definite”，转录未错，不能在原引文中静默改成半负定。C：两份签名均PASS：正质量、β>0、C∞周期U及非零L²意义的C∞周期f，逐点满足Lf=ℓf，且参数ℓ预先属于ℝ，结论ℓ≤0。非零性相对于基本立方体Lebesgue几乎处处定义，正Gibbs权使其等价于Gibbs-L²非零；没有把特征值符号作为假设。声明不证明任意复特征值实性，也不证明严格负定；这些限制已由[EXTRA]说明。整条因原书严格负定用语的数学疑误需人工签核。
- 反例或理由：取Nc=1、m=1、U=0、β=1、f≡1。f在基本立方体上非零且C∞周期，Lf=0，故⟨f,Lf⟩β=0，而不是<0。ℓ=0完全符合本条两份正确签名。
- 原文版 Lean 名称及状态：本条提供限定/修正版子句或资格定义，未另称整条原文字面断言已经形式化；当前声明：`MD.Ch06.brownianRealEigenvalue`（已证）；`MD.Ch06.brownianRealEigenvalue_corrected`（已证）
- 修正版 Lean 名称、改动内容、证明状态：保留已明确的限定条件，原书疑误待裁定。；`MD.Ch06.brownianRealEigenvalue_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留原文negative definite并挂[ERRATUM?]；限定/修正版使用半负定及实特征参数非正，复谱实性另引闭自伴结果。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.brownianRealEigenvalue`=PASS；`MD.Ch06.brownianRealEigenvalue_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：A：原文确实同时写⟨f,Lf⟩≤0和“negative definite”，转录未错，不能在原引文中静默改成半负定。C：两份签名均PASS：正质量、β>0、C∞周期U及非零L²意义的C∞周期f，逐点满足Lf=ℓf，且参数ℓ预先属于ℝ，结论ℓ≤0。非零性相对于基本立方体Lebesgue几乎处处定义，正Gibbs权使其等价于Gibbs-L²非零；没有把特征值符号作为假设。声明不证明任意复特征值实性，也不证明严格负定；这些限制已由[EXTRA]说明。整条因原书严格负定用语的数学疑误需人工签核。


### MD-6.4.3-BrownianNegativeDefinitePrinted

- 印刷页 / PDF页：250 / 271。
- 原文引文（逐字）：

> so that $`\langle f,\mathcal Lf\rangle\le0`$ so the operator is negative definite and can only have non-positive eigenvalues.

- 问题所在：取f≡1，非零而〈f,Lf〉=0。
- 反例或理由：任意维数取U=0、m≡1、β=1、f≡1；基本域测度1，f非零而Lf=0，结论0<0为假。
- 原文版 Lean 名称及状态：`MD.Ch06.brownianNegativeDefinitePrinted`（未证）
- 修正版 Lean 名称、改动内容、证明状态：将严格小于0改为小于等于0；零特征值与常数核保留。；`MD.Ch06.brownianNegativeDefinitePrinted_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：修正版改≤0，或在零均值非零子空间给严格不等式。
- 网站复审结论：本条未单独复审，保留首轮整体=NEEDS\_HUMAN；`MD.Ch06.brownianNegativeDefinitePrinted`=原文忠实性PASS；原书数学/范围NEEDS\_HUMAN；`MD.Ch06.brownianNegativeDefinitePrinted_corrected`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：Printed严格负定版准确编码任意非零周期光滑f的二次型<0；虽为假，按原文字面版规则不以不忠实判FAIL。已有[ERRATUM?]正确。

## 23. MD-6.4.3-Theorem61 / MD-6.4.3-Theorem61TimeAveragePrinted

- source\_id：MD-6.4.3-Theorem61；MD-6.4.3-Theorem61TimeAveragePrinted。

### MD-6.4.3-Theorem61

- 印刷页 / PDF页：250–251 / 271–272。
- 原文引文（逐字）：

> Theorem 6.1 Define the generator of Brownian dynamics by

$$
\mathcal Lf\stackrel{\rm def}=-M^{-1}\nabla U^T\nabla f+\beta^{-1}\Delta_Mf.
$$


> Suppose that $`U`$ is smooth with periodic boundary conditions $`\mathcal Q=\mathbb T^{N_c}`$ ($`\mathbb T^{N_c}`$ an $`N_c`$-dimensional torus). Then, with respect to the space $`C_0^2(\mu_\beta)`$ with inner product $`\langle f,g\rangle_\beta`$ as defined above, we have:
> 1. $`\mathcal L`$ is self-adjoint, negative definite, with spectrum consisting of discrete eigenvalues on the half line $`(-\infty,0]`$.
> 2. $`\mathcal L`$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $`\sigma(\mathcal L)\subset(-\infty,-\alpha]`$ for some $`\alpha\gt 0`$.
> 3. averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $`\varphi`$, we have

$$
|\bar\varphi(t)-\operatorname{Av}_\beta(\varphi)|\le K\|\varphi\|_\beta e^{-\alpha t};
$$


> for some positive $`K`$ and $`\alpha`$, where recall $`\bar\varphi(t)`$ denotes the time average of $`\varphi`$ defined in (5.6).

- 问题所在：常数核反驳严格负定；随机轨道时间平均通常不具有原式的逐路径指数误差界；核心域上的对称性不自动等于闭实现的自伴性。此外p.244将ΔM定义为正质量权重，Brownian生成元扩散应为逆质量权重；m=2、U=0、f(x)=x²可区分二者。 旧Printed使用闭实现是形式化偏差，已改名限定摘录；原文负定措辞及分布/轨道平均冲突仍保留。印刷244/PDF265已目视核定ΔM=Σmi∂²/∂pi²，与构型逆质量生成元须区分。
- 反例或理由：严格负定：取一维、m=β=1、U=0、f≡1，有Lf=0且⟨f,Lf⟩=0。轨道指数界也不能用分布指数混合替代：在同一圆周Brownian模型、初值0、f(q)=cos(2πq)时，对每个固定t>0有正概率整段路径停在足够小的邻域，时间平均仍接近1而空间平均为0；当t足够大，任意固定Kexp(−αt)都会小于该偏差，故Printed所要求的几乎处处、所有t成立的固定常数界不能成立。此处反例说明原书疑误，不作为Printed忠实性FAIL的理由。
- 原文版 Lean 名称及状态：原文逐字全文保留在上方；原域及原生成元的整条字面Lean声明尚缺。`MD.Ch06.theorem61ClosedRealizationExcerpt`仅为闭实现限定摘录（未证），不能计为原域Printed。
- 修正版 Lean 名称、改动内容、证明状态：主版与\_corrected保持网站已通过的闭实现/分布平均签名。旧theorem61Printed改名theorem61ClosedRealizationExcerpt，明确只是闭实现限定摘录，不能冒称C₀²原域及原ΔM生成元的整条字面实现。分布平均与轨道时间平均冲突、negative definite措辞保留为原书疑误。；`MD.Ch06.theorem61_corrected`（未证）；`MD.Ch06.brownianMassGeneratorPrinted_corrected`（定义）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：不改工程的建议：保留当前主版/corrected为闭实现和分布平均修正版。将现有Printed重命名为闭实现限定摘录，或另设真正保留C₀²原域及原ΔM记号的literal声明；不把单独质量表达式当作已经连接到整个Printed定理。原书数学疑误继续标[ERRATUM?]并待人工决定。
- 网站复审结论：复审整体=FAIL；`MD.Ch06.theorem61`=PASS；`MD.Ch06.theorem61_corrected`=PASS；`MD.Ch06.theorem61ClosedRealizationExcerpt`=修复后未再送网站；`MD.Ch06.brownianMassGeneratorPrinted`=修复后未再送网站；`MD.Ch06.brownianMassGeneratorPrinted_corrected`=修复后未再送网站。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：A：Theorem 6.1的生成元、三款结论及最后明确指向(5.6)的time average均准确转录；书中分布平均与轨道时间平均的冲突以及negative definite措辞须保留为原书疑误。C分版本：theorem61和theorem61\_corrected作为限定修正版均PASS，包含完整闭自伴、全部复谱实且非正、可数、每点有非零图特征向量、孤立、非零谱隙及对所有非负归一L²相对初始密度的演化分布平均指数界。K、α在ρ之后、在所有f和t之前选择，量词正确；DensityLaw为真实Brownian核作用初始ρμβ，DensityAverage的分母在这些概率条件下为1。修正生成元的扩散和漂移均用逆质量，匹配给出的实际Brownian路径系数。theorem61Printed的严格负定及几乎处处轨道平均指数界保留了原文疑误，但它仍使用与corrected相同的闭复L²算子，而原文明确以C₀²(μβ)为域；其全部谱/自伴断言也未与另列的brownianMassGeneratorPrinted建立对象联系。因此该名字为Printed的整条声明不是原域及原生成元的字面实现，忠实性FAIL；这与原书数学错误本身的NEEDS\_HUMAN及sorry无关。brownianMassGeneratorPrinted的代数表达与其注释一致，但附件没有印刷244页，无法据本附件独立确认ΔM在该页的既定含义，应保留记号歧义而不能假称已逐页核实。


### MD-6.4.3-Theorem61TimeAveragePrinted

- 印刷页 / PDF页：251 / 272。
- 原文引文（逐字）：

> Theorem 6.1 Define the generator of Brownian dynamics by

$$
\mathcal Lf\stackrel{\rm def}=-M^{-1}\nabla U^T\nabla f+\beta^{-1}\Delta_Mf.
$$


> Suppose that $`U`$ is smooth with periodic boundary conditions $`\mathcal Q=\mathbb T^{N_c}`$ ($`\mathbb T^{N_c}`$ an $`N_c`$-dimensional torus). Then, with respect to the space $`C_0^2(\mu_\beta)`$ with inner product $`\langle f,g\rangle_\beta`$ as defined above, we have:
> 1. $`\mathcal L`$ is self-adjoint, negative definite, with spectrum consisting of discrete eigenvalues on the half line $`(-\infty,0]`$.
> 2. $`\mathcal L`$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $`\sigma(\mathcal L)\subset(-\infty,-\alpha]`$ for some $`\alpha\gt 0`$.
> 3. averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $`\varphi`$, we have

$$
|\bar\varphi(t)-\operatorname{Av}_\beta(\varphi)|\le K\|\varphi\|_\beta e^{-\alpha t};
$$


> for some positive $`K`$ and $`\alpha`$, where recall $`\bar\varphi(t)`$ denotes the time average of $`\varphi`$ defined in (5.6).

- 问题所在：对非平凡平稳扩散，时间平均的随机波动通常为代数尺度；原句前半讨论演化分布平均，末句却引用(5.6)时间平均。
- 反例或理由：取一维圆周U=0、标准Brownian及非恒定余弦检验。若所有t的时间积分误差≤Ct exp(−αt)，则积分趋0；任意固定长度的后期区间积分也须趋0，但混合平稳极限中该区间积分具有非退化分布，矛盾。
- 原文版 Lean 名称及状态：`MD.Ch06.theorem61TimeAveragePrinted`（未证）
- 修正版 Lean 名称、改动内容、证明状态：选择演化分布平均，限定L²初始相对密度；轨道遍历极限应另行陈述，不赋予指数逐路径率。；`MD.Ch06.theorem61TimeAveragePrinted_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留字面版并判人工；修正版改演化分布平均，轨道平均另给适当概率/渐近结论。
- 网站复审结论：本条未单独复审，保留首轮整体=NEEDS\_HUMAN；`MD.Ch06.theorem61TimeAveragePrinted`=未获单独PASS；见分版意见；`MD.Ch06.theorem61TimeAveragePrinted_corrected`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：按Printed规则核查：任意点初值、K,α先于f与AE样本、全部t>0的轨道时间积分，确为原末句时间平均读法的明确化。AE资格是额外选择；原文本身与前句分布平均冲突且该指数路径界一般错误。

## 24. MD-6.4.2-OUDensityPrinted

- source\_id：MD-6.4.2-OUDensityPrinted。

### MD-6.4.2-OUDensityPrinted

- 印刷页 / PDF页：248 / 269。
- 原文引文（逐字）：

> The solution $`p(t)`$ to the Ornstein-Uhlenbeck equation, for any finite time $`t`$, is always normally distributed

$$
\rho(p,t)=\exp\left[-\frac{(p-\mu(t))^2}{2\sigma(t)^2}\right];\tag{6.44}
$$


> where

$$
\mu(t)=p_0e^{-\gamma t};\qquad\sigma^2(t)=k_BT m[1-e^{-2\gamma t}].\tag{6.45}
$$



- 问题所在：高斯权重积分为sqrt(2πσ²(t))而非1；t=0为Dirac测度。
- 反例或理由：在方差v=1时，未归一化指数在实线的积分为sqrt(2π)，不是1；t=0时真实law为δx0。
- 原文版 Lean 名称及状态：`MD.Ch06.ouDensityPrinted`（定义）
- 修正版 Lean 名称、改动内容、证明状态：增加(2πσ²(t))⁻¹/²，并限γ>0、噪声非零、t>0的密度解释。；`MD.Ch06.ouDensity`（定义）；`MD.Ch06.ouDensityPrinted_corrected`（定义）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留原书疑误并加[ERRATUM?]；按本条说明分别保留Printed版和修正版。
- 网站复审结论：本条未单独复审，保留首轮整体=PASS；`MD.Ch06.ouDensityPrinted`=PASS；`MD.Ch06.ouDensity`=PASS；`MD.Ch06.ouDensityPrinted_corrected`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：Printed定义保留了原书未归一化指数。ouMean=exp(−γt)x0，ouVariance=σ\_noise²(1−exp(−2γt))/(2γ)；取σ\_noise²=2γkBTm就得到6.45。[EXTRA]已经说明参数转换。作为字面公式定义PASS，不把原书缺归一化或t=0问题算成该字面定义的签名错误。

## 25. MD-6.4.4-Assumption1Printed / MD-6.4.4-Theorem62

- source\_id：MD-6.4.4-Assumption1Printed；MD-6.4.4-Theorem62。

### MD-6.4.4-Assumption1Printed

- 印刷页 / PDF页：252 / 273。
- 原文引文（逐字）：

> Assumption 1 The Markov process generated by the SDE (6.43) satisfies, for some fixed compact set $`C\in\mathcal B(D)`$, the conditions:
> (i) For some $`y\in\operatorname{int}(C)`$, we have that for any $`\delta\gt 0`$ there is a $`t_0\gt 0`$ such that

$$
\operatorname{Pr}(X(t_0)\in B_\delta(y)\mid X(0)=X_0)>0,\quad\forall X_0\in C.
$$


> (ii) For $`t\gt 0`$, the transition kernel possesses a density $`\widehat\rho(X,z,t)`$ such that

$$
\operatorname{Pr}(X(t)\in A\mid X(0)=X_0)=\int_A\widehat\rho(X_0,z,t)dz,\quad\forall X_0\in C,\ A\in\mathcal B(D)\cap\mathcal B(C);
$$


> and $`\widehat\rho(X,z,t)`$ is jointly continuous in $`C\times C\times[0,\infty)`$.

- 问题所在：Brownian热核对角线上随t↓0发散，t=0转移核是Dirac测度。
- 反例或理由：正维热核在对角随t↓0发散，不能在C×C×[0,∞)上取有限连续延拓。
- 原文版 Lean 名称及状态：`MD.Ch06.assumption1Printed`（定义）
- 修正版 Lean 名称、改动内容、证明状态：联合连续性的时间域由[0,∞)改为(0,∞)。；`MD.Ch06.assumption1Printed_corrected`（定义）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留Printed；改正定义仅将连续时间域改为Ioi 0，不声称原条件自动成立。
- 网站复审结论：本条未单独复审，保留首轮整体=NEEDS\_HUMAN；`MD.Ch06.assumption1Printed`=未获单独PASS；见分版意见；`MD.Ch06.assumption1Printed_corrected`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：Printed保留紧C、同一内点y、δ后选统一t、全部x和可测A⊆C及联合连续时间Ici 0；与原[0,∞)一致。ν是披露的参考测度推广，但Kernel本身不含Markov/半群资格；此定义只编码局部条件。原零时连续性疑误保留。


### MD-6.4.4-Theorem62

- 印刷页 / PDF页：252 / 273。
- 原文引文（逐字）：

> Theorem 6.2 (Geometric Ergodicity) Let the solution to (6.43) be denoted $`X(t)`$. If Assumption 1 and Assumption 2 are satisfied for

$$
C=\{X\in D\mid\varphi(X)\le K_{\alpha,\delta}\},
$$


> where $`K_{\alpha,\delta}`$ is a particular positive value depending on $`\alpha`$ and $`\delta`$, then
> (i) there exists a unique invariant measure $`\rho_*`$, with $`\mathcal L^*\rho_*=0`$, and
> (ii) there exist positive constants $`\kappa`$ and $`\lambda`$ such that for all suitable functions $`f`$ with $`|f|\le\varphi`$,

$$
|e^{t\mathcal L}f(X_0)-\operatorname{Av}(f)|\le \kappa e^{-\lambda t}\varphi(X_0);\tag{6.48}
$$


> where $`\operatorname{Av}(f)=\int_D f(z)\rho_*(z)dz`$ is the spatial average.

- 问题所在：本项与Assumption 1(ii)同一零时刻连续密度疑误，合并计数；Printed未限制真实生成元测试域是形式化偏差，本轮已另行修复。
- 反例或理由：端点问题：以一维Brownian运动、初值0、Lebesgue参考测度为例，t>0的热核在原点为(4πDt)⁻¹/²，t↓0时无界；t=0的分布是δ0，而不是在C×C×[0,∞)连续的有限实值密度。这是原书端点疑误；Printed测试域FAIL的理由是其总导数对象与原实际生成元不相同，而不是该热核例或sorry。
- 原文版 Lean 名称及状态：`MD.Ch06.theorem62Printed`（未证）
- 修正版 Lean 名称、改动内容、证明状态：原文两处k按网站逐页核对改回κ（转录纠正）。Printed的弱平稳测试补主版同样的真实右导数及局部可积差商支配，排除derivWithin默认值；保留原[0,∞)连续密度端点疑误，阈值统一性和全部结论量词不变。；`MD.Ch06.theorem62_corrected`（未证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：原文JSON的k改回κ，保留端点[ERRATUM?]。Printed中的L*ρ*=0应采用真实生成元的测试域/弱方程，至少保留主版的真实右导数与换积分资格；若需保留旧的总导数断言，应另名为形式化问题版，不称原书Printed。阈值统一性及所有结论量词应保持现状。
- 网站复审结论：复审整体=FAIL；`MD.Ch06.theorem62`=PASS；`MD.Ch06.theorem62_corrected`=PASS；`MD.Ch06.theorem62Printed`=修复后未再送网站。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：A：节号、页码、阈值集合、唯一不变测度、弱平稳意图、加权指数界及空间平均均核对；原页的正系数为κ，JSON两处写为k，应作转录纠正，其余原文数学措辞保留。C：theorem62及corrected作为加强的半群版本，签名PASS：阈值函数先于状态空间、过程及φ量化；完整Markov/Feller、局部紧Polish状态、σ有限ν、每个正时刻全部初值的绝对连续性；φ正连续且子水平紧，α、δ正；另有实际积分可积性和半群漂移估计；结论保留全部不变概率的唯一性、相对于ν的密度、受真实右导数及局部可积差商支配限制的弱平稳检验，以及统一于所有可测|f|≤φ、t≥0、x的指数界。没有把不变性或收敛结论作假设，也没有把有限个检验或单一初态替代全部量词。Printed保留[0,∞)连续密度的原书疑误，这一点本身应NEEDS\_HUMAN；但其弱平稳分句量化所有有界连续f，仅假设kernelGenerator f可积，没有要求该f存在真实右导数/属于生成元测试域。D中kernelGenerator是总定义的derivWithin，不能把其无导数时的默认值当成原书实际SDE生成元。该超出原生成元域的Printed弱平稳断言不属于原书字面陈述，忠实性FAIL。主版新增的测试域保护没有在Printed中保留，这一偏差不是sorry问题，也不能全标成原书疑误。

## 26. MD-6.4.4-MinorizationPrinted / MD-6.4.4-MinorizationCorrectedImplication

- source\_id：MD-6.4.4-MinorizationPrinted；MD-6.4.4-MinorizationCorrectedImplication。

### MD-6.4.4-MinorizationPrinted

- 印刷页 / PDF页：252 / 273。
- 原文引文（逐字）：

> It can be shown that this assumption is tantamount to the SDE satisfying a minorization condition. This condition is a particular case of the general concept of small sets, found in Markov literature for proving ergodicity.

- 问题所在：取C=∅，小集下界对全部x∈C空真，但Assumption1要求y∈int(C)，因此不成立。即使C非空，小集下界也不自动给相对于指定参考测度的联合连续密度。
- 反例或理由：S=ℝ，C=[0,1]，ν为Lebesgue，K\_t(x)=δ₀对所有t。右侧取ε=1,μ=δ₀成立；左侧局部密度不存在，且点0不在int C。故反向不成立。
- 原文版 Lean 名称及状态：`MD.Ch06.minorizationPrinted`（未证）
- 修正版 Lean 名称、改动内容、证明状态：只保留在明确正时刻密度、可达性条件下到小集下界的充分方向。；`MD.Ch06.minorizationPrinted_corrected`（未证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留字面等价并判人工；充分方向需补半群和适当正则/可达条件，反向不能无条件恢复。
- 网站复审结论：本条未单独复审，保留首轮整体=NEEDS\_HUMAN；`MD.Ch06.minorizationPrinted`=原文忠实性PASS；原书数学/范围NEEDS\_HUMAN；`MD.Ch06.minorizationPrinted_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：Printed将tantamount忠实读为↔，右侧给一个正时刻、正ENNReal下界系数和同一概率μ，对全部x∈C作完整测度序下界。左侧仍为原零时连续版；抽象签名没有SDE或Markov半群假设，等价一般错误。


### MD-6.4.4-MinorizationCorrectedImplication

- 印刷页 / PDF页：252 / 273。
- 原文引文（逐字）：

> It can be shown that this assumption is tantamount to the SDE satisfying a minorization condition. This condition is a particular case of the general concept of small sets, found in Markov literature for proving ergodicity.

- 问题所在：A：关于“tantamount”及small sets的两句原文准确。C：两份声明签名相同，作为明确加强前提的充分方向均PASS。逐项包含实际概率核半群/Chapman–Kolmogorov、参考测度对所有非空开集为正、紧C及其内点可达条件、仅正时刻在C×C上联合连续的实非负密度；此外还另行假设所有点、所有正时刻对每个非空开集都有正概率。这一全局开放集可达性是实质性加强，不能由原Assumption 1(i)的固定内点可达性直接冒充。结论的时间、ε>0及概率μ先于所有x∈C选择，测度序ε•μ≤K t x正是共同小集下界；ε不必额外假设≤1，因为K t x和μ为概率。连续局部密度、紧性和真实核合成足以支持此加强版的共同下界；未以sorry是否消除作为签名判据。这里只认证充分方向，未把原文“tantamount”解读为已经认证了必要方向。JSON须补记遗漏的全局可达前提。 仅覆盖加强条件下充分方向；还独立要求所有点、所有正时刻对每个非空开集有正概率，以及Markov合成、参考测度全支撑，不覆盖原tantamount的必要方向。
- 反例或理由：A：关于“tantamount”及small sets的两句原文准确。C：两份声明签名相同，作为明确加强前提的充分方向均PASS。逐项包含实际概率核半群/Chapman–Kolmogorov、参考测度对所有非空开集为正、紧C及其内点可达条件、仅正时刻在C×C上联合连续的实非负密度；此外还另行假设所有点、所有正时刻对每个非空开集都有正概率。这一全局开放集可达性是实质性加强，不能由原Assumption 1(i)的固定内点可达性直接冒充。结论的时间、ε>0及概率μ先于所有x∈C选择，测度序ε•μ≤K t x正是共同小集下界；ε不必额外假设≤1，因为K t x和μ为概率。连续局部密度、紧性和真实核合成足以支持此加强版的共同下界；未以sorry是否消除作为签名判据。这里只认证充分方向，未把原文“tantamount”解读为已经认证了必要方向。JSON须补记遗漏的全局可达前提。
- 原文版 Lean 名称及状态：本条提供限定/修正版子句或资格定义，未另称整条原文字面断言已经形式化；当前声明：`MD.Ch06.minorizationCorrectedImplication`（未证）；`MD.Ch06.minorizationPrinted_corrected`（未证）
- 修正版 Lean 名称、改动内容、证明状态：仅覆盖加强条件下充分方向；还独立要求所有点、所有正时刻对每个非空开集有正概率，以及Markov合成、参考测度全支撑，不覆盖原tantamount的必要方向。；`MD.Ch06.minorizationPrinted_corrected`（未证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：在JSON假设说明中补全全局开放集可达性，并保留“只审充分方向”的范围说明；不应将此修正版计为原文等价关系的完整形式化。
- 网站复审结论：复审整体=PASS；`MD.Ch06.minorizationCorrectedImplication`=PASS；`MD.Ch06.minorizationPrinted_corrected`=PASS。原书疑误/范围待导师。反例：未给统一的独立反例判定。
  原始分版说明：A：关于“tantamount”及small sets的两句原文准确。C：两份声明签名相同，作为明确加强前提的充分方向均PASS。逐项包含实际概率核半群/Chapman–Kolmogorov、参考测度对所有非空开集为正、紧C及其内点可达条件、仅正时刻在C×C上联合连续的实非负密度；此外还另行假设所有点、所有正时刻对每个非空开集都有正概率。这一全局开放集可达性是实质性加强，不能由原Assumption 1(i)的固定内点可达性直接冒充。结论的时间、ε>0及概率μ先于所有x∈C选择，测度序ε•μ≤K t x正是共同小集下界；ε不必额外假设≤1，因为K t x和μ为概率。连续局部密度、紧性和真实核合成足以支持此加强版的共同下界；未以sorry是否消除作为签名判据。这里只认证充分方向，未把原文“tantamount”解读为已经认证了必要方向。JSON须补记遗漏的全局可达前提。

## 27. MD-6.4.4-PeriodicPotentialBound / MD-6.4.4-PeriodicConfiningPrinted

- source\_id：MD-6.4.4-PeriodicPotentialBound；MD-6.4.4-PeriodicConfiningPrinted。

### MD-6.4.4-PeriodicPotentialBound

- 印刷页 / PDF页：253 / 274。
- 原文引文（逐字）：

> We also consider the potential energy to be smooth ($`C^\infty`$) with $`U(q)\to\infty`$ as $`|q|\to\infty`$. As we have a smooth potential on a bounded (position) domain, we have

$$
1<U_{\min}\le U(q)\le U_{\max}<\infty,\quad\forall q\in\mathcal Q,
$$


> for some constants $`U_{\min}`$ and $`U_{\max}`$.

- 问题所在：周期势有界，不可能同时在其欧氏lift上随|q|→∞趋于∞；U=0也不满足Umin>1。
- 反例或理由：U≡0满足连续周期却没有1<Umin≤U；正维周期势沿整数平移保持常值，不能趋∞。
- 原文版 Lean 名称及状态：`MD.Ch06.periodicPotentialBoundPrinted`（未证）；`MD.Ch06.periodicPotentialBoundPrinted_counterexample`（已证）
- 修正版 Lean 名称、改动内容、证明状态：保留周期势有界结论；正下界通过加常数归一单独实现。；`MD.Ch06.periodicPotentialBound_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：原文保留；修正版分为全域有界与可平移归一两条，删除周期lift的围束要求。
- 网站复审结论：本条未单独复审，保留首轮整体=NEEDS\_HUMAN；`MD.Ch06.periodicPotentialBound`=未获单独PASS；见分版意见；`MD.Ch06.periodicPotentialBound_corrected`=未获单独PASS；见分版意见；`MD.Ch06.periodicPotentialBoundPrinted`=未获单独PASS；见分版意见；`MD.Ch06.periodicPotentialBoundPrinted_counterexample`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：连续周期势全域有界的签名正确，M≥0的范数界给−M≤U≤M。它未包含原1<Umin；该要求由下一条平移解释而非本条证明。原文同时要求周期与配置无穷远围束，本条[ERRATUM?]正确保留。


### MD-6.4.4-PeriodicConfiningPrinted

- 印刷页 / PDF页：253 / 274。
- 原文引文（逐字）：

> The whole phase space is $`D=\mathbb T^{N_c}\times\mathbb R^{N_c}`$. We also consider the potential energy to be smooth ($`C^\infty`$) with $`U(q)\to\infty`$ as $`|q|\to\infty`$.

- 问题所在：正维周期lift沿整数平移取相同势值，无法趋于∞。
- 反例或理由：取任意q及非零整数方向e₁；q+ke₁逃离每个紧集，周期性却给U(q+ke₁)=U(q)。
- 原文版 Lean 名称及状态：`MD.Ch06.periodicConfiningPrinted`（定义）
- 修正版 Lean 名称、改动内容、证明状态：围束对象改为环面×动量空间上的Hamiltonian幂；无穷远只涉及动量方向。；`MD.Ch06.periodicConfiningPrinted_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留字面定义和勘误；torus位置域只需光滑周期，围束由H对动量给出。
- 网站复审结论：本条未单独复审，保留首轮整体=NEEDS\_HUMAN；`MD.Ch06.periodicConfiningPrinted`=原文忠实性PASS；原书数学/范围NEEDS\_HUMAN；`MD.Ch06.periodicConfiningPrinted_corrected`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：Printed对正维欧氏lift同时要求C∞、整数平移周期、cocompact处趋∞，确实忠实表达原矛盾资格；hn排除零维真空情况。不应要求构造满足它的势。

## 28. MD-6.4.4-HamiltonianPowerMomentumLaplacian / MD-6.4.4-LaplacianBoundPrinted / MD-6.4.4-LyapunovYoungBounds

- source\_id：MD-6.4.4-HamiltonianPowerMomentumLaplacian；MD-6.4.4-LaplacianBoundPrinted；MD-6.4.4-LyapunovYoungBounds。

### MD-6.4.4-HamiltonianPowerMomentumLaplacian

- 印刷页 / PDF页：253 / 274。
- 原文引文（逐字）：


$$
\Delta_p\varphi=l(l-1)H^{l-2}\|p\|^2+N_clH^{l-1}\le l(l+N_c-1)H^{l-1}.
$$



- 问题所在：A：原页的动量Laplacian精确等式和上界系数l(l+Nc−1)均准确转录，应保留原错误系数作疑误。C分版本：hamiltonianPowerMomentumLaplacian为PASS；相空间两分量确为(q,p)，H=Σpᵢ²/2+U(q)，沿(0,eᵢ)作两次一元导数再求和，结论是完整精确等式。l为正自然数；l=1时(l−2)的自然数截断无害，因为前系数l(l−1)=0；对任意U也合理，因为只对动量微分。附带给出的laplacianBoundPrinted忠实保留原上界，但该不等式错误，应NEEDS\_HUMAN而非因数学错误将字面忠实版判FAIL。laplacianBoundCorrect的系数2l(l−1)+Ncl，在U≥1前提下是正确上界，签名PASS。JSON现称上界“不属于本条”，但本包又列出了两份上界声明；应明确它们是随包核对的关联声明，不能只审等式后声称原不等式已成立。 精确等式与修正版上界2l(l−1)+Ncl获PASS；随包原上界l(l+Nc−1)保留疑误，三者分别登记。
- 反例或理由：取Nc=1、l=2、光滑周期常势U≡2、p=4。H=10，ΔpH²=3p²+4=52，而原上界l(l+Nc−1)H^(l−1)=4×10=40；52≤40为假。U=2也满足原书严格大于1的势下界。修正上界为6H=60，52≤60成立。
- 原文版 Lean 名称及状态：本条提供限定/修正版子句或资格定义，未另称整条原文字面断言已经形式化；当前声明：`MD.Ch06.hamiltonianPowerMomentumLaplacian`（已证）
- 修正版 Lean 名称、改动内容、证明状态：精确等式与修正版上界2l(l−1)+Ncl获PASS；随包原上界l(l+Nc−1)保留疑误，三者分别登记。；`MD.Ch06.laplacianBoundCorrect`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：原引文与Printed系数保持原样并挂[ERRATUM?]；修正版明确使用2l(l−1)+Ncl；范围说明列清主等式及随包两份上界的不同审校结论。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.hamiltonianPowerMomentumLaplacian`=PASS；`MD.Ch06.laplacianBoundCorrect`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：A：原页的动量Laplacian精确等式和上界系数l(l+Nc−1)均准确转录，应保留原错误系数作疑误。C分版本：hamiltonianPowerMomentumLaplacian为PASS；相空间两分量确为(q,p)，H=Σpᵢ²/2+U(q)，沿(0,eᵢ)作两次一元导数再求和，结论是完整精确等式。l为正自然数；l=1时(l−2)的自然数截断无害，因为前系数l(l−1)=0；对任意U也合理，因为只对动量微分。附带给出的laplacianBoundPrinted忠实保留原上界，但该不等式错误，应NEEDS\_HUMAN而非因数学错误将字面忠实版判FAIL。laplacianBoundCorrect的系数2l(l−1)+Ncl，在U≥1前提下是正确上界，签名PASS。JSON现称上界“不属于本条”，但本包又列出了两份上界声明；应明确它们是随包核对的关联声明，不能只审等式后声称原不等式已成立。


### MD-6.4.4-LaplacianBoundPrinted

- 印刷页 / PDF页：253 / 274。
- 原文引文（逐字）：


$$
\Delta_p\varphi=l(l-1)H^{l-2}\|p\|^2+N_clH^{l-1}\le l(l+N_c-1)H^{l-1}.
$$



- 问题所在：n=1、U=2、l=2、p=4时，实际Laplacian为52，印刷上界为40。
- 反例或理由：n=1，U≡2，l=2，p=4：H=10，二阶导数52，所称上界40。
- 原文版 Lean 名称及状态：`MD.Ch06.laplacianBoundPrinted`（未证）
- 修正版 Lean 名称、改动内容、证明状态：系数l(l+Nc−1)改为2l(l−1)+Nc·l。；`MD.Ch06.laplacianBoundPrinted_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留Printed并标ERRATUM?；修正版系数2l(l−1)+nl。
- 网站复审结论：本条未单独复审，保留首轮整体=NEEDS\_HUMAN；`MD.Ch06.laplacianBoundPrinted`=原文忠实性PASS；原书数学/范围NEEDS\_HUMAN；`MD.Ch06.laplacianBoundPrinted_corrected`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：原字面上界的量词n、U≥1、l≥1、全部相点及系数l(l+n−1)忠实；原数学断言错误，按要求保留而不把原书错误算作转录失败。


### MD-6.4.4-LyapunovYoungBounds

- 印刷页 / PDF页：253 / 274。
- 原文引文（逐字）：

> As $`H^l`$ grows faster than $`H^{l-1}`$, for any fixed $`l`$ we are able to find positive constants $`c`$ and $`d`$ such that

$$
l(l+N_c-1)H^{l-1}\le\tfrac l2H^l+c;\qquad 2lH^{l-1}U(q)<2lH^{l-1}U_{\max}\le\tfrac l2H^l+d.
$$



- 问题所在：U(q)≤Umax不能推出严格U(q)<Umax；原Laplacian错系数也不能由Young估计补救。
- 反例或理由：量词顺序正确：c,d依赖l,n,Umax，独立于所有H≥1；正性、两条原有效非严格标量界及修正系数界同时覆盖。未编码U(q)的严格不等式，已在EXTRA/ERRATUM?说明是修正版；应保留该范围说明。
- 原文版 Lean 名称及状态：`MD.Ch06.lyapunovYoungBoundsPrinted`（未证）；`MD.Ch06.lyapunovYoungBoundsPrinted_counterexample`（已证）
- 修正版 Lean 名称、改动内容、证明状态：采用非严格上界，并列原有效标量界和正确Laplacian系数所需界；若另选严格外上界才可写原严格号。；`MD.Ch06.lyapunovYoungBounds_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：把原U(q)<Umax标为需严格外界；不得把本签名称为该严格链的字面形式。
- 网站复审结论：本条未单独复审，保留首轮整体=PASS；`MD.Ch06.lyapunovYoungBounds`=PASS；`MD.Ch06.lyapunovYoungBounds_corrected`=未获单独PASS；见分版意见；`MD.Ch06.lyapunovYoungBoundsPrinted`=未获单独PASS；见分版意见；`MD.Ch06.lyapunovYoungBoundsPrinted_counterexample`=未获单独PASS；见分版意见。原书疑误/范围待导师。反例：未给统一的独立反例判定。
  原始分版说明：量词顺序正确：c,d依赖l,n,Umax，独立于所有H≥1；正性、两条原有效非严格标量界及修正系数界同时覆盖。未编码U(q)的严格不等式，已在EXTRA/ERRATUM?说明是修正版；应保留该范围说明。

## 29. MD-6.4.4-Definition61

- source\_id：MD-6.4.4-Definition61。

### MD-6.4.4-Definition61

- 印刷页 / PDF页：254 / 275。
- 原文引文（逐字）：

> Definition 6.1 (Hörmander's Condition) Let $`U\subset\mathbb R^m`$ be open. The SDE (6.43) with $`C^\infty`$ vector fields $`b_0,b_1,\ldots,b_r:U\to\mathbb R^m`$ are said to satisfy Hörmander's condition at $`z\in U`$ if the vector space spanned by the collection of iterated Lie brackets

$$
b_0,b_1,\ldots,b_r,[b_0,b_1],[b_0,b_2],\ldots,[b_{r-1},b_r],[b_0,[b_0,b_1]],\ldots
$$


> (evaluated at $`z`$) is $`\mathbb R^m`$.

- 问题所在：一维确定性dX=dt的漂移b₀=1已张成R，但点初始转移法则始终为Dirac，没有Lebesgue密度。单独把漂移放入生成族不能保证随机平滑。
- 反例或理由：A：Definition 6.1的开域、光滑向量场、域内点、包括b0的迭代括号及实线性张成等于ℝm均准确转录，省略号保持同一完整有限生成族。C：definition61与Printed逐项保留开域D、x∈D、所有Fin(S+1)字段在D上C∞以及包括漂移b0的全部迭代Lie括号；D95不是有限深度截断，D96–D97在x处取实span=⊤。全空间总化函数只用于表示局部字段，D开且光滑性只要求ContDiffOn D，因此不要求原书没有的全局光滑延拓。Bracket符号与原文v′u−u′v一致。corrected的第0层只用b1,…,bS，后续允许与任一bᵢ取括号再取并，最后量化所有自然数层并取实span，正确区分用于正时刻密度的抛物型条件。原定义包含漂移作为一个数学定义本身并不矛盾；不能据此对一般SDE断言转移密度，而本条也没有这样的定理结论。四个定义的角色及[EXTRA]一致。
- 原文版 Lean 名称及状态：`MD.Ch06.definition61Printed`（定义）
- 修正版 Lean 名称、改动内容、证明状态：用于密度结论时，从噪声字段开始，允许与漂移及噪声反复取括号；不把漂移本身直接加入初始生成族。；`MD.Ch06.definition61_corrected`（定义）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：接受所列限定解释 / 保留原书疑问待定。
- 网站复审结论：复审整体=PASS；`MD.Ch06.definition61`=PASS；`MD.Ch06.parabolicNoiseBracketLevels`=PASS；`MD.Ch06.definition61_corrected`=PASS；`MD.Ch06.definition61Printed`=PASS。原书疑误/范围待导师。反例：未给统一的独立反例判定。
  原始分版说明：A：Definition 6.1的开域、光滑向量场、域内点、包括b0的迭代括号及实线性张成等于ℝm均准确转录，省略号保持同一完整有限生成族。C：definition61与Printed逐项保留开域D、x∈D、所有Fin(S+1)字段在D上C∞以及包括漂移b0的全部迭代Lie括号；D95不是有限深度截断，D96–D97在x处取实span=⊤。全空间总化函数只用于表示局部字段，D开且光滑性只要求ContDiffOn D，因此不要求原书没有的全局光滑延拓。Bracket符号与原文v′u−u′v一致。corrected的第0层只用b1,…,bS，后续允许与任一bᵢ取括号再取并，最后量化所有自然数层并取实span，正确区分用于正时刻密度的抛物型条件。原定义包含漂移作为一个数学定义本身并不矛盾；不能据此对一般SDE断言转移密度，而本条也没有这样的定理结论。四个定义的角色及[EXTRA]一致。

## 30. MD-6.4.4-Lemma61Printed

- source\_id：MD-6.4.4-Lemma61Printed。

### MD-6.4.4-Lemma61Printed

- 印刷页 / PDF页：255 / 276。
- 原文引文（逐字）：

> Lemma 6.1 For all $`t\gt 0`$ and all open $`C\subset D`$, we have that

$$
\Pr(X(t)\in C\mid X(0)=X_0)>0,\quad\forall X_0\in D,
$$


> where $`X(t)=(q(t),p(t))^T`$ is a solution to Langevin dynamics (6.47).

- 问题所在：C=∅是开集，但概率为0。
- 反例或理由：仅针对原书数学错误：取任意允许的正时间、初值及物理参数，令C=∅。∅是开集，任何转移测度都有K t x ∅=0，故原严格不等式变成0<0。此反例不作为Printed忠实性FAIL的理由。
- 原文版 Lean 名称及状态：`MD.Ch06.lemma61Printed`（未证）
- 修正版 Lean 名称、改动内容、证明状态：kind恢复编号lemma；Printed收回原(6.47)正摩擦γ>0及物理噪声σ=√(2γθ)、θ=kBT>0的参数域，保留所有开集（包括空集）的原断言。任意实γ/非零σ的推广只留在非空修正版；漏C.Nonempty是原书疑误，不证明Printed。；`MD.Ch06.lemma61Nonempty`（已证）；`MD.Ch06.lemma61Printed_corrected`（已证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：kind改为lemma。真正的Printed应保留原all open（包括空集）和原物理参数域，并挂[ERRATUM?]；任意实γ、非零σ的推广放到非空修正版中或另行命名。
- 网站复审结论：复审整体=FAIL；`MD.Ch06.lemma61Printed`=修复后未再送网站；`MD.Ch06.lemma61Nonempty`=PASS；`MD.Ch06.lemma61Printed_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：A：Lemma 6.1的标题、所有t>0、所有开集、全部点初值及原式准确；kind应为编号lemma而不是unnumbered\_claim。C：缺少C.Nonempty忠实保留了原文的空集漏洞，这个数学错误应NEEDS\_HUMAN，不能仅因此判Printed签名FAIL。实际端点核的定义、时间正性、全部点初值及周期单位质量相空间均已核对。不过原页把过程指定为(6.47)，其γ为正且噪声为√(2γkBT)；当前Printed却量化任意实γ和任意非零实σ，额外覆盖γ≤0及不满足物理噪声关系的过程。它们可用于有限时刻开放集可达性的正确推广，但该推广没有在本条EXTRA中完整披露，也不是(6.47)的字面参数域。按Printed必须审忠实性的要求，本条因参数域扩张FAIL；原书空集错误仍独立标NEEDS\_HUMAN。此结论不依据sorry。

## 31. MD-6.4.4-Proposition64Printed / MD-6.4.4-ForwardKernelGibbs

- source\_id：MD-6.4.4-Proposition64Printed；MD-6.4.4-ForwardKernelGibbs。

### MD-6.4.4-Proposition64Printed

- 印刷页 / PDF页：257 / 278。
- 原文引文（逐字）：

> Proposition 6.4 Let $`U`$ be $`C^\infty`$ on the position domain $`Q=\mathbb T^{N_c}`$ and suppose $`g\in H^1(\mu)`$ satisfies

$$
\int_D g\,d\mu_\beta=0,
$$


> where $`\mu_\beta`$ is the canonical measure, then the Poisson equation

$$
\mathcal L_{LD}^\dagger\varphi=g
$$


> has a solution $`\varphi\in H^1(\mu)`$ which is unique up to addition of a constant multiple of the Gibbs density.

- 问题所在：flat前向算子的像应满足相对于体积的零质量条件；原却用Gibbs加权零均值，同时把核写成Gibbs密度，混合两种坐标。
- 反例或理由：针对原印刷flat-forward弱域，而非相对Gibbs修正版：取n=1、U=0、β=γ=1，μ为单位环面Haar概率与标准高斯的乘积。令w(q,p)=exp(-p²/2)·∫₀ᵖexp(s²/2)ds。w为非零奇函数，满足∂ₚw+p w=1，故∂ₚ²w+∂ₚ(pw)=0，且与q无关。w及其一阶导数在高斯加权L²中，因而给出所定义的完整加权H¹元素；对每个紧支光滑测试函数均满足flatForwardWeak U 1 1 w 0。w不可能是偶函数Gibbs密度的常数倍。g=0时0与w已经破坏唯一模Gibbs倍数的结论。这是一项解析审校反例，不是经Lean验证的\_counterexample声明；本任务未摘录任何此名声明。
- 原文版 Lean 名称及状态：`MD.Ch06.proposition64Printed`（未证）
- 修正版 Lean 名称、改动内容、证明状态：选择相对Gibbs密度坐标与真实加权伴随算子，核相应为常数；保留完整H¹解存在与唯一性目标。；`MD.Ch06.proposition64Relative`（未证）；`MD.Ch06.proposition64Printed_corrected`（未证）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：原文字面版保留并加[ERRATUM?]坐标/域警示；若使用相对Gibbs密度，采用条目6的闭Hilbert伴随与唯一模常数。若坚持flat密度，则需要另行选择排除非可积恒通量模式的自然域，并核对相应的平直零质量兼容条件。
- 网站复审结论：复审整体=NEEDS\_HUMAN；`MD.Ch06.proposition64Printed`=原文忠实性PASS；原书数学/范围NEEDS\_HUMAN；`MD.Ch06.proposition64Relative`=PASS；`MD.Ch06.proposition64Printed_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：Printed忠实性：PASS。给定光滑周期U、β>0、γ>0，对每个Gibbs加权H¹且μβ零均值的g，确实逐项保留flat-forward弱Poisson方程、完整H¹解存在、以及全部H¹解唯一模Gibbs密度倍数。CanonicalDensity为D52–D59的归一exp(-βH)，与未归一Gibbs密度相差正常数，不改变唯一模其倍数的表述。但这一原文字面版本在所定义弱域上存在明确恒通量反例；不能将平直前向伴随与Gibbs Hilbert伴随混用。因此总判NEEDS\_HUMAN，保留Printed；不是因sorry失败。修正版在条目6的独立声明另审，未用它替换此原文版。


### MD-6.4.4-ForwardKernelGibbs

- 印刷页 / PDF页：257 / 278。
- 原文引文（逐字）：

> If we have two solutions $`\varphi_1,\varphi_2`$ of $`\mathcal L_{LD}^\dagger\varphi=g`$, then their difference $`w`$ must be a solution of $`\mathcal L_{LD}^{\dagger}w=0`$ and the only such solution is a constant multiple of the Gibbs density $`\rho_\beta`$.

- 问题所在：PASS限于EXTRA明确交付的相对Gibbs修正版。它保留所有光滑周期U、β>0、γ>0，对每个完整弱H¹零模w，在真实Langevin后向闭算子的Gibbs Hilbert伴随域内断言value(w)为常数。图成员资格不可省略，且这里没有使用旧flat紧支测试定义。这与r↦ρβr的密度转换一致，核陈述合理。原句的“两解差”可由伴随图线性化为此零模结论，但本条没有另外给出flat坐标的两解差等式；不能将常数直接说成原坐标的Gibbs密度倍数。EXTRA已经声明改动，故不当作静默纠错或签名FAIL；原书域/坐标问题在A阶段维持NEEDS\_HUMAN。本结论尚待证明与签名是否正确是两回事。
- 反例或理由：针对原印刷flat-forward弱域，而非相对Gibbs修正版：取n=1、U=0、β=γ=1，μ为单位环面Haar概率与标准高斯的乘积。令w(q,p)=exp(-p²/2)·∫₀ᵖexp(s²/2)ds。w为非零奇函数，满足∂ₚw+p w=1，故∂ₚ²w+∂ₚ(pw)=0，且与q无关。w及其一阶导数在高斯加权L²中，因而给出所定义的完整加权H¹元素；对每个紧支光滑测试函数均满足flatForwardWeak U 1 1 w 0。w不可能是偶函数Gibbs密度的常数倍。g=0时0与w已经破坏唯一模Gibbs倍数的结论。这是一项解析审校反例，不是经Lean验证的\_counterexample声明；本任务未摘录任何此名声明。
- 原文版 Lean 名称及状态：本条提供限定/修正版子句或资格定义，未另称整条原文字面断言已经形式化；当前声明：`MD.Ch06.forwardKernelGibbs`（未证）
- 修正版 Lean 名称、改动内容、证明状态：保留已明确的限定条件，原书疑误待裁定。；正确限定子句或合格域定义见上列；未提供的完整结论不计为已完成。
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：修复LaTeX拼接，明确把forwardKernelGibbs标为相对密度核的修正版，并在coverage\_gaps登记原flat版本未独立覆盖；不改工程、不补证明。
- 网站复审结论：复审整体=PASS；`MD.Ch06.forwardKernelGibbs`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：PASS限于EXTRA明确交付的相对Gibbs修正版。它保留所有光滑周期U、β>0、γ>0，对每个完整弱H¹零模w，在真实Langevin后向闭算子的Gibbs Hilbert伴随域内断言value(w)为常数。图成员资格不可省略，且这里没有使用旧flat紧支测试定义。这与r↦ρβr的密度转换一致，核陈述合理。原句的“两解差”可由伴随图线性化为此零模结论，但本条没有另外给出flat坐标的两解差等式；不能将常数直接说成原坐标的Gibbs密度倍数。EXTRA已经声明改动，故不当作静默纠错或签名FAIL；原书域/坐标问题在A阶段维持NEEDS\_HUMAN。本结论尚待证明与签名是否正确是两回事。

## 32. MD-6.4.5-SmoothTestL2Printed

- source\_id：MD-6.4.5-SmoothTestL2Printed。

### MD-6.4.5-SmoothTestL2Printed

- 印刷页 / PDF页：258 / 279。
- 原文引文（逐字）：

> Since all the eigenvalues lie to the left of a vertical line in the left half plane, for any $`\varphi`$ in $`C^\infty`$ we have

$$
\int_D\varphi\rho(q,p,t)d\omega=\operatorname{Av}_\beta(\varphi)+\alpha e^{t\lambda_1}\int_D\varphi\rho^{(1)}d\omega.
$$


> The latter integral is bounded since both $`\varphi`$ and $`\rho^{(1)}`$ are in $`L^2`$, and since $`\operatorname{Re}(\lambda_1)\lt 0`$, we see that this converges exponentially to the desired average.

- 问题所在：在正维无界动量空间上，f≡1光滑却不属于flat L²；一般光滑也不保证Gibbs L²。
- 反例或理由：针对Printed数学主张：n=1取f(q,p)=1，周期提升处处C∞，但平直∫T×R|f|²dω=∞，故不在L²。也可取任意非零高次多项式。该反例不反驳corrected的C∞∩L²定义。
- 原文版 Lean 名称及状态：`MD.Ch06.smoothTestL2Printed`（未证）
- 修正版 Lean 名称、改动内容、证明状态：恢复原文完整末句。Printed仅保留光滑蕴含平直L²的原书疑误子主张；_corrected仅是网站已PASS的C∞∩L²合格域定义。限定当前覆盖，不把该定义计作平均公式或积分有界定理。；`MD.Ch06.smoothTestL2Printed_corrected`（定义）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：原文恢复完整末句并加[ERRATUM?]；保留Printed及正确的限定域定义。另列两种平均相等及ρ1、测试函数满足L²时的积分界，或如实登记当前缺口；不得把def合格域算成完整平均定理。
- 网站复审结论：复审整体=FAIL；`MD.Ch06.smoothTestL2Printed`=原文子主张忠实性PASS；原书数学NEEDS\_HUMAN；`MD.Ch06.smoothTestL2Printed_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：分版审校：smoothTestL2Printed忠实地保留原页隐含的“每个光滑测试函数均在平直L²”子主张；该子主张的原书数学疑误判NEEDS\_HUMAN，而不因它为假就判Printed不忠实。smoothTestL2Printed\_corrected是正确的限定域定义C∞∩L²，修正合理，局部签名PASS；但它是def，不是有界积分定理。本条scope仍称覆盖所引原句及展示公式，coverage\_gaps却为null。实际两个声明都没有ρt、ρeq、ρ1、λ1、α、传播关系、平均恒等式或积分界，因此总audit为FAIL，理由是独立的完整结论覆盖缺口，而不是原书数学疑误或sorry。原文错误另在json\_review中保留NEEDS\_HUMAN。

## 33. MD-6.4.5-ComplexInitialDensity（解释记录）

- source\_id：MD-6.4.5-ComplexInitialDensity。

### MD-6.4.5-ComplexInitialDensity

- 印刷页 / PDF页：258 / 279。
- 原文引文（逐字）：

> For example, if we assume that $`\lambda_1,\rho^{(1)}`$ is some eigenvalue, eigenfunction pair with $`\operatorname{Re}(\lambda_1)\lt 0`$ and take the initial distribution to be

$$
\rho_0=\rho_{eq}+\alpha\rho^{(1)},
$$


> for $`\alpha\in\mathbb R`$, then we have

- 问题所在：complexInitialDensity：作为EXTRA明确声明的概率资格辅助定义，PASS；complexInitialDensity\_corrected：同样PASS，且二者实为同体，不是一个已证另一个待证。它们要求ρeq及给定组合ρeq+αρ1各自AE实且非负，实部可积且积分1；这些是复L²候选代表概率密度所需的正确条件。不要求ρ1本身非负，亦不要求α≠0，均正确；α=0时没有从单位质量倒推ρ1零积分。定义里没有λ或A，也没有声称所有α合格、ρeq确为Gibbs或ρ1确为本征函数；这些必须由使用处如条目14另列。因此这是合理的显式限定，不是对原页任意α的无条件实现；A阶段仍须人工核定原文中“initial distribution”的隐含范围。
- 反例或理由：取n=1、U=0、β=γ=1，ρeq=(2π)^(-1/2)e^(-p²/2)，ρ1=pρeq（q无关），这是平直前向OU生成元的非零特征函数，特征值-1。两者均在平直L²，且∫ρ1=0；但α=1时ρ0=(1+p)ρeq在p<-1为负，故不是概率密度。即使实本征模式和负实特征值也不能免去非负检查。
- 原文版 Lean 名称及状态：本条提供限定/修正版子句或资格定义，未另称整条原文字面断言已经形式化；当前声明：`MD.Ch06.complexInitialDensity`（定义）；`MD.Ch06.complexInitialDensity_corrected`（定义）
- 修正版 Lean 名称、改动内容、证明状态：保留已明确的限定条件，原书疑误待裁定。；`MD.Ch06.complexInitialDensity_corrected`（定义）
- 待人工核查点：核对原句上下文、有效域、端点及反例；确认修正或限定是否符合作者意图。
- 导师选项：保留原句；补[ERRATUM?]α及模式的概率资格问题，同步scope和coverage\_gaps。若讨论非实本征模式的非平凡概率扰动，应使用共轭配对并再次检查非负性。
- 网站复审结论：复审整体=PASS；`MD.Ch06.complexInitialDensity`=PASS；`MD.Ch06.complexInitialDensity_corrected`=PASS。原书疑误/范围待导师。反例：网站给出理由或反例，独立具名声明的结论以上列为准。
  原始分版说明：complexInitialDensity：作为EXTRA明确声明的概率资格辅助定义，PASS；complexInitialDensity\_corrected：同样PASS，且二者实为同体，不是一个已证另一个待证。它们要求ρeq及给定组合ρeq+αρ1各自AE实且非负，实部可积且积分1；这些是复L²候选代表概率密度所需的正确条件。不要求ρ1本身非负，亦不要求α≠0，均正确；α=0时没有从单位质量倒推ρ1零积分。定义里没有λ或A，也没有声称所有α合格、ρeq确为Gibbs或ρ1确为本征函数；这些必须由使用处如条目14另列。因此这是合理的显式限定，不是对原页任意α的无条件实现；A阶段仍须人工核定原文中“initial distribution”的隐含范围。

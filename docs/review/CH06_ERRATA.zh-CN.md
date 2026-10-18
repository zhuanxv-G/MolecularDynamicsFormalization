# 第6章原书疑误与双版本审阅单

教材：Leimkuhler–Matthews，Molecular Dynamics，Springer 2015，第6章正文。页码采用PDF物理页。工作勘误和范围解释尚待导师裁定。
网站首轮对忠实原文、限定/修正版及原书数学问题的评价分别保留。网站PASS是所交签名的语义判断，不表示未证声明已有证明；本轮修改版本待复审。
OU根号范围（PDF256）和两次分部积分正号（PDF263）已目视核对为转录错误，已撤销原书疑误归因；WeakItoAlias的非可积默认零是项目辅助定义问题，也不计原书勘误。
共34项合并问题。

## 1. MD-6.1.2-BathTaylor

- source_id：MD-6.1.2-BathTaylor。

### MD-6.1.2-BathTaylor

- 印刷页 / PDF页：216 / 237。
- 原文引文（逐字）：

> Since $Z_B(E-s)=\exp(S_B(E-s)/k_B)$, and $s\ll E$, we (naively) apply the mean value theorem to $S_B$ to obtain
> \[S_B(E-s)=S_B(E)-S'_B(\xi)s,\]
> and from $S'_B(\xi)=1/T$, we obtain
> \[Z_B(E-s)\propto\exp(-\beta s).\]

- 问题所在：取S(E)=E²、E=kB=1、β=2、s=1，原两端分别为e⁻¹和e⁻²。
- 反例或理由：令S(x)=x²，energy=kB=1，β=2。全部显式前提成立，且均值定理分量成立；取s=1/2，左边指数比为exp(−3/4)，右边为exp(−1)，不相等。一般0<s≤1时两边相差exp(s²)，故任意小正s也不能使精确式成立。
- 原文版 Lean 名称及状态：`MD.Ch06.bathBoltzmannPrinted`（未证）；`MD.Ch06.bathBoltzmannPrinted_counterexample`（已证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：精确Boltzmann因子增加整个能量区间的恒定熵斜率；一般热浴只保留带余项近似。 ；`MD.Ch06.bathBoltzmannPrinted_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留Printed原文与ERRATUM?；另提供独立修正版的完整签名：可要求相关区间上S′≡kBβ，或将指数中的误差以C·s²控制。第11、12条分别是合法的近似及恒斜率处理，不能据此声称本Printed命题成立。
- 网站审校结论：所交声明 `MD.Ch06.bathBoltzmannPrinted` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。Printed声明量化任意C²实熵S及正energy,kB，只在energy处假设S′=kBβ。第一合取分量对任意s>0给闭区间中值点，数学上成立；第二分量却对所有0≤s≤energy断言精确指数比，单点斜率不足以推出。它忠实暴露原文从ξ到固定温度的缺口，按任务要求保留字面版并判NEEDS_HUMAN，不因命题一般为假而将忠实Printed版判签名FAIL。repair_log仅提到_corrected声明名称，没有提供其签名，本条未审定该修正版。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 2. MD-6.1.2-CanonicalCDFPrinted

- source_id：MD-6.1.2-CanonicalCDFPrinted。

### MD-6.1.2-CanonicalCDFPrinted

- 印刷页 / PDF页：216 / 237。
- 原文引文（逐字）：

> On the other hand the probability for the active system to have energy $\leq\alpha$ is the same as the probability of the bath having energy $\geq E-\alpha$, this must be
> \[P(\alpha)=\Pr\{E_B\geq E-\alpha\}\propto\int_0^\alpha Z_B(E-s)ds.\]
> Thus we have $P(\alpha)\propto\int_0^\alpha\exp(-\beta s)ds$.

- 问题所在：取ZA(s)=1+s、ZB(s)=1、E=1、α=1/2，两边分别为5/12和1/2。
- 反例或理由：取ZA(s)=1+s²、ZB(s)=1，energy=1，α=1/2；两函数全实轴连续且严格正。以s+s³/3为原函数，带ZA的分子=13/24、分母=4/3，故CDF=13/32；不带ZA的CDF=(1/2)/1=1/2，两者不同。
- 原文版 Lean 名称及状态：`MD.Ch06.canonicalCDFPrinted`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：能量累计概率的分子分母均保留ZA(s)权重；改为正确累计概率的定义。 ；`MD.Ch06.canonicalCDFPrinted_corrected`（定义）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留Printed与ERRATUM?；修正版应将正确CDF定义为∫₀^α ZA(s)ZB(E−s)ds / ∫₀^E ZA(s)ZB(E−s)ds。若要与无ZA权重的CDF相等，需另加ZA在相关区间为正的常数等充分条件。
- 网站审校结论：所交声明 `MD.Ch06.canonicalCDFPrinted` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。Printed签名对两个全实轴连续、处处正的函数ZA,ZB及0<α<energy，断言有ZA权重与无ZA权重的两个归一化CDF相等。分子、分母和能量约束都与字面省略ZA的主张相对应，但任意ZA不可能消去。按原文版审忠实性的要求判NEEDS_HUMAN；不能将其作为正确一般定理，也不能把repair_log中未附签名的_corrected定义视为已审通过。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 3. MD-6.1.3-FiniteDomainPrinted

- source_id：MD-6.1.3-FiniteDomainPrinted。

### MD-6.1.3-FiniteDomainPrinted

- 印刷页 / PDF页：218 / 239。
- 原文引文（逐字）：

> If $U$ is smooth and the domain $Q$ is finite, then clearly both integrals are well defined, so the normalization is sensible.

- 问题所在：Q=(0,1)、U(q)=log q、β=1，权重1/q不可积；U在Q内光滑且Q体积有限。
- 反例或理由：取n=1，Q={q | 0<q(0)<1}，U(q)=−(q(0))⁻¹（使用Lean实逆元在0处总定义），β=1。Q可测且体积为1，U在Q上C∞。权重为exp(1/q(0))，对0<q(0)<1有exp(1/q(0))≥1/(2q(0)²)，故其在Q的积分发散，结论不成立。
- 原文版 Lean 名称及状态：`MD.Ch06.finiteDomainPrinted`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：将有限体积域内光滑改为紧域上连续，使用紧性保证权重可积。 ；`MD.Ch06.finiteDomainPrinted_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：Printed原文保持不变；独立修正版可改为Q紧且ContinuousOn U Q，或保留有限体积并加U在Q有统一下界。若要断言概率归一化，还须Q具有正体积及相应正质量、正β条件。
- 网站审校结论：所交声明 `MD.Ch06.finiteDomainPrinted` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。Printed签名将finite解释为可测有限体积Q，将smooth解释为ContDiffOn U Q，且β>0，结论为exp(−βU)在Q可积。这种字面读法不足以控制U趋边界为−∞，即使Q有界也有反例。原文若意指紧配置空间且U在其上连续，则可成立，但不能由当前Printed前提直接获得。按任务要求对原文歧义/疑误判NEEDS_HUMAN，保留忠实版，不把它判为一般正确定理。repair_log所列_corrected签名未提供，本条不推断其内容。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 4. MD-6.1.4-CanonicalAveragePrinted

- source_id：MD-6.1.4-CanonicalAveragePrinted。

### MD-6.1.4-CanonicalAveragePrinted

- 印刷页 / PDF页：220 / 241。
- 原文引文（逐字）：

> Under assumptions on the potential energy as discussed above, and with $\phi$ continuous and allowed to grow at most polynomially fast at infinity, we may proceed to define averages with respect to the canonical density $\rho_\beta$, namely
> \[\operatorname{Av}_\beta(\phi)=Z_{\rm can}^{-1}\int_D\phi(q,p)\rho_\beta(q,p)d\omega.\tag{6.4}\]

- 问题所在：若Zcan=2，则原Avβ(1)=1/2；概率平均必须为1。
- 反例或理由：若Z>0且权重可积，Printed平均(1)=1/Z，只有Z=1时为1。例如一自由度H=(q²+p²)/2、β=1有Z=2π，Printed平均(1)=1/(2π)。
- 原文版 Lean 名称及状态：`MD.Ch06.canonicalAveragePrinted`（定义）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：去掉对已经归一化ρβ的第二次Zcan⁻¹；沿用未归一权重乘一次Zcan⁻¹的定义。 ；`MD.Ch06.canonicalAveragePrinted_corrected`（定义）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留Printed字面式；采用条目5中单次归一化修正版作标准平均，原书勘误由人工确认。
- 网站审校结论：所交声明 `MD.Ch06.canonicalAveragePrinted` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。Printed定义确实在D1已归一密度之外又乘D2的Z倒数；全实相空间、H、β、f的类型一致。作为原书字面定义忠实，不能因其非标准平均而判签名FAIL；原书与(6.3)及p.221用法冲突，须人工处理。修正版已在条目5给出，需分别看待。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 5. MD-6.1.5-Proposition61

- source_id：MD-6.1.5-Proposition61。

### MD-6.1.5-Proposition61

- 印刷页 / PDF页：222 / 243。
- 原文引文（逐字）：

> Proposition 6.1 Let $H$ be a Hamiltonian defined on the phase space $\mathbb R^{2N_c}$ and suppose $G:\mathbb R^{2N_c}\to\mathbb R^{2N_c}$ is a smooth ($C^1$) vector field with the following properties:
> \[0<|\operatorname{Av}_\beta(G\cdot\nabla H)|<\infty,\quad
> 0<\operatorname{Av}_\beta(\nabla\cdot G)<\infty,\quad |Ge^{-\beta H}|<\infty.\]
> Then
> \[k_BT=\frac{\operatorname{Av}_\beta(G\cdot\nabla H)}{\operatorname{Av}_\beta(\nabla\cdot G)}.\]

- 问题所在：所交为显式加强条件的温度恒等式；原证明除以球体积后取极限只给0=0，保留原证明并登记缺口；原下标和体积元依网站原页修订，未认证原论证。
- 反例或理由：这里指出原证明的逻辑缺口，不提供加强版签名的反例；除以v_R使有限的非零积分也趋0，所以缩放后的相等极限不足以判定未缩放积分相等。
- 原文版 Lean 名称及状态：`MD.Ch06.proposition61`（已证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：所交为显式加强条件的温度恒等式；原证明除以球体积后取极限只给0=0，保留原证明并登记缺口；原下标和体积元依网站原页修订，未认证原论证。；`MD.Ch06.proposition61_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：恢复原页下标、体积元与措辞；保留原证明并标明极限步骤缺口。加强版须另给权重层集截断等有效论证，不把除体积论证当证明。
- 网站审校结论：所交声明 `MD.Ch06.proposition61` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。相空间为(Fin Nc⊕Fin Nc)→ℝ，维数2Nc；kB,T正，H,G为C¹，真实权重及两个加权观测量可积，加权向量场有统一界，平均散度严格正。D8为导数迹、D9为dH(G)，比值方向正确。原文的逐点有限条件被明确加强为统一有界；原证明以球体积除两边后取极限只能得到0=0，不能据此恢复未缩放积分恒等式，不能按原证明认证。加强前提下的恒等式可另用权重层集截断证明，非此处已提供证明。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 6. MD-6.1.5-PartitionInversePrinted

- source_id：MD-6.1.5-PartitionInversePrinted。

### MD-6.1.5-PartitionInversePrinted

- 印刷页 / PDF页：220 / 241。
- 原文引文（逐字）：

> The associated canonical density is
> \[\rho_\beta=Z_{\rm can}^{-1}\exp\left(-\beta\left[\frac{p^2}{2m}+U(q)\right]\right),\]
> where
> \[Z_{\rm can}^{-1}=\int_{-\infty}^{\infty}\int_{-\infty}^{\infty}\exp\left(-\beta\left[\frac{p^2}{2m}+U(q)\right]\right)dpdq.\]

- 问题所在：积分为2时，原式断言1/2=2。
- 反例或理由：n=1，m=1，β=1，U(q)=q²/2，权重exp(-(q²+p²)/2)可积，Z=2π，故Z⁻¹≠Z。符合所有给定前提，错误来自忠实保留的原书印刷式。
- 原文版 Lean 名称及状态：`MD.Ch06.partitionInversePrinted`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：Zcan定义为积分本身；归一密度的结论另见DensityNormalization，避免把定义重述作新定理。 ；`MD.Ch06.partitionInversePrinted_corrected`（定义）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：原文保持Z⁻¹=积分并标勘误；标准版用Z=积分。提供partitionInversePrinted_corrected实际定义后再审；补列实际额外条件。
- 网站审校结论：所交声明 `MD.Ch06.partitionInversePrinted` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。字面原页确印Zcan⁻¹=积分，签名把既定Z=积分代入后断言Z⁻¹=Z，忠实保存这一原书矛盾，故按任务规则NEEDS_HUMAN而非因数学错误直接FAIL。n维、正质量、正β及全权重可积是额外限制，未在extra_assumptions中列出；并未消除错误。repair_log提及的partitionInversePrinted_corrected没有在本任务给出实际声明或定义，不能认证该修正版，仅其改动方向合理。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 7. MD-6.2.1-CoarseMarkovPrinted

- source_id：MD-6.2.1-CoarseMarkovPrinted。

### MD-6.2.1-CoarseMarkovPrinted

- 印刷页 / PDF页：227 / 248。
- 原文引文（逐字）：

> Let $A(x)$, $B(x)$ and $C(x)$ be three events dependent on state variable $x$, and let $t_+>t_0>t_-$ be three times, then, for a Markov process $X(t)$ we have (using the notation for conditional probability):
> \[\Pr[A(X(t_+))\mid B(X(t_0)),C(X(t_-))]=\Pr[A(X(t_+))\mid B(X(t_0))].\]

- 问题所在：令当前粗事件为全集，Brownian过去值与未来值仍相关；粗事件未保留完整当前状态。
- 反例或理由：标准Brownian，past=1,present=2,future=3，b=ℝ，a=c=(0,∞)。P(W3>0|W1>0)=1/2+arcsin(1/√3)/π>1/2=P(W3>0)，正条件概率成立。
- 原文版 Lean 名称及状态：`MD.Ch06.coarseMarkovPrinted`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：以完整当前状态生成的σ代数写条件期望Markov性质。 ；`MD.Ch06.coarseMarkovPrinted_corrected`（定义）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留Printed版及ERRATUM?；正确性质应在完整σ(Wpresent)及真实过去过滤下比较条件期望，不能把未约束history的定义当作已证明定理。
- 网站审校结论：所交声明 `MD.Ch06.coarseMarkovPrinted` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。字面版在真实PreBrownian下量化任意可测事件a,b,c、past<present<future及正条件事件概率，ENNReal比值忠实表达印刷条件概率式。但原书把完整当前状态换成任意粗事件，一般错误，须保留疑误而不因字面忠实判数学正确。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 8. MD-6.2.2-RiemannTags

- source_id：MD-6.2.2-RiemannTags。

### MD-6.2.2-RiemannTags

- 印刷页 / PDF页：228 / 249。
- 原文引文（逐字）：

> Recall that the Riemann integral of a continuous function $g$ on $[0,\tau]$ is the limit of Riemann sums constructed as follows: partition the interval $[0,\tau]$ into $K$ subintervals each of width $\delta t=\tau/\nu$, choose an arbitrary $t_k$ from the $k$th subinterval, $1\leq k\leq \nu$, and evaluate the integral as a limit of the sum of products:
> \[\int_0^\tau g(t)dt=\lim_{\nu\to\infty}\sum_{k=0}^{\nu-1}g(t_k)\delta t.\]
> We know that this limit does not depend on where the $t_k$ are chosen within the subintervals. For example we can take the left or right endpoint of each subinterval or the midpoint.

- 问题所在：原书文字1≤k≤ν与求和0≤k<ν冲突；本条数学修正版统一0≤k<ν，原句保留。
- 反例或理由：任意T≥0、[0,T]上连续g、每个K>0的所有k<K标签位于第k个闭子区间，结论为整族带标签和趋于区间积分。K=0不影响atTop；形式化正确地采用0起始索引。原书文字1≤k≤ν而公式0≤k<ν有索引冲突，需保留原貌并标疑误。
- 原文版 Lean 名称及状态：`MD.Ch06.riemannTags`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：原书文字1≤k≤ν与求和0≤k<ν冲突；本条数学修正版统一0≤k<ν，原句保留。；`MD.Ch06.riemannTags_corrected`（未证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留原文1≤k≤ν并标记；数学修正版统一为0≤k<ν。
- 网站审校结论：所交声明 `MD.Ch06.riemannTags` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。任意T≥0、[0,T]上连续g、每个K>0的所有k<K标签位于第k个闭子区间，结论为整族带标签和趋于区间积分。K=0不影响atTop；形式化正确地采用0起始索引。原书文字1≤k≤ν而公式0≤k<ν有索引冲突，需保留原貌并标疑误。 本轮修改版：待复审；反例：无单列网站verdict。

## 9. MD-6.2.2-Proposition62

- source_id：MD-6.2.2-Proposition62。

### MD-6.2.2-Proposition62

- 印刷页 / PDF页：229–230 / 250–251。
- 原文引文（逐字）：

> Proposition 6.2 Let $\nu\delta t=\tau$ then
> \[\operatorname{l.i.m.}_{\nu\to\infty}\sum_{k=0}^{\nu-1}[(W((k+1)\delta t)-W(k\delta t))^2]=\tau,\]
> where, for a sequence of random variables, $A_\nu$ and a random variable $B$, we have
> \[\operatorname{l.i.m.}_{\nu\to\infty}A_\nu=B\iff\lim_{\nu\to\infty}\mathbb E(A_\nu-B)^2=0.\]
> (This is referred to as convergence in the mean square sense.)

- 问题所在：有序交叉和应系数+1；若仅遍历k<l，则为+2。原写−2且遍历k≠l。独立中心变量的交叉期望恰好为0，故最终结论不受影响。另p.230末句ν→0应为ν→∞。
- 反例或理由：任意T≥0和PreBrownian，结论为实际平方增量和减T的平方误差期望随K→∞趋0，吻合命题结论。原证明负交叉项和ν→0两处印刷疑误必须保留。repair_log列出的proposition62_corrected没有在本条给出签名，不能仅凭名称确认其完整内容。
- 原文版 Lean 名称及状态：`MD.Ch06.proposition62`（已证）；`MD.Ch06.proposition62Printed`（定义）；`MD.Ch06.proposition62Printed_counterexample`（已证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：保持已证二次变差结论；独立记录印刷平方展开与其正确代数式，并注明极限方向。 ；`MD.Ch06.proposition62_corrected`（已证）；`MD.Ch06.proposition62Expansion_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：原文保留疑误；正确恒等式用2∑_{k<l}ZkZl或∑_{k≠l}ZkZl，极限为ν→∞。当前proposition62结论PASS；未提供的_corrected签名需单独核对。
- 网站审校结论：所交声明 `MD.Ch06.proposition62` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。任意T≥0和PreBrownian，结论为实际平方增量和减T的平方误差期望随K→∞趋0，吻合命题结论。原证明负交叉项和ν→0两处印刷疑误必须保留。repair_log列出的proposition62_corrected没有在本条给出签名，不能仅凭名称确认其完整内容。 本轮修改版：待复审；反例：无单列网站verdict。

## 10. MD-6.2.2-SelfStratonovichIntegral

- source_id：MD-6.2.2-SelfStratonovichIntegral。

### MD-6.2.2-SelfStratonovichIntegral

- 印刷页 / PDF页：230 / 251。
- 原文引文（逐字）：

> In contrast, the Stratonovich (midpoint) integral can be calculated as
> \[\int_0^\tau W(t)\circ dW(t)=\operatorname{l.i.m.}_{\nu\to\infty}\sum_{k=0}^{\nu-1}W(k\delta t+\delta t/2)[W((k+1)\delta t)-W(k\delta t)].\]
> Writing
> \[W(k\delta t+\delta t/2)=W(\frac{(k+1)\delta t+k\delta t}{2})=\frac12(W((k+1)\delta t)+W(k\delta t))+O(\sqrt{\delta t}),\]
> allows us to evaluate the integral as
> \[\int_0^\tau W(t)\circ dW(t)=\frac12\operatorname{l.i.m.}_{\nu\to\infty}\sum_{k=0}^{\nu-1}[W((k+1)\delta t)^2-W(k\delta t)^2]=\frac12W(\tau)^2.\]

- 问题所在：仅覆盖真实时间中点和的均方结论；原单步O(√dt)推理未控制总误差，不能当成完整证明；所需Brownian桥残差估计未补建。
- 反例或理由：真实时间中点和存在L²极限Y且AE为W(T)²/2，结论数学正确。原文单步O(√δt)没有指定随机意义或控制累积误差，不能直接据此丢弃K项残差；需保留此原文论证疑点，正式签名本身并未依赖该大O假设。
- 原文版 Lean 名称及状态：`MD.Ch06.selfStratonovichIntegral`（已证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：仅覆盖真实时间中点和的均方结论；原单步O(√dt)推理未控制总误差，不能当成完整证明；所需Brownian桥残差估计未补建。；`MD.Ch06.selfStratonovichIntegral_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留原启发式并注明非完整证明；用Brownian桥残差与整步增量独立，证明残差和L²误差趋0（方差T²/(4K)），即可支持所列正确签名。
- 网站审校结论：所交声明 `MD.Ch06.selfStratonovichIntegral` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。真实时间中点和存在L²极限Y且AE为W(T)²/2，结论数学正确。原文单步O(√δt)没有指定随机意义或控制累积误差，不能直接据此丢弃K项残差；需保留此原文论证疑点，正式签名本身并未依赖该大O假设。 本轮修改版：待复审；反例：无单列网站verdict。

## 11. MD-6.2.2-DeterministicStrobePrinted

- source_id：MD-6.2.2-DeterministicStrobePrinted。

### MD-6.2.2-DeterministicStrobePrinted

- 印刷页 / PDF页：231 / 252。
- 原文引文（逐字）：

> Finally, we observe that by calculating $\sigma^2(t_n)$ and generating random increments $R_n\sim N(0,\sigma(t_n))$ we have a discrete representation of the continuous time stochastic process $Y(t)$, effectively an exact stroboscopic representation.

- 问题所在：若g≡1，区间[tₙ,tₙ₊₁]增量方差应为tₙ₊₁−tₙ，不能使用累计到tₙ₊₁的方差或把标准差当方差参数。
- 反例或理由：取g≡1，times≡1，Y=W：所有真实增量为0，签名却要求非退化N(0,1)；另外times 0=0,times 1=4时，签名variance=2而实际4，显示标准差未平方的独立问题。
- 原文版 Lean 名称及状态：`MD.Ch06.deterministicStrobePrinted`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：采用区间积分∫[tₙ,tₙ₊₁]g²及同一过程的独立增量资格。 Printed忠实保留原书N(0,σ(t_n))累计尺度，将标准差平方后传给gaussianReal方差参数；该印刷增量说法有疑。独立修正版保留相邻区间∫g²及整族独立性，以Y(times 0)为初始观测，不假设times 0=0。；`MD.Ch06.deterministicStrobeCorrected`（未证）；`MD.Ch06.deterministicStrobePrinted_corrected`（未证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：原文保留Y(t)和印刷N(0,σ(t_n))；若按标准差读印刷量，转换到gaussianReal须平方。真实过程表示另用第5条相邻区间方差和独立族，初始化须从Y(times 0)或令times 0=0。
- 网站审校结论：所交声明 `MD.Ch06.deterministicStrobePrinted` 的整体 verdict=FAIL；原文栏=NEEDS_HUMAN。原书N的第二参数按标准差读时，Lean gaussianReal第二参数是方差，不能直接放sqrt(∫g²)。此外t_n至t_(n+1)的增量应取区间积分，且签名没有整个增量族独立性。即使保留原文错误，当前参数转换也不忠实。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 12. MD-6.3.1-DiffusiveTaylorPrinted

- source_id：MD-6.3.1-DiffusiveTaylorPrinted。

### MD-6.3.1-DiffusiveTaylorPrinted

- 印刷页 / PDF页：233 / 254。
- 原文引文（逐字）：

> Now we expand the 2nd order term and, working in the diffusion limit, recognize that $\delta x^2\sim\delta t$, thus we have
> \[\delta\phi=\phi'(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)+\tfrac12\phi''(X_n)b(X_n,n\delta t)^2\delta t+O(\delta t^{3/2}).\]

- 问题所在：φ(x)=|x|^(5/2)在0为C²；a=0,b=1时余项为dt^(5/4)，不是O(dt^(3/2))。
- 反例或理由：φ(x)=|x|^(5/2)属于C²，x=a=0,b=1时φ′(0)=φ″(0)=0，余项=dt^(5/4)，除dt^(3/2)为dt^(−1/4)，无界。
- 原文版 Lean 名称及状态：`MD.Ch06.diffusiveTaylorPrinted`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：C²加强为C³，使三阶Taylor余项与扩散缩放匹配。 ；`MD.Ch06.diffusiveTaylorPrinted_corrected`（未证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留原文并标勘误疑问；C²下改余项为o(dt)，或增加C³/局部Lipschitz二阶导数再断言O(dt^(3/2))。
- 网站审校结论：所交声明 `MD.Ch06.diffusiveTaylorPrinted` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。签名取J=+1及δx=√dt的字面特例，a,b可任意实数，故−1符号可吸收到b。右侧滤子dt→0+、二阶项及3/2指数对应。但C²只给o(dt)，不能保证O(dt^(3/2))。按原文疑误保留并NEEDS_HUMAN，不因sorry失败；C³修正合理但该修正声明不在本条展示范围内。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 13. MD-6.3.1-TimeItoFormula

- source_id：MD-6.3.1-TimeItoFormula。

### MD-6.3.1-TimeItoFormula

- 印刷页 / PDF页：234 / 255。
- 原文引文（逐字）：

> We also mention that the Itô-Doeblin formula can be easily generalized to functions of the form $\phi(x,t)$:
> \[d\phi(X,t)=\phi_t(X,t)+\phi_x(X,t)(a(X,t)dt+b(X,t)dW)+\tfrac12\phi_{xx}(X,t)b(X,t)^2dt.\tag{6.18}\]

- 问题所在：取φ(x,t)=t，原右端留下常数1而非微分dt；修正公式应为dφ=dt。
- 反例或理由：取标准Brownian W，X_t=exp(−t/2)W_t，a(x,t)=−x/2，b(x,t)=exp(−t/2)，x0=0。令Φ(x)=∫₀ˣ exp(e*u²/4)/(1+u²)^(1/8) du；Φ光滑。Var(X_t)=v(t)=t exp(−t)，唯一最大V=1/e在t=1。g_t=Φ′(X_t)b(t)适应；在t=1，E[g_t²]=∞，因为Gaussian指数恰抵消，尾积分为∫u^(−1/2)du；附近E[g_t²]量级|t−1|^(−1/2)，故任意有限时间∫E[g_t²]dt有限，满足D20。T=2,K=2左和含g_1(W_2−W_1)，未来增量独立且方差1，所以该项二阶矩无限，另一项为常数倍W_1，不能抵消；D5要求MemLp的结论失败。第14条取φ(x,t)=Φ(x)。
- 原文版 Lean 名称及状态：`MD.Ch06.timeItoFormula`（未证）；`MD.Ch06.timeItoFormulaPrinted`（定义）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：原文右端以形式微分占位量记录，时间偏导补dt；完整修正积分公式独立命名。 补X联合可测及自然过滤适应、被积过程全部网格和L²与局部均方时间Hölder资格。仅时间积分平方可积的旧签名前提不足且有网站反例；新签名不假设所求积分公式/极限，仍缺一般Itô理论，不证明。Time版与_corrected同步，漏dt原文形式单列保留。；`MD.Ch06.timeItoFormula_corrected`（未证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：原文漏dt保留并标注，修正公式独立命名；同时修复第12条所述严格左和L²缺口。
- 网站审校结论：所交声明 `MD.Ch06.timeItoFormula` 的整体 verdict=FAIL；原文栏=NEEDS_HUMAN。签名是补上φ_t dt后的完整积分修正版，(1,0)/(0,1)方向及二阶x导数正确，[EXTRA]已坦白修正。但仍有与第12条相同的全部有限和L²缺口；取下述φ(x,t)=Φ(x)即可，故当前积分版本在所列前提下也不成立。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 14. MD-6.3.3-BathForcePrinted / MD-6.3.3-BathReductionPrinted

- source_id：MD-6.3.3-BathForcePrinted；MD-6.3.3-BathReductionPrinted。

### MD-6.3.3-BathForcePrinted

- 印刷页 / PDF页：237 / 258。
- 原文引文（逐字）：

> where we define
> \[f(t)=-k^{-1}\sum_{i=1}^k[\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i-\cos(\Omega_i t)Q(0)].\]

- 问题所在：将(6.26)代回(6.23)，初值项为+k⁻¹Σ[(qᵢ(0)−Q(0))cos+…]；原f定义却有负号。
- 反例或理由：同第28条：单振子初始位移1给实际初始合力+1，印刷f为−1；Printed定义本身忠实，冲突在其代入(6.29)。
- 原文版 Lean 名称及状态：`MD.Ch06.bathForcePrinted`（定义）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：选择正的初值合力f，使(6.29)保留+f；等价选项是保留原f并将(6.29)改为−f。 ；`MD.Ch06.bathForce`（定义）；`MD.Ch06.bathForcePrinted_corrected`（定义）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留Printed负号和ERRATUM?；修正版按第28条处理。
- 网站审校结论：所交声明 `MD.Ch06.bathForcePrinted` 的整体 verdict=PASS；原文栏=NEEDS_HUMAN。实际Chapter06Review.bathForce为正k⁻¹和，外取负号得到原页字面f，括号内cos*(q0−Q0)及sin*p0/μ完全对应。k>0及μ>0齐全。作为Printed定义PASS，不能把它与保留+f的修正动力式同时当正确推导。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。


### MD-6.3.3-BathReductionPrinted

- 印刷页 / PDF页：237 / 258。
- 原文引文（逐字）：

> \[\dot P=-U'(Q)+f(t)-\int_0^t\psi(t-s)P(s)ds.\tag{6.29}\]
> \[f(t)=-k^{-1}\sum_{i=1}^k[\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i-\cos(\Omega_i t)Q(0)].\]

- 问题所在：同上一项：原定义f为负合力，却在约化方程中加f。
- 反例或理由：k=1、μ=1、U=0；Q(t)=(1−cos(√2t))/2，q(t)=(1+cos(√2t))/2，P(t)=sin(√2t)/√2，p(t)=−sin(√2t)/√2。所有ODE前提成立；t=0时deriv P=1，Printed右端=−1。
- 原文版 Lean 名称及状态：`MD.Ch06.bathReductionPrinted`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：使用从原Hamilton方程实际代入所得的正合力卷积方程。 ；`MD.Ch06.bathReductionPrinted_corrected`（未证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留原文及ERRATUM?；补记技术前提。另提供实际_corrected签名，正合力版本应使用D1而非D7；勿仅凭repair_log算已审。
- 网站审校结论：所交声明 `MD.Ch06.bathReductionPrinted` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。C：原声明与条目1相同的全部对象、正质量、非负时刻、C²和四组ODE前提俱在；D7=-D1，完整卷积未丢失。按Printed只审忠实性，本签名忠实性PASS；其数学结论与原书一样有符号矛盾，按任务要求总判NEEDS_HUMAN。extra_assumptions=[]未记录新增C²及全实轴ODE范围。repair_log仅给出bathReductionPrinted_corrected名称，任务未提供其实际签名，无法独立审校该修正版。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 15. MD-6.3.3-MemoryKernelDeltaMeaning

- source_id：MD-6.3.3-MemoryKernelDeltaMeaning。

### MD-6.3.3-MemoryKernelDeltaMeaning

- 印刷页 / PDF页：238 / 259。
- 原文引文（逐字）：

> If sufficient high frequency components are present, then the mass of the memory kernel is typically found to be localized around 0; in such a situation of rapid decay it is found that one may replace the function $\psi$ by a Dirac delta function scaled by a positive coefficient $\gamma$; we say that the system is Markovian or memory-less in this situation and we replace the delay-differential equation (6.29) by the SDEs
> \[dQ=Pdt;\tag{6.30}\quad dP=-U'(Q)dt+\sigma dW-\gamma Pdt.\tag{6.31}\]

- 问题所在：不限制频率与权重时，可选全部频率固定，余弦记忆核不会自动成为Dirac分布。
- 反例或理由：若γ>0，取f≥0、f(0)=1、紧支且∫f<γ，则每个k均有|∫ψk f|≤∫f<γ，不可能趋于γ。该论证与频率及质量选择无关。
- 原文版 Lean 名称及状态：`MD.Ch06.memoryKernelDeltaMeaning`（定义）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：仅给分布收敛的精确定义，并明确正质量资格；不声称任意热浴满足该极限。 ；`MD.Ch06.memoryKernelDeltaMeaning_corrected`（定义）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：由人工确认时间/振幅重标度及单边δ约定；保留原启发式。将修正版注明为当前归一化下不可实现的资格，或先改物理标度后重新定义，不能把加入正质量视为有效勘误。
- 网站审校结论：所交声明 `MD.Ch06.memoryKernelDeltaMeaning` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。C：原版和_corrected均为分布极限资格定义，测试所有实轴上的C∞紧支函数，k→∞，极限γ f(0)，γ>0；修正版额外要求所有质量为正。二者没有声称此极限已成立。但D3的1/k平均使|ψk(t)|≤1，故该固定归一化下任何族均不可能收敛到正质量δ。增加正质量不能修复此问题；此外全实轴γδ与单边Volterra摩擦γ之间的边界因子未说明。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 16. MD-6.3.3-BathForceWeakLimitMeaning

- source_id：MD-6.3.3-BathForceWeakLimitMeaning。

### MD-6.3.3-BathForceWeakLimitMeaning

- 印刷页 / PDF页：237–238 / 258–259。
- 原文引文（逐字）：

> For large $k$ and for many choices of the frequencies $\Omega_i$ and the initial conditions $\{q_i(0);p_i(0)\}$, function $f(t)$ will take on the character of a Wiener process; in fact the convergence can be shown in the weak sense. We may even take the initial conditions to be randomly distributed [13,205].

- 问题所在：光滑有限热浴力的极限应区分白噪声与其时间积分Wiener过程；无初始化法则和谱条件不能指定普适法则。
- 反例或理由：C：原版量化正质量族、随机q0/p0、固定Q0和所有有限T的连续路径；把Printed负热浴力逐点识别为forcePaths，与有界连续路径泛函的期望收敛，确实强于单时均值。_corrected改为D1正力的时间积分并保留同一弱测试，改动在物理对象上合理，但不是原句字面版，且未证明任何频率/初值族满足。两版均未要求样本→连续路径映射可测（也未用HasLaw声明真正路径law）；对任意不可测对象，Lean的总定义积分不能直接当作概率弱收敛。需补足概率law和路径可测资格后才能认定为完整弱法则定义。
- 原文版 Lean 名称及状态：`MD.Ch06.bathForceWeakLimitMeaning`（定义）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：将与Wiener过程比较的对象改为时间积分后的热浴力；仍只定义极限意义。 ；`MD.Ch06.bathForceWeakLimitMeaning_corrected`（定义）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：人工确认原文f应为力/白噪声还是其时间积分；分别保留字面版和修正版。增加路径随机变量可测性及明确概率测度，必要时用路径law的弱收敛表述；不要把资格定义计为极限定理。
- 网站审校结论：所交声明 `MD.Ch06.bathForceWeakLimitMeaning` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。C：原版量化正质量族、随机q0/p0、固定Q0和所有有限T的连续路径；把Printed负热浴力逐点识别为forcePaths，与有界连续路径泛函的期望收敛，确实强于单时均值。_corrected改为D1正力的时间积分并保留同一弱测试，改动在物理对象上合理，但不是原句字面版，且未证明任何频率/初值族满足。两版均未要求样本→连续路径映射可测（也未用HasLaw声明真正路径law）；对任意不可测对象，Lean的总定义积分不能直接当作概率弱收敛。需补足概率law和路径可测资格后才能认定为完整弱法则定义。 本轮修改版：待复审；反例：无单列网站verdict。

## 17. MD-6.3.6-FPPolynomialAdjoint

- source_id：MD-6.3.6-FPPolynomialAdjoint。

### MD-6.3.6-FPPolynomialAdjoint

- 印刷页 / PDF页：241–242 / 262–263。
- 原文引文（逐字）：

> We assume that $\rho$ is $C^\infty$ for all $t$ and that the density tends to zero exponentially fast as $x\to\pm\infty$, whereas $a$ and $b$ are $C^\infty$ functions which grow at most polynomially fast in these limits, that is, there are constants $\eta_a$, $\eta_b$ such that
> \[a(x)=\mathcal O(|x|^{\eta_a}),\quad b(x)=\mathcal O(|x|^{\eta_b}),\quad x\to\pm\infty.\]
> [中间原文略]
> \[\langle\mathcal L\phi,\rho\rangle=\langle\phi,\mathcal L^\dagger\rho\rangle.\]

- 问题所在：函数值的多项式增长不控制全部导数；可取振荡频率快速增长的有界光滑函数。
- 反例或理由：函数值有界不控制导数：例如f(x)=sin(exp(x²))为C∞且有界，f′(x)=2x exp(x²)cos(exp(x²))不受任何多项式界控制。原条件不能直接提供所需导数估计。
- 原文版 Lean 名称及状态：`MD.Ch06.fpPolynomialAdjoint`（未证）；`MD.Ch06.fpPolynomialAdjointPrinted`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：显式约束所需导数的多项式增长和密度导数的指数衰减。 ；`MD.Ch06.fpPolynomialAdjoint_corrected`（未证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：原书条件保留并标疑误；将已给声明明确称为加强版。补充_corrected实际签名，不能仅依赖repair_log；还原原句和dagger。
- 网站审校结论：所交声明 `MD.Ch06.fpPolynomialAdjoint` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。C：实际fpPolynomialAdjoint已显式加强：a/b/ρ/φ全C∞；a、b、φ的0至2阶导数各有多项式全局界；ρ的0至2阶导数各有正指数衰减界。两边真实积分恒等由两次分部积分成立，这个已给出的加强版数学PASS，[EXTRA]准确披露了附加资格。但它不是仅原文值增长假设的定理；repair_log再列fpPolynomialAdjoint_corrected而无实际签名，不能独立确认命名修正版，所以本条整体NEEDS_HUMAN。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 18. MD-6.3.3-VariableFrictionCanonicalPrinted

- source_id：MD-6.3.3-VariableFrictionCanonicalPrinted。

### MD-6.3.3-VariableFrictionCanonicalPrinted

- 印刷页 / PDF页：239 / 260。
- 原文引文（逐字）：

> However, it should be noted that in many types of modelling, the physical nature of the interaction with the solvent bath is neglected and $\gamma$ or $\Gamma(q)$ are simply viewed as artificial parameters which allow recovery of averages with respect to the canonical distribution.

- 问题所在：M与A=ΓΓᵀ不交换时，A M⁻¹和M⁻¹/² A M⁻¹/²不同；例如M=diag(1,4)、Γ=(1,1)ᵀ。
- 反例或理由：n=2,r=1,m=(1,4),θ=1,U=0,Γ=(1,1)ᵀ常矩阵，p=(1,1)。ΓΓᵀ为全1矩阵。D42/ρ=−pᵀM⁻¹(ΓΓᵀ)p+pᵀM⁻½(ΓΓᵀ)M⁻½p=−1/4，故前向值=−exp(−5/8)/4≠0。
- 原文版 Lean 名称及状态：`MD.Ch06.variableFrictionCanonicalPrinted`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：增加ΓΓᵀ与质量矩阵M交换条件；另一个可选修法是修改漂移以匹配噪声协方差。 ；`MD.Ch06.variableFrictionCanonicalPrinted_corrected`（未证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留原句和疑误；加入条目14的交换前提可获形式stationarity。若要保留任意Γ，可重新设计满足涨落耗散的漂移；不可把原文平均恢复直接提升为遍历采样定理。
- 网站审校结论：所交声明 `MD.Ch06.variableFrictionCanonicalPrinted` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。C：量化任意n/r、正m、光滑U/Γ、θ>0以及所有相点，断言D42作用于未归一化exp(−H/θ)为0；对象、Hamiltonian质量分母和全部结论无遗漏。但该Printed全称命题不成立。作为原书canonical目标的必要检验可保留，不能认定数学PASS；也没有证明归一化存在或采样遍历性。[EXTRA]正确提醒必要性，不修复非交换问题。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 19. MD-6.4.1-FiniteDistribution

- source_id：MD-6.4.1-FiniteDistribution。

### MD-6.4.1-FiniteDistribution

- 印刷页 / PDF页：245 / 266。
- 原文引文（逐字）：

> A distribution on the state space is typically associated to a row vector $\psi=(\psi_1,\psi_2,\ldots,\psi_k)$ with nonzero elements and which is normalized such that
> \[\sum_{i=1}^k\psi_i=1.\]

- 问题所在：一般概率向量可为(1,0)；nonzero不能作为全部分布的定义。
- 反例或理由：ψ=(1,0)非负且和1，但第二分量不严格正；任务给出的counterexample完整表达此事实。
- 原文版 Lean 名称及状态：`MD.Ch06.finiteDistribution`（定义）；`MD.Ch06.finiteDistributionPrinted`（定义）；`MD.Ch06.finiteDistributionPrinted_counterexample`（已证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：原nonzero单独保留为严格正权重版本；一般定义采用非负权重、总和1。 ；`MD.Ch06.finiteDistribution_corrected`（定义）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留原书疑误并加[ERRATUM?]；按本条说明分别保留Printed版和修正版。
- 网站审校结论：所交声明 `MD.Ch06.finiteDistribution` 的整体 verdict=PASS；原文栏=NEEDS_HUMAN。逐个审校：finiteDistribution及_corrected均为非负且总和1的一般概率向量；finiteDistributionPrinted按概率权重上下文将nonzero保留为严格正且总和1；反例(1,0)确实满足前者且不满足后者。三种对象及counterexample相互吻合。原句含typically，不能无条件把原文认定为错误定义；应保留人审。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 20. MD-6.4.2-CylinderForwardPrinted

- source_id：MD-6.4.2-CylinderForwardPrinted。

### MD-6.4.2-CylinderForwardPrinted

- 印刷页 / PDF页：247 / 268。
- 原文引文（逐字）：

> Taking the adjoint, the forward Kolmogorov or Fokker-Planck operator is $\mathcal L^*$, acting on a density $\rho(X)$ as
> \[\mathcal L^*\rho=-\nabla\cdot(b_0\rho)+\tfrac12\operatorname{Tr}(B^T\phi''B).\]

- 问题所在：密度前向算子不应依赖独立的检验函数φ；即使ρ固定，改变φ会改变印刷右端。
- 反例或理由：取n=r=1、b₀=0、B=[1]、φ(x)=x²、ρ=0。原印刷式值为(1/2)·2=1，当前Lean定义值为2。
- 原文版 Lean 名称及状态：`MD.Ch06.cylinderForwardPrinted`（定义）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：扩散项中的φ″改为ρ″。 Printed补原页1/2，保留印刷φ而不静默改ρ；独立corrected采用实际周期lift的前向密度表达式，与VectorForward相同。；`MD.Ch06.cylinderForwardPeriodic_corrected`（定义）；`MD.Ch06.cylinderForwardPrinted_corrected`（定义）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：仅修复字面忠实版：将vectorDiffusion B φ x改为vectorDiffusion B φ x / 2，继续保留原印刷φ并标[ERRATUM?]；另设corrected版本才改成ρ并对真正圆柱空间使用周期lift。
- 网站审校结论：所交声明 `MD.Ch06.cylinderForwardPrinted` 的整体 verdict=FAIL；原文栏=NEEDS_HUMAN。字面版确实保留了原页误写的φ而不是ρ，但漏掉原页清楚印出的1/2：D7的vectorDiffusion是完整∑ij(BBᵀ)ij∂ijφ，自身不含1/2。因此即使按Printed忠实标准也FAIL。[EXTRA]只说明错误φ，未记录新增的二倍系数错误；签名也没有圆环lift约束，只能视为欧氏局部表达。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 21. MD-6.4.3-BrownianSymmetry / MD-6.4.3-BrownianClosedSelfAdjoint / MD-6.4.3-BrownianCompactResolvent

- source_id：MD-6.4.3-BrownianSymmetry；MD-6.4.3-BrownianClosedSelfAdjoint；MD-6.4.3-BrownianCompactResolvent。

### MD-6.4.3-BrownianSymmetry

- 印刷页 / PDF页：250 / 271。
- 原文引文（逐字）：

> In this form we see that $f$ and $g$ appear symmetrically, so we may write
> \[\langle f,\mathcal Lg\rangle_\beta=\langle\mathcal Lf,g\rangle_\beta;\]
> hence, with respect to the weighted inner product, $\mathcal L^\dagger=\mathcal L$. (Note that the adjoint indicated here is quite different than the $L^2$ adjoint mentioned previously in connection with the Fokker-Planck operator.)

- 问题所在：本条仅为周期光滑核心上的形式对称配对；核心对称不推出伴随域相等。闭实现自伴另见BrownianClosedSelfAdjoint，原C₀²域解释待签核。
- 反例或理由：Lean只陈述周期光滑核心上的对称配对，签名正确；原引文还推出L=L*，核心对称不等于完整伴随域相等。[EXTRA]承认缩小含义，却不能把原整段自伴结论视作已完全覆盖。
- 原文版 Lean 名称及状态：`MD.Ch06.brownianSymmetry`（已证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：本条仅为周期光滑核心上的形式对称配对；核心对称不推出伴随域相等。闭实现自伴另见BrownianClosedSelfAdjoint，原C₀²域解释待签核。；`MD.Ch06.brownianSymmetry_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：把形式对称与闭实现自伴分开，并由人工确认原C₀²域的解释。
- 网站审校结论：所交声明 `MD.Ch06.brownianSymmetry` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。Lean只陈述周期光滑核心上的对称配对，签名正确；原引文还推出L=L*，核心对称不等于完整伴随域相等。[EXTRA]承认缩小含义，却不能把原整段自伴结论视作已完全覆盖。 本轮修改版：待复审；反例：无单列网站verdict。


### MD-6.4.3-BrownianClosedSelfAdjoint

- 印刷页 / PDF页：249–250 / 270–271。
- 原文引文（逐字）：

> Then $\mathcal L$ is self-adjoint with respect to this inner product.

- 问题所在：明确采用周期紧环面的Gibbs L²图闭包/最大复图实现；此域修正替换原C₀²核心域，不能把核心上的形式对称当原域自伴，待人工签核。
- 反例或理由：D11、D19、D20给出光滑周期实L²算子的图闭包；D12–D14给出完整复特征基上的最大图算子。正质量、β>0、光滑周期势下闭自伴陈述合理，归一化无碍；但这替换了原文C₀²核心域，不能以核心形式对称直接视作原域自伴。
- 原文版 Lean 名称及状态：`MD.Ch06.brownianClosedSelfAdjoint`（已证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：明确采用周期紧环面的Gibbs L²图闭包/最大复图实现；此域修正替换原C₀²核心域，不能把核心上的形式对称当原域自伴，待人工签核。；`MD.Ch06.brownianClosedSelfAdjoint_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：人工签核闭实现对原文域的修正；本条不因证明未给出而失败。
- 网站审校结论：所交声明 `MD.Ch06.brownianClosedSelfAdjoint` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。D11、D19、D20给出光滑周期实L²算子的图闭包；D12–D14给出完整复特征基上的最大图算子。正质量、β>0、光滑周期势下闭自伴陈述合理，归一化无碍；但这替换了原文C₀²核心域，不能以核心形式对称直接视作原域自伴。 本轮修改版：待复审；反例：无单列网站verdict。


### MD-6.4.3-BrownianCompactResolvent

- 印刷页 / PDF页：250 / 271。
- 原文引文（逐字）：

> In particular, it has a compact resolvent [360]; this can be shown to imply that the spectrum consists only of a countable collection of eigenvalues, i.e. that the operator has a discrete spectrum.

- 问题所在：仅断言紧torus上的闭实现具有紧预解式；原一般C₀²措辞未覆盖，域与紧配置假设需人工签核。
- 反例或理由：在Q=ℝ、U=0时，拉普拉斯的(1−Δ)⁻¹不紧：平移的固定局部函数序列无强收敛子列。
- 原文版 Lean 名称及状态：`MD.Ch06.brownianCompactResolvent`（已证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：仅断言紧torus上的闭实现具有紧预解式；原一般C₀²措辞未覆盖，域与紧配置假设需人工签核。；`MD.Ch06.brownianCompactResolvent_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：将原断言限定到紧torus及闭实现。
- 网站审校结论：所交声明 `MD.Ch06.brownianCompactResolvent` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。移位图映射为(x,y)↦x−y，逆映射再投影为(1−L)⁻¹，实部/虚部复化对应复L²预解式。周期紧域上紧性合理；原段在未明确紧配置域及闭算子域前泛称C₀²算子具有紧预解式，范围需签核。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 22. MD-6.4.3-BrownianNonpositive / MD-6.4.3-BrownianRealEigenvalue / MD-6.4.3-BrownianNegativeDefinitePrinted

- source_id：MD-6.4.3-BrownianNonpositive；MD-6.4.3-BrownianRealEigenvalue；MD-6.4.3-BrownianNegativeDefinitePrinted。

### MD-6.4.3-BrownianNonpositive

- 印刷页 / PDF页：250 / 271。
- 原文引文（逐字）：

> Moreover, from the calculation above,
> \[\langle f,\mathcal Lf\rangle=-\beta^{-1}\int_{\mathcal Q}\|\nabla f\|^2\bar\rho_\beta d\omega_q;\]
> so that $\langle f,\mathcal Lf\rangle\le0$ so the operator is negative definite and can only have non-positive eigenvalues.

- 问题所在：非零常数函数的梯度为0，二次型等于0；故仅为半负定。
- 反例或理由：f≡1光滑周期非零，但Lf=0，二次型=0。
- 原文版 Lean 名称及状态：`MD.Ch06.brownianNonpositive`（已证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：采用≤0并区分闭算子实现与光滑核心；严格负定字面另见BrownianNegativeDefinitePrinted。 ；`MD.Ch06.brownianNonpositive_corrected`（已证）；`MD.Ch06.brownianNegativeDefinitePrinted_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：原文保留并标注半负定；严格负定只能在合适的零均值非零子空间讨论。
- 网站审校结论：所交声明 `MD.Ch06.brownianNonpositive` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。正质量、β>0及周期光滑域下未归一二次型≤0正确。原文negative definite错误，已有[ERRATUM?]保留；本签名仅保留正确的半负定子结论。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。


### MD-6.4.3-BrownianRealEigenvalue

- 印刷页 / PDF页：250 / 271。
- 原文引文（逐字）：

> so that $\langle f,\mathcal Lf\rangle\le0$ so the operator is negative definite and can only have non-positive eigenvalues.

- 问题所在：[ERRATUM?]原引文negative definite应为半负定，常数零模反例与BrownianNegativeDefinitePrinted共用；本条只证明已给实特征参数≤0，不冒称全部复谱实性。
- 反例或理由：常数特征函数的ℓ=0反驳严格负定，不反驳本条ℓ≤0。
- 原文版 Lean 名称及状态：`MD.Ch06.brownianRealEigenvalue`（已证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：[ERRATUM?]原引文negative definite应为半负定，常数零模反例与BrownianNegativeDefinitePrinted共用；本条只证明已给实特征参数≤0，不冒称全部复谱实性。；`MD.Ch06.brownianRealEigenvalue_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：补录negative definite的[ERRATUM?]，保留本正确子结论。
- 网站审校结论：所交声明 `MD.Ch06.brownianRealEigenvalue` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。非零性为基本域Lebesgue几乎处处非零之否定，正权重下范数严格正；全域特征关系及二次型非正推出所给实数ℓ≤0。签名未声称证明所有复特征值实性。原引文仍含negative definite疑误，应补相同勘误标记。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。


### MD-6.4.3-BrownianNegativeDefinitePrinted

- 印刷页 / PDF页：250 / 271。
- 原文引文（逐字）：

> so that $\langle f,\mathcal Lf\rangle\le0$ so the operator is negative definite and can only have non-positive eigenvalues.

- 问题所在：取f≡1，非零而〈f,Lf〉=0。
- 反例或理由：任意维数取U=0、m≡1、β=1、f≡1；基本域测度1，f非零而Lf=0，结论0<0为假。
- 原文版 Lean 名称及状态：`MD.Ch06.brownianNegativeDefinitePrinted`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：将严格小于0改为小于等于0；零特征值与常数核保留。 ；`MD.Ch06.brownianNegativeDefinitePrinted_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：修正版改≤0，或在零均值非零子空间给严格不等式。
- 网站审校结论：所交声明 `MD.Ch06.brownianNegativeDefinitePrinted` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。Printed严格负定版准确编码任意非零周期光滑f的二次型<0；虽为假，按原文字面版规则不以不忠实判FAIL。已有[ERRATUM?]正确。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 23. MD-6.4.3-Theorem61 / MD-6.4.3-Theorem61TimeAveragePrinted

- source_id：MD-6.4.3-Theorem61；MD-6.4.3-Theorem61TimeAveragePrinted。

### MD-6.4.3-Theorem61

- 印刷页 / PDF页：250–251 / 271–272。
- 原文引文（逐字）：

> Theorem 6.1 Define the generator of Brownian dynamics by
> \[\mathcal Lf\stackrel{\rm def}=-M^{-1}\nabla U^T\nabla f+\beta^{-1}\Delta_Mf.\]
> Suppose that $U$ is smooth with periodic boundary conditions $\mathcal Q=\mathbb T^{N_c}$ ($\mathbb T^{N_c}$ an $N_c$-dimensional torus). Then, with respect to the space $C_0^2(\mu_\beta)$ with inner product $\langle f,g\rangle_\beta$ as defined above, we have:
> 1. $\mathcal L$ is self-adjoint, negative definite, with spectrum consisting of discrete eigenvalues on the half line $(-\infty,0]$.
> 2. $\mathcal L$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $\sigma(\mathcal L)\subset(-\infty,-\alpha]$ for some $\alpha>0$.
> 3. averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $\varphi$, we have
> \[|\bar\varphi(t)-\operatorname{Av}_\beta(\varphi)|\le K\|\varphi\|_\beta e^{-\alpha t};\]
> for some positive $K$ and $\alpha$, where recall $\bar\varphi(t)$ denotes the time average of $\varphi$ defined in (5.6).

- 问题所在：常数核反驳严格负定；随机轨道时间平均通常不具有原式的逐路径指数误差界；核心域上的对称性不自动等于闭实现的自伴性。此外p.244将ΔM定义为正质量权重，Brownian生成元扩散应为逆质量权重；m=2、U=0、f(x)=x²可区分二者。
- 反例或理由：f≡1反驳严格负定；轨道平均的指数路径界亦不随分布平均指数收敛而成立。
- 原文版 Lean 名称及状态：`MD.Ch06.theorem61`（未证）；`MD.Ch06.theorem61Printed`（未证）；`MD.Ch06.brownianMassGeneratorPrinted`（定义）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：明确闭Gibbs-L²实现、半负定、离散谱、谱隙和L²初始相对密度的演化分布平均；Brownian扩散使用逆质量权重，不混用p.244动量算子的ΔM；不声称已证原轨道时间平均。 Theorem6.1主版、corrected和Printed同时补全部谱点特征值子句；仍保留闭域/半负定/L²相对初始密度的分布平均与原印刷严格负定/轨道平均两套版本，原文疑误不证。；`MD.Ch06.theorem61_corrected`（未证）；`MD.Ch06.brownianMassGeneratorPrinted_corrected`（定义）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：补全特征值子句；保留原版与闭域/半负定/分布平均修正版两套陈述，并明确L²初始密度范围。
- 网站审校结论：所交声明 `MD.Ch06.theorem61` 的整体 verdict=FAIL；原文栏=NEEDS_HUMAN。量词顺序保证K,α独立于检验函数和时间，可依赖初始L²密度；闭自伴、全谱非正、可数孤立和谱隙均在。但仍漏明确的“全谱点均为特征值”结论，亦将严格负定改为非正谱、原时间平均改为演化分布平均并缩限初始law。后者已[EXTRA]/[ERRATUM?]披露，属需人工确认的修订，不能当原定理完整忠实版。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。


### MD-6.4.3-Theorem61TimeAveragePrinted

- 印刷页 / PDF页：251 / 272。
- 原文引文（逐字）：

> Theorem 6.1 Define the generator of Brownian dynamics by
> \[\mathcal Lf\stackrel{\rm def}=-M^{-1}\nabla U^T\nabla f+\beta^{-1}\Delta_Mf.\]
> Suppose that $U$ is smooth with periodic boundary conditions $\mathcal Q=\mathbb T^{N_c}$ ($\mathbb T^{N_c}$ an $N_c$-dimensional torus). Then, with respect to the space $C_0^2(\mu_\beta)$ with inner product $\langle f,g\rangle_\beta$ as defined above, we have:
> 1. $\mathcal L$ is self-adjoint, negative definite, with spectrum consisting of discrete eigenvalues on the half line $(-\infty,0]$.
> 2. $\mathcal L$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $\sigma(\mathcal L)\subset(-\infty,-\alpha]$ for some $\alpha>0$.
> 3. averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $\varphi$, we have
> \[|\bar\varphi(t)-\operatorname{Av}_\beta(\varphi)|\le K\|\varphi\|_\beta e^{-\alpha t};\]
> for some positive $K$ and $\alpha$, where recall $\bar\varphi(t)$ denotes the time average of $\varphi$ defined in (5.6).

- 问题所在：对非平凡平稳扩散，时间平均的随机波动通常为代数尺度；原句前半讨论演化分布平均，末句却引用(5.6)时间平均。
- 反例或理由：取一维圆周U=0、标准Brownian及非恒定余弦检验。若所有t的时间积分误差≤Ct exp(−αt)，则积分趋0；任意固定长度的后期区间积分也须趋0，但混合平稳极限中该区间积分具有非退化分布，矛盾。
- 原文版 Lean 名称及状态：`MD.Ch06.theorem61TimeAveragePrinted`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：选择演化分布平均，限定L²初始相对密度；轨道遍历极限应另行陈述，不赋予指数逐路径率。 ；`MD.Ch06.theorem61TimeAveragePrinted_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留字面版并判人工；修正版改演化分布平均，轨道平均另给适当概率/渐近结论。
- 网站审校结论：所交声明 `MD.Ch06.theorem61TimeAveragePrinted` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。按Printed规则核查：任意点初值、K,α先于f与AE样本、全部t>0的轨道时间积分，确为原末句时间平均读法的明确化。AE资格是额外选择；原文本身与前句分布平均冲突且该指数路径界一般错误。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 24. MD-6.4.2-OUDensityPrinted

- source_id：MD-6.4.2-OUDensityPrinted。

### MD-6.4.2-OUDensityPrinted

- 印刷页 / PDF页：248 / 269。
- 原文引文（逐字）：

> The solution $p(t)$ to the Ornstein-Uhlenbeck equation, for any finite time $t$, is always normally distributed
> \[\rho(p,t)=\exp\left[-\frac{(p-\mu(t))^2}{2\sigma(t)^2}\right];\tag{6.44}\]
> where
> \[\mu(t)=p_0e^{-\gamma t};\qquad\sigma^2(t)=k_BT m[1-e^{-2\gamma t}].\tag{6.45}\]

- 问题所在：高斯权重积分为sqrt(2πσ²(t))而非1；t=0为Dirac测度。
- 反例或理由：在方差v=1时，未归一化指数在实线的积分为sqrt(2π)，不是1；t=0时真实law为δx0。
- 原文版 Lean 名称及状态：`MD.Ch06.ouDensityPrinted`（定义）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：增加(2πσ²(t))⁻¹/²，并限γ>0、噪声非零、t>0的密度解释。 ；`MD.Ch06.ouDensity`（定义）；`MD.Ch06.ouDensityPrinted_corrected`（定义）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留原书疑误并加[ERRATUM?]；按本条说明分别保留Printed版和修正版。
- 网站审校结论：所交声明 `MD.Ch06.ouDensityPrinted` 的整体 verdict=PASS；原文栏=NEEDS_HUMAN。Printed定义保留了原书未归一化指数。ouMean=exp(−γt)x0，ouVariance=σ_noise²(1−exp(−2γt))/(2γ)；取σ_noise²=2γkBTm就得到6.45。[EXTRA]已经说明参数转换。作为字面公式定义PASS，不把原书缺归一化或t=0问题算成该字面定义的签名错误。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 25. MD-6.4.4-Assumption1Printed

- source_id：MD-6.4.4-Assumption1Printed。

### MD-6.4.4-Assumption1Printed

- 印刷页 / PDF页：252 / 273。
- 原文引文（逐字）：

> Assumption 1 The Markov process generated by the SDE (6.43) satisfies, for some fixed compact set $C\in\mathcal B(D)$, the conditions:
> (i) For some $y\in\operatorname{int}(C)$, we have that for any $\delta>0$ there is a $t_0>0$ such that
> \[\operatorname{Pr}(X(t_0)\in B_\delta(y)\mid X(0)=X_0)>0,\quad\forall X_0\in C.\]
> (ii) For $t>0$, the transition kernel possesses a density $\widehat\rho(X,z,t)$ such that
> \[\operatorname{Pr}(X(t)\in A\mid X(0)=X_0)=\int_A\widehat\rho(X_0,z,t)dz,\quad\forall X_0\in C,\ A\in\mathcal B(D)\cap\mathcal B(C);\]
> and $\widehat\rho(X,z,t)$ is jointly continuous in $C\times C\times[0,\infty)$.

- 问题所在：Brownian热核对角线上随t↓0发散，t=0转移核是Dirac测度。
- 反例或理由：正维热核在对角随t↓0发散，不能在C×C×[0,∞)上取有限连续延拓。
- 原文版 Lean 名称及状态：`MD.Ch06.assumption1Printed`（定义）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：联合连续性的时间域由[0,∞)改为(0,∞)。 ；`MD.Ch06.assumption1Printed_corrected`（定义）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留Printed；改正定义仅将连续时间域改为Ioi 0，不声称原条件自动成立。
- 网站审校结论：所交声明 `MD.Ch06.assumption1Printed` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。Printed保留紧C、同一内点y、δ后选统一t、全部x和可测A⊆C及联合连续时间Ici 0；与原[0,∞)一致。ν是披露的参考测度推广，但Kernel本身不含Markov/半群资格；此定义只编码局部条件。原零时连续性疑误保留。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 26. MD-6.4.4-MinorizationPrinted / MD-6.4.4-MinorizationCorrectedImplication

- source_id：MD-6.4.4-MinorizationPrinted；MD-6.4.4-MinorizationCorrectedImplication。

### MD-6.4.4-MinorizationPrinted

- 印刷页 / PDF页：252 / 273。
- 原文引文（逐字）：

> It can be shown that this assumption is tantamount to the SDE satisfying a minorization condition. This condition is a particular case of the general concept of small sets, found in Markov literature for proving ergodicity.

- 问题所在：取C=∅，小集下界对全部x∈C空真，但Assumption1要求y∈int(C)，因此不成立。即使C非空，小集下界也不自动给相对于指定参考测度的联合连续密度。
- 反例或理由：S=ℝ，C=[0,1]，ν为Lebesgue，K_t(x)=δ₀对所有t。右侧取ε=1,μ=δ₀成立；左侧局部密度不存在，且点0不在int C。故反向不成立。
- 原文版 Lean 名称及状态：`MD.Ch06.minorizationPrinted`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：只保留在明确正时刻密度、可达性条件下到小集下界的充分方向。 ；`MD.Ch06.minorizationPrinted_corrected`（未证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留字面等价并判人工；充分方向需补半群和适当正则/可达条件，反向不能无条件恢复。
- 网站审校结论：所交声明 `MD.Ch06.minorizationPrinted` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。Printed将tantamount忠实读为↔，右侧给一个正时刻、正ENNReal下界系数和同一概率μ，对全部x∈C作完整测度序下界。左侧仍为原零时连续版；抽象签名没有SDE或Markov半群假设，等价一般错误。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。


### MD-6.4.4-MinorizationCorrectedImplication

- 印刷页 / PDF页：252 / 273。
- 原文引文（逐字）：

> It can be shown that this assumption is tantamount to the SDE satisfying a minorization condition. This condition is a particular case of the general concept of small sets, found in Markov literature for proving ergodicity.

- 问题所在：主版与minorizationPrinted_corrected同时补Chapman–Kolmogorov/Markov半群及参考测度全支撑。两步核局部共同下界仍需大型小集理论，未证明、未宣称数学结论已核定；交网站复审。
- 反例或理由：D为单位圆周、C=D、ν为归一Haar；所有t令K_t(x,dz)=[1−cos(2π(z−x))]ν(dz)。密度连续非负归一且每个非空开集正，满足assumption1及附加可达性。若εμ≤K_t(x)对全部x，则μ≪ν且对可数稠密x同时有εdμ/dν≤1−cos(2π(z−x))，取下确界得密度0，矛盾μ(D)=1。
- 原文版 Lean 名称及状态：`MD.Ch06.minorizationCorrectedImplication`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：主版与minorizationPrinted_corrected同时补Chapman–Kolmogorov/Markov半群及参考测度全支撑。两步核局部共同下界仍需大型小集理论，未证明、未宣称数学结论已核定；交网站复审。；`MD.Ch06.minorizationPrinted_corrected`（未证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：增加真正Markov半群资格并重审利用两步核获得共同下界的条件；不能仅增加全支撑。
- 网站审校结论：所交声明 `MD.Ch06.minorizationCorrectedImplication` 的整体 verdict=FAIL；原文栏=CORRECTED。即使修正正时连续并加每个正时刻所有非空开集可达，任意kernel族仍不能推出共同小集下界。签名缺少Chapman–Kolmogorov/Markov半群结构，新增全支撑不足以弥补。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 27. MD-6.4.4-Theorem62

- source_id：MD-6.4.4-Theorem62。

### MD-6.4.4-Theorem62

- 印刷页 / PDF页：252 / 273。
- 原文引文（逐字）：

> Theorem 6.2 (Geometric Ergodicity) Let the solution to (6.43) be denoted $X(t)$. If Assumption 1 and Assumption 2 are satisfied for
> \[C=\{X\in D\mid\varphi(X)\le K_{\alpha,\delta}\},\]
> where $K_{\alpha,\delta}$ is a particular positive value depending on $\alpha$ and $\delta$, then
> (i) there exists a unique invariant measure $\rho_*$, with $\mathcal L^*\rho_*=0$, and
> (ii) there exist positive constants $k$ and $\lambda$ such that for all suitable functions $f$ with $|f|\le\varphi$,
> \[|e^{t\mathcal L}f(X_0)-\operatorname{Av}(f)|\le ke^{-\lambda t}\varphi(X_0);\tag{6.48}\]
> where $\operatorname{Av}(f)=\int_D f(z)\rho_*(z)dz$ is the spatial average.

- 问题所在：原Assumption1在0时刻的密度问题需先修正；抽象generator与实际Markov演化的域、全状态密度和非爆炸资格不能省略。
- 反例或理由：阈值在所有状态空间/过程前选择且仅依α,δ；全体测度不变概率唯一性、密度、弱生成元检验和统一加权指数界均写出。但kernelGenerator仅为derivWithin总定义，假设没有保证φ或测试函数的右导数真实存在，也没有C₀半群/扩展生成元域及交换积分极限条件；空间Feller不补这些时间域条件。原Assumption1已被正时修正。不能据此签核完整Harris推广定理。
- 原文版 Lean 名称及状态：`MD.Ch06.theorem62`（未证）；`MD.Ch06.theorem62Printed`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：明示实际Markov/Feller演化、正确正时刻密度、generator联系和先于过程选择的阈值；整条仍未证明。 ；`MD.Ch06.theorem62_corrected`（未证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：补φ的真实（扩展）生成元域和Dynkin/半群漂移条件，补弱平稳方程测试域的可交换条件，并签核从局部正时密度到small set的桥接。
- 网站审校结论：所交声明 `MD.Ch06.theorem62` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。阈值在所有状态空间/过程前选择且仅依α,δ；全体测度不变概率唯一性、密度、弱生成元检验和统一加权指数界均写出。但kernelGenerator仅为derivWithin总定义，假设没有保证φ或测试函数的右导数真实存在，也没有C₀半群/扩展生成元域及交换积分极限条件；空间Feller不补这些时间域条件。原Assumption1已被正时修正。不能据此签核完整Harris推广定理。 本轮修改版：待复审；反例：无单列网站verdict。

## 28. MD-6.4.4-PeriodicPotentialBound / MD-6.4.4-PeriodicConfiningPrinted

- source_id：MD-6.4.4-PeriodicPotentialBound；MD-6.4.4-PeriodicConfiningPrinted。

### MD-6.4.4-PeriodicPotentialBound

- 印刷页 / PDF页：253 / 274。
- 原文引文（逐字）：

> We also consider the potential energy to be smooth ($C^\infty$) with $U(q)\to\infty$ as $|q|\to\infty$. As we have a smooth potential on a bounded (position) domain, we have
> \[1<U_{\min}\le U(q)\le U_{\max}<\infty,\quad\forall q\in\mathcal Q,\]
> for some constants $U_{\min}$ and $U_{\max}$.

- 问题所在：周期势有界，不可能同时在其欧氏lift上随|q|→∞趋于∞；U=0也不满足Umin>1。
- 反例或理由：U≡0满足连续周期却没有1<Umin≤U；正维周期势沿整数平移保持常值，不能趋∞。
- 原文版 Lean 名称及状态：`MD.Ch06.periodicPotentialBound`（已证）；`MD.Ch06.periodicPotentialBoundPrinted`（未证）；`MD.Ch06.periodicPotentialBoundPrinted_counterexample`（已证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：保留周期势有界结论；正下界通过加常数归一单独实现。 ；`MD.Ch06.periodicPotentialBound_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：原文保留；修正版分为全域有界与可平移归一两条，删除周期lift的围束要求。
- 网站审校结论：所交声明 `MD.Ch06.periodicPotentialBound` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。连续周期势全域有界的签名正确，M≥0的范数界给−M≤U≤M。它未包含原1<Umin；该要求由下一条平移解释而非本条证明。原文同时要求周期与配置无穷远围束，本条[ERRATUM?]正确保留。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。


### MD-6.4.4-PeriodicConfiningPrinted

- 印刷页 / PDF页：253 / 274。
- 原文引文（逐字）：

> The whole phase space is $D=\mathbb T^{N_c}\times\mathbb R^{N_c}$. We also consider the potential energy to be smooth ($C^\infty$) with $U(q)\to\infty$ as $|q|\to\infty$.

- 问题所在：正维周期lift沿整数平移取相同势值，无法趋于∞。
- 反例或理由：取任意q及非零整数方向e₁；q+ke₁逃离每个紧集，周期性却给U(q+ke₁)=U(q)。
- 原文版 Lean 名称及状态：`MD.Ch06.periodicConfiningPrinted`（定义）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：围束对象改为环面×动量空间上的Hamiltonian幂；无穷远只涉及动量方向。 ；`MD.Ch06.periodicConfiningPrinted_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留字面定义和勘误；torus位置域只需光滑周期，围束由H对动量给出。
- 网站审校结论：所交声明 `MD.Ch06.periodicConfiningPrinted` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。Printed对正维欧氏lift同时要求C∞、整数平移周期、cocompact处趋∞，确实忠实表达原矛盾资格；hn排除零维真空情况。不应要求构造满足它的势。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 29. MD-6.4.4-HamiltonianPowerMomentumLaplacian / MD-6.4.4-LaplacianBoundPrinted / MD-6.4.4-LyapunovYoungBounds

- source_id：MD-6.4.4-HamiltonianPowerMomentumLaplacian；MD-6.4.4-LaplacianBoundPrinted；MD-6.4.4-LyapunovYoungBounds。

### MD-6.4.4-HamiltonianPowerMomentumLaplacian

- 印刷页 / PDF页：253 / 274。
- 原文引文（逐字）：

> \[\Delta_p\varphi=l(l-1)H^{l-2}\|p\|^2+N_clH^{l-1}\le l(l+N_c-1)H^{l-1}.\]

- 问题所在：保留已证精确Laplacian等式；原错误上界Printed与修正系数分别由MD-6.4.4-LaplacianBoundPrinted/LaplacianBoundCorrect保存，不能把等式视为已覆盖原印刷不等式。
- 反例或理由：取Nc=1,l=2,U≡2,p=3，则H=13/2，实际Δp H²=2p²+2H=31，原右界4H=26，31≤26为假；已满足原U>1光滑周期资格。
- 原文版 Lean 名称及状态：`MD.Ch06.hamiltonianPowerMomentumLaplacian`（已证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：保留已证精确Laplacian等式；原错误上界Printed与修正系数分别由MD-6.4.4-LaplacianBoundPrinted/LaplacianBoundCorrect保存，不能把等式视为已覆盖原印刷不等式。；本条是正确限定子句/资格定义；不把原文字面错误计成已证，相关完整修正版见同组。
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：增加原不等式Printed条款和[ERRATUM?]；U≥0、H>0时可改界l(2(l−1)+Nc)H^(l−1)，保留现有正确等式。
- 网站审校结论：所交声明 `MD.Ch06.hamiltonianPowerMomentumLaplacian` 的整体 verdict=FAIL；原文栏=NEEDS_HUMAN。实际坐标二阶导数和的等式正确，l=1时自然数截断指数乘零系数仍正确；但签名完全遗漏原文随后≤l(l+Nc−1)H^(l−1)结论。[EXTRA]说原不等式另存，却在本条没有独立Printed声明或勘误，不能通过完整结论审校。原不等式本身错误，须保留并判人工，不能静默删去。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。


### MD-6.4.4-LaplacianBoundPrinted

- 印刷页 / PDF页：253 / 274。
- 原文引文（逐字）：

> \[\Delta_p\varphi=l(l-1)H^{l-2}\|p\|^2+N_clH^{l-1}\le l(l+N_c-1)H^{l-1}.\]

- 问题所在：n=1、U=2、l=2、p=4时，实际Laplacian为52，印刷上界为40。
- 反例或理由：n=1，U≡2，l=2，p=4：H=10，二阶导数52，所称上界40。
- 原文版 Lean 名称及状态：`MD.Ch06.laplacianBoundPrinted`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：系数l(l+Nc−1)改为2l(l−1)+Nc·l。 ；`MD.Ch06.laplacianBoundPrinted_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留Printed并标ERRATUM?；修正版系数2l(l−1)+nl。
- 网站审校结论：所交声明 `MD.Ch06.laplacianBoundPrinted` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。原字面上界的量词n、U≥1、l≥1、全部相点及系数l(l+n−1)忠实；原数学断言错误，按要求保留而不把原书错误算作转录失败。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。


### MD-6.4.4-LyapunovYoungBounds

- 印刷页 / PDF页：253 / 274。
- 原文引文（逐字）：

> As $H^l$ grows faster than $H^{l-1}$, for any fixed $l$ we are able to find positive constants $c$ and $d$ such that
> \[l(l+N_c-1)H^{l-1}\le\tfrac l2H^l+c;\qquad 2lH^{l-1}U(q)<2lH^{l-1}U_{\max}\le\tfrac l2H^l+d.\]

- 问题所在：U(q)≤Umax不能推出严格U(q)<Umax；原Laplacian错系数也不能由Young估计补救。
- 反例或理由：量词顺序正确：c,d依赖l,n,Umax，独立于所有H≥1；正性、两条原有效非严格标量界及修正系数界同时覆盖。未编码U(q)的严格不等式，已在EXTRA/ERRATUM?说明是修正版；应保留该范围说明。
- 原文版 Lean 名称及状态：`MD.Ch06.lyapunovYoungBounds`（已证）；`MD.Ch06.lyapunovYoungBoundsPrinted`（未证）；`MD.Ch06.lyapunovYoungBoundsPrinted_counterexample`（已证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：采用非严格上界，并列原有效标量界和正确Laplacian系数所需界；若另选严格外上界才可写原严格号。 ；`MD.Ch06.lyapunovYoungBounds_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：把原U(q)<Umax标为需严格外界；不得把本签名称为该严格链的字面形式。
- 网站审校结论：所交声明 `MD.Ch06.lyapunovYoungBounds` 的整体 verdict=PASS；原文栏=APPROVED。量词顺序正确：c,d依赖l,n,Umax，独立于所有H≥1；正性、两条原有效非严格标量界及修正系数界同时覆盖。未编码U(q)的严格不等式，已在EXTRA/ERRATUM?说明是修正版；应保留该范围说明。 本轮修改版：待复审；反例：无单列网站verdict。

## 30. MD-6.4.4-Definition61

- source_id：MD-6.4.4-Definition61。

### MD-6.4.4-Definition61

- 印刷页 / PDF页：254 / 275。
- 原文引文（逐字）：

> Definition 6.1 (Hörmander's Condition) Let $U\subset\mathbb R^m$ be open. The SDE (6.43) with $C^\infty$ vector fields $b_0,b_1,\ldots,b_r:U\to\mathbb R^m$ are said to satisfy Hörmander's condition at $z\in U$ if the vector space spanned by the collection of iterated Lie brackets
> \[b_0,b_1,\ldots,b_r,[b_0,b_1],[b_0,b_2],\ldots,[b_{r-1},b_r],[b_0,[b_0,b_1]],\ldots\]
> (evaluated at $z$) is $\mathbb R^m$.

- 问题所在：一维确定性dX=dt的漂移b₀=1已张成R，但点初始转移法则始终为Dirac，没有Lebesgue密度。单独把漂移放入生成族不能保证随机平滑。
- 反例或理由：一维b0=1、所有噪声为0：印刷张成条件成立，但确定性平移的转移律为Dirac，无Lebesgue密度。
- 原文版 Lean 名称及状态：`MD.Ch06.definition61`（定义）；`MD.Ch06.parabolicNoiseBracketLevels`（定义）；`MD.Ch06.definition61Printed`（定义）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：用于密度结论时，从噪声字段开始，允许与漂移及噪声反复取括号；不把漂移本身直接加入初始生成族。 ；`MD.Ch06.definition61_corrected`（定义）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：补textbookIteratedBracket实际定义；原版保留ERRATUM?，密度用途采用已列噪声生成修正版。
- 网站审校结论：所交声明 `MD.Ch06.definition61` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。definition61/Printed含全部b0及噪声，域内C∞和x∈D完整；corrected从噪声开始并反复与所有字段取括号，修正方向合理。但D38引用的项目谓词textbookIteratedBracket全文未提供，无法只据摘录核定原版究竟包含哪些迭代括号。原含漂移定义也不能一般推出抛物型密度。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 31. MD-6.4.4-Lemma61Printed

- source_id：MD-6.4.4-Lemma61Printed。

### MD-6.4.4-Lemma61Printed

- 印刷页 / PDF页：255 / 276。
- 原文引文（逐字）：

> Lemma 6.1 For all $t>0$ and all open $C\subset D$, we have that
> \[\Pr(X(t)\in C\mid X(0)=X_0)>0,\quad\forall X_0\in D,\]
> where $X(t)=(q(t),p(t))^T$ is a solution to Langevin dynamics (6.47).

- 问题所在：C=∅是开集，但概率为0。
- 反例或理由：取C=∅即要求0<P∅=0；不依赖任何动力学。
- 原文版 Lean 名称及状态：`MD.Ch06.lemma61Printed`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：增加目标开集非空；保留任意点初值、任意t>0的实际核正概率。 ；`MD.Ch06.lemma61Nonempty`（已证）；`MD.Ch06.lemma61Printed_corrected`（已证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：Printed应回到单位质量周期域或明确标注扩大范围；另列非空目标修正版，不在Printed内静默加非空。
- 网站审校结论：所交声明 `MD.Ch06.lemma61Printed` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。字面保留所有开集，空集确使断言错误；还把原单位质量周期相空间扩大为任意正质量、全欧氏Phase n，且extra_assumptions为空，故不是完整忠实的Printed形式。原书疑误按NEEDS_HUMAN处理，并记录额外的签名范围偏移。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 32. MD-6.4.4-Proposition64Printed / MD-6.4.4-ForwardKernelGibbs

- source_id：MD-6.4.4-Proposition64Printed；MD-6.4.4-ForwardKernelGibbs。

### MD-6.4.4-Proposition64Printed

- 印刷页 / PDF页：257 / 278。
- 原文引文（逐字）：

> Proposition 6.4 Let $U$ be $C^\infty$ on the position domain $Q=\mathbb T^{N_c}$ and suppose $g\in H^1(\mu)$ satisfies
> \[\int_D g\,d\mu_\beta=0,\]
> where $\mu_\beta$ is the canonical measure, then the Poisson equation
> \[\mathcal L_{LD}^\dagger\varphi=g\]
> has a solution $\varphi\in H^1(\mu)$ which is unique up to addition of a constant multiple of the Gibbs density.

- 问题所在：flat前向算子的像应满足相对于体积的零质量条件；原却用Gibbs加权零均值，同时把核写成Gibbs密度，混合两种坐标。
- 反例或理由：在n=1、U≡0、β=γ=1下，w(p)=exp(−p²/2)∫₀ᵖexp(s²/2)ds满足w′+pw=1，故w″+(pw)′=0；它与导数有界，属高斯加权H¹，却不是Gibbs倍数。g=0时已违反所写唯一性。
- 原文版 Lean 名称及状态：`MD.Ch06.proposition64Printed`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：选择相对Gibbs密度坐标与真实加权伴随算子，核相应为常数；保留完整H¹解存在与唯一性目标。 ；`MD.Ch06.proposition64Relative`（未证）；`MD.Ch06.proposition64Printed_corrected`（未证）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：原文保持并NEEDS_HUMAN；决定μ及forward/relative密度约定；采用26的相对坐标修正后核应为常数。
- 网站审校结论：所交声明 `MD.Ch06.proposition64Printed` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。签名确实保留平坦forward弱PDE、Gibbs均值零、H¹存在及唯一模Gibbs密度这一有疑误组合。原书约定μ未澄清；当前弱PDE的H¹类过宽，还存在非Gibbs的零模，故原文必须保留疑误而不能判正确。H¹本身亦有缺失测试表达式定义。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。


### MD-6.4.4-ForwardKernelGibbs

- 印刷页 / PDF页：257 / 278。
- 原文引文（逐字）：

> If we have two solutions $\varphi_1,\varphi_2$ of $\mathcal L_{LD}^\dagger\varphi=g$, then their difference $w$ must be a solution of $\mathcal L_{LD}^\daggerw=0$ and the only such solution is a constant multiple of the Gibbs density $\rho_\beta$.

- 问题所在：改用相对Gibbs密度的Hilbert adjoint闭域，核结论为常数；旧flat紧支弱测试允许非Gibbs恒通量零模，网站反例保留。改后核定理尚缺大型理论，不证明；原印刷flat措辞由Proposition64Printed留存。
- 反例或理由：n=1，U≡0，β=γ=1；q无关，w(p)=e^(−p²/2)∫₀ᵖe^(s²/2)ds。w′+pw=1，故L* w=w″+(pw)′=0。w为奇函数且不为零，而Gibbs密度为正偶函数。w~1/p、w′~−1/p²，二者在Gaussian加权L²内；紧支测试积分均成立。
- 原文版 Lean 名称及状态：`MD.Ch06.forwardKernelGibbs`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：改用相对Gibbs密度的Hilbert adjoint闭域，核结论为常数；旧flat紧支弱测试允许非Gibbs恒通量零模，网站反例保留。改后核定理尚缺大型理论，不证明；原印刷flat措辞由Proposition64Printed留存。；本条是正确限定子句/资格定义；不把原文字面错误计成已证，相关完整修正版见同组。
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：在平坦forward密度空间加合适L¹/零通量条件并核定算子域，或转相对密度的Hilbert adjoint闭域，核结论改为常数。
- 网站审校结论：所交声明 `MD.Ch06.forwardKernelGibbs` 的整体 verdict=FAIL；原文栏=CORRECTED。D66的flatForwardWeak仅用紧支测试函数；w只要求Gibbs加权H¹，未要求相对于平坦测度可积或零通量。这样的定义包含额外平稳通量解，因此“所有零模为Gibbs倍数”本身错误，不只是缺证明。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 33. MD-6.4.5-SmoothTestL2Printed

- source_id：MD-6.4.5-SmoothTestL2Printed。

### MD-6.4.5-SmoothTestL2Printed

- 印刷页 / PDF页：258 / 279。
- 原文引文（逐字）：

> Since all the eigenvalues lie to the left of a vertical line in the left half plane, for any $\varphi$ in $C^\infty$ we have
> \[\int_D\varphi\rho(q,p,t)d\omega=\operatorname{Av}_\beta(\varphi)+\alpha e^{t\lambda_1}\int_D\varphi\rho^{(1)}d\omega.\]
> The latter integral is bounded since both $\varphi$ and $\rho^{(1)}$ are in $L^2$.

- 问题所在：在正维无界动量空间上，f≡1光滑却不属于flat L²；一般光滑也不保证Gibbs L²。
- 反例或理由：n=1，f(q,p)=1；f∘periodicProjection是常光滑函数，但∫|f|² dflat=∞，故不属于L²。
- 原文版 Lean 名称及状态：`MD.Ch06.smoothTestL2Printed`（未证）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：明确要求检验函数属于所选L²空间；给出正确检验函数域定义，不冒称所有C∞函数可积。 ；`MD.Ch06.smoothTestL2Printed_corrected`（定义）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留Printed为原书字面问题记录；另给出修正版实际签名，明确f属于flat L²（并保证平衡态及模式属L²），再陈述完整平均恒等式、CS界和衰减。将“all eigenvalues”勘误为相关非零谱，保留原文。
- 网站审校结论：所交声明 `MD.Ch06.smoothTestL2Printed` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。Printed签名∀n、∀实函数f，提升到欧氏相空间后ContDiff∞便推出flat MemLp 2，忠实暴露原书“光滑即L²”的错误，不因其不可证或sorry判FAIL。它只覆盖本条的一项字面子断言；原文平均恒等式及谱措辞的疑误仍需人工处理。原[ERRATUM?]关于flat常数反例及一般Gibbs下增长反例合理。repair_log称修正版已明示L²域，但实际修正签名未提供，不能确认它是否覆盖完整结论。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

## 34. MD-6.4.5-ComplexInitialDensity

- source_id：MD-6.4.5-ComplexInitialDensity。

### MD-6.4.5-ComplexInitialDensity

- 印刷页 / PDF页：258 / 279。
- 原文引文（逐字）：

> For example, if we assume that $\lambda_1,\rho^{(1)}$ is some eigenvalue, eigenfunction pair with $\operatorname{Re}(\lambda_1)<0$ and take the initial distribution to be
> \[\rho_0=\rho_{eq}+\alpha\rho^{(1)},\]
> for $\alpha\in\mathbb R$, then we have

- 问题所在：仅为给定复L²候选的概率资格辅助定义；本征关系、Reλ<0及平衡态识别须在使用处另列，单一非实模式须共轭配对后再查非负性，不能覆盖任意α的原句。
- 反例或理由：若ρ1在正测度集合有非零虚部且α≠0，则实ρeq+αρ1仍有非零虚部，不能为概率密度；即使ρ1实且积分0，也未必可为任意α保持非负。
- 原文版 Lean 名称及状态：`MD.Ch06.complexInitialDensity`（定义）。原书有疑的字面断言不证明；原有正确子句或定义保留。
- 修正版 Lean 名称、改动内容、证明状态：仅为给定复L²候选的概率资格辅助定义；本征关系、Reλ<0及平衡态识别须在使用处另列，单一非实模式须共轭配对后再查非负性，不能覆盖任意α的原句。；`MD.Ch06.complexInitialDensity_corrected`（定义）
- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。
- 导师选项：保留原句并登记[ERRATUM?]；将此声明定位为概率资格辅助定义，在使用处补生成元本征关系、Re λ<0及真正平衡态识别。非实模式需选共轭成对实组合并另行检查非负性。
- 网站审校结论：所交声明 `MD.Ch06.complexInitialDensity` 的整体 verdict=NEEDS_HUMAN；原文栏=NEEDS_HUMAN。n任意，ρeq、ρ1均为复flat L²等价类，α实数；谓词准确要求平衡候选和初始组合AE实、非负、可积、归一，并未缩为实负λ。α=0不约束ρ1是合理的概率资格行为。作为新增概率资格定义合理，但不证明或表达本征/平衡条件，本征条件在第9条另有编码。原书把单一复模式当概率初始分布的可行性需人工确认；不能把此限制后的谓词当原句对任意α成立的证明。 本轮修改版：待复审；反例：网站正文已讨论，未单列verdict。

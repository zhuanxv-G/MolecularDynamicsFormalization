# 第6章原书疑误与双版本审阅单

教材：B. Leimkuhler 与 C. Matthews，Molecular Dynamics: With Deterministic and Stochastic Numerical Methods，Springer，2015，第6章正文。
页码：PDF物理页从1起数，本章PDF页＝印刷页＋21。原句和原公式逐字保留；修正版是工作建议，均待导师裁定。网站审计尚未提交。
原文版的错误断言不证明；原文公式的定义仅记录表达式。修正版定义、已证定理与未证定理分别标明。第7项属于既有Lean辅助定义缺口，不归因于教材。

## 1. MD-6.1.2-BathTaylor

- source_id：MD-6.1.2-BathTaylor；印刷页 216 / PDF页 237。
- 原文引文（逐字）：

> Since $Z_B(E-s)=\exp(S_B(E-s)/k_B)$, and $s\ll E$, we (naively) apply the mean value theorem to $S_B$ to obtain
> \[S_B(E-s)=S_B(E)-S'_B(\xi)s,\]
> and from $S'_B(\xi)=1/T$, we obtain
> \[Z_B(E-s)\propto\exp(-\beta s).\]

- 问题所在：原书脚注3承认热浴推导不精确；S′(ξ)=1/T通常只能作为大热浴近似，完整精确Boltzmann因子保留字面NEEDS_HUMAN。
- 反例或理由：取S(E)=E²、E=kB=1、β=2、s=1，原两端分别为e⁻¹和e⁻²。
- 原文版 Lean 名称及状态：`MD.Ch06.bathBoltzmannPrinted`：未证；原书疑误不证。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.bathBoltzmannPrinted_corrected`：尚未落盘，不计完成；精确Boltzmann因子增加整个能量区间的恒定熵斜率；一般热浴只保留带余项近似。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 2. MD-6.1.2-CanonicalCDFPrinted

- source_id：MD-6.1.2-CanonicalCDFPrinted；印刷页 216 / PDF页 237。
- 原文引文（逐字）：

> On the other hand the probability for the active system to have energy $\leq\alpha$ is the same as the probability of the bath having energy $\geq E-\alpha$, this must be
> \[P(\alpha)=\Pr\{E_B\geq E-\alpha\}\propto\int_0^\alpha Z_B(E-s)ds.\]
> Thus we have $P(\alpha)\propto\int_0^\alpha\exp(-\beta s)ds$.

- 问题所在：页末能量密度含ZA(α)，此前CDF却省略ZA(s)权重；一般ZA下两归一化CDF不相等。
- 反例或理由：取ZA(s)=1+s、ZB(s)=1、E=1、α=1/2，两边分别为5/12和1/2。
- 原文版 Lean 名称及状态：`MD.Ch06.canonicalCDFPrinted`：未证；原书疑误不证。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.canonicalCDFPrinted_corrected`：尚未落盘，不计完成；能量累计概率的分子分母均保留ZA(s)权重；改为正确累计概率的定义。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 3. MD-6.1.3-FiniteDomainPrinted

- source_id：MD-6.1.3-FiniteDomainPrinted；印刷页 218 / PDF页 239。
- 原文引文（逐字）：

> If $U$ is smooth and the domain $Q$ is finite, then clearly both integrals are well defined, so the normalization is sensible.

- 问题所在：仅有限体积、Q内部光滑不足以排除趋向边界的U→−∞；需要下界、紧域上的连续性或权重可积性。
- 反例或理由：Q=(0,1)、U(q)=log q、β=1，权重1/q不可积；U在Q内光滑且Q体积有限。
- 原文版 Lean 名称及状态：`MD.Ch06.finiteDomainPrinted`：未证；原书疑误不证。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.finiteDomainPrinted_corrected`：尚未落盘，不计完成；将有限体积域内光滑改为紧域上连续，使用紧性保证权重可积。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 4. MD-6.1.4-CanonicalAveragePrinted

- source_id：MD-6.1.4-CanonicalAveragePrinted；印刷页 220 / PDF页 241。
- 原文引文（逐字）：

> Under assumptions on the potential energy as discussed above, and with $\phi$ continuous and allowed to grow at most polynomially fast at infinity, we may proceed to define averages with respect to the canonical density $\rho_\beta$, namely
> \[\operatorname{Av}_\beta(\phi)=Z_{\rm can}^{-1}\int_D\phi(q,p)\rho_\beta(q,p)d\omega.\tag{6.4}\]

- 问题所在：式(6.3)的ρβ已含Zcan⁻¹，式(6.4)再乘一次导致Avβ(1)=Zcan⁻¹，而后文p.221使用标准归一化平均。
- 反例或理由：若Zcan=2，则原Avβ(1)=1/2；概率平均必须为1。
- 原文版 Lean 名称及状态：`MD.Ch06.canonicalAveragePrinted`：定义已落盘；公理/类型已核。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.canonicalAveragePrinted_corrected`：尚未落盘，不计完成；去掉对已经归一化ρβ的第二次Zcan⁻¹；沿用未归一权重乘一次Zcan⁻¹的定义。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 5. MD-6.1.5-PartitionInversePrinted

- source_id：MD-6.1.5-PartitionInversePrinted；印刷页 220 / PDF页 241。
- 原文引文（逐字）：

> The associated canonical density is
> \[\rho_\beta=Z_{\rm can}^{-1}\exp\left(-\beta\left[\frac{p^2}{2m}+U(q)\right]\right),\]
> where
> \[Z_{\rm can}^{-1}=\int_{-\infty}^{\infty}\int_{-\infty}^{\infty}\exp\left(-\beta\left[\frac{p^2}{2m}+U(q)\right]\right)dpdq.\]

- 问题所在：此页印刷Zcan⁻¹=积分，与p.218的Zcan=积分相反；字面保留，标准DensityNormalization仍按真实积分归一化。
- 反例或理由：积分为2时，原式断言1/2=2。
- 原文版 Lean 名称及状态：`MD.Ch06.partitionInversePrinted`：未证；原书疑误不证。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.partitionInversePrinted_corrected`：尚未落盘，不计完成；Zcan定义为积分本身；归一密度的结论另见DensityNormalization，避免把定义重述作新定理。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 6. MD-6.2.1-CoarseMarkovPrinted

- source_id：MD-6.2.1-CoarseMarkovPrinted；印刷页 227 / PDF页 248。
- 原文引文（逐字）：

> Let $A(x)$, $B(x)$ and $C(x)$ be three events dependent on state variable $x$, and let $t_+>t_0>t_-$ be three times, then, for a Markov process $X(t)$ we have (using the notation for conditional probability):
> \[\Pr[A(X(t_+))\mid B(X(t_0)),C(X(t_-))]=\Pr[A(X(t_+))\mid B(X(t_0))].\]

- 问题所在：印刷用任意粗事件B(X(t0))替代完整当前状态的条件σ代数；一般不成立，例如B=univ时过去事件仍可影响未来。
- 反例或理由：令当前粗事件为全集，Brownian过去值与未来值仍相关；粗事件未保留完整当前状态。
- 原文版 Lean 名称及状态：`MD.Ch06.coarseMarkovPrinted`：未证；原书疑误不证。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.coarseMarkovPrinted_corrected`：尚未落盘，不计完成；以完整当前状态生成的σ代数写条件期望Markov性质。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 7. MD-6.2.2-WeakItoAlias

- source_id：MD-6.2.2-WeakItoAlias；印刷页 228–229 / PDF页 249–250。
- 原文引文（逐字）：

> By analogy, we would like to write the stochastic integral of a function $g$, where $g$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:
> \[\sum_{k=0}^{K-1}g(t_k)[W((k+1)\delta t)-W(k\delta t)],\quad K\to\infty.\]
> The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.

- 问题所在：既有Review定义仅要求Y∈L²及误差Bochner积分收敛，未要求各有限和L²，非可积默认积分0会掩盖错误；不得用于新PASS SDE证明。
- 反例或理由：此项是既有Lean辅助定义的缺口，不是教材笔误：非可积函数的默认Bochner积分为0，可能使错误的均方极限成立。
- 原文版 Lean 名称及状态：`MD.Ch06.weakItoAlias`：定义已落盘；公理/类型已核。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.weakItoAlias_corrected`：尚未落盘，不计完成；严格定义要求每个有限和及极限变量均属于L²；正式库冻结，只在Blueprint使用严格版。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 8. MD-6.2.2-Proposition62

- source_id：MD-6.2.2-Proposition62；印刷页 229–230 / PDF页 250–251。
- 原文引文（逐字）：

> Proposition 6.2 Let $\delta t=\tau/K$ then
> \[\operatorname{l.i.m.}_{K\to\infty}\sum_{k=0}^{K-1}[(W((k+1)\delta t)-W(k\delta t))^2]=\tau,\]
> where, for a sequence of random variables, $A_K$ and a random variable $B$, we have
> \[\operatorname{l.i.m.}_{K\to\infty}A_K=B\iff\lim_{K\to\infty}\mathbb E(A_K-B)^2=0.\]
> (This is referred to as convergence in the mean square sense.)

- 原书证明中的相关逐字段落：

> With $\tau,K$ fixed, we have $\delta t=\tau/K$.
> Let $W_{K,k}=W((k+1)\delta t)-W(k\delta t)=W((k+1)\tau/K)-W(k\tau/K)$ and observe that
> \[\sum_{k=0}^{K-1}W_{K,k}^2-\tau=\sum_{k=0}^{K-1}[W_{K,k}^2-\delta t].\]
> Then
> \[I\stackrel{\rm def}=\mathbb E(\sum_{k=0}^{K-1}W_{K,k}^2-\tau)^2=\mathbb E(\sum_{k=0}^{K-1}[W_{K,k}^2-\delta t])^2.\]
> Terms of the form $Z_{K,k}\stackrel{\rm def}=W_{K,k}^2-\delta t$ are independent and have mean zero. Therefore
> \[\mathbb E(\sum_{k=0}^{K-1}Z_{K,k})^2=\mathbb E\sum_{k=0}^{K-1}Z_{K,k}^2-2\mathbb E\sum_{k\ne l}Z_{K,k}Z_{K,l}=\mathbb E\sum_{k=0}^{K-1}Z_{K,k}^2,\]
> where the last equation follows from independence of the increments ($\mathbb E Z_kZ_l=0$ if $k\ne l$).
> Also observe that $\Delta W_k$ is a normally distributed random variable with the following properties
> \[\mathbb E\Delta W_k=0;\quad\mathbb E\Delta W_k^2=\delta t=\tau/K;\quad\mathbb E\Delta W_k^4=3\delta t^2=3(\tau/K)^2.\]
> Thus we have
> \[I=\sum_{k=0}^{K-1}\mathbb E(\Delta W_{K,k}^2-\delta t)^2
> =\sum_{k=0}^{K-1}\mathbb E[\Delta W_{K,k}^4-2\delta t\Delta W_{K,k}^2+\delta t^2]
> =\sum_{k=0}^{K-1}[3\delta t^2-2\delta t^2+\delta t^2]=2K\delta t^2=2\tau^2/K.\]
> Thus $I\to0$ as $K\to0$, which is the desired result.

- 问题所在：印刷证明的独立交叉项展开带负号；平方展开应正号，见单独疑误条。 原书p.230末句印刷ν→0，实际应为ν→∞。
- 反例或理由：有序交叉和应系数+1；若仅遍历k<l，则为+2。原写−2且遍历k≠l。独立中心变量的交叉期望恰好为0，故最终结论不受影响。另p.230末句ν→0应为ν→∞。
- 原文版 Lean 名称及状态：`MD.Ch06.proposition62Printed`：尚未落盘，不计完成。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.proposition62_corrected`：尚未落盘，不计完成；保持已证二次变差结论；独立记录印刷平方展开与其正确代数式，并注明极限方向。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 9. MD-6.2.2-DeterministicStrobePrinted

- source_id：MD-6.2.2-DeterministicStrobePrinted；印刷页 231 / PDF页 252。
- 原文引文（逐字）：

> Finally, we observe that by calculating $\sigma^2(t_n)$ and generating random increments $R_n\sim N(0,\sigma(t_n))$ we have a discrete representation of the continuous time stochastic process $Y(t_n)$, effectively an exact stroboscopic representation.

- 问题所在：生成增量使用σ(tn)而非相邻时刻方差差；单时边际法则也不能确定同一过程联合分布。保持印刷式，不以独立边际偷换过程。
- 反例或理由：若g≡1，区间[tₙ,tₙ₊₁]增量方差应为tₙ₊₁−tₙ，不能使用累计到tₙ₊₁的方差或把标准差当方差参数。
- 原文版 Lean 名称及状态：`MD.Ch06.deterministicStrobePrinted`：未证；原书疑误不证。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.deterministicStrobePrinted_corrected`：尚未落盘，不计完成；采用区间积分∫[tₙ,tₙ₊₁]g²及同一过程的独立增量资格。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 10. MD-6.3.1-DiffusiveTaylorPrinted

- source_id：MD-6.3.1-DiffusiveTaylorPrinted；印刷页 233 / PDF页 254。
- 原文引文（逐字）：

> Now we expand the 2nd order term and, working in the diffusion limit, recognize that $\delta x^2\approx\delta t$, thus we have
> \[\delta\phi=\phi'(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)+\tfrac12\phi''(X_n)b(X_n,n\delta t)^2\delta t+O(\delta t^{3/2}).\]

- 问题所在：C² Taylor余项仅o(h²)，不能自动提升为O(h³)；在h≈√δt时原O(δt³⁄²)需要更高阶正则性。
- 反例或理由：φ(x)=|x|^(5/2)在0为C²；a=0,b=1时余项为dt^(5/4)，不是O(dt^(3/2))。
- 原文版 Lean 名称及状态：`MD.Ch06.diffusiveTaylorPrinted`：未证；原书疑误不证。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.diffusiveTaylorPrinted_corrected`：尚未落盘，不计完成；C²加强为C³，使三阶Taylor余项与扩散缩放匹配。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 11. MD-6.3.1-TimeItoFormula

- source_id：MD-6.3.1-TimeItoFormula；印刷页 234 / PDF页 255。
- 原文引文（逐字）：

> We also mention that the Itô-Doeblin formula can be easily generalized to functions of the form $\phi(x,t)$:
> \[d\phi(X,t)=\phi_t(X,t)+\phi_x(X,t)(a(X,t)dt+b(X,t)dW)+\tfrac12\phi_{xx}(X,t)b(X,t)^2dt.\tag{6.18}\]

- 问题所在：印刷φ_t(X,t)项漏dt，字面微分式不具一致类型；补dt需要网站审计裁定。
- 反例或理由：取φ(x,t)=t，原右端留下常数1而非微分dt；修正公式应为dφ=dt。
- 原文版 Lean 名称及状态：`MD.Ch06.timeItoFormulaPrinted`：尚未落盘，不计完成。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.timeItoFormula_corrected`：尚未落盘，不计完成；原文右端以形式微分占位量记录，时间偏导补dt；完整修正积分公式独立命名。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 12. MD-6.3.2-OULawPrinted

- source_id：MD-6.3.2-OULawPrinted；印刷页 235 / PDF页 256。
- 原文引文（逐字）：

> The solution with equivalent distribution is therefore
> \[X(t)=e^{-\gamma t}X(0)+\sigma\sqrt{(2\gamma)^{-1}}(1-e^{-2\gamma t})\widehat Y(t).\]
> where $\widehat Y(t)$ should be interpreted as random process which at every time $t$ evaluates to a normal random variable ($\widehat Y(t)\sim N(0,1)$). This is what we mean by the exact distributional solution of the Ornstein-Uhlenbeck SDE with prescribed initial value $X(0)$.

- 问题所在：原页根号只覆盖(2γ)⁻¹，(1−e⁻²γt)漏在根号内；方差因此被错误平方。单时分布等价不确定整个过程耦合。
- 反例或理由：令1−e^(−2γt)=1/2，原噪声项方差多乘1/2。
- 原文版 Lean 名称及状态：`MD.Ch06.ouLawPrinted`：未证；原书疑误不证。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.ouLawPrinted_corrected`：尚未落盘，不计完成；把整个(1−e^(−2γt))/(2γ)放入根号；只断言同一OU过程的单时刻法则。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 13. MD-6.3.3-BathForcePrinted

- source_id：MD-6.3.3-BathForcePrinted；印刷页 237 / PDF页 258。
- 原文引文（逐字）：

> where we define
> \[f(t)=-k^{-1}\sum_{i=1}^k[\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i-\cos(\Omega_i t)Q(0)].\]

- 问题所在：印刷f含负k⁻¹，而(6.29)写+f；从(6.23)代入振子解得到正k⁻¹合力。
- 反例或理由：将(6.26)代回(6.23)，初值项为+k⁻¹Σ[(qᵢ(0)−Q(0))cos+…]；原f定义却有负号。
- 原文版 Lean 名称及状态：`MD.Ch06.bathForcePrinted`：定义已落盘；公理/类型已核。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.bathForcePrinted_corrected`：尚未落盘，不计完成；选择正的初值合力f，使(6.29)保留+f；等价选项是保留原f并将(6.29)改为−f。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 14. MD-6.3.3-BathReductionPrinted

- source_id：MD-6.3.3-BathReductionPrinted；印刷页 237 / PDF页 258。
- 原文引文（逐字）：

> \[\dot P=-U'(Q)+f(t)-\int_0^t\psi(t-s)P(s)ds.\tag{6.29}\]
> \[f(t)=-k^{-1}\sum_{i=1}^k[\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i-\cos(\Omega_i t)Q(0)].\]

- 问题所在：原负f与+f约化式符号冲突；保留完整字面卷积方程。
- 反例或理由：同上一项：原定义f为负合力，却在约化方程中加f。
- 原文版 Lean 名称及状态：`MD.Ch06.bathReductionPrinted`：未证；原书疑误不证。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.bathReductionPrinted_corrected`：尚未落盘，不计完成；使用从原Hamilton方程实际代入所得的正合力卷积方程。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 15. MD-6.3.3-MemoryKernelDeltaMeaning

- source_id：MD-6.3.3-MemoryKernelDeltaMeaning；印刷页 238 / PDF页 259。
- 原文引文（逐字）：

> If sufficient high frequency components are present, then the mass of the memory kernel is typically found to be localized around 0; in such a situation of rapid decay it is found that one may replace the function $\psi$ by a Dirac delta function scaled by a positive coefficient $\gamma$; we say that the system is Markovian or memory-less in this situation and we replace the delay-differential equation (6.29) by the SDEs
> \[dQ=Pdt;\tag{6.30}\quad dP=-U'(Q)dt+\sigma dW-\gamma Pdt.\tag{6.31}\]

- 问题所在：原“sufficient high frequency/typically”没有给频率序列、归一化、热浴初值法则及白噪声弱收敛资格，不能声明任意热浴自动满足δ极限。
- 反例或理由：不限制频率与权重时，可选全部频率固定，余弦记忆核不会自动成为Dirac分布。
- 原文版 Lean 名称及状态：`MD.Ch06.memoryKernelDeltaMeaning`：定义已落盘；公理/类型已核。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.memoryKernelDeltaMeaning_corrected`：尚未落盘，不计完成；仅给分布收敛的精确定义，并明确正质量资格；不声称任意热浴满足该极限。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 16. MD-6.3.3-BathForceWeakLimitMeaning

- source_id：MD-6.3.3-BathForceWeakLimitMeaning；印刷页 237–238 / PDF页 258–259。
- 原文引文（逐字）：

> For large $k$ and for many choices of the frequencies $\Omega_i$ and the initial conditions $\{q_i(0);p_i(0)\}$, function $f(t)$ will take on the character of a Wiener process; in fact the convergence can be shown in the weak sense. We may even take the initial conditions to be randomly distributed [13,205].

- 问题所在：原many choices没有给热浴初值法则/频率条件/拓扑；此处f像Wiener process、下页f(t)作为Wiener increment还存在力与积分过程的类型疑问。
- 反例或理由：光滑有限热浴力的极限应区分白噪声与其时间积分Wiener过程；无初始化法则和谱条件不能指定普适法则。
- 原文版 Lean 名称及状态：`MD.Ch06.bathForceWeakLimitMeaning`：定义已落盘；公理/类型已核。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.bathForceWeakLimitMeaning_corrected`：尚未落盘，不计完成；将与Wiener过程比较的对象改为时间积分后的热浴力；仍只定义极限意义。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 17. MD-6.3.6-FPDiffusionPrinted

- source_id：MD-6.3.6-FPDiffusionPrinted；印刷页 242 / PDF页 263。
- 原文引文（逐字）：

> With two rounds of integration by parts on the term involving $b(x)$, we find, using the fact that the boundary terms vanish,
> \[\int_{-\infty}^{+\infty}b^2(x)\phi''(x)\rho(x,t)dx=-\int_{-\infty}^{+\infty}\phi(x)(b^2(x)\rho)_{xx}dx.\]

- 问题所在：原页两次IBP后仍打印负号；正确应正号，且(6.39)最终算子已经使用正号。
- 反例或理由：两次分部积分产生正号。取b=1，ρ与紧支φ使二阶导配对非零，负号将其错误取反。
- 原文版 Lean 名称及状态：`MD.Ch06.fpDiffusionPrinted`：未证；原书疑误不证。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.fpDiffusionPrinted_corrected`：尚未落盘，不计完成；仅将两次分部积分后的外负号改为正号，保留原C²和紧支资格。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 18. MD-6.3.6-FPPolynomialAdjoint

- source_id：MD-6.3.6-FPPolynomialAdjoint；印刷页 241–242 / PDF页 262–263。
- 原文引文（逐字）：

> We assume that $\rho$ is $C^\infty$ for all $t$ and that the density tends to zero exponentially fast as $x\to\pm\infty$, whereas $a$ and $b$ are $C^\infty$ functions which grow at most polynomially fast in these limits.
> \[\langle\mathcal L\phi,\rho\rangle=\langle\phi,\mathcal L^*\rho\rangle.\]

- 问题所在：原只给函数值尾部增长而未约束导数；完整IBP及边界消失需技术资格，已全部明示，不静默添加。
- 反例或理由：函数值的多项式增长不控制全部导数；可取振荡频率快速增长的有界光滑函数。
- 原文版 Lean 名称及状态：`MD.Ch06.fpPolynomialAdjointPrinted`：尚未落盘，不计完成。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.fpPolynomialAdjoint_corrected`：尚未落盘，不计完成；显式约束所需导数的多项式增长和密度导数的指数衰减。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

## 19. MD-6.3.3-VariableFrictionCanonicalPrinted

- source_id：MD-6.3.3-VariableFrictionCanonicalPrinted；印刷页 239 / PDF页 260。
- 原文引文（逐字）：

> However, it should be noted that in many types of modelling, the physical nature of the interaction with the solvent bath is neglected and $\gamma$ or $\Gamma(q)$ are simply viewed as artificial parameters which allow recovery of averages with respect to the canonical distribution.

- 问题所在：任意ΓΓᵀ与对角质量不交换时，印刷漂移ΓΓᵀp与噪声M½Γ不自动满足Gibbs涨落耗散平衡；原canonical目标不能推广为任意质量/任意矩阵全称定理。
- 反例或理由：M与A=ΓΓᵀ不交换时，A M⁻¹和M⁻¹/² A M⁻¹/²不同；例如M=diag(1,4)、Γ=(1,1)ᵀ。
- 原文版 Lean 名称及状态：`MD.Ch06.variableFrictionCanonicalPrinted`：未证；原书疑误不证。原文文字和完整展示式见上；启发式极限只登记其意义，不声称一般热浴已满足。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch06.variableFrictionCanonicalPrinted_corrected`：尚未落盘，不计完成；增加ΓΓᵀ与质量矩阵M交换条件；另一个可选修法是修改漂移以匹配噪声协方差。
- 待人工核查点：核对原页上下文是否补足所缺条件，以及上述修法是否符合作者意图；特别区分实际过程、形式微分算子和概率密度。
- 导师选项：采用本条明确修正版 / 指定另一组充分条件或测度坐标 / 只保留原文疑误；默认并列展示上述修正版，等待导师确认。
- 网站复审结论：未提交，全部待审；不把本地检查计作网站通过。

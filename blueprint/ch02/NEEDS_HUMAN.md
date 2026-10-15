# 网站NEEDS_HUMAN分流

原始返回和完整理由见website_audit.json；以下问题未替导师作数学选择。

## (i) 材料缺失：补材料后复审

- MD-2.3.7-FlowSelfAdjoint：补充绑定版本Mathlib的Flow结构及Flow.toHomeomorph实际定义（含正向、逆向和群作用律）；据此核验负时间逆后重审，无需先修改定理或补证明。

## (ii) 原文数学判断：供导师裁定

- MD-2.2.1-Admissible：闭区间容许曲线采用C²还是C∞，并用哪种延拓解释？选项：C²区间资格 / C∞存在光滑延拓。
- MD-2.4.5-ConjugateLimits：equivalent stability properties是否包含一般稳定性的双向等价？选项：完整稳定性 / 仅共同极限例子。

## EAUDIT03 原文数学判断（保持现状）

- MD-2.2.1-Admissible：原页先说C²后又说C∞，曲线类采用哪种区间光滑资格？选项：C²区间／C∞可延拓类；现有全线代表资格保持，待裁定。 网站反例：n=1，q(t)0=|t−1/2|³ 在 [0,1] 为 C²，端点均为1/8，却不是 C³，因而能区分原页前后两种资格；另 q(t)0=|t−2| 在 [0,1] 等于2−t，局部光滑且端点2、1，却在全线不光滑，因而不能满足当前 ContDiff ℝ ∞ q。这不排除该区间限制另有光滑延拓。; 原返回NEEDS_HUMAN保留。
- MD-2.2.1-StationaryNotMin：脚注的极小/极大/鞍点及第二变分采用哪种曲线空间与拓扑？选项：导师指定C∞空间和范数后补全部分类／明确拆分脚注与既有EulerLagrange条目；原页未给拓扑，保留现状，不自行选一致范数。 网站反例：缺失条款本身足以判 FAIL。可作修复子命题的正质量光滑例：将 Q 1 识别为 ℝ，L(x,v)=(v²−ω²x²)/2，ω>π，q(t)=0。所有零端点 C² 方向的一阶作用量导数在0为0；η(t)=c sin(πt)，0<|c|<δ，使 action 差=c²(π²−ω²)/4<0。该例验证存在子命题可以为真，但不能补足所引三句的其他结论，也不是对该存在命题的反例。; 原返回FAIL保留。

## EAUDIT04 原文数学判断（保持现状）

- MD-2.2.2-DiscreteAction：原页正文机械L写+U，而展示离散作用量写−U；选项：批准以展示式−U另立修订／保留两种原印并只登记一般L。此处不自行选择符号勘误，原一般定义保持。 网站反例：展开 deps:2816、2844–2847：Q为实坐标空间，discreteVelocity的第i坐标为相邻差除h，Finset.range ν为0至ν−1，h*L与原文L*h相等，因此一般L的求和定义正确。但本条statement_scope包含机械作用量展示式，而bp_discreteAction只有一般L求和，未陈述机械式。deps:2842–2843 的 mechanicalL = (∑i m_i v_i²)/2−U(q) 确实支持展示式的−U模型，却没有作为本条的等式结论。原文Riemann近似亦仅被定义右端和式，未表达近似/极限；原文未给误差界，不能擅加具体阶数。保留的[ERRATUM?]成立于已沿用A证据：正文带点v及+U与展示式和前节−U不一致；选择一般L不能补全本条机械子句。该定义无sorry，FAIL来自结论覆盖不足。; 原返回FAIL保留。

## EAUDIT05 原文数学判断（保持现状）

- MD-2.2.3-DefectPrinted：原印Q−q(t+h)三阶项符号与Taylor相减不符；选项：批准另立正残差修正版／保留原印作为疑误。原负/正号不自行裁定，当前字面陈述保持。 网站反例：取 F(x)=x，γ(t)=(sinh t,cosh t)。F 为 C∞ 且 γ′(t)=(cosh t,sinh t)=((γ t).2,F((γ t).1))，全部假设成立。γ(0)=(0,1)，正式 scalarVerlet 给 (Q,P)=(h,1+h²/2)。位置残差为 h−sinh h−h³/6=−h³/3+O(h⁵)，除以 h⁴ 的绝对值无界，非 O(h⁴)。动量残差 1+h²/2−cosh h 为 O(h⁴)，不影响第一合取项的失败。; 原返回FAIL保留。

## EAUDIT06 原文数学判断（保持现状）

- MD-2.2.4-IntegralErrorPrinted：原印KB/(2L)比已给点误差推出的KB/L小一半；选项：批准另立去掉2的修正版／导师提供独立更强误差前提；保持原印和常数，不加倍K、不把积分误差当假设。 网站反例：取 n=1，I(q)=q 0，D=univ，B=3/2，K=L=1，h=1/2，p=1，k=0，a=fun _=>1/2，b=fun _=>0。I 为C∞、导数算子范数1<B，所有假设成立，先前误差界为1/2≤1/2，但结论为1/2≤3/8，假。即使添加 hbar=1、h<hbar、p>0，仍是反例。这是实际签名的点界反例，不声称来自满足原书全部方法假设的数值轨迹。; 原返回FAIL保留。

## EAUDIT07 原文数学判断（保持现状）

- MD-2.3.1-VariationalPrinted：原印变分矩阵在移动点取空间Jacobian，链式法则多项；选项：批准固定初值ζ版本／保留移动点并重写全部右侧；当前字面式及ERRATUM保持，不自行勘误。 网站反例：取 n=1，以 Q 1≅ℝ 识别。令 g(u)=u+u³，k=g⁻¹。g′=1+3u²>0，且 g 为满射，故 k 全局 C∞。设 f(x)=1+3k(x)²，Φ(t,x)=g(k(x)+t)，τ=1，ζ=0。Φ 联合 C∞、Φ(0,x)=x，∂tΦ=g′(k(x)+t)=f(Φ(t,x))，对全实线成立，因此满足 flowC1。Φ(t,0)=g(t)，W(t)=∂xΦ(t,g(t))=g′(2t)/g′(t)=(1+12t²)/(1+3t²)。W′(t)=18t/(1+3t²)²，Df(Φ(t,0))=6t/(1+3t²)。在 t=1/2∈(0,1)，W=16/7、W′=144/49，而 Df·W=192/49；W′/W=9/7，而 Df=12/7。两个合取子句均不成立，W 此时非零。; 原返回FAIL保留。

## EAUDIT08 原文数学判断（保持现状）

- MD-2.3.2-EulerVolumePrinted：原印体积保存等价det=1遗漏绝对值；选项：批准|det|=1勘误／明确正行列式的小步长限制；保持原印，负行列式反例交导师。 网站反例：n=1，S=[-2]，h=1，则linearEuler S h=[-1]。映射x↦-x保存每个可测集合的Lebesgue体积，故左边为真；行列式=-1，右边为假。即使另加trace S=0：S=diag(-2,2)、h=1/√2时det(I+hS)=1-4h²=-1，同样反例。; 原返回FAIL保留。

## EAUDIT10 原文数学判断（保持现状）

- MD-2.3.4-HamiltonVariationalPrinted：原印W在移动点取Jacobian；选项：批准固定ζ并用联合C²流的正式定理／保留移动点且补完整链式右侧；原印保持，不自行裁定。 网站反例：取Nc=1，f(q)=2+sin q，H(q,p)=p f(q)。令Q_t(q)为q̇=f(q)的全局流（f光滑有界且1≤f≤3），定义Φ_t(q,p)=(Q_t(q), p f(q)/f(Q_t(q)))。它是全局C∞真实Hamilton流、Φ₀=id，满足全部前提。ζ=(0,0)，W(t)=DΦ_t(Φ_t(ζ))的(q,q)项a(t)=f(Q_{2t}(0))/f(Q_t(0))，且W的(p,q)项为0。直接求导a′/a=2cos(Q_{2t}(0))−cos(Q_t(0))；宣称右侧JHzz(Φ_t(ζ))W的(q,q)项除以a却为cos(Q_t(0))。取τ=1/4、t=1/8，则0<Q_t(0)<Q_{2t}(0)≤3/4<π，余弦严格递减，二者不等。这一反例直接适用于附件已核实的J符号、坐标及导数定义。; 原返回FAIL保留。

## EAUDIT11 原文数学判断（保持现状）

- MD-2.3.5-GlobalGroupPrinted：非退化局部Jacobian不足推出全球双射；选项：批准另立全球辛微分同胚群／将原文全球可逆及群主张整体登记疑误；现有字面式保持。 网站反例：取 n=1，将 z(Sum.inl 0)=q、z(Sum.inr 0)=p。设 a(q)=q+sqrt(1+q²)，b(q)=a′(q)=1+q/sqrt(1+q²)>0，定义 Φ(q,p)=(a(q),p/b(q))。这是 R² 上 C∞ 自映射，其实际导数矩阵为 [[b,0],[-p b′/b²,1/b]]，其中 b′=(1+q²)^(-3/2)，故 det DΦ=1，且对正式 J=[[0,1],[-1,0]] 有 DΦᵀ J DΦ=J，满足展开后的 IsTextbookSymplecticMap。a 是 R 到 (0,∞) 的双射，因此 Φ 的像为 (0,∞)×R，漏掉 (0,0)，不是满射，Function.Bijective Φ 为假。该反例直接匹配正式坐标空间与 C¹ 条件，不依赖缺失定义。; 原返回FAIL保留。

## EAUDIT16 原文数学判断（保持现状）

- MD-2.4.2-CompositionOrder：原文typically及高于min的例子未被当前下界覆盖，且局部阶逐点常数不能直接用于移动初值；选项：导师确定通常/确切阶的范围后补邻域一致阶及辛Euler→Verlet严格升阶实例／将本条完整拆分并交叉映射现有Verlet条目。当前签名保持，不能把下界静默当作整句。 网站反例：缺失结论条款而非已建立的定理反例：原文“but it can be higher, as the example of the Verlet method (constructed by composing symplectic Euler and its adjoint) shows”没有对应Lean结论。min阶下界即使成立，也不能推出存在一对方法使复合确切阶严格高于两者最小确切阶。; 原返回FAIL保留。

## EAUDIT19 原文数学判断（保持现状）

- MD-2.4.5-ConjugateLimits：equivalent stability是否包括Lyapunov稳定/吸引性双向等价，还是仅随后共同极限例子，需确定范围；选项：补指定稳定性定义及等价／批准缩为共同极限例子。当前已证签名保持。 网站反例：展开 textbookConjugateMap 后，签名的具体收敛命题忠实：先固定共同极限zStar，再假设∀z，B^[k] z→zStar，最后∀z，A^[k] z→χ⁻¹zStar。B轨道应从χ z出发；全称hB使这一换初值合法。ProcessedMethods.lean 的 textbook_conjugate_iterates_tendsto_iff（合集:1672附近）确实给对应初值和对应极限的双向收敛，并利用χ及χ⁻¹的连续性。所有实际用到的项目定义已找到，缺的不是库定义。需要数学判断的原文问题是 statement_scope 中“equivalent stability properties under iteration”是否只指随后给出的全局共同极限例子，还是还要求一般Lyapunov稳定性、吸引性等性质的双向等价；签名仅明确形式化随后例子的单向结论，没有这些一般稳定性谓词。若来源范围只限该例子可判PASS；若包含一般稳定性断言则缺条款。无[ERRATUM?]；本地与所引收敛定理均无sorry。; 原返回NEEDS_HUMAN保留。

## EAUDIT20 原文数学判断（保持现状）

- MD-2.5.1-RKSymplectic：任意可约Butcher表的系数必要性有反例；选项：批准只保留充分方向／指定不可约等资格后保留必要性。当前iff及原文不擅改。 网站反例：取s=2、A=0、b=(1,−1)。对任何n,H,h和满足关系的阶段，两阶段均等于X_H(z)，输出必为G(z)=z。因此右侧普适命题成立：恒等映射C¹且Jacobian=I，IᵀJI=J。左侧i=j=0时为0=1，失败。即使补一致性也不足：A四项均1/4、b=(1,0)，重复阶段化为中点法而系数条件在首个对角项为1/2=1。; 原返回FAIL保留。
- MD-2.5.1-GaussFamily：原文even order需区分确切有限阶与偶数阶下界，原全步长唯一分支资格也过强；选项：批准局部唯一分支上的至少2s阶／定义最高有限阶后证明确切阶偶性。需先确定数学范围，当前声明保持。 网站反例：范围反例：n=s=1、c=1/2、f(x)=x，精确流F(t,z)=e^t z全局光滑。h=2,z≠0时阶段方程K=z+K无解，因而被全实h的唯一可解前提排除；这不是条件定理为假的反例。结论缺失：methodLocalOrder是下界，未加入¬methodLocalOrder G F (r+1)，无法得到确切阶为偶数。; 原返回FAIL保留。

## EAUDIT22 原文数学判断（保持现状）

- MD-2.5.3-NewmarkReduction：原印一般质量公式不能推出Verlet，正质量仍有反例；选项：导师批准m≡1限制／另立质量因子修正版newmarkMassCorrected，保留原印与反例。 网站反例：n=1；m(0)=2；F(q)(0)=1（来自光滑势能U(q)=-q(0)）；h=1；z=(0,0)；w=(1/2,1)，各数视作单坐标向量。newmarkRelation m F (1/2) 0 h z w为真；invMass m F=1/2，verlet m F h z=(1/4,1)，因此右侧为假。质量严格为正。; 原返回FAIL保留。
- MD-2.5.3-NewmarkNotSymplectic：非辛反例未覆盖插值位置处力构造的相关辛方法族，原页只给定性构造并引用395；选项：核对395后指定插值参数及更新关系／导师批准另列独立构造条目。现有反例签名保持，不凭空选择方法族。 网站反例：缺失结论条款：a related family of symplectic methods can be constructed by replacing interpolated forces by forces evaluated at interpolated positions。存在一个非辛Newmark求解映射不会给出任何相关辛方法族或其构造。; 原返回FAIL保留。

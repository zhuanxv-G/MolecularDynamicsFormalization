# 第3章原书疑误与双版本审阅单

教材：B. Leimkuhler 与 C. Matthews，Molecular Dynamics: With Deterministic and Stochastic Numerical Methods，Springer，2015。
页码采用原PDF从1起算的物理页。以下为工作勘误及资格补充，尚未经导师或作者裁定。定义、原有正确的数学子句和原书字面疑误分别保留；编译通过不表示未证命题已经成立。
原文引文沿用已逐页核对的来源记录；本轮网站返回保留其原有版本及判定。原有声明可能已经是限定解释或修正版，须按网站正文确定PASS的对象；本轮新增或修改版本均未再次送网站。
共30项问题，涉及43个source\_id。同一问题的多条来源已合并；各来源原文、版本和网站判定仍分别列出。

## 1. MD-3.1-ShadowEllipses

- source\_id：MD-3.1-ShadowEllipses。

### MD-3.1-ShadowEllipses

- 印刷页 / PDF页：99 / 121。
- 原文引文（逐字）：

> Recall that the graph of

$$
\frac{x^2}{a^2}+\frac{y^2}{b^2}=1
$$


> is an ellipse with major and minor axes aligned to the coordinate axes. If $\epsilon$ is a small value, then

$$
\frac{x^2}{a^2}+\frac{y^2}{b^2}+\epsilon xy=1
$$


> will be a slightly rotated ellipse (with slightly different major and minor axes). Thus we can think of the energy surface of the numerical method as being a small perturbation of the ellipse which represents the ‘energy surface’ (energy curve, in this case) of the harmonic oscillator itself.

- 问题所在：所有相关自定义对象均已在依赖中找到并展开，没有缺失定义。Ch03.lean:52–64 的第一项是 ∀a,b≠0 后 ∃δ>0、∃θ,A,B（均为 ε 的函数），A→|a|、B→|b|，对每个 |ε|<δ 有正半轴和对全部 x,y 成立的实际正交旋转恒等式，确实覆盖一般椭圆及半轴长度的小扰动，不是仅振子特例。第二项展开 oscillatorShadow 得矩阵 [[Ω²,hΩ²/2],[hΩ²/2,1]]；[EXTRA] Ω>0 是正频率约定（数学上 Ω≠0 已足够），|hΩ|<2 正是正定性的必要充分步长条件，合理且未假设结论。L 是真实实线性等价，表达正定二次型标准化。对 E>0，令 x=q、y=p、a=√(2E)/Ω、b=√(2E)、ε=hΩ²/(2E)，一般合取项即给出影子能量水平集和 h→0 的形状扰动，此联系能从现有定义推得，不能据“未统一”报材料不足。真正需要人工裁定的是原书“slightly rotated”含义：签名只断言旋转存在，未要求 θ(ε)→0；当 a²=b² 时原曲线是圆，原始主轴无唯一方向，而微小交叉项选择的轴相对于固定坐标轴可以是45°。需确认作者仅指曲线形状接近，还是在非圆条件下还要求小角度变化。原书未明确，这个原文问题是本条 NEEDS\_HUMAN 的唯一原因。本条没有 [ERRATUM?] 标注，疑点已另行记录；有 sorry，只表示证明未完成，与上述签名审计分开判断。 网站原文审校另记：
- 反例或理由：退化例：a=b=1、0<ε<2 时，x²+y²+εxy=(1+ε/2)((x+y)/√2)²+(1−ε/2)((−x+y)/√2)²。可取 θ=π/4、A=(1+ε/2)^(-1/2)、B=(1−ε/2)^(-1/2)；ε→0 时 A,B→1，但相对于固定坐标轴 θ 不趋于0。此例区分形状小扰动与小旋转角，并非否定原书椭圆结论。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.shadowEllipses`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.shadowEllipses_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：若原书只指形状小扰动，现签名的两合取项可以保留，并补写 E>0 的变量对应说明。若要求小旋转角，则在 a²≠b² 分支加入 Tendsto θ (𝓝 0) (𝓝 0) 或等价的主轴方向收敛，单独处理圆形退化。应先确认这项原文语义，不可静默在原文补非圆条件或删改“slightly”。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.shadowEllipses。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 2. MD-3.2-FiniteLieTaylor

- source\_id：MD-3.2-FiniteLieTaylor。

### MD-3.2-FiniteLieTaylor

- 印刷页 / PDF页：101 / 123。
- 原文引文（逐字）：

> The Taylor series expansion of $\phi(\boldsymbol z(t))$ along a solution of the differential equation can therefore be written as

$$
\phi(\boldsymbol z(t))=\phi(\boldsymbol z(0))+t(\mathcal L_f\phi)(\boldsymbol z(0))+\frac{t^2}{2}(\mathcal L_f^2\phi)(\boldsymbol z(0))+\cdots.
$$



- 问题所在：相关自定义定义均已找到，不存在缺失定义。已展开 Ch03\_deps.txt 的 -- FILE: MolecularDynamics/Chapter02/ReviewDefinitions.lean 中 Q n=Fin n→ℝ，以及 -- FILE: MolecularDynamics/Chapter03/LiePoisson.lean 中 L\_fφ(z)=Dφ(z)[f(z)]；-- FILE: MolecularDynamics/Chapter03/Statements.lean 的 lieTaylor\_statement 与 Ch03.lean 此签名相同。量词是先任取 n、k、f、φ、γ，给出全域C∞和∀t真实ODE条件，再存在依赖这些数据及k的C>0、δ>0，对所有|t|<δ给出从j=0到k、在γ(0)评价的余项界；不是一个C、δ对所有k统一成立，也没有把余项界当前提。此实际有限Taylor结论数学上合理，不需要analytic或无限级数收敛；全域光滑、全时间解比局部所需资格强。原文需要数学判断的问题明确为：PDF p.123 的实际函数等号随后被声明按formal series解释，是否允许以新增的每一有限阶实际O(|t|^(k+1))估计，作为该形式等号的完整替代陈述。原页没有这种定量不等式，而 [EXTRA] 中的余项界其实是新增结论、不是额外假设；仅“此估计为真”不足以自动认可 source-to-signature 的替代范围。本批已有的严格化待裁定问题因此保留为 NEEDS\_HUMAN。若接受全阶Taylor jet／渐近展开解释，可接受该签名作为严格版本；若要求只对应原句的形式系数，应单列形式系数与沿解时间导数的等式，将此余项定理列作辅助结果。不能据光滑性把原式静默改成实际收敛的无限和；本条没有 [ERRATUM?] 标记，本审查也不修改原书。证明状态独立记录：Ch03.lean 的 lieTaylor 函数体为 sorry；这是未完成证明，既不是此语义待裁定的理由，也不提供数学验证。 网站原文审校另记：
- 反例或理由：以下仅反驳把原文读成实际函数等于其无限Taylor和，不是lieTaylor余项界的反例：n=1，f(x)=1，γ(t)=t，φ(0)=0、φ(x)=exp(-1/x²)（x≠0）。f、φ光滑且γ是全局实际解；所有(L\_f^jφ)(0)均为0，但φ(γ(t))在t≠0时正值。形式Taylor级数为0，不能靠该级数恢复实际观测量；各有限阶O(|t|^(k+1))估计仍成立。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.lieTaylor`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.lieTaylor_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：明确裁定原文等号采用Taylor jet／全阶渐近意义还是仅采用形式系数定义。采用前者时保留此签名，并将“余项不等式”从额外假设说明移到新增严格化结论说明；采用后者时将该声明与原文源条目分开，另列第j阶时间导数等于(L\_f^jφ)(γ(0))及其形式级数系数的陈述，把现有有限余项界保留为辅助定理。两种方案都不增加无限和等于实际函数的主张。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.lieTaylor。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 3. MD-3.2-FlowCoordinates

- source\_id：MD-3.2-FlowCoordinates。

### MD-3.2-FlowCoordinates

- 印刷页 / PDF页：101 / 123。
- 原文引文（逐字）：

> This gives a concise formula for the evolution of any function of the phase variables, including, in particular, any solution component $z_i$. Thus the flow map of the system can be represented by $\exp(t\mathcal L_f)$. When one writes $\mathcal F_t=\exp(t\mathcal L_f)$, what is actually meant is that the individual components satisfy

$$
z_i(t,\boldsymbol\zeta)=[\mathcal F_t(\boldsymbol\zeta)]_i=\left.(\exp(t\mathcal L_f)z_i)\right|_{\boldsymbol z=\boldsymbol\zeta}.
$$



- 问题所在：相关自定义定义均已找到。已展开 Ch03\_deps.txt 的 -- FILE: MolecularDynamics/Chapter02/ReviewDefinitions.lean 中 Q n=Fin n→ℝ、-- FILE: MolecularDynamics/Chapter03/ReviewDefinitions.lean 中 formalObservable 的系数 ((L\_f)^[j]φ)(ζ)/j!，以及 -- FILE: MolecularDynamics/Chapter03/Statements.lean 中 actualFlow：0<η，且对每个ζ∈D有Φ(0,ζ)=ζ，对每个|t|<η有Φ(t,ζ)∈D并具有真实导数 f(Φ(t,ζ))。所以初值和真实ODE资格没有遗漏，也没有用形式流或目标余项代替实际流。坐标观测量φ(z)=z\_i的选取正确，常数项是ζ\_i；系数乘t^j、截至j=k，其评价点和阶数与形式exp作用于坐标一致。量词为任取n、k、f、D、Φ、η，在光滑f和actualFlow之后任取ζ∈D和i，再存在可依赖ζ、i、k的C>0、δ>0且δ≤η，界对所有|t|<δ成立；没有对所有初值、坐标、阶数的共同余项常数。该局部实际估计数学上合理，但全域C∞、共同η和D内不离域是显式选用的局部流框架，不是原文给出的全部全局流数据。[EXTRA]中的有限余项是新增结论；没有本条 [ERRATUM?]。需要数学判断的具体原文问题是：页上 z\_i(t,ζ)=[F\_t(ζ)]_i=(exp(tL\_f)z\_i)|_(z=ζ) 的实际流与形式算子的连接，在原书不讨论收敛的条件下应怎样精确解释；是否接受每个初值处、任意有限阶的局部渐近估计作为此源等式的完整对应。此签名未直接声明实际流等于某个已定义的算子作用，也没有另声明时间Taylor系数与Lie系数相等；采用Taylor jet解释可认可现有估计，要求原式逐子句对应则应另列形式jet身份，并将余项界作为辅助结果。不能以额外估计本身为真就代替对原文含义的裁定，故 NEEDS\_HUMAN，而不是因缺少定义或sorry。证明状态独立记录：Ch03.lean 的 flowCoordinates 为 sorry，尚未证明；本次只读审计未编译。 网站原文审校另记：
- 反例或理由：以下只反驳实际流分量等于其形式级数取实数值的解释，不是现有局部余项界的反例：在R²上令g(0)=0、g(x)=exp(-1/x²)（x≠0），G(x)=∫₀ˣg(s)ds，f(x,y)=(1,g(x))，D=R²，Φ(t,(x,y))=(x+t,y+G(x+t)-G(x))，η=1。f光滑，此Φ满足已展开的actualFlow，ζ=(0,0)的第二坐标为G(t)>0（t>0），但所有第二坐标的Lie-Taylor系数在ζ处均为0。因此形式坐标级数为0，无法恢复实际流分量；按各有限阶作局部余项解释没有这个矛盾。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.flowCoordinates`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.flowCoordinates_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：先明确原页实际流与形式exp的连接采用何种含义。采用Taylor jet／全阶渐近解释时明确现有签名是局部、逐初值逐坐标的严格化，并将新增余项结论单独标注；要求直接覆盖原等式时，另定义实际流作用于观测量的拉回或时间Taylor jet，逐系数声明其作用于坐标的jet等于formalObservable f (fun z=>z i) ζ，保留原式Φ(t,ζ)_i的实际流解释，再将现有有限余项界列为辅助定理。不要把形式PowerSeries无条件评价成实际流。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.flowCoordinates。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 4. MD-3.3-LeadingModifiedExponential

- source\_id：MD-3.3-LeadingModifiedExponential。

### MD-3.3-LeadingModifiedExponential

- 印刷页 / PDF页：105 / 127。
- 原文引文（逐字）：

> Because of this, we may interpret the first term in the expansion of the error as itself being derived from a Hamiltonian. This is a crucial observation which suggests an alternative perspective on the error expansion in splitting. The idea is to view the product of exponentials as an exponential:

$$
e^{hA}e^{hB}=e^{h(A+B+hR)},
$$


> for some operator $R$. Expanding out the right hand side gives

$$
\begin{aligned}e^{h(A+B+hR)}&=\mathrm{Id}+h(A+B+hR)+\frac{h^2}{2}(A+B+hR)^2+\cdots\\ &=\mathrm{Id}+hA+hB+h^2R+\frac{h^2}{2}\bigl(A^2+AB+BA+B^2+h^2R^2+h(A+B)R+hR(A+B)\bigr)+\cdots.\end{aligned}
$$


> Comparing this to our expansion for $e^{hA}e^{hB}$, for agreement to $O(h^2)$ we must have

$$
\frac12(2AB+A^2+B^2)=R+\frac12(A^2+AB+BA+B^2)=O(h),
$$


> or

$$
R=AB-\frac12(AB+BA)=\frac12[A,B]+O(h),
$$



- 问题所在：C：A、B属于同一实代数；n为自然数且n<3，即全部低于3次的系数相等。modifiedGenerator为(A+B)X+CX²；textbookFormalZeroConstantExponential确为零常项形式级数的指数，故C=(AB−BA)/2时结论正确。没有假设完整R(h)存在，更未形式化原书错误的系数比较链。context已披露该限制，但extra\_assumptions空列表未列出这一范围缩减；整段原文的数学问题需人工保留处理。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。 网站原文审校另记：A：引文忠实，包括原书比较式的连续两个等号和最后的=O(h)，不得把它静默改写为系数差。该比较式作为一般算子等式不成立，属于原书问题。；原issues中“展示h³交叉项似缺1/2”不成立：两项h(A+B)R、hR(A+B)均在h²/2的大括号内，已经含有1/2。；C：声明正确表达R的首项所给出的0、1、2次系数匹配，但不包含原文存在完整R(h)的全阶指数表示及错误的比较式；不能将此声明视作整段逐式形式化。
- 反例或理由：取标量A=1、B=0：比较式左侧恒为1/2，不能为O(h)。这不反驳当前Lean的低次匹配命题。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.leadingModifiedExponential`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.leadingModifiedExponential_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原文比较式；另列正确的低次系数推论，并明确这只核对R₀而非完整R(h)存在性。删除缺1/2的误报。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.leadingModifiedExponential。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 5. MD-3.3-BCHHamiltonianMatching / MD-3.3-LeadingShadowHamiltonian

- source\_id：MD-3.3-BCHHamiltonianMatching；MD-3.3-LeadingShadowHamiltonian。

### MD-3.3-BCHHamiltonianMatching

- 印刷页 / PDF页：106 / 128。
- 原文引文（逐字）：

> We refer to this series as the modified (also perturbed, shadow) Hamiltonian corresponding to the splitting method. The implication of the series is that the numerical method may be viewed as being equivalent to the exact solution of a nearby Hamiltonian system, although we have not addressed the convergence of the expansion.

- 问题所在：已读取 Ch03.lean 实际声明和 Ch03\_deps.txt 对应 -- FILE 段，审计针对签名语义；该 theorem 的证明体为 sorry，不据此判断签名 PASS/FAIL，亦不声称已获 Lean 验证。依赖展开：SymplecticCoordinates n=(Fin n ⊕ Fin n)→ℝ，inl 为 q、inr 为 p；textbookJ=[[0,I],[-I,0]]；X\_H=textbookHamiltonianVectorField H=J∇H；textbookPoissonBracket F G=DF(X\_G)=Σ(F\_q G\_p−G\_q F\_p)。actualFlow f D Φ η 展开为 η>0，且每个 z∈D 有 Φ(0,z)=z，对全部 |t|<η 有 Φ(t,z)∈D 和时间方向 HasDerivAt Φ(·,z) f(Φ(t,z)) t；未把复合相等或匹配放进假设。solution f γ 0 h 展开为在整个闭区间 [0,h] 的 HasDerivWithinAt γ (f(γ(t)))。 matchesHamiltonian K G B p 展开为 ∃C>0、δ>0、Γ，对全部 0<h<δ、z∈B 有 Γ(h,z,0)=z、solution X_{K(h)} Γ 0 h 及 ‖G(h,z)−Γ(h,z,h)‖≤C h^{p+1}；本条 p=4 即 O(h⁵)，不是预设匹配假设。bchHamiltonian3 展开为原页到 h³ 的印刷函数；该有限阶 O(h⁵) 解释是光滑情况下合理的形式级数有限后果，不证明收敛或无限级数的实际精确等价。按原页及 PDF124/印刷102 的 L\_H F={F,H}，exp(hL\_A) 是 Φ\_A 的 pullback；exp(hL\_A)exp(hL\_B)F=F∘Ψ\_B∘Φ\_A，而 Lean 端点是 Φ\_A∘Ψ\_B。实际 [L\_A,L\_B]=L_{ {B,A} }=−L_{ {A,B} }，PDF127 顶部第一式也给出 {B,A}，紧接的第二式却改成 {A,B}，故该原书符号疑误可确定。Lean 的正号 Hamiltonian 对 Φ\_A∘Ψ\_B 是合理的，但这不是所引原文算子等式的逐义形式化。 [EXTRA] 开放 D、紧 K⊆D、光滑性用于统一有限阶余项，合理；全 D 统一 η 且所有轨线留在 D 比一般局部流强，应披露。无需因所谓未知定义、组合次序或余项阶而 NEEDS\_HUMAN：相关定义全部在附件中，次序与 O(h⁵) 已可明确判定。 网站原文审校另记：
- 反例或理由：取 n=1，D=ℝ²，K={(1,0)}，A(q,p)=p²/2，B(q,p)=q²/2，η=1；Φ\_h(q,p)=(q+hp,p)，Ψ\_h(q,p)=(q,p−hq)，满足全部光滑及 actualFlow 假设。Lean 使用 Φ\_hΨ\_h(1,0)=(1−h²,−h)，原文算子乘积作用于坐标所得状态则是 Ψ\_hΦ\_h(1,0)=(1,−h)，相差 (−h²,0)。{A,B}=−pq，正号修正 Hamiltonian 的端点 q=1−h²+O(h³)，不能以 O(h³) 或 O(h⁵) 匹配原文次序的 q=1。此为对象/次序不忠实的见证，不是假称 Lean 当前 Φ∘Ψ 结论为假。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.bchHamiltonianMatching`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：默认保留状态复合Φ\_h∘Ψ\_h及其正号修正Hamiltonian；对应拉回算子应为exp(hL\_B)exp(hL\_A)。原印反向算子顺序作为勘误保留。只声明现有有限实际流匹配。；`MD.Ch03.bchHamiltonianMatching_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“默认保留状态复合Φ\_h∘Ψ\_h及其正号修正Hamiltonian；对应拉回算子应为exp(hL\_B)exp(hL\_A)。原印反向算子顺序作为勘误保留。只声明现有有限实际流匹配。”。
- 导师选项：明确选择并标注勘误路线：若保留原文算子乘积 exp(hL\_A)exp(hL\_B)，状态端点应改为 Ψ\_h∘Φ\_h，同时 leading 项改为 −h{A,B}/2；三阶截断的 h 与 h³ 奇数项都反号，h² 项不变（等价于 bchHamiltonian3 B A）。若保留当前 Φ\_h∘Ψ\_h 与正号公式，应将原文算子关系显式勘误为 exp(hL\_B)exp(hL\_A)，记录 PDF127 交换子顺序错误，而不能声称忠实保留原文等式。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch03.bchHamiltonianMatching。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-3.3-LeadingShadowHamiltonian

- 印刷页 / PDF页：105 / 127。
- 原文引文（逐字）：

> and from this it follows that

$$
e^{h\mathcal L_{H_1}}e^{h\mathcal L_{H_2}}=e^{h\mathcal L_G},
$$


> where

$$
G=H_1+H_2+\frac h2\{H_1,H_2\}+O(h^2).
$$



- 问题所在：已读取 Ch03.lean 实际声明和 Ch03\_deps.txt 对应 -- FILE 段，审计针对签名语义；该 theorem 的证明体为 sorry，不据此判断签名 PASS/FAIL，亦不声称已获 Lean 验证。依赖展开：SymplecticCoordinates n=(Fin n ⊕ Fin n)→ℝ，inl 为 q、inr 为 p；textbookJ=[[0,I],[-I,0]]；X\_H=textbookHamiltonianVectorField H=J∇H；textbookPoissonBracket F G=DF(X\_G)=Σ(F\_q G\_p−G\_q F\_p)。actualFlow f D Φ η 展开为 η>0，且每个 z∈D 有 Φ(0,z)=z，对全部 |t|<η 有 Φ(t,z)∈D 和时间方向 HasDerivAt Φ(·,z) f(Φ(t,z)) t；未把复合相等或匹配放进假设。solution f γ 0 h 展开为在整个闭区间 [0,h] 的 HasDerivWithinAt γ (f(γ(t)))。按原页及 PDF124/印刷102 的 L\_H F={F,H}，exp(hL\_A) 是 Φ\_A 的 pullback；exp(hL\_A)exp(hL\_B)F=F∘Ψ\_B∘Φ\_A，而 Lean 端点是 Φ\_A∘Ψ\_B。实际 [L\_A,L\_B]=L_{ {B,A} }=−L_{ {A,B} }，PDF127 顶部第一式也给出 {B,A}，紧接的第二式却改成 {A,B}，故该原书符号疑误可确定。Lean 的正号 Hamiltonian 对 Φ\_A∘Ψ\_B 是合理的，但这不是所引原文算子等式的逐义形式化。 [EXTRA] 开放域和无限光滑保证局部 ODE 唯一及 Taylor 控制，紧 K⊆D 用于统一 C、δ，均合理；无限光滑高于此低阶估计所需但符合原书 smooth 语境。actualFlow 要求全 D 统一时间且保持 D，是强于普通局部流的实质限制，应披露；不能仅解释为给定一点的局部流。结论 C、δ、Γ 先于 h,z，确为统一端点 O(h³)，但只是首阶截断的有限近似，并非原文全部形式等式。 网站原文审校另记：
- 反例或理由：取 n=1，D=ℝ²，K={(1,0)}，A(q,p)=p²/2，B(q,p)=q²/2，η=1；Φ\_h(q,p)=(q+hp,p)，Ψ\_h(q,p)=(q,p−hq)，满足全部光滑及 actualFlow 假设。Lean 使用 Φ\_hΨ\_h(1,0)=(1−h²,−h)，原文算子乘积作用于坐标所得状态则是 Ψ\_hΦ\_h(1,0)=(1,−h)，相差 (−h²,0)。{A,B}=−pq，正号修正 Hamiltonian 的端点 q=1−h²+O(h³)，不能以 O(h³) 或 O(h⁵) 匹配原文次序的 q=1。此为对象/次序不忠实的见证，不是假称 Lean 当前 Φ∘Ψ 结论为假。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.leadingShadowHamiltonian`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：默认保留状态复合Φ\_h∘Ψ\_h及其正号修正Hamiltonian；对应拉回算子应为exp(hL\_B)exp(hL\_A)。原印反向算子顺序作为勘误保留。只声明现有有限实际流匹配。；`MD.Ch03.leadingShadowHamiltonian_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“默认保留状态复合Φ\_h∘Ψ\_h及其正号修正Hamiltonian；对应拉回算子应为exp(hL\_B)exp(hL\_A)。原印反向算子顺序作为勘误保留。只声明现有有限实际流匹配。”。
- 导师选项：明确选择并标注勘误路线：若保留原文算子乘积 exp(hL\_A)exp(hL\_B)，状态端点应改为 Ψ\_h∘Φ\_h，同时 leading 项改为 −h{A,B}/2；三阶截断的 h 与 h³ 奇数项都反号，h² 项不变（等价于 bchHamiltonian3 B A）。若保留当前 Φ\_h∘Ψ\_h 与正号公式，应将原文算子关系显式勘误为 exp(hL\_B)exp(hL\_A)，记录 PDF127 交换子顺序错误，而不能声称忠实保留原文等式。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch03.leadingShadowHamiltonian。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 6. MD-3.3.2-VerletModifiedHamiltonian / MD-3.3.2-VerletModifiedMatching

- source\_id：MD-3.3.2-VerletModifiedHamiltonian；MD-3.3.2-VerletModifiedMatching。

### MD-3.3.2-VerletModifiedHamiltonian

- 印刷页 / PDF页：107 / 129。
- 原文引文（逐字）：

> In general for the Verlet method applied to Hamiltonians of the form $H(q,p)=T(p)+U(q)$, the BCH lemma gives

$$
\begin{aligned}\widetilde H_h={}&T+U+\frac{h^2}{12}\left(\{T,\{T,U\}\}-\frac12\{U,\{U,T\}\}\right)\\ &+\frac{h^4}{120}\left(-\frac16\{T,\{T,\{T,\{T,U\}\}\}\}+\frac13\{U,\{T,\{T,\{T,U\}\}\}\}-\frac14\{U,\{U,\{T,\{T,U\}\}\}\}+\{T,\{T,\{U,\{U,T\}\}\}\}\right)+O(h^6).\end{aligned}
$$



- 问题所在：C：verletModifiedH对任意n及任意两个相空间实函数T/U、任意h/z定义总化有限多项式；所有Poisson括号均用dF(J∇G)，与所引符号一致，h²两项和h⁴四项逐项完全一致。作为有限式定义它不主张可微性、可分离性、真实流或O(h^6)匹配，extra明确将这些义务分给第7条。定义的字面翻译通过；但整条原文一般T的数学主张有反例，因此合并裁定需人工，不能把有限式的忠实性当成一般BCH正确性。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。 网站原文审校另记：A：h²、h⁴四个括号项的嵌套顺序、−1/6、1/3、−1/4、1及O(h⁶)均忠实。C：有限函数定义逐项忠实，且已通过[EXTRA]把匹配义务分给第7条；但原文“In general ... T(p)+U(q)”对任意可分离T过宽，当前有限式不能提供该一般性的修正Hamiltonian。不得静默把原文改成二次T。
- 反例或理由：取n=1，T(p)=p^4/4，U(q)=q^2/2，D=ℝ²，B={(q,p)=(1,0)}。两个子流全局光滑：Φ\_t(q,p)=(q+t p³,p)，Ψ\_t(q,p)=(q,p−tq)，满足任意η>0的actualFlow。印刷有限K为p⁴/4+q²/2+h²(p⁶/12−q²p²/8)+h⁴(p⁸/20−q²p⁴/16)。kick-drift-kick的端点为q=1−h⁴/8，p=−h+h⁵/16。K\_h的真实时间h流在同一初值的p分量为−h+11h⁵/120+O(h⁶)：沿0≤t≤h有q(t)=1−t⁴/4+h²t²/8+O(h⁶)，故ṗ=−1+t⁴/4+h²t²/8+O(h⁶)，积分得到上述系数。数值端点减真实端点的p分量=−7h⁵/240+O(h⁶)，不是O(h⁷)。这是对所写一般光滑可分离T/U的具体反例；不是对正质量二次动能机械特例的反例。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.verletModifiedH`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：这份独立表达式只按机械二次动能解释，不能用于一般非二次T；机械匹配见verletModifiedMatching\_corrected。一般T的h⁴公式尚待导师，不声称本通用函数对任意T正确。；`MD.Ch03.verletModifiedH_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“这份独立表达式只按机械二次动能解释，不能用于一般非二次T；机械匹配见verletModifiedMatching\_corrected。一般T的h⁴公式尚待导师，不声称本通用函数对任意T正确。”。
- 导师选项：保留印刷表达式和原文范围；人工决定是否把匹配限制为机械二次T，或另列一般T的正确h⁴项。不得用修正内容覆盖原书字面式。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.verletModifiedH。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-3.3.2-VerletModifiedMatching

- 印刷页 / PDF页：107 / 129。
- 原文引文（逐字）：

> In general for the Verlet method applied to Hamiltonians of the form $H(q,p)=T(p)+U(q)$, the BCH lemma gives

- 问题所在：C：verletModifiedMatching量化正质量m、全域C∞的U及紧B；K以二次T和位置U代入，G是先半kick、全drift、半kick，matchesHamiltonian(...,5)为O(h⁶)，与更强的正确截断阶相容。general则量化任意全域C∞ T/U、开放D、紧B⊆D、η及两条D内真实子流；结论含K4截断匹配O(h⁷)、存在全套D上C∞ Hj、H0/H2/H4精确值、所有奇次全域为零、每个k≥6的截断匹配O(h^(k+1))。这些量词和余项阶已完整保留，负号和次序也正确；但[EXTRA]把二次动能式提升到任意T，所固定H4有具体反例，故不能批准general。机械版本单独在签名语义上通过；本条总裁定依原书疑误规则NEEDS\_HUMAN。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。 网站原文审校另记：A：所引引导句忠实；完整展示式按context由第6条提供，未在此改动。C：机械特例和一般可分离版本须分别判断。前者p=5是较弱但合理的端点O(h⁶)要求；后者p=6及Hj4约束对任意光滑T不成立，问题源自印刷式的一般性。
- 反例或理由：取n=1，T(p)=p^4/4，U(q)=q^2/2，D=ℝ²，B={(q,p)=(1,0)}。两个子流全局光滑：Φ\_t(q,p)=(q+t p³,p)，Ψ\_t(q,p)=(q,p−tq)，满足任意η>0的actualFlow。印刷有限K为p⁴/4+q²/2+h²(p⁶/12−q²p²/8)+h⁴(p⁸/20−q²p⁴/16)。kick-drift-kick的端点为q=1−h⁴/8，p=−h+h⁵/16。K\_h的真实时间h流在同一初值的p分量为−h+11h⁵/120+O(h⁶)：沿0≤t≤h有q(t)=1−t⁴/4+h²t²/8+O(h⁶)，故ṗ=−1+t⁴/4+h²t²/8+O(h⁶)，积分得到上述系数。数值端点减真实端点的p分量=−7h⁵/240+O(h⁶)，不是O(h⁷)。这是对所写一般光滑可分离T/U的具体反例；不是对正质量二次动能机械特例的反例。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.verletModifiedMatching`（未证）；`MD.Ch03.verletModifiedMatching_general`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：独立修正版仅保留正质量机械二次动能的有限匹配，不复制一般T的有疑h⁴结论。标量h⁴另有独立系数核对。；`MD.Ch03.verletModifiedMatching_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“独立修正版仅保留正质量机械二次动能的有限匹配，不复制一般T的有疑h⁴结论。标量h⁴另有独立系数核对。”。
- 导师选项：将机械特例与一般T公式分别标记；一般版本须在人工裁定原书疑误后限制T或修正H4。保留现有原书字面记录，不修改工程。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.verletModifiedMatching; MD.Ch03.verletModifiedMatching\_general。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 7. MD-3.3.2-DifferentLogsCommute / MD-3.3.2-ModifiedEven

- source\_id：MD-3.3.2-DifferentLogsCommute；MD-3.3.2-ModifiedEven。

### MD-3.3.2-DifferentLogsCommute

- 印刷页 / PDF页：108 / 130。
- 原文引文（逐字）：

> Multiplying by the same expansion using a different time step $s$, we have

$$
\exp(\tfrac s2X)\exp(sY)\exp(\tfrac s2X)\exp(\tfrac t2X)\exp(tY)\exp(\tfrac t2X)=\exp(sZ_s)\exp(tZ_t).\tag{3.4}
$$


> But we know that $Z_t$ commutes with $Z_s$, giving

$$
\begin{aligned}\exp(sZ_s)\exp(tZ_t)&=\exp(sZ_s+tZ_t)\\ &=\exp((s+t)\widetilde Z_{[1]}+(s^2+t^2)\widetilde Z_{[2]}+(s^3+t^3)\widetilde Z_{[3]}+(s^4+t^4)\widetilde Z_{[4]}+\cdots).\end{aligned}\tag{3.5}
$$



- 问题所在：textbookFormalOperatorExponential A 的第k系数为A^k/k!；formalStrang A B=exp(xA/2)exp(xB)exp(xA/2)；formalLog P 的第n系数为Σ_{j=1}^n (−1)^(j+1)/j·coeff\_n((P−1)^j)，在P(0)=1时就是真实形式log；commutator A B=AB−BA。 Lean量词∀R,A,B,s,t，结论是两条共享形式变量x的log的交换子为零；非零s,t时log S(sx)=sx Z_(sx)，交换性与生成元版本对应，零缩放时log=0。确实保留了原文的普遍交换断言，但该断言一般是假，[ERRATUM?]成立；不能靠sorry使其成为正确结论。所给反例使(3.5)对一般s,t也失效；s=−t的反步消去及最终奇性仍可独立成立。当前证明为sorry。 网站原文审校另记：
- 反例或理由：在R=M₂(ℝ)中取A=[[0,1],[0,0]]、B=[[0,0],[1,0]]、s=1、t=2。设L=A+B、C=B/6−A/12；log S(sx)=sxL+s³x³C+O(x⁵)，[L,C]=diag(1,−1)/4。因此[x⁴][log S(sx),log S(tx)]=st(t²−s²)[L,C]=diag(3/2,−3/2)≠0。该实矩阵代数满足Lean的Ring及Algebra ℝ假设。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.differentLogsCommute`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：仅在A、B交换这一明示充分条件下给不同步长log交换；不使用原书一般交换断言证明奇性。；`MD.Ch03.differentLogsCommute_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“仅在A、B交换这一明示充分条件下给不同步长log交换；不使用原书一般交换断言证明奇性。”。
- 导师选项：将此条标作原书错误断言，禁止无条件定理进入已验证结论。若保留正确条件版本，可显式要求A、B交换（充分但限制范围），或直接要求两log交换；证明奇性应使用Strang反步恒等式及形式log唯一性，不依赖一般不同步长交换。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch03.differentLogsCommute。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-3.3.2-ModifiedEven

- 印刷页 / PDF页：107–108 / 129–130。
- 原文引文（逐字）：

> The extra power of $h$ in the leading perturbation reflects the fact that this method is 2nd order accurate, rather than first order, as Symplectic Euler. Note that only even order terms $(h^2,h^4,\ldots)$ appear in the perturbative expansion; this is a consequence of the symmetry of the method.
> Setting $s=-t$, the left hand side of (3.4) collapses to the identity. Hence the surviving even-powered terms in the expansion on the right hand side of (3.5) must be zero. If the even order terms vanish, then the effect of composing linear operators symmetrically is to keep only odd order terms in the exponent, giving the symmetric BCH formula

$$
\exp(\tfrac t2X)\exp(tY)\exp(\tfrac t2X)=\exp(t(X+Y)+t^3\widetilde Z_{[3]}+\cdots).\tag{3.6}
$$



- 问题所在：C：任意实代数R（Ring而非CommRing）及A/B，formalStrang是e^(XA/2)e^(XB)e^(XA/2)，formalLog为对P−1展开的形式log。结论一次系数A+B，且对所有j∈ℕ包括j=0，2j次系数均为0；因此指数含h(A+B)及至少h³的奇项，除以h后修正生成元只有偶项，涵盖至少二阶。formalStrang常项1确保formalLog使用合法，不需要收敛或不同步长log交换。[EXTRA]新增一次项并未把错误的原书证明当前提。Lean签名PASS；JSON因保留原书推理缺口NEEDS\_HUMAN。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。 网站原文审校另记：A：两页引文及(3.6)忠实。原页(3.5)前“But we know that Z\_t commutes with Z\_s”对一般非交换生成元没有依据；在s=−t时用逆关系即可证明奇性，但不能据此认可任意s/t的对数可交换。原context称“另列ERRATUM”，本条issues却为空，现补入。C：当前Lean只断言正确结论，不使用该错误前提。
- 反例或理由：A：两页引文及(3.6)忠实。原页(3.5)前“But we know that Z\_t commutes with Z\_s”对一般非交换生成元没有依据；在s=−t时用逆关系即可证明奇性，但不能据此认可任意s/t的对数可交换。原context称“另列ERRATUM”，本条issues却为空，现补入。C：当前Lean只断言正确结论，不使用该错误前提。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.modifiedEven`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.modifiedEven_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原文并注明范围 / 接受独立限定修正版。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch03.modifiedEven。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 8. MD-3.3.4-ProcessorEnergyPrinted

- source\_id：MD-3.3.4-ProcessorEnergyPrinted。

### MD-3.3.4-ProcessorEnergyPrinted

- 印刷页 / PDF页：113 / 135。
- 原文引文（逐字）：

> and inserting these into $H$ yields, after expanding in a Taylor series:

$$
\begin{aligned}H(\widetilde q,\widetilde p)&=T+\frac{h^2}{12}\left(p^TM^{-1}U''M^{-1}p-\nabla U^TM^{-1}\nabla U\right)+O(h^4)\\ &=\widetilde H_h(q,p)+O(h^4).\end{aligned}
$$



- 问题所在：已展开 mechanicalEnergy=T+U、quadraticKinetic=T、takahashiProcessor 为式(3.9)，shadowTerms 前两项分别是pᵀM⁻¹U''M⁻¹p与grad UᵀM⁻¹grad U，takahashiShadow2=H+h²/12(A−B)。签名把原文两行都转成同一C,δ下对紧集B一致的绝对余项界，∀n,m,U,B后存在C,δ再∀h,z的量词适合这种局部O解释；C⁴、正对角质量、紧集是合理且充分但非最弱的附加条件。然而第一界忠实照抄了原书错误的T，导致结论在h=0即要求|U(q)|≤0，而其假设没有U|_B=0。第二界没有这个遗漏且在所加条件下合理。[ERRATUM?]已被明确反例确认成立；不能因逐字忠实就把矛盾签名记为PASS。声明含sorry，此失败独立于证明状态。 网站原文审校另记：
- 反例或理由：n=1，m₀=1，U(q)≡1，B={(q=0,p=0)}。正质量、C⁴、紧性均满足。grad U=0、U''=0，处理器恒等，shadowTerms=(0,0,0)，T=0，H=1，takahashiShadow2=1。任意δ>0都有h=0∈(−δ,δ)，第一界要求1≤C·0⁴=0，第二界为0≤0。即使删除h=0，第一界1≤Ch⁴在h→0时仍不成立。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.processorEnergyPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：首界补回遗漏势能U(q)，把T改成H；其余统一余项资格和第二界不变。；`MD.Ch03.processorEnergyPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“首界补回遗漏势能U(q)，把T改成H；其余统一余项资格和第二界不变。”。
- 导师选项：原文JSON继续保留T并记录确认的原书疑误。保留Printed声明作为错误原式的档案并明确不可证明；另立Corrected声明，把第一界quadraticKinetic m z.2改为mechanicalEnergy m U z，保留第二界和统一余项资格。不得静默改原书。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch03.processorEnergyPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 9. MD-3.3.4-TakahashiEffectiveOrder

- source\_id：MD-3.3.4-TakahashiEffectiveOrder。

### MD-3.3.4-TakahashiEffectiveOrder

- 印刷页 / PDF页：113 / 135。
- 原文引文（逐字）：

> Since $\widetilde H_h$ is assumed to be constant along the numerical solution, the coordinate transformations have the result of giving an effective order of four for the energy. It turns out that the Takahashi-Imada method is, more generally, an effective 4th order scheme, i.e. for arbitrary quantities, not just the energy [166].

- 问题所在：所有相关定义均已找到并展开：solution 要求γ在[0,τ]每点满足实际HasDerivWithinAt；mechanicalField(m,F)(q,p)=(M⁻¹p,F(q))；verlet 的q新值为q+hM⁻¹p+h²/2 M⁻¹F(q)，p新值为p+h/2(F(q)+F(q新))，此处F=−grad(takahashiPotential m U h)。textbookProcessedMethod χ B h=(χ h)⁻¹∘B\_h∘χ h，oneStepIterate=(G\_h)^[k]，oneStepMaxError=max_{0≤k≤ν}‖G\_h^[k](γ(0))−γ(kh)‖。所以它确实控制有限时间的全部网格轨迹误差，不只是能量或一步误差。量词∃χ在∀γ,τ之前要求同一族全空间homeomorphism服务所有轨迹，并且χ完全没有近恒等、h光滑性、式(3.9)的二阶系数或局部作用域要求。PDF134–135所说的是给定坐标变换带来的有效阶；该签名无法识别那个处理器，并额外要求全空间双向连续的精确逆。全局homeomorphism是存在结论的强化，并非一个已给出的额外前提，不能仅标[EXTRA]就证明合理。正质量、全域C∞、连续有限时间解是合理的充分正则化；全域正则性比局部需要强。给定这些确切缺失，判FAIL，无须以定义缺失或导师判断为由判NEEDS\_HUMAN。χ⁻¹∘G∘χ本身不是方向错误：若P是原文从原坐标到带波浪号坐标的后处理，则应取χ=P⁻¹，得到P∘G∘P⁻¹。原文关于能量的解释显式以影子能量沿数值解恒定为假定，该签名也未单列这项条件式能量结论。声明含sorry；未声称已否证存在任意全局χ的四阶定理。 网站原文审校另记：
- 反例或理由：缺失条款：存在任意χ的声明不要求原文指定处理器或其二阶展开，且把局部坐标展开提升为全空间homeomorphism。具体说明此提升不能直接由式(3.9)给出：n=1,m=1,U(q)=q⁴，则P\_h第一分量q−h²q³/3；任意h≠0，(q,p)=(0,0)、(√3/|h|,0)、(−√3/|h|,0)均映到(0,0)，所以式(3.9)自身不是全局homeomorphism。该例只否定将显式P\_h直接认作全局可逆映射，不是否定存在另一族全局χ的命题。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.takahashiEffectiveOrder`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.takahashiEffectiveOrder_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：明确原文后处理P\_h及P\_h=id+h²a+O(h⁴)，其中a(q,p)=(−M⁻¹grad U/12,UM⁻¹p/12)；使用轨迹紧邻域内的局部可逆处理器，写P\_h∘G\_h∘P\_h⁻¹的真实网格误差界，确保初值、各次迭代和逆映射作用域一致。若继续采用χ⁻¹∘G∘χ，应规定χ=P\_h⁻¹及相应负二阶系数。若坚持全局homeomorphism版本，另给全局延拓和近恒等一致性依据；将以影子能量恒定为条件的能量叙述与一般轨迹阶结论分开。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch03.takahashiEffectiveOrder。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 10. MD-3.4-Thm3.1 / MD-3.4-TruncatedConservation / MD-3.4-EnergyTelescoping / MD-3.4-UniformTruncatedLipschitz / MD-3.4-PhysicalEnergyDrift

- source\_id：MD-3.4-Thm3.1；MD-3.4-TruncatedConservation；MD-3.4-EnergyTelescoping；MD-3.4-UniformTruncatedLipschitz；MD-3.4-PhysicalEnergyDrift。

### MD-3.4-Thm3.1

- 印刷页 / PDF页：114–116 / 136–138。
- 原文引文（逐字）：

> Theorem 3.1. Suppose the Hamiltonian $H$ and modified Hamiltonian $\bar H_k$ are smooth functions globally defined on a convex, compact subset $\mathcal B$ of $\mathbb R^{2N_c}$ and suppose that the exact solution and numerical approximations (for $h$ sufficiently small) are confined to $\mathcal B$. Then, we have asymptotically for $h\to0$ that

$$
H(\boldsymbol z_n)=H(\boldsymbol z_0)+O(h^r),
$$


> for $n=0,1,\ldots,\nu$ where $\tau=\nu h=O(h^{-k+r})$.

- 问题所在：Lean中n,r,k、实Hamiltonian及系数、开放凸D、紧凸B⊆D、r>0、r≤k和C∞条件均显式。finiteMatching给真实截断ODE、留D及统一A h^(k+1)端点缺陷；它不是能量结论。量词∀T>0后取M,δ，与ν及z₀无关；νh·h^(k−r)≤T正是时间O(h^(−k+r))。数值轨道直到ν留B足够，截断短轨可在B的紧邻域控制，无须全部留B。给定匹配后的能量签名数学上合理，但原书证明有记号及严格不等号疑误，须人工确认其解释；构造存在性不由本声明证明。 网站原文审校另记：原书115页在同一有限截断的守恒/望远镜推导中混用bar H\_k与tilde H\_k；忠实保留原印，但只有明确二者指同一截断时方能按Lean统一K解释。；原证明先为H取L，随后对bar H\_k沿用L，且由||η||≤C h^(k+1)写成Lνh^(k+1)省略C。可重选统一截断Lipschitz常数并吸收C，但原文未说明；Lean显式LA版本合理，原印不静默勘误。；proof\_latex首个Lipschitz式写≤，附件第5页/原页114实际印<；u=v时严格不等式不成立，必须忠实还原并标记原书疑误。；proof\_latex望远镜第三行最后一项写tilde H\_k，附件第6页/原页115该处实际是bar H\_k；第二行该处为tilde，不能一并改写。
- 反例或理由：取原印Lipschitz式中u=v∈B，则0<0为假；此反例针对原书严格不等号，不针对Lean的能量估计。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.theorem31`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.theorem31_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：采用corrected\_json恢复原印<及第三行末bar；保留原书疑误供人工确认。数学解释可另列≤、统一截断记号和显式常数的勘误版本，勿混入字面原文。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 ['MD.Ch03.theorem31']。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-3.4-TruncatedConservation

- 印刷页 / PDF页：115 / 137。
- 原文引文（逐字）：

> Since $\mathcal F_h^{(k)}$ preserves its Hamiltonian (3.11), we have

$$
\bar H_k(\mathcal F_h^{(k)}(\boldsymbol z_n))=\widetilde H_k(\boldsymbol z_n).
$$



- 问题所在：对任意H、曲线γ及实τ，沿Icc 0 τ要求H在γt可微以及实际Hamiltonian ODE的within导数；结论覆盖所有该区间t，包括端点。由dH(J∇H)=0得常值；τ<0时结论空真，τ=0为自反等式。不预设守恒，取H为截断K后得到一步守恒。签名正确，但原书等式右边印为tilde，须确认与bar指同一函数。 网站原文审校另记：原书115页在同一有限截断的守恒/望远镜推导中混用bar H\_k与tilde H\_k；忠实保留原印，但只有明确二者指同一截断时方能按Lean统一K解释。
- 反例或理由：原书115页在同一有限截断的守恒/望远镜推导中混用bar H\_k与tilde H\_k；忠实保留原印，但只有明确二者指同一截断时方能按Lean统一K解释。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.truncatedConservation`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.truncatedConservation_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原印bar/tilde差异；请人工确认同一有限截断解释，另列统一记号的数学版本。Lean签名无需据此改写。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 ['MD.Ch03.truncatedConservation']。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。


### MD-3.4-EnergyTelescoping

- 印刷页 / PDF页：115 / 137。
- 原文引文（逐字）：

> Now

$$
\begin{aligned}\bar H_k(\boldsymbol z_\nu)-\bar H_k(\boldsymbol z_0)&=\sum_{n=0}^{\nu-1}\bar H_k(\boldsymbol z_{n+1})-\bar H_k(\boldsymbol z_n)\\ &=\sum_{n=0}^{\nu-1}\bar H_k(\boldsymbol z_{n+1})-\widetilde H_k(\mathcal F_h^{(k)}(\boldsymbol z_n))\\ &=\sum_{n=0}^{\nu-1}\bar H_k(\mathcal F_h^{(k)}(\boldsymbol z_n)+\boldsymbol\eta_n)-\bar H_k(\mathcal F_h^{(k)}(\boldsymbol z_n)).\end{aligned}
$$



- 问题所在：首声明是任意类型E上实际G迭代的有限实数差望远镜恒等式。complete在带减法/加法的状态空间中用ηi=z(i+1)−F(zi)，在明确的一步守恒前提下给三段等式，n=0亦成立；该前提由独立守恒条目供应，不循环假定总能量差。统一K是合理的记号澄清，但不是原印bar/tilde混用本身的证明。 网站原文审校另记：原书115页在同一有限截断的守恒/望远镜推导中混用bar H\_k与tilde H\_k；忠实保留原印，但只有明确二者指同一截断时方能按Lean统一K解释。
- 反例或理由：原书115页在同一有限截断的守恒/望远镜推导中混用bar H\_k与tilde H\_k；忠实保留原印，但只有明确二者指同一截断时方能按Lean统一K解释。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.energyTelescoping`（已证）；`MD.Ch03.energyTelescoping_complete`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.energyTelescoping_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原印bar/tilde差异；请人工确认同一有限截断解释，另列统一记号的数学版本。Lean签名无需据此改写。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 ['MD.Ch03.energyTelescoping', 'MD.Ch03.energyTelescoping\_complete']。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。


### MD-3.4-UniformTruncatedLipschitz

- 印刷页 / PDF页：115 / 137。
- 原文引文（逐字）：

> Hence

$$
|\bar H_k(\boldsymbol z_\nu)-\bar H_k(\boldsymbol z_0)|\le L\sum_{n=0}^{\nu-1}\|\boldsymbol\eta_n\|\le L\nu h^{k+1}.
$$



- 问题所在：第一声明由紧凸B⊆开放D、H及有限Hj的C¹得到单个正L，对所有0≤h≤1及u,v∈B同时成立。chain显式要求非负h,L,A、各步守恒、实际端点Lipschitz界和缺陷≤A h^(k+1)，结论完整保留LΣ缺陷≤LA n h^(k+1)，零步亦成立。这些是合理拆分资格，不把总能量结论作为假设；原页省略C及沿用H的L仍需人工解释。 网站原文审校另记：原证明先为H取L，随后对bar H\_k沿用L，且由||η||≤C h^(k+1)写成Lνh^(k+1)省略C。可重选统一截断Lipschitz常数并吸收C，但原文未说明；Lean显式LA版本合理，原印不静默勘误。
- 反例或理由：原证明先为H取L，随后对bar H\_k沿用L，且由||η||≤C h^(k+1)写成Lνh^(k+1)省略C。可重选统一截断Lipschitz常数并吸收C，但原文未说明；Lean显式LA版本合理，原印不静默勘误。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.uniformTruncatedLipschitz`（已证）；`MD.Ch03.uniformTruncatedLipschitz_chain`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.uniformTruncatedLipschitz_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原页公式；人工确认L可重选并吸收缺陷常数，正式数学版采用统一截断Lipschitz常数与显式A。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 ['MD.Ch03.uniformTruncatedLipschitz', 'MD.Ch03.uniformTruncatedLipschitz\_chain']。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。


### MD-3.4-PhysicalEnergyDrift

- 印刷页 / PDF页：115 / 137。
- 原文引文（逐字）：

> Therefore

$$
|H(\boldsymbol z_\nu)-H(\boldsymbol z_0)|\le L\nu h^{k+1}+O(h^r),
$$



- 问题所在：首声明明确真实截断ODE族γ、初值、所有0≤h≤1短轨留B和有限C¹系数；推得两端余项2C h^r及L乘实际缺陷和。complete另加非负统一A及一步误差≤A h^(k+1)，结论为2C h^r+LA n h^(k+1)，量词C,L先于h,z₀,n，数值轨道直到n留B。未假设能量守恒，h=0也相容。这是原文漂移式的合理显式常数版；原页L的来源及吸收常数需要与前条一起澄清。 网站原文审校另记：原证明先为H取L，随后对bar H\_k沿用L，且由||η||≤C h^(k+1)写成Lνh^(k+1)省略C。可重选统一截断Lipschitz常数并吸收C，但原文未说明；Lean显式LA版本合理，原印不静默勘误。
- 反例或理由：原证明先为H取L，随后对bar H\_k沿用L，且由||η||≤C h^(k+1)写成Lνh^(k+1)省略C。可重选统一截断Lipschitz常数并吸收C，但原文未说明；Lean显式LA版本合理，原印不静默勘误。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.physicalEnergyDrift`（已证）；`MD.Ch03.physicalEnergyDrift_complete`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.physicalEnergyDrift_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原页公式；人工确认L可重选并吸收缺陷常数，正式数学版采用统一截断Lipschitz常数与显式A。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 ['MD.Ch03.physicalEnergyDrift', 'MD.Ch03.physicalEnergyDrift\_complete']。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 11. MD-3.4-AnalyticDefect

- source\_id：MD-3.4-AnalyticDefect。

### MD-3.4-AnalyticDefect

- 印刷页 / PDF页：116 / 138。
- 原文引文（逐字）：

> It is possible to prove (see discussions in [164, 227] for more detail), that for many standard classes of numerical methods, there are real, positive constants $C,D$ such that

$$
\|\mathcal G_h(\zeta)-\mathcal F_h^{(k)}(\zeta)\|\le Ch[D(k+1)h]^{k+1},
$$


> giving a precise bound on the magnitude of the difference between the time $h$ evolution under the truncated perturbed Hamiltonian and the numerical method.

- 问题所在：已展开Ch03\_deps.txt：SymplecticCoordinates n=(Fin n⊕Fin n)→ℝ；smoothSymplecticData要求r>0、开放凸D、紧凸B⊆D、H光滑、G(0)=id、联合光滑、Jacobian满足AᵀJA=J、B上真实H流以及局部O(|h|^(r+1))阶。Jacobian是实际fderiv矩阵。truncatedFlow要求Γ(0)=z及[0,h]上的实际ODE；Hamiltonian为H+Σ_{j=r}^k h^j Hj。解析假设、统一C/A/δ先于k、真实流估计均明确，且加入A(k+1)h≤1并另给指数截断。未找到缺失定义；原文many standard classes未界定适用类，需数学判断这些解析及域条件是否足以支持此全域解析系数结论；不能仅据名字或sorry判PASS。analyticBEA含sorry，与此语义判定分开。 网站原文审校另记：
- 反例或理由：未单列反例；问题在原文省略资格、术语、证明步骤或覆盖范围。请结合原句及下列修正核查。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.analyticBEA`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.analyticBEA_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：明确原文适用方法类和解析邻域条件，再确认有限k范围及额外指数结论；不将构造或缺陷估计作为前提。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.analyticBEA。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 12. MD-3.4-OptimalTruncation

- source\_id：MD-3.4-OptimalTruncation。

### MD-3.4-OptimalTruncation

- 印刷页 / PDF页：116 / 138。
- 原文引文（逐字）：

> If $h$ is small, then for $k$ sufficiently small the quantity in brackets is less than one and the difference from the truncated approximation decreases in magnitude with increasing $k$. As soon as $k$ satisfies

$$
k+1>\frac1{Dh}
$$


> the power grows monotonically without bound. We can minimize the difference between $\mathcal G_h$ and $\mathcal F_h^{(k)}$ by choosing

$$
k=\frac1{Dh\mathrm e}-1,
$$


> in which case,

$$
\|\mathcal G_h(\zeta)-\mathcal F_h^{(k)}(\zeta)\|<\widetilde C h\mathrm e^{-1/(\gamma h)},\qquad\gamma=\frac1{D\mathrm e}.
$$



- 问题所在：Lean只断言m=floor(1/(Ae h))>0及(A m h)^m≤C exp(−1/(Ae h))，m对应原文k+1；没有任何数值映射/实际截断流对象，未表达原文增长、最小化实际差或展示的原书指数。D>0及正小h合理，独立C可吸收取整误差；但context\_notation承认缩窄不能代替完整statement\_scope。此定理含sorry，语义缺项独立于证明完成度。[ERRATUM?]成立：连续变量x的log((Dh x)^x)=x log(Dh x)，最小点x=1/(Deh)，最小值exp(−1/(Deh))。 网站原文审校另记：
- 反例或理由：缺失实际流差结论及增长/最小化条款。取A=0.1、h\_N=1/(0.1 e N)，Lean幂=(1/e)^N；原书指数界则exp(−0.1 e/h\_N)=exp(−0.01 e²N)，与Lean率不同；A较大时原书率还会比真实连续最小值快，无法用固定C̃吸收。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.optimalTruncation`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.optimalTruncation_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：将整数标量引理明确列为辅助条目；另建实际缺陷推论，保留原书疑误并显式说明采用经确认的−γ/h版本；区分上界最小化和真实差最小化。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch03.optimalTruncation。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 13. MD-3.4-ScalarVerletShadow4

- source\_id：MD-3.4-ScalarVerletShadow4。

### MD-3.4-ScalarVerletShadow4

- 印刷页 / PDF页：117 / 139。
- 原文引文（逐字）：

> The modified energy for the Verlet method for a single degree of freedom system with energy $H=p^2/2+U(q)$ is

$$
\widetilde H_h=H+\frac{h^2}{24}(2p^{T}U''p-(U')^2) +h^4\left(\frac1{720}p^4U''''-\frac1{120}p^2U'U'''-\frac1{240}(U')^2U''-\frac1{60}p^2((U'')^2+U'U''')\right)+O(h^6).
$$



- 问题所在：两个声明均已审校。scalarVerletShadow4取z=(q,p)，所定义有限h⁴多项式在标量化后忠实于原印，不能因定义中没有O项而当作余项已证。新增scalarVerletShadow4\_matching确实量化任意C∞势、紧B和统一正C、δ，给出从z出发的真实Hamiltonian局部流及velocity Verlet的O(h⁷)端点匹配。C∞的∞编码在本条实际正确；但这个新增结论本身为假：U(q)=q²/2时，印刷多项式产生的q端点与Verlet已有非零h⁵差项，故不能有O(h⁷)界。FAIL针对新增matching的数学结论；忠实的印刷有限式本身应保留，并把原书系数问题转人工，不能通过补sorry解决。 网站原文审校另记：code：A\_FORMULA\_NOT\_LITERAL；field：statement\_latex；detail：原印为2pᵀU″p；输入改写为2p²U″。恢复原记号，其标量数学值不变。；code：SOURCE\_SHADOW\_COEFFICIENT\_SUSPECT；field：statement\_latex / issues；detail：原印h⁴系数在谐振子特例已不能产生所称Verlet修改流；保留全部原印系数并标记NEEDS\_HUMAN。；code：C\_FALSE\_ADDED\_MATCHING；field：scalarVerletShadow4\_matching；detail：新增的O(h⁷)实际流匹配被U(q)=q²/2、B={(0,1)}反驳。
- 反例或理由：令U(q)=q²/2，B={(0,1)}，均满足光滑性和紧性。有限式K\_h=(1/2+h²/12−h⁴/60)p²+(1/2−h²/24−h⁴/240)q²。置a=1+h²/6−h⁴/30，b=1−h²/12−h⁴/120，其向量场为(q̇,ṗ)=(ap,−bq)。从(0,1)出发的唯一流在时刻h有q(h)=a·sin(h√(ab))/√(ab)=h−h⁵/15+O(h⁷)。该展开在足够小h处由解析闭式给出；h⁵系数为−1/30−(1/4)/6+1/120=−1/15。velocity Verlet的Q=h，故|Q−q(h)|/h⁷~1/(15h²)→∞。任何满足solution及初值的Γ在正时间区间都由线性ODE唯一性等于该流，不能另选Γ绕开反例。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.scalarVerletShadow4`（定义）；`MD.Ch03.scalarVerletShadow4_matching_Printed`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：保留原印系数及原印匹配声明，独立列修正系数和匹配声明；精确代数核对见SHADOW4\_ALGEBRA.json，实际流误差定理未证明。；`MD.Ch03.scalarVerletShadow4_corrected`（定义）；`MD.Ch03.scalarVerletShadow4_matching_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“保留原印系数及原印匹配声明，独立列修正系数和匹配声明；精确代数核对见SHADOW4\_ALGEBRA.json，实际流误差定理未证明。”。
- 导师选项：保留scalarVerletShadow4作为印刷字面有限式并标记原书疑误；另设明确命名的corrected版本，先独立核对完整h⁴系数，再给实际流匹配。谐振子特例至少要求h⁴的p²系数为+1/60，原印为−1/60；本审校不据此擅改一般势的全部系数。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch03.scalarVerletShadow4。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 14. MD-3.4-CommutingEnergy

- source\_id：MD-3.4-CommutingEnergy。

### MD-3.4-CommutingEnergy

- 印刷页 / PDF页：117 / 139。
- 原文引文（逐字）：

> Suppose that, somehow, $H$ were exactly conserved along the numerical solution, so

$$
\dot H=0\Rightarrow\{H,\widetilde H_h\}=0.
$$



- 问题所在：actualFlow要求η>0、每个D中初值Φ(0,z)=z、每个|t|<η轨道留D且导数等于K的真实Hamiltonian场。textbookPoissonBracket H K=DH(X\_K)，X\_K=J∇K；H在开放D为C¹足以从连续轨道守恒得到结论。但Lean前提是全部连续时刻守恒，替换了原文数值解离散守恒，属于关键强化而非技术性[EXTRA]。context\_notation已指出此差异，却未修复原陈述覆盖。定理含sorry不影响这一签名判断。 网站原文审校另记：
- 反例或理由：固定步长h₀>0，K=(π/h₀)(q²+p²)，其时间h₀映射为恒等，故H(q,p)=q沿所有离散快照守恒；然而{H,K}=2πp/h₀不恒为0。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.commutingEnergy`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.commutingEnergy_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：把当前命题明确标为连续流条件引理；原数值解结论须另给足以从整族步映射推至生成场/形式系数的条件与论证。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch03.commutingEnergy。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 15. MD-3.4-EnergySymplecticNoGo

- source\_id：MD-3.4-EnergySymplecticNoGo。

### MD-3.4-EnergySymplecticNoGo

- 印刷页 / PDF页：118 / 140。
- 原文引文（逐字）：

> This certainly seems unlikely to hold except in very special cases indeed, unless the numerical method happens to coincide with the exact solution (up to a time rescaling). Thus the properties of symplecticness and energy conservation for numerical methods are essentially mutually exclusive from a practical point of view. A more precise formulation of this result was first given by Ge and Marsden [400].

- 问题所在：noExtraIntegrals实际展开为：所有D上光滑且{K,H}=0的全局函数K都等于某个g(H)，不要求g光滑。[EXTRA]是明显强资格，原书未给，不能独自推出当前全局统一δ结论；还缺轨道时间范围与非紧D上的统一控制。actualFlow仅在|t|<η约束Φ，结论τ h (H z)却不受此范围约束，也没有G(h,D)⊆D条件。全局辛定义为C¹及每点AᵀJA=J，不含全局双射。原书practical措辞不足以证明此精确版本；已有明确反例，故不以NEEDS\_HUMAN替代FAIL。定理含sorry。 网站原文审校另记：
- 反例或理由：n=1，D=ℝ²，H=(q²+p²)/2，η=1。记R\_t为X\_H的真实旋转流，定义Φ(t,z)=R\_t z当|t|<1，其他时间Φ(t,z)=z。这满足actualFlow。H的所有光滑第一积分在每个圆上恒定，故满足noExtraIntegrals。令G(h,z)=R_{h H(z)}z，这是Hamiltonian H²/2的全局光滑流，辛、保H且G(0)=id。任意δ>0取0<h<δ及H(z)=π/h，则G(h,z)=−z。所有|t|<1的R\_t z以及范围外的Φ(t,z)=z均不等于−z；不存在任何τ。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.energySymplecticNoGo`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：只给能量保持的局部微分链式约束；一般全域时间重参数结论仍须连通能量层、局部流域与一致时间窗资格，保留为未覆盖问题，未拿此局部式充当原全局结论。；`MD.Ch03.energySymplecticNoGo_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“只给能量保持的局部微分链式约束；一般全域时间重参数结论仍须连通能量层、局部流域与一致时间窗资格，保留为未覆盖问题，未拿此局部式充当原全局结论。”。
- 导师选项：要求Φ是全时间真实H流，或将结论局部化到受控紧域并要求τ落在已知流时间窗；还应控制G轨道留域及生成场存在全局Hamiltonian的拓扑条件。以正式精确命题区分原书实践性评论。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch03.energySymplecticNoGo。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 16. MD-3.5-VerletOscillatorEnergy

- source\_id：MD-3.5-VerletOscillatorEnergy。

### MD-3.5-VerletOscillatorEnergy

- 印刷页 / PDF页：123 / 145。
- 原文引文（逐字）：

> In the case of Euler's method applied to the harmonic oscillator, the error in energy grows with time and without bound. In the case of Störmer-Verlet, the energy fluctuates but remains bounded for all time and at its worst is of size proportional to $h^2$, a numerical observation that is supported by the existence of the modified Hamiltonian.

- 问题所在：当前verletOscillatorEnergy是正确的受限版本：一自由度、单位质量、Ω>0，先固定0<ρ<2和z，再选C≥0，随后对所有|hΩ|≤ρ及所有ν∈ℕ统一控制真实机械能差≤Ch²。常数不依赖h或ν，符合稳定范围内全时间O(h²)能量误差；h=0和零初值也不成问题。展开verlet、mechanicalEnergy和oneStepIterate后对象一致。但原句无条件的全时间断言在稳定阈值及不稳定步长下失败；[EXTRA]确实限制了适用范围，不能当作无条件原句已核验。另原句Euler无界分句在当前给出的全部声明中没有对应结论。context\_notation虽说另属EulerGrowth，本任务未提供它，且statement\_scope仍称覆盖所引原句；该分流及原书省略资格需人工确认。NEEDS\_HUMAN不否定当前受限Verlet上界的数学正确性。 网站原文审校另记：code：SOURCE\_STABILITY\_QUALIFICATION\_MISSING；field：statement\_latex / issues；detail：原书省略稳定步长范围；当前显式[EXTRA]是合理受限修复，但原句应保留疑误标记。；code：SOURCE\_EULER\_DEGENERATE\_CASES；field：statement\_latex / issues；detail：Euler能量无界还需要非零步长及非零初始能量；零解不能作无界增长解释。；code：C\_SCOPE\_MAPPING\_UNVERIFIED；field：statement\_scope / context\_notation；detail：本条完整摘录仅给Verlet上界，未给EulerGrowth声明；不能据旧注释认定Euler分句已核验。
- 反例或理由：反例针对原书未加限定的断言，不满足当前Lean的ρ<2前提：取Ω=1、h=2、z₀=(q₀,p₀)=(0,1)。velocity Verlet矩阵为[[-1,2],[0,−1]]，故qν=2ν(−1)^(ν−1)、pν=(−1)^ν，Hν=(4ν²+1)/2无界。Euler的“无界”分句另有退化例z₀=0或h=0，此时能量恒定。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.verletOscillatorEnergy`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.verletOscillatorEnergy_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原文逐字保留并标记NEEDS\_HUMAN；保留现有合理稳定资格。明确Verlet受限子结论与Euler跨条结论的审校范围；若要声明整段已形式化，需要提供本版EulerGrowth完整签名及其非退化资格。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.verletOscillatorEnergy。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 17. MD-3.6.2-FlowReversal / MD-3.6.2-FlowReversalIdentity / MD-3.6.1-ReversedTrajectoryPrinted / MD-3.6.1-ReversedTrajectory

- source\_id：MD-3.6.2-FlowReversal；MD-3.6.2-FlowReversalIdentity；MD-3.6.1-ReversedTrajectoryPrinted；MD-3.6.1-ReversedTrajectory。

### MD-3.6.2-FlowReversal

- 印刷页 / PDF页：129 / 151。
- 原文引文（逐字）：

> From this we see that if we start from a point $z_0$ and integrate forward in time (i.e apply $\mathcal F_t$) then apply the involution $R$, we get the exact same result as if we start from $\widetilde z(0)=Rz_0$ and integrate backward in time (i.e apply $\mathcal F_{-t}$). In sum, since $z_0$ is an arbitrary point,

$$
\mathcal F_{-t}(Rz)=R\mathcal F_t(z).
$$



- 问题所在：flowReversal作为经典修正版数学正确：任意n与连续线性involution R、全局C¹ f，显式要求f(Rz)=−Rf(z)，Φ对每个初值在全部实时间有正确初值和ODE导数，结论对所有t,z为Φ(−t,Rz)=RΦ(t,z)。C¹场保证唯一性；没有把所需反转等式塞进Φ的资格，也不需预先假设群律。对应原文的唯一未决点是“reversible”的含义：当前关系采用正确R版，而p128字面定义用Rᵀ；仅involution不使二者等价，且本条未像reversedTrajectory那样补对称R资格。因此不给数学正确的经典定理判FAIL，但原书与当前签名之间的定义对应仍需人工确认；NEEDS\_HUMAN不是sorry导致的。 网站原文审校另记：code：SOURCE\_REVERSAL\_DEFINITION\_CONFLICT；field：context\_notation / extra\_assumptions；detail：附件中印刷页128把一般线性involution的反转写成 f̃(z)=−Rᵀf(Rz)，而印刷页129的坐标链式法则及流反演使用R。仅R²=I不能推出Rᵀ=R。应保留这个原书定义与后续推导之间的疑误，交人工确认；不得在原文中静默删去转置。
- 反例或理由：这是原书一般定义与后续推导的反例，不是当前采用经典反转前提的Lean定理的反例：令n=2，R=[[1,1],[0,−1]]，f(z)=(0,1)，γ(t)=(0,t)，Φ(t,z)=z+(0,t)。R²=I，且−Rᵀf(Rz)=(0,1)=f(z)，符合p128字面定义；但−Rf(z)=(−1,1)≠f(Rz)。因此d/dt[Rγ(−t)]=(−1,1)≠f(Rγ(−t))。在t=1,z=0，Φ(−1,Rz)=(0,−1)，RΦ(1,z)=(1,−1)；并有RΦ(t,RΦ(t,z))=z+(t,0)，不等于z。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.flowReversal`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.flowReversal_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原文继续逐字保留并标记NEEDS\_HUMAN。人工确定采用勘误后的经典反转定义，或在保留原印定义时明确限制R对称；不能静默把两个定义当成同一个。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.flowReversal。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-3.6.2-FlowReversalIdentity

- 印刷页 / PDF页：129 / 151。
- 原文引文（逐字）：

> For the flow map, $\mathcal F_{-t}=\mathcal F_t^{-1}$ so we can recast the identity as

$$
R\circ\mathcal F_t\circ R\circ\mathcal F_t=\mathrm{Id},\tag{3.14}
$$



- 问题所在：flowReversalIdentity逐项包含线性involution、C¹向量场、经典反转条件、Φ初值、全实时间ODE和群律，完整结论对任意t,z给R(Φ t(R(Φ t z)))=z。群律加初值确实给Φ(−t)为双侧逆；结合经典反转得到(3.14)，无循环假设。和上一条一样，这个经典版本正确，但原印p128的Rᵀ定义与当前f(Rz)=−Rf(z)在一般R下不等价；本条没有对称性限定。NEEDS\_HUMAN用于确认原文到当前声明的勘误解释，不否定所给条件下的代数/ODE结论。 网站原文审校另记：code：SOURCE\_REVERSAL\_DEFINITION\_CONFLICT；field：context\_notation / extra\_assumptions；detail：附件中印刷页128把一般线性involution的反转写成 f̃(z)=−Rᵀf(Rz)，而印刷页129的坐标链式法则及流反演使用R。仅R²=I不能推出Rᵀ=R。应保留这个原书定义与后续推导之间的疑误，交人工确认；不得在原文中静默删去转置。
- 反例或理由：这是原书一般定义与后续推导的反例，不是当前采用经典反转前提的Lean定理的反例：令n=2，R=[[1,1],[0,−1]]，f(z)=(0,1)，γ(t)=(0,t)，Φ(t,z)=z+(0,t)。R²=I，且−Rᵀf(Rz)=(0,1)=f(z)，符合p128字面定义；但−Rf(z)=(−1,1)≠f(Rz)。因此d/dt[Rγ(−t)]=(−1,1)≠f(Rγ(−t))。在t=1,z=0，Φ(−1,Rz)=(0,−1)，RΦ(1,z)=(1,−1)；并有RΦ(t,RΦ(t,z))=z+(t,0)，不等于z。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.flowReversalIdentity`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.flowReversalIdentity_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：与FlowReversal统一原文/勘误版本的定义和资格；保留原印及NEEDS\_HUMAN标记。确认采用经典反转后，当前完整结论及复合次序可保留。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.flowReversalIdentity。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-3.6.1-ReversedTrajectoryPrinted

- 印刷页 / PDF页：129 / 151。
- 原文引文（逐字）：

> For the system $\mathrm dz/\mathrm dt=f(\boldsymbol z)$, a coordinate transformation $\boldsymbol z\mapsto\widetilde{\boldsymbol z}=R\boldsymbol z$ results in

$$
\frac{\mathrm d\widetilde{\boldsymbol z}}{\mathrm dt}=R\frac{\mathrm d\boldsymbol z}{\mathrm dt}=Rf(R^{-1}\widetilde{\boldsymbol z})=Rf(R\widetilde{\boldsymbol z}),
$$


> since $R^{-1}=R$. A change of time $t\mapsto\tau=-t$ results in

$$
\frac{\mathrm d\boldsymbol z}{\mathrm d\tau}=\frac{\mathrm dt}{\mathrm d\tau}\frac{\mathrm d\boldsymbol z}{\mathrm dt}=-f(\boldsymbol z).
$$



- 问题所在：同source\_id三条声明全部正确且忠实于当前所录原页129：主声明给Rγ(−t)的导数−Rf(γ(−t))；coordinateChange给Rγ(t)的导数Rf(R(Rγ(t)))，R²=I使其等于Rf(γ(t))，正是Rf(Rz̃)；timeChange给γ(−t)的导数−f(γ(−t))。R是任意实方阵且R²=I，γ在所有实时间满足真实ODE；主结论并未声称变换轨道仍解原f，也未使用Rᵀ或要求R对称。因此Printed版本没有被换成错误的转置反转版本，[EXTRA]补出的分离链式规则已存在。PASS仅就本条原文链式规则及三个当前签名；p128定义争议另留NEEDS\_HUMAN。 网站原文审校另记：code：JSON\_STALE\_REVERSAL\_DESCRIPTION；field：context\_notation[0]；detail：注释称当前是−Rᵀ版本，实际主声明及两条补充声明均为R链式法则。；code：SOURCE\_REVERSAL\_DEFINITION\_CONFLICT；field：issues / review\_context\_pdf\_pages；detail：附件中印刷页128把一般线性involution的反转写成 f̃(z)=−Rᵀf(Rz)，而印刷页129的坐标链式法则及流反演使用R。仅R²=I不能推出Rᵀ=R。应保留这个原书定义与后续推导之间的疑误，交人工确认；不得在原文中静默删去转置。
- 反例或理由：这是原书一般定义与后续推导的反例，不是当前采用经典反转前提的Lean定理的反例：令n=2，R=[[1,1],[0,−1]]，f(z)=(0,1)，γ(t)=(0,t)，Φ(t,z)=z+(0,t)。R²=I，且−Rᵀf(Rz)=(0,1)=f(z)，符合p128字面定义；但−Rf(z)=(−1,1)≠f(Rz)。因此d/dt[Rγ(−t)]=(−1,1)≠f(Rγ(−t))。在t=1,z=0，Φ(−1,Rz)=(0,−1)，RΦ(1,z)=(1,−1)；并有RΦ(t,RΦ(t,z))=z+(t,0)，不等于z。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.reversedTrajectoryPrinted`（未证）；`MD.Ch03.reversedTrajectoryPrinted_coordinateChange`（未证）；`MD.Ch03.reversedTrajectoryPrinted_timeChange`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.reversedTrajectoryPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：只更新过时context，保留当前三个忠实链式签名；p128的Rᵀ定义继续标记NEEDS\_HUMAN，若另建勘误版必须与印刷版本明确分开。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch03.reversedTrajectoryPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-3.6.1-ReversedTrajectory

- 印刷页 / PDF页：129 / 151。
- 原文引文（逐字）：

> In other words, for a reversible vector field, the coordinate transformation $\boldsymbol z\mapsto R\boldsymbol z$ is equivalent to the change of time $t\mapsto-t$.

- 问题所在：reversedTrajectory量化任意n、连续线性R、f和全实时间解γ；要求R²=id，另明确加入全部基矩阵元素R\_ij=R\_ji的对称资格，以及f(Rz)=−Rf(z)。结论Rγ(−t)仍满足原f的ODE；由链式法则导数=−Rf(γ(−t))=f(Rγ(−t))，数学正确。坐标对称资格不是隐藏的，它恰使Rᵀ=R=R⁻¹，从而可与原印反转定义兼容；这是一条合理但严格受限的修复，并未证明原书对任意非对称involution的宽泛句子。PASS针对已显式标注[EXTRA]的受限当前签名，原书一般性问题保留NEEDS\_HUMAN。 网站原文审校另记：code：SOURCE\_REVERSAL\_DEFINITION\_CONFLICT；field：statement\_latex / issues；detail：附件中印刷页128把一般线性involution的反转写成 f̃(z)=−Rᵀf(Rz)，而印刷页129的坐标链式法则及流反演使用R。仅R²=I不能推出Rᵀ=R。应保留这个原书定义与后续推导之间的疑误，交人工确认；不得在原文中静默删去转置。
- 反例或理由：这是原书一般定义与后续推导的反例，不是当前采用经典反转前提的Lean定理的反例：令n=2，R=[[1,1],[0,−1]]，f(z)=(0,1)，γ(t)=(0,t)，Φ(t,z)=z+(0,t)。R²=I，且−Rᵀf(Rz)=(0,1)=f(z)，符合p128字面定义；但−Rf(z)=(−1,1)≠f(Rz)。因此d/dt[Rγ(−t)]=(−1,1)≠f(Rγ(−t))。在t=1,z=0，Φ(−1,Rz)=(0,−1)，RΦ(1,z)=(1,−1)；并有RΦ(t,RΦ(t,z))=z+(t,0)，不等于z。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.reversedTrajectory`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.reversedTrajectory_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留当前明确对称资格的受限版本；原句及p128定义保留并标记NEEDS\_HUMAN。若另立一般经典修正版，使用f(Rz)=−Rf(z)，并说明它与非对称R下原印Rᵀ定义不等价。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch03.reversedTrajectory。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 18. MD-3.6.2-AffineInvariant

- source\_id：MD-3.6.2-AffineInvariant。

### MD-3.6.2-AffineInvariant

- 印刷页 / PDF页：130 / 152。
- 原文引文（逐字）：

> Definition 3.1 (Affine Invariance) Let

$$
\frac{\mathrm d\boldsymbol z}{\mathrm dt}=f(\boldsymbol z)\tag{3.16}
$$


> be a given ordinary differential equation. The transformation $\widetilde{\boldsymbol z}=A\boldsymbol z$, where $A$ is a non-singular square matrix, results in the modified differential equation

$$
\frac{\mathrm d\boldsymbol z}{\mathrm dt}=Af(A^{-1}\widetilde{\boldsymbol z}).\tag{3.17}
$$


> Let $z_0,z_1,\ldots$ be a sequence of points obtained by application of the numerical method $\mathcal G_h$ to (3.16). If the same method, when applied to (3.17) produces the set of points $Az_0,Az_1,\ldots$, then we say that the numerical method is invariant with respect to the transformation $\widetilde{\boldsymbol z}=Az$. An affine invariant method is one which is invariant under any such transformation.

- 问题所在：affineInvariant量化固定有限维实空间上的全部连续线性同构A、向量场f、实步长h和初值z；transportedField A f(z)=A(f(A⁻¹z))。完整关系G_{A f A⁻¹}(h,Az)=A(G\_f(h,z))正是变换初值后每一步等变，归纳即得所述序列。≃L准确表示有限维非奇异方阵；未偷加平移，也未把A限制成正交矩阵。PASS针对上下文已明示的变换坐标语义及当前方法定义；原印(3.17)左端记号疑误在json\_review保留NEEDS\_HUMAN。 网站原文审校另记：code：SOURCE\_TRANSFORMED\_COORDINATE\_TYPO；field：statement\_latex / issues；detail：(3.17)左端原印缺少z的波浪号；按变换坐标解释Lean定义合理，但原文不得静默修订。
- 反例或理由：code：SOURCE\_TRANSFORMED\_COORDINATE\_TYPO；field：statement\_latex / issues；detail：(3.17)左端原印缺少z的波浪号；按变换坐标解释Lean定义合理，但原文不得静默修订。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.affineInvariant`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.affineInvariant_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原文(3.17)保持印刷字面，继续标NEEDS\_HUMAN；另注勘误解释应为d z̃/dt=A f(A⁻¹ z̃)。现行按该语义给出的affineInvariant定义可保留。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch03.affineInvariant。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 19. MD-3.6.2-SymmetricAffineReversible

- source\_id：MD-3.6.2-SymmetricAffineReversible。

### MD-3.6.2-SymmetricAffineReversible

- 印刷页 / PDF页：130 / 152。
- 原文引文（逐字）：

> If a differential equation is time-reversible with respect to the involution $R$, and we apply a method which is affine invariant and symmetric, then the method will be time-reversible (3.15).

- 问题所在：symmetricAffineReversible的全部条件已核对：R为连续线性同构且平方为id；f有经典R反转；方法对全部线性同构等变；另只对本固定f显式要求G_{−f}(h)=G\_f(−h)；并要求所有h的反步复合G\_f(−h)∘G\_f(h)=id。因为量化所有h，最后一个条件同时给另一方向的逆关系，不必再把G编码为Perm。对R使用affineInvariant，利用transportedField R f=−f及变号相容性，得到R∘G\_f(h)∘R=G\_f(−h)，再复合G\_f(h)即为reversibleMethod。完整结论∀h,z,R(G\_f(h,R(G\_f(h,z))))=z与(3.15)一致；不存在把所需结论作为假设的问题。[EXTRA]变号相容性是实质新增且已明示的合理修复，不能把当前受限正确版本当作原句对所有抽象方法已成立。 网站原文审校另记：code：SOURCE\_METHOD\_CLASS\_QUALIFICATION\_MISSING；field：statement\_latex / issues；detail：仅线性等变和对称不足以对任意抽象G推出R可逆；原书省略的方法类或变号相容性资格需要人工确认，当前已作为[EXTRA]加入。
- 反例或理由：反例针对省略相容性的原文抽象蕴含，不满足当前Lean新增相容性：在ℝ上令R=id、f=0，定义所有g的G\_g(h,z)=exp(h³)z。此族对全部非奇异线性变换等变，各G(−h)是G(h)的逆，且G(0)=id（对f=0亦有正确一阶一致性）。但是R∘G\_f(h)∘R∘G\_f(h)(z)=exp(2h³)z，一般不等于z；G_{−f}(h)=G\_f(h)也不等于G\_f(−h)。所以原句按已给抽象定义需要附加资格；此例不声称满足一个未在本任务中规定的更强数值方法类。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.symmetricAffineReversible`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.symmetricAffineReversible_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留当前已明示[EXTRA]的正确受限声明及原书NEEDS\_HUMAN标记；若要解除原句疑误，需人工明确适用方法类并确认其变号相容性，不能删去新增前提。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch03.symmetricAffineReversible。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 20. MD-3.6.2-PartitionedAffine / MD-3.6.2-PartitionedAffinePrinted / MD-3.6.2-RKAffine

- source\_id：MD-3.6.2-PartitionedAffine；MD-3.6.2-PartitionedAffinePrinted；MD-3.6.2-RKAffine。

### MD-3.6.2-PartitionedAffine

- 印刷页 / PDF页：130 / 152。
- 原文引文（逐字）：

> All Runge-Kutta methods and Partitioned Runge-Kutta methods are affine invariant, thus, if they are also symmetric, then they preserve time-reversal symmetry.

- 问题所在：partitionedAffine作为受限修正版通过：对所有n,s及任意Lq,Lp、fq,fp、两套阶段和更新系数，三个前提精确给出PRK两阶段方程与更新；三个结论是分块运输后两阶段方程及终点更新。Lp/Lq逆像的位置和各自系数相配，h无额外限制。该修复不允许混合q,p，也不包含平移或时间反演；这些限制已明确写进scope/[EXTRA]，不是证明原文任意变换全称。[EXTRA]合理，但原印全称仍待人工勘误。 网站原文审校另记：code：SOURCE\_PRK\_GENERALITY；detail：受限修复正确，但它不能消除原印PRK对所有非奇异变换等变的数学疑误。
- 反例或理由：PRK取单阶段Aq=Ap=0、bq=1、bp=2，f(q,p)=(q,p)，h=1。更新为(2q,3p)。交换q,p后按相同分区表格得到(2p,3q)，而交换原更新为(3p,2q)，一般不同。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.partitionedAffine`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.partitionedAffine_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原句；将修复正式说明为保持分区的线性等变，原印全称单独标NEEDS\_HUMAN。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.partitionedAffine。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-3.6.2-PartitionedAffinePrinted

- 印刷页 / PDF页：130 / 152。
- 原文引文（逐字）：

> All Runge-Kutta methods and Partitioned Runge-Kutta methods are affine invariant, thus, if they are also symmetric, then they preserve time-reversal symmetry.

- 问题所在：依赖展开：Ch03\_deps.txt 的 MolecularDynamics/Chapter02/ReviewDefinitions.lean 定义 Q n = Fin n → ℝ、Z n = Q n × Q n；Chapter03/ReviewDefinitions.lean 定义 linearInvolution R 为 R.comp R = ContinuousLinearMap.id ℝ (Q n)，即 ∀z, R(Rz)=z。 partitionedRKRelation 展开为 (∀i, F\_i=f(z\_q+h∑_j Aq\_ij(F\_j)_q, z\_p+h∑_j Ap\_ij(F\_j)_p)) ∧ w=(z\_q+h∑_i bq\_i(F\_i)_q,z\_p+h∑_i bp\_i(F\_i)_p)。签名全称允许独立 Aq,Ap,bq,bp 和任意混合 q,p 的连续线性等价 L，并用真运输场 x↦L(f(L⁻¹x))。因为分区不同表格的求和不与任意混合 L 交换，原文的全线性 PRK 主张和这个签名都被反例否定，[ERRATUM?] 成立，不需人工判断或缺失定义。签名也未覆盖原句对称时保持时间反转的后半句。声明体为 sorry，此处 FAIL 来自实际反例及遗漏，非来自 sorry。 网站原文审校另记：
- 反例或理由：取 n=s=1，Q1 识别为 ℝ，Z1=ℝ²。h=1，Aq=[0]，Ap=[1]，bq=bp=[1]，f(q,p)=(p,q)，z=(1,0)，唯一阶段 F₀=(1,1)，w=(2,1)。原关系阶段输入为 (1,1)，f(1,1)=(1,1)，输出 (1+1,0+1)=(2,1)，故两个合取项均成立。取 L(q,p)=(p,q)，连续线性等价且 L⁻¹=L；运输场 LfL⁻¹=f。Lz=(0,1)、LF₀=(1,1)、Lw=(1,2)。运输后用同一 Aq,Ap 的阶段输入为 (0,2)，f(0,2)=(2,0)≠(1,1)，且预期输出为 (1,2)。故阶段合取项明确失败。两套权重均为1，反例并非不一致权重造成。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.partitionedAffinePrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：默认两套PRK表相同退化为普通相空间RK，才允许任意混合可逆线性变换；保持分区的更一般版本独立保留。；`MD.Ch03.partitionedAffinePrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“默认两套PRK表相同退化为普通相空间RK，才允许任意混合可逆线性变换；保持分区的更一般版本独立保留。”。
- 导师选项：将正确等变结论限制为保持分区的 L(q,p)=(Lq q,Lp p)，并显式标明是原句修复版；或若要允许所有混合线性 L，要求 Aq=Ap 且 bq=bp，使之退化为相空间上的普通 RK。时间反转推论还须限定 R 保持分区，或给表格与 R 的具体相容条件，并加入相应对称及符号相容论证。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch03.partitionedAffinePrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-3.6.2-RKAffine

- 印刷页 / PDF页：130 / 152。
- 原文引文（逐字）：

> All Runge-Kutta methods and Partitioned Runge-Kutta methods are affine invariant, thus, if they are also symmetric, then they preserve time-reversal symmetry.

- 问题所在：普通RK子句签名正确：n、s允许零维/零阶段，L为实连续线性自同构；任意f、实系数A,b及实h，给定完整阶段解F与终点w，结论正是运输场L∘f∘L⁻¹下运输阶段、初末状态满足同一关系。没有偷加求解唯一性，也没有断言存在数值单值映射。原页定义所谓affine invariance实际只写非奇异线性变换，故本条不因缺平移判FAIL。[EXTRA]/scope明确只覆盖普通RK，未覆盖PRK和时间反演推论。原句对任意混合q,p变换的PRK全称过强，且时间反演仍须原微分方程对R可逆；这些原书资格疑点须保留。 网站原文审校另记：code：SOURCE\_PRK\_GENERALITY；detail：原页确实印有All ... Partitioned Runge-Kutta ... affine invariant；不同分区表格的PRK一般只对保持分区的变换等变，不能将原句当无条件正确结论。；code：SOURCE\_REVERSIBILITY\_CONTEXT；detail：原页上一段先假设微分方程对R可逆；末句应在该语境读取，不能仅由方法对称性推出任意ODE的时间反演。
- 反例或理由：PRK取单阶段Aq=Ap=0、bq=1、bp=2，f(q,p)=(q,p)，h=1。更新为(2q,3p)。交换q,p后按相同分区表格得到(2p,3q)，而交换原更新为(3p,2q)，一般不同。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.rkAffine`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.rkAffine_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保持statement\_latex原文；将普通RK子签名标为通过，原句PRK全称交人工处理；时间反演另条须保留f(Rz)=−Rf(z)资格。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.rkAffine。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 21. MD-3.6.3-ConjugateIterates

- source\_id：MD-3.6.3-ConjugateIterates。

### MD-3.6.3-ConjugateIterates

- 印刷页 / PDF页：131–132 / 153–154。
- 原文引文（逐字）：

> Recall that a pair of maps $\Phi$ and $\Psi$ are said to be conjugate if there is a homomorphism $\chi$ such that

$$
\Phi=\chi^{-1}\Psi\chi.
$$


> In such a case the iterates of the two maps will also be conjugate

- 问题所在：主声明已为任意类型α、任意可逆Equiv χ及A,B，假设A=χ⁻¹∘B∘χ，对所有自然数n给出完整共轭迭代恒等式，包含n=0；没有拓扑或范数前提。homeomorph辅助版同样正确，额外连续性仅属于辅助版本。原页确实写homomorphism并随后使用χ⁻¹；一般同态不保证可逆，原书用词须人工处理，Equiv是合理显式修复。context仍把主签名说成实赋范空间和Homeomorph，已经过时。 网站原文审校另记：code：SOURCE\_INVERTIBILITY\_AMBIGUITY；detail：原印homomorphism不能单独保证χ⁻¹存在，保留原文并标注疑误。；code：STALE\_SCOPE\_ANNOTATION；detail：主声明现已为任意类型Equiv；旧context错误限制主声明。
- 反例或理由：code：SOURCE\_INVERTIBILITY\_AMBIGUITY；detail：原印homomorphism不能单独保证χ⁻¹存在，保留原文并标注疑误。；code：STALE\_SCOPE\_ANNOTATION；detail：主声明现已为任意类型Equiv；旧context错误限制主声明。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.conjugateIterates`（未证）；`MD.Ch03.conjugateIterates_homeomorph`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.conjugateIterates_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原句不改；确认作者是否意指可逆同态或homeomorphism，并保留Equiv修正版。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.conjugateIterates。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 22. MD-3.6.3-ConjugateOrderPrinted

- source\_id：MD-3.6.3-ConjugateOrderPrinted。

### MD-3.6.3-ConjugateOrderPrinted

- 印刷页 / PDF页：132 / 154。
- 原文引文（逐字）：

> and, if they are numerical methods, they will have similar stability properties and performance (e.g. the same effective order).

- 问题所在：展开 Chapter03Review.localOrder：存在 C>0,δ>0，使全部 |h|<δ 和 z∈B 满足 ‖G h z−Φ h z‖≤C|h|^(r+1)。这不是 effective order 的定义，而是相对任意参考映射的局部误差上界；Φ 没有任何实际流资格。Homeomorph 与 IsCompact B、r>0 都不足以保持同一误差幂阶。已有标记指出数学风险，但 Lean 签名仍断言错误的全称命题，不能因 sorry 或 NEEDS\_HUMAN 标记而通过。原文问题是 “similar stability properties and performance (e.g. the same effective order)” 中 effective order 的精确定义、允许的处理器以及正则性未给出；这部分须数学判断，A记 NEEDS\_HUMAN，C的明确假命题记FAIL。还未形式化原句的稳定性/性能条款。 网站原文审校另记：
- 反例或理由：取 n=1,r=1，识别 Q 1≅ℝ；B={0}（紧），Φ(h,x)=x（恒等参考流），G(h,x)=x+h²。χ(x)=sgn(x)√|x|，χ⁻¹(y)=y|y|，是全局 homeomorphism。原误差恒为 h²，取 C=1,δ=1 满足 localOrder。χ(B)={0}，在0处共轭误差为 |χ(h²)−χ(0)|=|h|，不可能在任何零邻域被 C′|h|² 一致控制。即使 Φ 已是真实恒等流，反例仍成立。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.conjugateOrderPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：补运输映射的全局Lipschitz充分资格；只给单向局部误差阶运输，不声称全部effective order、性能或稳定性。；`MD.Ch03.conjugateOrderPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“补运输映射的全局Lipschitz充分资格；只给单向局部误差阶运输，不声称全部effective order、性能或稳定性。”。
- 导师选项：先澄清 effective order 的原书含义；若确要误差阶运输，要求 χ 在包含 G(h,B) 与 Φ(h,B) 的共同邻域上一致 Lipschitz，双向同阶通常需双向 Lipschitz，并补参考流与方法的资格。稳定性、性能及 effective order 条款分别给明确定义，避免仅用 localOrder 代替全部原句。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch03.conjugateOrderPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 23. MD-3.6.3-ReversibleVolumeFailure

- source\_id：MD-3.6.3-ReversibleVolumeFailure。

### MD-3.6.3-ReversibleVolumeFailure

- 印刷页 / PDF页：132 / 154。
- 原文引文（逐字）：

> Of particular importance for molecular dynamics are the following properties: a symplectic map will preserve volume, whereas a time-reversible map need not do so, and a symplectic integrator will approximately conserve energy due to the existence of the perturbed Hamiltonian, whereas a time-reversible integrator may give rise to a drift in energy [166].

- 问题所在：已展开Ch03\_deps.txt中的实际定义：MolecularDynamics.Chapter02Review.Q n := Fin n → ℝ（第2816行）；linearInvolution R := R.comp R = ContinuousLinearMap.id ℝ (Q n)（第3616行）；MolecularDynamics.textbookCoordinateJacobian G z := LinearMap.toMatrix' (fderiv ℝ G z).toLinearMap（第2365–2366行），其第(i,j)项为((fderiv ℝ G z) (Pi.single j 1)) i（第2368–2369行）。因此这里是实n维空间的真实导数矩阵，而非替代变量。G : Q n ≃ Q n给出双射及逆，双方ContDiff ℝ 1给出C¹微分同胚；R是连续线性对合，∀z, R(G(R(G z)))=z等价于R∘G∘R=G⁻¹，忠实表达相对于R的可逆性。存在z使绝对雅可比行列式不为1，结合C¹微分同胚的换元性质，确实表达不保持Lebesgue体积。量词∃n∃R∃G再∃z正确表达need not，而非错误地要求所有可逆映射都非保体积。C¹、双射和线性对合是为给出真实光滑反例采用的合理对象限制；本条无[EXTRA]或[ERRATUM?]标注，也无原书错误需静默修正。然而statement\_scope明确包含所引整句，Lean签名只覆盖其中“a time-reversible map need not do so”这一子句，缺少其余三项结论。context\_notation称其他结论已在别处保留，不能代替本条对具体声明或引用的覆盖。故完整范围的语义审计FAIL；若范围显式限定为可逆非保体积存在性，则此签名本身可通过该子句的语义审计。Ch03.lean第1276–1280行的证明为sorry；这是未完成证明，独立于上述签名覆盖不足的判断。 网站原文审校另记：
- 反例或理由：缺失条款：①辛映射保持体积；②辛积分器因扰动Hamiltonian而近似保持能量（需保留适用条件及定量意义）；③时间可逆积分器可能产生能量漂移。当前签名没有Hamiltonian、积分器族、步长、轨道或能量函数，因而无法表达②③，也没有辛映射的保体积结论。这里不是声称已形式化的存在性子句为假，而是整句覆盖不足。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.reversibleVolumeFailure`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.reversibleVolumeFailure_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留当前真实C¹可逆非保体积存在性签名，同时为所引整句补充并明确关联其余三项结论的具体Lean声明：辛映射的体积保持、具备明确BEA条件的近似能量守恒，以及可逆积分器存在能量漂移的实例或精确命题。不要将may改为所有可逆积分器必然漂移。另一可行修复是明确将本条statement\_scope及对应原文摘录限定为可逆映射未必保体积，并把其余子句建立为有明确声明映射的独立条目；不能只用context\_notation声称已覆盖。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch03.reversibleVolumeFailure。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 24. MD-3.7.1-FreeHardSphereHamiltonian / MD-3.7.1-HardCorePotential

- source\_id：MD-3.7.1-FreeHardSphereHamiltonian；MD-3.7.1-HardCorePotential。

### MD-3.7.1-FreeHardSphereHamiltonian

- 印刷页 / PDF页：133 / 155。
- 原文引文（逐字）：

> The hard sphere system described by

$$
H_{\mathrm{free}}=p^TM^{-1}p/2+U_{\mathrm{h.s.}}
$$


> consists of purely ballistic (straight line) motion punctuated by momentum jumps.

- 问题所在：主定义对正质量、N个d维位置和动量给出原印≤障碍的自由Hamiltonian，有限区动能∑‖pi‖²/(2mi)及WithTop ℝ编码正确。ballistic辅助对所有t给出q\_i(t)=q\_i+t p\_i/mi的全局导数及常动量导数0，公式正确；它是自由段ODE公式，不声称直线路径穿过障碍仍是实际硬球轨道。contactAllowed辅助保留闭可行域版本；其自身未带正质量前提，作为实全除法定义有意义，物理使用须另加正质量。scope已明确接触反射由其他条目承担。旧[EXTRA]第一项说主版本沿用p132接触允许，与当前主定义矛盾，应更正；原印边界冲突仍须人工处理。 网站原文审校另记：code：SOURCE\_CONTACT\_BOUNDARY\_CONFLICT；detail：自由Hamiltonian继承原印≤与接触允许语境的边界冲突。；code：STALE\_BOUNDARY\_ANNOTATION；detail：extra\_assumptions第一项说沿用接触允许边界，但主定义实际是原印≤；contactAllowed才允许接触。
- 反例或理由：code：SOURCE\_CONTACT\_BOUNDARY\_CONFLICT；detail：自由Hamiltonian继承原印≤与接触允许语境的边界冲突。；code：STALE\_BOUNDARY\_ANNOTATION；detail：extra\_assumptions第一项说沿用接触允许边界，但主定义实际是原印≤；contactAllowed才允许接触。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.freeHardSphereHamiltonian`（定义）；`MD.Ch03.freeHardSphereHamiltonian_ballistic`（未证）；`MD.Ch03.freeHardSphereHamiltonian_contactAllowed`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.freeHardSphereHamiltonian_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留主定义原印≤及辅助命名；不将ballistic公式当全局无碰撞资格，人工确认原书障碍边界。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.freeHardSphereHamiltonian。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。


### MD-3.7.1-HardCorePotential

- 印刷页 / PDF页：133 / 155。
- 原文引文（逐字）：

> Splitting methods are suggested by considering a formal hard-sphere Hamiltonian

$$
H_{\mathrm{h.s.}}=p^TM^{-1}p/2+U(q)+U_{\mathrm{h.s.}},
$$


> where $U_{\mathrm{h.s.}}$ is assumed to be infinite for overlapping configurations (some $\|q_i-q_j\|\le\sigma_i+\sigma_j$) and zero otherwise.

- 问题所在：原印≤已目视确认。hardCorePotential以ENNReal表达不同粒子距离≤半径和则∞、否则0，字面忠实；hardSphereHamiltonianPrinted在同一判据下返回∞，否则正质量动能和任意实U，WithTop ℝ容许负有限势，完整H表达正确。contactAllowed辅助为闭允许域内0、外∞，对应严格重叠才惩罚的物理边界，明确分名，不能代替Printed。定义本身无签名错误；原书p132允许等号和p133将等号判∞的冲突必须保留人工裁定。 网站原文审校另记：code：SOURCE\_CONTACT\_BOUNDARY\_CONFLICT；detail：p132允许接触等号，p133原印≤又使接触势∞；两个版本均已忠实分开，原书边界疑点未解决。
- 反例或理由：两球σ1=σ2=1/2，中心距离1：hardCoreDomain允许该构型，hardCorePotential及hardSphereHamiltonianPrinted却取∞；contactAllowed取0势。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.hardCorePotential`（定义）；`MD.Ch03.hardSphereHamiltonianPrinted`（定义）；`MD.Ch03.hardCorePotential_contactAllowed`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：允许接触等号，只有严格重叠才取∞；原印≤判∞独立保留。；`MD.Ch03.hardCorePotential_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“允许接触等号，只有严格重叠才取∞；原印≤判∞独立保留。”。
- 导师选项：原印≤与Printed定义保持；由人工决定是否另以严格<作为物理勘误，不静默覆盖原句。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.hardCorePotential。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 25. MD-3.7.1-PrimitiveOrder

- source\_id：MD-3.7.1-PrimitiveOrder。

### MD-3.7.1-PrimitiveOrder

- 印刷页 / PDF页：133–134 / 155–156。
- 原文引文（逐字）：

> Even with this symmetric form (“kick”, “drift”, “kick”) where “drift” now involves the solution of the system $H_{\mathrm{free}}$, it was shown in [184] that energy accumulates rapidly. Assuming a finite number of collisions on a fixed interval, the error behaves as $O(h)$. In long simulations the energy error grows without bound.
> In general, because an error of size $O(h)$ occurs in each collision and there are a finite number of collisions in a fixed time interval, the total error is also $O(h)$, i.e. first order.

- 问题所在：已展开Q、Z(2816–2817)、grad(2932)、positiveMass(2948)、invMass(2840)、finiteCollisionTrajectory(4431–4441)、collisionalGlobalOrder(4460–4464)、admissibleCollisionState及freeCollisionFlow(4465–4472)。目标是经θ:ℝ≃oℝ进行O(h)时间移动后的全相空间网格误差，而原文以能量缺陷为论据，且明确包含长期能量误差无界；该结论子句完全未表示。更严重，finiteCollisionTrajectory只要求q在闭区间连续，p的ODE仅在内部非事件点成立，事件时只约束左右极限，不约束p(t)的取值；端点动量也无连续性要求。故它不能保证真实初始状态和右侧轨道一致，签名甚至在无碰撞时为假。有限横截性确有内积<0，单个光滑g则是比多硬球约束窄的模型；C∞可作为充分正则性，但非书中明确必需条件。freeCollisionFlow对每个τ只允许内部事件且要求全局有限碰撞，强于所称固定区间假设。sorry独立存在，不改变这些语义缺陷。 网站原文审校另记：
- 反例或理由：n=1,m=1,U=0,g=1,τ=1,events=∅。令q(t)=0，p(0)=1，其余t的p(t)=0。finiteCollisionTrajectory全部成立。取真实自由流Gfree(t,(x,v))=(x+t v,v)，满足freeCollisionFlow。kick恒等，从(q(0),p(0))=(0,1)迭代ν步得到(1,1)，而θ(1)=1强迫比较(q(1),p(1))=(0,0)，误差≥1，不能≤C/ν。另U=0的真实硬球轨道能量严格守恒，说明原书长期无界不能理解为所有系统的全称命题。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.primitiveOrder`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：限定为事件表穷尽真实接触、非零法向、初端右连续、终端左连续且终端无碰撞、事件取碰后动量的轨道；只保留明确的时间对齐误差目标，不宣称同时间动量阶。精确子流Strang仍是独立限定解释，原混合法及无根事件分支未覆盖。二阶项另限数值碰撞横截；尚缺统一事件稳定性与误差累积理论。；`MD.Ch03.finiteCollisionTrajectory_corrected`（定义）；`MD.Ch03.primitiveOrder_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“限定为事件表穷尽真实接触、非零法向、初端右连续、终端左连续且终端无碰撞、事件取碰后动量的轨道；只保留明确的时间对齐误差目标，不宣称同时间动量阶。精确子流Strang仍是独立限定解释，原混合法及无根事件分支未覆盖。二阶项另限数值碰撞横截；尚缺统一事件稳定性与误差累积理论。”。
- 导师选项：先修正轨道定义：初端右连续、末端左连续，碰撞时约定并绑定实际p(t)为碰后值；限制允许初态、接触几何和同时/掠碰。明确时间对齐误差是新增的收敛目标并单独证明能量O(h)；长期无界需按适当实例/条件另述，不能遗漏也不能无条件全称化。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch03.primitiveOrder。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 26. MD-3.7.1-EndImpactThirdOrderPrinted

- source\_id：MD-3.7.1-EndImpactThirdOrderPrinted。

### MD-3.7.1-EndImpactThirdOrderPrinted

- 印刷页 / PDF页：134 / 156。
- 原文引文（逐字）：

> In cases (i) and (ii) it is clear that the error accumulating in a single step will be third order in the stepsize, since the Verlet method has local error of order three (since it is a second order method).
> • there is no collision
> • the collision occurs at the end of a timestep

- 问题所在：已展开Position和obstacleReflection，核对Ch03.lean:1404–1420：确实保留tc=h、反射及末尾half-kick，并用∃C,δ正量化O(h³)能量差。但原条范围还包括无碰撞分支，签名完全未表示该子句。末端反射分支本身为假，即使补上原文‖qc‖=1、局部物理入射，也不成立；以下单位球反例直接验证[ERRATUM?]，并非仅由套用步内公式到端点推测。C³是合理充分正则性，qc≠0合理；对所有h>0约束步族比局部误差需要更强。原文“error”的状态/能量解读应明确，但在当前选定能量解读下已有确定反例，因此FAIL。含sorry不作为语义FAIL理由。 网站原文审校另记：
- 反例或理由：d=1,U(x)=x,qc=1,pbar=−1,tc(h)=h，initial(h)=(1+h+h²/2,−1)。F=−1，pminus=−1−h/2，反射后=1+h/2，final(h)=(1,1)。这是从单位障碍外侧到末端首次接触的真实入射步，所有h>0的前提成立，U为C∞。ΔH=(1/2+1)−(1/2+1+h+h²/2)=−h−h²/2；|ΔH|/h³→∞。故无法选择固定C,δ得到O(h³)。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.endImpactThirdOrderPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：原末端碰撞三阶能量断言有反例；对接近接触点的初值族只给一阶上界，新增趋近资格排除隐式方程的远端分支，不声称二阶或三阶。；`MD.Ch03.endImpactThirdOrderPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“原末端碰撞三阶能量断言有反例；对接近接触点的初值族只给一阶上界，新增趋近资格排除隐式方程的远端分支，不声称二阶或三阶。”。
- 导师选项：将原书末端三阶断言作为有反例的勘误记录，而非可证明的通用定理。无碰撞Verlet局部三阶单独陈述；若欲恢复末端碰撞三阶，须改变碰撞时刻/末kick调度或增加势在碰撞法向不变等充分结构，并独立推导，不能静默修改原书。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch03.endImpactThirdOrderPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 27. MD-3.7.2-CollisionalVerletRelation

- source\_id：MD-3.7.2-CollisionalVerletRelation。

### MD-3.7.2-CollisionalVerletRelation

- 印刷页 / PDF页：135 / 157。
- 原文引文（逐字）：

> Collisional Verlet Algorithm (CVA) [Single Step]
> [computes $h$ (the timestep) and $(Q,P)$ given a starting point $(q,p)$]
> Calculate $\tau_c$ the time of next collision from the Verlet paths (quadratics) of (3.18) using collision conditions (3.19).
> If $\tau_c<h_{\max}$, then

$$
h:=\tau_c,\qquad(Q,P):=R_c\mathcal G_h^{\mathrm{Verlet}}(q,p)
$$


> else

$$
h:=h_{\max},\qquad(Q,P):=\mathcal G_h^{\mathrm{Verlet}}(q,p).
$$



- 问题所在：辅助collisionalVerletRelation精确保留0<tc、0<hmax、h=min(tc,hmax)和严格tc<hmax才反射的分支；m,F,Rc任意，故仅是参数化更新。physicalCVARelation已补正质量/半径、可微U及F的负微分对偶、初态非重叠、粒子二次路径、全体粒子对先前严格分离、唯一碰撞对（交换同一对除外）和质量加权弹性反射。particleVerlet与二次路径位置一致，particleReflection的法向两粒子分量相反，分母由正质量及接触距离正而非零。none分支要求所有正时间无接触，表示无未来根而非仅步长内无根；some允许tc超过hmax，不会误反射。tc=hmax严格走else忠实于原书；但下一步从接触初态选严格正根可能遗漏即时反射，算法边界疑点保留。额外排除多重碰撞、要求初态合法和保守力均明确披露，未声称阶数或求根实现。 网站原文审校另记：code：SOURCE\_EQUALITY\_BRANCH；detail：原印tc=hmax不反射；若接触时正入射，下步只找严格正根不能补上t=0事件，须人工确定边界处理。
- 反例或理由：一维两球相向匀速，初始间距=半径和+相对速度×hmax，F=0。则tc=hmax，原分支到接触仍保持入射动量；从该接触态继续寻找严格正接触根，不能表达当下应发生的反射。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.collisionalVerletRelation`（定义）；`MD.Ch03.particleQuadraticPath`（定义）；`MD.Ch03.particleVerlet`（定义）；`MD.Ch03.particleReflection`（定义）；`MD.Ch03.physicalCVARelation`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch03.collisionalVerletRelation_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原印严格<保持不动；人工决定是否另立≤反射的修正版或明示端点事件传递约定。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.collisionalVerletRelation。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 28. MD-3.7.2-CollisionalVerletOrder

- source\_id：MD-3.7.2-CollisionalVerletOrder。

### MD-3.7.2-CollisionalVerletOrder

- 印刷页 / PDF页：135 / 157。
- 原文引文（逐字）：

> A step can then be taken to the first point of subsequent collision, with positions updated using the quadratic and momenta adjusted according to the Verlet map combined with $R_c$. In this way, all steps taken are Verlet steps so the order of accuracy is two. Effectively, this is a Verlet method with variable timestep chosen to match collision times.

- 问题所在：已读本地 Ch03.lean:1445–1468 及依赖 MolecularDynamics/Chapter03/Statements.lean:4508–4530，并展开所有专用定义。Q n=Fin n→ℝ，Z n=Q n×Q n；positiveMass m 为 ∀i,0<m i；grad U q i=(fderiv ℝ U q)(Pi.single i 1)；invMass m v i=v i/m i；collisionQuadraticPath 与 verlet 如式(3.18)及完整速度 Verlet 更新。oneStepIterate G h z j=(G h)^[j]z（MolecularDynamics/Chapter02/OneStepConvergence.lean:1443–1444），所以这里迭代的 h 参数是固定外层 hmax，实际累计时间另由 times 的 min(tc,hmax) 递推。admissibleCollisionState（Statements.lean:4464–4465）为 g(q)>0 或 g(q)=0 且 ∑ grad g(q)_i p\_i/m\_i>0。finiteCollisionTrajectory（4431–4440）只要求 q 在闭区间连续、g(q)≥0、在开区间非事件处满足 Newton ODE，并在有限 events 的每个内部事件有接触、左右动量极限、负入射法向速度及弹性左右极限关系；它不规定 p 在端点的值／连续性，不规定事件处 p(t) 取哪侧，也没有“所有接触恰为 events”的双向资格。签名再要求每个 admissible 状态都有有限最小正二次路径根 tc，明确给出 Rc 的质量加权反射公式，并要求所有 h>0、所有状态满足分支关系。结论是存在统一 C,δ，在合格自适应网格上允许 θ:ℝ≃oℝ 的 O(hmax²) 时间对齐后，全相空间节点误差 O(hmax²)，且 θ 固定0和τ。定义全部已找到，不需要 NEEDS\_HUMAN。
[EXTRA]正质量、光滑势／接触函数和有限非切向实际事件，是可用于限定二阶论断的合理资格，但数值根没有横截条件；所谓“有限横截隔离事件”只保证列出的实际 events，而不排除漏列接触。排除 tc=hmax 如实避开原书未反射边界，得到的是额外限定版本；时间对齐在结论中而非前提中，不能冒充原书明示的同时间二阶误差定义。要求对所有 admissible 状态必有有限未来根不必要且过强，排除了自由静止或永不相撞的合法状态，宜按有限窗口／可选接触表示。
更直接地，现有签名为假：finiteCollisionTrajectory 没有约束终点动量，却在结论中强制比较该终点动量，下面反例满足全部现有前提。原书的概括性论断不能由这一失真的轨迹对象承载。[ERRATUM?]本条无该标签；保留原书严格分支，不因本次签名反例给原书添加未经依据的勘误。该 theorem 的证明体为 sorry，这是独立的证明完成度问题，FAIL 来自定义／结论反例而非 sorry。 网站原文审校另记：
- 反例或理由：令 n=1、m=1，按 Q 1≃ℝ 识别坐标，取光滑 U(x)=−x、F=−grad U=1、g(x)=1−x²、τ=1、events=∅。令 q(t)=t²/2，p(t)=t（t≠1），但 p(1)=100。在 0<t<1 上 q′=p=t、p′=1，闭区间 q 连续且 g(q)≥3/4>0，所以 finiteCollisionTrajectory 成立；它没有检查 p(1)。对每个 admissible z=(x,v)，定义 tc(z) 为 x+vt+t²/2 首次到达 ±1 的正时刻。因 x 位于(−1,1)，或在端点且 v 严格指向内部，并且该抛物线最终趋向+∞，此根存在且此前 g>0；对非 admissible 状态置 tc=1，保证全状态 tc>0。令 Rc 恰等于签名的反射公式，G 恰按 collisionalVerletRelation 的严格分支定义，则所有 h>0、所有 z 的算法前提成立。对任意充分大的整数 N≥3，取 hmax=1/N：直至 times\_N=1，每个节点数值状态都精确为 ((j/N)²/2,j/N)，其下一根 tc\_j=√2−j/N≥√2−1>hmax，故所有 times\_j<1 的资格与 tc\_j≠hmax 都成立。结论规定 θ(1)=1，所以 j=N 的相空间误差必为 |1−100|=99。任意固定 C,δ 都可取 N 足够大使 1/N<δ 且 C/N²<99，违反所需误差界。此反例针对 Lean 签名的端点漏洞，不声称这条具有任意终点赋值的 p 是原书所意指的物理轨迹。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.collisionalVerletOrder`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：限定为事件表穷尽真实接触、非零法向、初端右连续、终端左连续且终端无碰撞、事件取碰后动量的轨道；只保留明确的时间对齐误差目标，不宣称同时间动量阶。精确子流Strang仍是独立限定解释，原混合法及无根事件分支未覆盖。二阶项另限数值碰撞横截；尚缺统一事件稳定性与误差累积理论。；`MD.Ch03.collisionalVerletOrder_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“限定为事件表穷尽真实接触、非零法向、初端右连续、终端左连续且终端无碰撞、事件取碰后动量的轨道；只保留明确的时间对齐误差目标，不宣称同时间动量阶。精确子流Strang仍是独立限定解释，原混合法及无根事件分支未覆盖。二阶项另限数值碰撞横截；尚缺统一事件稳定性与误差累积理论。”。
- 导师选项：先修正轨迹资格：指定右连续的碰撞后动量约定，要求非事件处及0、τ处的相应单侧连续性，约束初始动量与起始 ODE 段匹配，并要求每次真实接触都由有限事件表正确分类，终点无未处理碰撞或明确采用相同侧值。其次以选定不同粒子对的实际硬球间隙或有明确物理解释的接触函数表达碰撞，要求非退化接触法向和精确／数值的横截及稳定性；将全状态必有有限 tc 改为有根时的首根资格与无根时的正常 Verlet 分支。保留严格等号边界的限制，并在定理名称／说明中标明这是受限版本。明确原文“二阶”采用时间对齐误差、位置误差还是同时间相空间误差，按选择的定义重述所有结论；不能用含任意 θ 的较弱误差概念悄悄替代同时间概念。这些均为修复建议，本次未修改 Lean 或补证明。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch03.collisionalVerletOrder。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 29. MD-3.7.3-PairForceDecoupling

- source\_id：MD-3.7.3-PairForceDecoupling。

### MD-3.7.3-PairForceDecoupling

- 印刷页 / PDF页：136 / 158。
- 原文引文（逐字）：

> This can be achieved in systems of spheres with pair potentials $\varphi_{ij}$ only by writing $\varphi_{ij}=\alpha_{ij}+\beta_{ij}$ where the derivative of the second term is chosen to vanish at the point of contact between the spheres, i.e. $\alpha'_{ij}(\sigma_i+\sigma_j)=0$.

- 问题所在：Ch03.lean:1467–1468展开为对每个实数r有φ(r)=α(r)+β(r)，且deriv α contact=0；无其他封装定义。contact作为σ\_i+σ\_j的参数化是合理抽象，但定义只保留展示公式的α′条件，没有解决原文“second term”应指β而后句又让β负责kick的矛盾。[ERRATUM?]冲突经PDF确认成立；需数学判断究竟修改文字“second”为“first”，还是修改公式α′为β′，两者会产生不同算法。另需注意Lean的deriv是全函数，未可微处取0；原书谈导数的语义需适当可微条件。无[EXTRA]。这是定义而非含sorry的定理，签名问题独立于证明状态。所需定义均已找到，NEEDS\_HUMAN的原因仅为上述原书问题。 网站原文审校另记：
- 反例或理由：未单列反例；问题在原文省略资格、术语、证明步骤或覆盖范围。请结合原句及下列修正核查。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.pairForceDecoupling`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：明确α为kick势并补接触点可微，deriv α contact=0才作为经典零接触力；α/β文字冲突保留导师选项。；`MD.Ch03.pairForceDecoupling_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“明确α为kick势并补接触点可微，deriv α contact=0才作为经典零接触力；α/β文字冲突保留导师选项。”。
- 导师选项：先人工裁定原书文字与公式的勘误；保留原句和勘误记录。确定哪个势为kick势后单独定义零接触导数条件，并加入DifferentiableAt或约定势光滑；contact实例化为σ\_i+σ\_j。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch03.pairForceDecoupling。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 30. MD-3.7.3-DecoupledOrder

- source\_id：MD-3.7.3-DecoupledOrder。

### MD-3.7.3-DecoupledOrder

- 印刷页 / PDF页：136 / 158。
- 原文引文（逐字）：

> The idea is to exploit the observation that impulsive forces (“kicks”) can be supplied without reducing the order of accuracy as long as these have a vanishing component in the direction of the collision vector $u_\perp$, that is if $F_\perp=-\nabla U(q_c)\cdot u_\perp=0$.
> If this decomposition is used, then it is possible to build a 2nd order accurate hybrid method that uses only the first part $\alpha$ to define the quadratic Verlet paths for the collision detection scheme, whereas $\beta$ is introduced as a standard “kick” at collision points.

- 问题所在：依赖Ch03\_deps.txt已展开：ReviewDefinitions中的Q n=Fin n→ℝ，Z n=Q n×Q n，grad U q i=(fderiv ℝ U q)(Pi.single i 1)，invMass m v i=v\_i/m\_i，positiveMass为逐分量正质量；Statements中的finiteCollisionTrajectory要求q在闭区间连续、g(q)≥0、非事件开区间内q′=M⁻¹p及p′=F(q)，有限事件具有入射负法向速度、左右极限和弹性反射；但不约束p在0、τ或事件时刻的实际取值，也不要求端点动量连续。collisionalGlobalOrder展开为∃C>0、ν₀>0，对每个ν≥ν₀存在保序双射θ，固定0和τ且|θ(t)−t|≤C(τ/ν)^2，所有j≤ν的数值状态与(q,p)(θ(jτ/ν))误差≤C(τ/ν)^2；oneStepIterate是真正从(q0,p0)迭代(G h)^j。以下无碰撞反例已否定签名。[EXTRA]正质量、有限横截事件、光滑性和允许O(h²)时间对齐可作为明确的局部适用条件，但Gfree被假设为任意时长的精确V碰撞流，结论使用步首步尾U半kick，未给出原书α的二次Verlet碰撞检测及在碰撞点施加β kick的混合法。边界法向条件是质量加权grad g·M⁻¹grad U=0，需说明它与原书u_⊥的坐标/质量约定，不能直接认作原书未加权点积。并且对所有g≥0状态要求全时长Gfree远强于有限横截局部问题；缺少右连续及端点实际动量约定。[ERRATUM?]原书α/β矛盾确实存在，需另行裁定，但此FAIL不依赖其裁定。Ch03.lean:1485后为sorry；未证明状态与上述语义失败分别记录。 网站原文审校另记：
- 反例或理由：取n=1、m₀=1、U=V=0、g≡1、τ=1、events=∅。令q(t)=0，p(t)=0（t≠1），p(1)=1；所有开区间ODE条件成立，q连续、g≥0，故finiteCollisionTrajectory成立。取Gfree(t,(a,b))=(a+t b,b)；对所有状态、所有T>0，它的轨道满足V=0、g=1、ev=∅的finiteCollisionTrajectory，且Gfree(0,z)=z，零法向条件亦成立。从(q(0),p(0))=(0,0)出发，两个U kick都是恒等，所有迭代都为(0,0)。结论在j=ν且θ(1)=1处要求1≤C/ν²，对任意固定C及所有充分大的ν不可能。因此签名为假，且反例没有碰撞或任何原书勘误歧义。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch03.decoupledOrder`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：限定为事件表穷尽真实接触、非零法向、初端右连续、终端左连续且终端无碰撞、事件取碰后动量的轨道；只保留明确的时间对齐误差目标，不宣称同时间动量阶。精确子流Strang仍是独立限定解释，原混合法及无根事件分支未覆盖。二阶项另限数值碰撞横截；尚缺统一事件稳定性与误差累积理论。；`MD.Ch03.decoupledOrder_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“限定为事件表穷尽真实接触、非零法向、初端右连续、终端左连续且终端无碰撞、事件取碰后动量的轨道；只保留明确的时间对齐误差目标，不宣称同时间动量阶。精确子流Strang仍是独立限定解释，原混合法及无根事件分支未覆盖。二阶项另限数值碰撞横截；尚缺统一事件稳定性与误差累积理论。”。
- 导师选项：先明确目标算法：定义原书α的二次Verlet轨道、碰撞检测、反射及碰撞点β kick，再对该算法陈述二阶结果。finiteCollisionTrajectory须加入初末端点动量的单侧连续性，以及每个事件实际值等于选定的单侧极限（例如右连续），使参考轨道是确定的物理状态；Gfree同样须有该约定，限制到适当可接受初态与所需局部时间，并补足唯一性及稳定性条件。澄清质量加权法向与u_⊥的关系；人工裁定α/β勘误并记录。若保留现有精确子流Strang方法，应独立命名和证明，不能作为原书所述混合法的直接转录。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch03.decoupledOrder。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


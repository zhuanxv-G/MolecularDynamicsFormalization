# 网站NEEDS_HUMAN分流

原始返回和完整理由见website_audit.json；以下问题未替导师作数学选择。

## (i) 材料缺失：补材料后复审


## (ii) 原文数学判断：供导师裁定

- MD-3.1-ShadowEllipses：slightly要求形状扰动还是还要求主轴转角趋零？选项：形状扰动 / 非圆分支转角趋零。
- MD-3.2-FiniteLieTaylor：原等号采用Taylor jet渐近解释还是仅形式系数解释？选项：Taylor jet / 形式系数另立余项定理。
- MD-3.2-FlowCoordinates：实际流与形式exp采用何种连接？选项：逐初值Taylor jet / 形式拉回逐系数关系。
- MD-3.4-AnalyticDefect：原文允许哪些方法类及解析邻域，有限阶与指数结论的范围如何确定？选项：导师指定方法和范围 / 保留未定。
- MD-3.7.3-PairForceDecoupling：文字与公式不一致时哪个势是kick势？选项：按文字另立勘误 / 按公式另立勘误。

## EAUDIT03 原文数学判断（保持现状）

- MD-3.1-ShadowEllipses：slightly rotated是否要求旋转角趋零须先确定，圆形退化时主轴不唯一；选项：仅形状小扰动／非圆分支补主轴趋零并单列圆。保持现状，不默补非圆前提。 网站反例：退化例：a=b=1、0<ε<2 时，x²+y²+εxy=(1+ε/2)((x+y)/√2)²+(1−ε/2)((−x+y)/√2)²。可取 θ=π/4、A=(1+ε/2)^(-1/2)、B=(1−ε/2)^(-1/2)；ε→0 时 A,B→1，但相对于固定坐标轴 θ 不趋于0。此例区分形状小扰动与小旋转角，并非否定原书椭圆结论。; 原返回NEEDS_HUMAN保留。

## EAUDIT04 原文数学判断（保持现状）

- MD-3.2-FiniteLieTaylor：原文形式exp等号采用形式系数还是Taylor jet/全阶渐近，需数学范围裁定；选项：逐阶导数/形式系数等式／现有有限余项严格化并单独标新增结论。现状保持，不声称无限级数收敛。 网站反例：以下仅反驳把原文读成实际函数等于其无限Taylor和，不是lieTaylor余项界的反例：n=1，f(x)=1，γ(t)=t，φ(0)=0、φ(x)=exp(-1/x²)（x≠0）。f、φ光滑且γ是全局实际解；所有(L_f^jφ)(0)均为0，但φ(γ(t))在t≠0时正值。形式Taylor级数为0，不能靠该级数恢复实际观测量；各有限阶O(|t|^(k+1))估计仍成立。; 原返回NEEDS_HUMAN保留。
- MD-3.2-FlowCoordinates：原页实际流与形式exp的连接需选形式jet还是全阶渐近解释；选项：定义实际拉回的时间jet并逐系数等同／批准现有局部有限余项作为严格化。保持当前声明。 网站反例：以下只反驳实际流分量等于其形式级数取实数值的解释，不是现有局部余项界的反例：在R²上令g(0)=0、g(x)=exp(-1/x²)（x≠0），G(x)=∫₀ˣg(s)ds，f(x,y)=(1,g(x))，D=R²，Φ(t,(x,y))=(x+t,y+G(x+t)-G(x))，η=1。f光滑，此Φ满足已展开的actualFlow，ζ=(0,0)的第二坐标为G(t)>0（t>0），但所有第二坐标的Lie-Taylor系数在ζ处均为0。因此形式坐标级数为0，无法恢复实际流分量；按各有限阶作局部余项解释没有这个矛盾。; 原返回NEEDS_HUMAN保留。

## EAUDIT06 原文数学判断（保持现状）

- MD-3.3-LeadingShadowHamiltonian：算子乘积与状态复合方向及Poisson奇数项符号冲突；选项：保留expLA expLB并反转状态端点及h/h³符号／保留当前端点及正号、显式勘误原书算子次序。需导师选路线，当前不改。 网站反例：取 n=1，D=ℝ²，K={(1,0)}，A(q,p)=p²/2，B(q,p)=q²/2，η=1；Φ_h(q,p)=(q+hp,p)，Ψ_h(q,p)=(q,p−hq)，满足全部光滑及 actualFlow 假设。Lean 使用 Φ_hΨ_h(1,0)=(1−h²,−h)，原文算子乘积作用于坐标所得状态则是 Ψ_hΦ_h(1,0)=(1,−h)，相差 (−h²,0)。{A,B}=−pq，正号修正 Hamiltonian 的端点 q=1−h²+O(h³)，不能以 O(h³) 或 O(h⁵) 匹配原文次序的 q=1。此为对象/次序不忠实的见证，不是假称 Lean 当前 Φ∘Ψ 结论为假。; 原返回FAIL保留。
- MD-3.3-BCHHamiltonianMatching：算子乘积与状态复合方向及Poisson奇数项符号冲突；选项：保留expLA expLB并反转状态端点及h/h³符号／保留当前端点及正号、显式勘误原书算子次序。需导师选路线，当前不改。 网站反例：取 n=1，D=ℝ²，K={(1,0)}，A(q,p)=p²/2，B(q,p)=q²/2，η=1；Φ_h(q,p)=(q+hp,p)，Ψ_h(q,p)=(q,p−hq)，满足全部光滑及 actualFlow 假设。Lean 使用 Φ_hΨ_h(1,0)=(1−h²,−h)，原文算子乘积作用于坐标所得状态则是 Ψ_hΦ_h(1,0)=(1,−h)，相差 (−h²,0)。{A,B}=−pq，正号修正 Hamiltonian 的端点 q=1−h²+O(h³)，不能以 O(h³) 或 O(h⁵) 匹配原文次序的 q=1。此为对象/次序不忠实的见证，不是假称 Lean 当前 Φ∘Ψ 结论为假。; 原返回FAIL保留。

## EAUDIT07 原文数学判断（保持现状）

- MD-3.3.2-DifferentLogsCommute：不同步长Strang的对数一般不交换；选项：保留为原书错误断言档案／批准加A、B交换的受限修复。现状不进入已证结论，奇性改依赖反步恒等式的路线另审。 网站反例：在R=M₂(ℝ)中取A=[[0,1],[0,0]]、B=[[0,0],[1,0]]、s=1、t=2。设L=A+B、C=B/6−A/12；log S(sx)=sxL+s³x³C+O(x⁵)，[L,C]=diag(1,−1)/4。因此[x⁴][log S(sx),log S(tx)]=st(t²−s²)[L,C]=diag(3/2,−3/2)≠0。该实矩阵代数满足Lean的Ring及Algebra ℝ假设。; 原返回FAIL保留。

## EAUDIT09 原文数学判断（保持现状）

- MD-3.3.4-ProcessorEnergyPrinted：原印第一行T遗漏U，h=0即不等于H；选项：批准另立Corrected将T改H，保留第二界／原印仅存档。当前原式保留，不尝试证明。 网站反例：n=1，m₀=1，U(q)≡1，B={(q=0,p=0)}。正质量、C⁴、紧性均满足。grad U=0、U''=0，处理器恒等，shadowTerms=(0,0,0)，T=0，H=1，takahashiShadow2=1。任意δ>0都有h=0∈(−δ,δ)，第一界要求1≤C·0⁴=0，第二界为0≤0。即使删除h=0，第一界1≤Ch⁴在h→0时仍不成立。; 原返回FAIL保留。
- MD-3.3.4-TakahashiEffectiveOrder：原后处理P=id+h²a与现χ⁻¹∘G∘χ的方向及全局Homeomorph域不匹配；选项：轨迹邻域P∘G∘P⁻¹并绑定原a／令χ=P⁻¹且系数取负并明确局部域。与第2章TI符号疑误一并裁定，当前保持。 网站反例：缺失条款：存在任意χ的声明不要求原文指定处理器或其二阶展开，且把局部坐标展开提升为全空间homeomorphism。具体说明此提升不能直接由式(3.9)给出：n=1,m=1,U(q)=q⁴，则P_h第一分量q−h²q³/3；任意h≠0，(q,p)=(0,0)、(√3/|h|,0)、(−√3/|h|,0)均映到(0,0)，所以式(3.9)自身不是全局homeomorphism。该例只否定将显式P_h直接认作全局可逆映射，不是否定存在另一族全局χ的命题。; 原返回FAIL保留。

## EAUDIT11 原文数学判断（保持现状）

- MD-3.4-AnalyticDefect：原文many standard classes没有给出准确方法类及解析邻域资格；选项：指定解析一阶方法类并核定k·h窗口／保留仅有限阶构造并另列指数严格化。需数学判断，不以缺陷结论作前提。 网站反例：已展开Ch03_deps.txt：SymplecticCoordinates n=(Fin n⊕Fin n)→ℝ；smoothSymplecticData要求r>0、开放凸D、紧凸B⊆D、H光滑、G(0)=id、联合光滑、Jacobian满足AᵀJA=J、B上真实H流以及局部O(|h|^(r+1))阶。Jacobian是实际fderiv矩阵。truncatedFlow要求Γ(0)=z及[0,h]上的实际ODE；Hamiltonian为H+Σ_{j=r}^k h^j Hj。解析假设、统一C/A/δ先于k、真实流估计均明确，且加入A(k+1)h≤1并另给指数截断。未找到缺失定义；原文many standard classes未界定适用类，需数学判断这些解析及域条件是否足以支持此全域解析系数结论；不能仅据名字或sorry判PASS。analyticBEA含sorry，与此语义判定分开。; 原返回NEEDS_HUMAN保留。
- MD-3.4-OptimalTruncation：原印指数1/(γh)与γ=1/(De)及现标量优化的γ/h不一致，标量界也不直接给真实缺陷；选项：导师确认指数勘误后与AnalyticDefect连接／原式保留存档。当前不自行确定勘误。 网站反例：缺失实际流差结论及增长/最小化条款。取A=0.1、h_N=1/(0.1 e N)，Lean幂=(1/e)^N；原书指数界则exp(−0.1 e/h_N)=exp(−0.01 e²N)，与Lean率不同；A较大时原书率还会比真实连续最小值快，无法用固定C̃吸收。; 原返回FAIL保留。

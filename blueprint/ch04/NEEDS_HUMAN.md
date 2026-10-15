# 网站NEEDS_HUMAN分流

原始返回和完整理由见website_audit.json；以下问题未替导师作数学选择。

## (i) 材料缺失：补材料后复审

- MD-4.3.2-NewtonQuadratic：补充Mathlib.LinearAlgebra.Matrix.NonsingularInverse中Matrix.inv/Matrix.nonsingInv及关联Inv实例的定义后完成该项审计；若希望降低加强，可将全局C²改为投影位置附近的局部C²。
- MD-4.4.1-FreeRigidSolution：补充 Mathlib 的 HasDerivWithinAt 及所依赖 HasFDerivWithinAt 定义摘录；明确I为时间区间，并说明端点为单侧/集合内导数，重新审计。
- MD-4.4.1-ExactPlanarRotation：请确认原页第二、第三式非零项应分别为π₂/I₂、π₃/I₃，并确认T_i表示对应主惯量。确认后现有负角Lean签名可就解释后的精确平面旋转判PASS；在JSON上下文保留原样展示和勘误说明，勿改原书转录或把sorry当已证。

## (ii) 原文数学判断：供导师裁定

- MD-4.1-PrintedModifiedFrequency：裁定并记录原文 ln 采用连续于 h=0 的主相位解释；将来源等式的使用域明确设为 h≠0，并给与 2 atan(hΩ/2)/h 的桥接等式。若希望零步长连续延拓，应单独定义值 Ω。
- MD-4.4.1-SecondAxisPrinted：请裁定PDF195第2子系统的无下标标量π是否应为π_2；如是，另建有明示勘误的π×e_2(π_2/I_2)版本，保留当前印刷占位版本，并记录a的含义。
- MD-4.4.1-ThirdAxisPrinted：请裁定PDF195第3子系统的无下标标量π是否应为π_3；如是，另建有明示勘误的π×e_3(π_3/I_3)版本，保留当前印刷占位版本，并记录a的含义。

## EAUDIT01 原文数学判断（保持现状）

- MD-4-PRKThreshold：两次半步显式辛PRK的稳定阈值可达4/Ω，反驳未按阶段成本归一化的全类最大2/Ω；选项：核对原参考[74]的方法类/成本归一化后重述／保留原印为疑误。需导师判断，现签名不改。 网站反例：s=2，b=c=(1/2,1/2)，A=[[0,0],[1/2,0]]，B=[[1/2,0],[1/2,1/2]]，G(Ω,h)=S(Ω,h/2)^2（S为symplecticEulerMatrix）。全部系数和、辛关系和三角条件成立，阶段关系有唯一解。Ω=1,h=3时G=[[7/16,-3/8],[3/8,1/4]]，det G=1，trace G=11/16，两个不同单位圆复根，故matrixStable(G)，但|hΩ|=3>2。实际上连通内区间为0<hΩ<4。; 原返回FAIL保留。
- MD-4-SymplecticEulerBoundaryPrinted：原印≤端点发生非平凡Jordan块并线性无界；选项：将幂有界域改为严格内区间／保留≤但结论仅谱模1。原印问题保持，等待导师裁定。 网站反例：Ω=1,h=2：S=[[-3,2],[-2,1]]=-I+N，N=[[-2,2],[-2,2]]，N²=0。对v=(1,0)，S^k v=(-1)^k(1+2k,2k)，范数无界。; 原返回FAIL保留。
- MD-4-VerletBoundaryPrinted：原印≤端点发生非平凡Jordan块并线性无界；选项：将幂有界域改为严格内区间／保留≤但结论仅谱模1。原印问题保持，等待导师裁定。 网站反例：Ω=1,h=2：V=[[-1,2],[0,-1]]=-I+N，N²=0。对v=(0,1)，V^k v=(-1)^k(-2k,1)，范数无界。; 原返回FAIL保留。

## EAUDIT03 原文数学判断（保持现状）

- MD-4.1-ActualMidpointRelation：PDF164的印刷“中点”公式其实梯形法，当前定义是真中点（PDF166机械中点背景）；选项：标独立更正候选并补准确来源／按原印重绑为梯形关系。须导师选择，当前定义保持，不覆盖PrintedImplicitRelation。 网站反例：取 n=1，f(x)=x²，z=0，Z=2，h=1：印刷式为 2=(0+4)/2，成立；实际中点式要求 2=1，不成立。; 原返回FAIL保留。
- MD-4.1-PrintedModifiedFrequency：复对数分支及h=0资格未指定；选项：采用连续于零的主相位且h≠0并桥接2atan(hΩ/2)/h／另给连续延拓值Ω。保持原式，不擅定分支。 网站反例：分支 k 与0的频率相差 2πk/h（h≠0）；h=0 时 Lean 定义为0，而原式含 1/(ih)，未定义。; 原返回NEEDS_HUMAN保留。

## EAUDIT04 原文数学判断（保持现状）

- MD-4.2.1-RESPAStructure：现source只引用分裂设计背景，保结构定理实际还据算法和跨页辛性句；选项：批准扩来源至PDF167算法及171辛性句并明确可逆解释／保留原source为设计背景且另列定理。涉及来源路线选择，保持现状。 网站反例：Ch04.lean 第412–416行量化 n、m、US、UF、r、h，要求所有 m_i>0、US/UF 为 C²、r>0，然后结论为辛性与对所有 z 的 G_{−h}(G_h(z))=z。所有依赖均已展开：Q n=Fin n→ℝ、Z n=Q n×Q n；dot u v=∑i u_i v_i；phaseForm(u,v)=dot(u.q,v.p)−dot(v.q,u.p)；symplecticMap G=∀z u v,phaseForm((fderiv ℝ G z)u,(fderiv ℝ G z)v)=phaseForm(u,v)。respa、kick、fastVerlet、Chapter02Review.verlet、invMass、grad→textbookConstraintGradient 分别是两次软势半 kick 包住 r 次快势 Verlet、p↦p−t∇U、实际坐标梯度及质量 drift，不是把保辛或可逆结论预先塞入定义。n 到 h 的量词顺序没有隐藏依赖，h 可为任意实数；C²保证实际梯度的 C¹ 及 Hessian 对称。[EXTRA] 正质量与 r>0 是合理的物理/算法资格，C² 是保辛的合理充分正则性；反步恒等式本身并不需要 C²，且作为代数映射的辛性也不严格需要质量为正，只需所用对角 drift 的适当解释。它们没有制造错误结论。FAIL 的原因是当前 statement_scope 明定仅覆盖所引原句及展示公式，而第167页这句话只是对称分裂的动机，没有断言任意 C² 势、任意步长下的全局 Jacobian 辛性与恒等式。注释把第171页的辛性及算法名称合并，扩大了来源与结论范围；[EXTRA] 可以标明补充假设，但不能自动使两项额外结论成为当前冻结原句的忠实陈述。此外 G_{−h}∘G_h=id 表示步长反号的自伴性；若 Reversible 专指 R(q,p)=(q,−p) 的动量反射可逆，还应显式交代 R∘G_h∘R=G_{−h}。该具体算法在这些正则性条件下的保结构命题数学上合理，此 FAIL 是来源/范围不匹配，没有声称已找到数学反例。本条无 [ERRATUM?]。第416行存在 sorry，证明仍未完成；范围 FAIL 不以 sorry 为理由，亦不把 sorry 当作命题为假的证据。; 原返回FAIL保留。

## EAUDIT05 原文数学判断（保持现状）

- MD-4.2.1-ResonanceEigenPrinted：原印sqrt(|ε|/2)首项不符实际sqrt(|ε|)，误差非O(ε)；选项：批准另立数学修正版同时列两支及误差界／仅存原印疑误。现原式保持。 网站反例：固定Ω=1、h=π−t，t↓0。两根r±满足(r±+1)/sqrt(t)→±sqrt(π)。目标正支为sqrt(πt/2)，故任一根与目标的差除以t均无界；正支差的首项是(1−1/sqrt(2))sqrt(πt)，负支更大。因此不存在所要求的固定C、δ。; 原返回FAIL保留。
- MD-4.2.1-ResonanceLinearRate：原词norm oscillate不成立，实际解有(-1)^k交替而范数单调线性增长；选项：批准把振荡解释为解的符号交替并并列精确轨道／仅保留原句疑误与正确线性率辅助。保持当前声明，待导师确认措辞勘误。 网站反例：Ω=π（h₀=1），z=(1,0)，则W^k z=(−1)^k(1,−k)，Pi范数为max(1,k)，单调且最终恰等k，并不振荡；二范数sqrt(1+k²)也单调。z=(0,1)则范数恒为1，说明附加q₀≠0必要。; 原返回FAIL保留。

## EAUDIT07 原文数学判断（保持现状）

- MD-4.3-RestraintForcePrinted：原页末项是标量φε(q)，与向量−∇φε(q)类型冲突，旧转录还误加撇号；选项：保留忠实原文类型疑误／另立径向力修正版并限定ε>0,q≠0。原印数学路线待导师，现Lean保持，JSON按原页CORRECTED合并。 网站反例：ε=1,r₀=1,q=(2,0,0)。在此非零点势光滑，∇φ(q)=(1,0,0)，故 −∇φ(q)=(−1,0,0)≠(1,0,0)。; 原返回FAIL保留。

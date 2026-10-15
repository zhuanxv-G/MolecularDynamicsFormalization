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

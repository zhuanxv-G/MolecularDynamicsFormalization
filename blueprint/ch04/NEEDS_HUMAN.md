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

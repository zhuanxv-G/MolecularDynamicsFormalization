# 极坐标真实Jacobian与局部图本地语义复核

印刷29/PDF52与前轮截图已实际核对，polarCoordinateMap(r,θ)=(r cosθ,r sinθ)。新PolarCoordinateMap.lean实际证明strict Frechet导数；其fderiv就是PolarCoordinates.lean已证明det=r的矩阵，不把静态速度矩阵当成未证明的Jacobian。

r≠0给真实可逆CLM，然后逆函数定理构造包含基点的OpenPartialHomeomorph，前向映射精确等于polarCoordinateMap；逆真实strict导数为可逆线性映射的逆。前向导数对所有r成立，可逆性仅非零r。没有全局角分支双射主张，不从局部图推出全时间不碰撞轨道。

attempt03--05实际退出0，五关键声明仅三项允许基础公理。正式完整check02进行中；極坐标EL、径向化约/有效能量、θ积分和action-angle/环面未计此批成果。负责人最终教材语义签核pending，新远端CI未跑。
正式full-check02实际08:12:32--08:13:53退出0：8966jobs、Scratch、全部项目声明审计、固定版本/扫描与输入SHA稳定。五新增关键仅允许基础公理。候选KeplerPolarDynamics不计该验收。

# 第一积分、平面角动量与极坐标本地语义复核

- 印刷28/PDF51第一积分说明、印刷29/PDF52 Kepler极坐标推导本轮实际视觉核对。印刷30/PDF53、31/PDF54后续也已查看但不计本批完成。
- IsFirstIntegralOn实际量化开时间区间中、状态域Q内全部真实ODE曲线。DI(x)f(x)=0充分性由真链式法则及连通区间导数零推出；必要性在Q开、f在Q各点C1下调用真实局部IVP，再用连续性缩到Q，不把每初值存在假设藏成待证明结果。I仅要求在Q可微。Hilbert梯度表达由Riesz真实导数推出。
- PlanarAngularMomentum用于单位质量二维状态，x p_y-y p_x。真位置/动量导数与投影/乘积法则推出力矩导数，再从零力矩得到守恒；任意中心力c(q)q的力矩零直接证明。固定外源Kepler总线动量未称守恒。
- PolarCoordinates中的动能、Kepler形式Lagrangian与角动量式是真代数/三角恒等式；r(t),θ(t)有真实导数时得到实际Cartesian两分量时间导数。矩阵项按书中速度变换列写出，其det=r及r≠0时可逆是真证明；尚未单独证明该矩阵是坐标映射的Frechet Jacobian或一般Euler--Lagrange坐标协变。
- 代数恒等式使用Lean总除法在r=0也有定义；物理极坐标/Kepler势仍要r>0，原点奇异模型与可逆性不被总除法掩盖。Kepler实际势梯度、极坐标Euler--Lagrange动力学、径向能量/积分解与action-angle/环面尚未完整证明。
- FirstIntegral/Angular首轮已退出0，Polar修复轮待结果，全部正式完整验收尚未运行。负责人最终独立语义签核pending，新远端CI未运行。

Polar attempt02已退出0，五项关键仅三项允许基础公理；Function.comp_def展开后系数重写成功。三个正式模块已接入，新增14关键审计，开始full-check01；不把上述边界内依赖成果计作完整Kepler解或全节完成。

正式full-check01于07:49:56--07:52:08实际退出0：8964jobs、Scratch、403导入声明依赖审计、固定版本/扫描/正式输入SHA稳定，14项关键显式审计仅三项允许基础公理。负责人最终语义签核pending，新远端CI未跑。

# §1.3--1.4 本地原页与陈述审计

原页2026-10-04本轮实际查看：印刷22--24 / PDF45--47，既有渲染在 `../tmp/t3-preparation-20261002/source-audit/pages/source-045.png` 至 `source-047.png`。完整内核/构建验收与负责人语义签核分开记录。

## 固定质量Euler--Lagrange

- L=1/2 vᵀMv-U(q)。Lagrangian模块复用固定对角坐标质量、动能与实际机械ODE。
- 所有真实梯度证明先给HasFDerivAt/HasGradientAt，速度梯度Mv对任意实质量成立；位置梯度要求U在q可微。总gradient的默认值不当作经典导数。
- IsEulerLagrangeTrajectoryOn包括位置Q成员、实际q时间导数和d/dt(速度切片梯度)=位置切片梯度。机械解到该谓词要求正质量、开时间域I、U在Q可微；反向构造实际(q,M deriv q)机械解只需谓词给出的两侧导数，不假设二阶ODE成立作为结论替身。
- 固定质量轨道双向桥不等于广义坐标的配置依赖质量动力学。此批还不包含最小作用量原理的变分证明。

## 广义坐标

- 取矩形J : R^k→R^n，静态L变换的质量矩阵为JᵀMJ。不要求n=k，允许约束参数化的不同坐标数量。
- 静态二次型恒等式对任意实m/J成立。实际速度链式法则另需HasFDerivAt Φ J在所访点及实际q时间导数；没有用总fderiv的默认值充当可微性。
- 质量正定与可逆要求每个质量严格正以及J.mulVec单射；这是原页full-rank条件的具体线性形式。正定性由固定mathlib Matrix.PosDef.conjTranspose_mul_mul_same推出，不将可逆作为已假定的最终结论。
- “变化的J由Jacobian给出”的逐点表达与一般广义Euler--Lagrange轨道变换仍需后续独立模块；不把静态坐标恒等式计作整个广义动力学完成。

## Legendre上确界（本地内核/完整构建通过）

- 印刷24仅提M(q)可逆而声称最大值在M⁻¹p取得。可逆不保证二次型正定；负质量方向会使目标函数无界。本工程在固定正对角质量模型下陈述，使完成平方余项非负。
- 候选目标为H(q,p)-(p·v-L(q,v))=T(v-M⁻¹p)。证明真实上界、实际达到点、目标range的BddAbove，再证明sSup=H。U任意，因为只在固定q作静态代数；位置/速度梯度另有各自可微条件。
- 本批full-check01已于06:29:14--06:31:00退出0：8950jobs、Scratch、261项导入声明依赖审计、固定版本和输入SHA稳定。16项关键显式依赖仅三项允许基础公理。负责人最终语义签核pending，新远端CI未运行。本批不涉及工具链升级、MathCopilot或全书完成。

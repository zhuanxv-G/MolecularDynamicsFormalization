# T5 独立证明批次结果与集成说明

最后更新：2026-10-03 01:21 +08:00。工作树分支 `chapter01-kinetic-energy-nonneg`，HEAD `675fcaedbdef7b6ec57393c1ee99e9ca727da649`；Lean `leanprover/lean4:v4.34.0`，mathlib `5ed2965256430c3649e86755f9576b54eca72435`。HEAD 由并行 T2 聊天推进，本聊天未执行 Git 写操作。

## 完整证明

独立源码从正式工程看为 `../tmp/t5-implementation-20261003/T5Proofs.lean`，含 24 条命名定理，每条均通过固定版本 `lake env lean` 和 `#print axioms`。六个一般目标逐一对应：

| 规格目标 | 已证明声明 |
| --- | --- |
| T5-D1 去心相对邻域 | `strictOn_iff_punctured` |
| T5-D1 全空间与 univ | `strictUniv_iff` |
| T5-D1 严格推出非严格 | `strictOn_isLocalMinOn` |
| T5-C1 紧集一致正差 | `compact_positive_gap` |
| T5-S1 每个合法半径球面屏障 | `fixed_sphere_barrier` |
| T5-O1 开配置域小半径屏障 | `open_domain_barrier` |

另有 `energy_excludes_sphere`、`energy_below_barrier_excludes_sphere` 两条静态能量排除。`conserved_trajectory_below_barrier_stays_in_ball` 只要求初始位置 `q t₀ ∈ ball q₀ r`，在给定闭时间区间内位置连续、动能非负、能量恒定且 `H₀ < U q₀ + δ` 时，全区间位置留球。IVT 起点取 `dist (q t₀) q₀ < r`；不要求初始位置等于中心。`conserved_trajectory_center_below_barrier_stays_in_ball` 将中心初值情形作为推论；原 `conserved_trajectory_stays_in_ball` 则保留中心初值、能量恰为 `U q₀` 的特例。

`open_domain_energy_confinement` 已同步推广为任意球内初始位置：由严格极小和开域先得到每个小半径的正球面屏障，再推出满足上述低能守恒条件的轨道在整个给定区间内留在该球及 `Q`。它是可调用的条件定理，未假设或证明真实轨道存在。

边界命题也已形式化：`Position 0` 正半径球面为空、任意势能有真空严格极小并可取屏障 `δ=1`；实数 `x^4` 严格极小、连续且半径 `r>0` 的球面屏障为 `r^4`；常数势能非严格极小而不严格；单点相对域的严格性不足以覆盖实数正半径球面；连续多项式 `x²(1−x²)` 在 `R=1` 的开球内严格，却在 `r=R` 无正屏障。这些分别由同名 `zero_dimensional_*`、`quartic_*`、`constant_*`、`singleton_*`、`endpoint_*` 声明证明。`x^4` 不存在所有小半径共用的正 `δ` 以及 Hessian 为零等进一步边界，此批没有单独形式化。

## 验证范围

从正式工程目录运行 `lake env lean ../tmp/t5-implementation-20261003/T5Proofs.lean`，进程 PATH 前置 `C:\Users\ustc\.elan\toolchains\leanprover--lean4---v4.34.0\bin`；最终退出码 0、错误 0、警告 0。24 条定理的 `#print axioms` 均仅列 `propext`、`Classical.choice`、`Quot.sound`。源码无 `sorry`、`admit`、新 `axiom`、`unsafe`；完整原始输出在 `../tmp/t5-implementation-20261003/T5Proofs.log`。最终源码 SHA256 `e227b7c17ebb83332c81953497a831d5aeff7923be462f14d01a5be87adebcc2`；输出 SHA256 `57c77ccd99c18325d273c039ac8ab5d6df7e0cbfe082fd31b37aea8b23ee167a`。各输入及输出哈希见 `../tmp/t5-implementation-20261003/INPUT_AND_OUTPUT_HASHES.json`。

最初 C1 证明因错误的简化引理名失败，改用 `linarith` 后通过；端点多项式连续性第一次 `fun_prop` 未展开本地定义，改为显式 `change` 后通过。失败输出中的 `sorryAx` 只属于未通过的中间尝试；最终输出没有 `sorryAx`。最终源码的关键声明和证明已验证，早先 T5 准备文档中的 API 与目标类型探针本身只算类型/API 检查。

## 集成与未验证事项

本批没有改正式 `MolecularDynamics/` 模块、顶层导入、共享 `Scratch.lean`、映射/假设/状态/交接文件，也没有暂存、提交或推送。原聊天负责将源码移入正式模块，按工程命名空间调整，维护顶层与 `FORMALIZATION_MAP.md`、`ASSUMPTIONS.md`、`STATUS.md`，再运行 `scripts/check.ps1` 和正式文件的公理检查。本批独立编译不能充当正式工程集成构建或 CI 成功。

MathCopilot 网站发送与结果收取由原聊天协调；T5 的网站独立审阅、负责人对教材语义的最终复核仍待完成。证明链没有涵盖 Theorem 1.1、Hessian 正定、真实解的存在/唯一性、动量控制或最大解的全局延拓。

集成第一动作：核对上述源码 SHA 与 T5 规格输入哈希，复制 `T5Proofs.lean` 的声明至新正式模块，再逐条完成正式构建及语义签核。

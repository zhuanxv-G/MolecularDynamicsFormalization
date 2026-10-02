# T5 独立实施日志

## 2026-10-03 00:56:13 +08:00 启动

核对工程规则、T5 六目标与现有边界探针；实际工作树的共有文件由 T2 聊天管理。本聊天只在独立目录写入。

## 2026-10-03 01:12 +08:00 完成检查点

- 独立 `T5Proofs.lean` 完成六个一般目标及五条能量/轨道辅助定理；`open_domain_energy_confinement` 将开域严格极小、球面屏障、低能连续守恒轨道留在球和域内组成一条完整条件证明。
- 边界：零维空球面/真空严格极小、x⁴/常数势能、单点相对域和 `r=R` 多项式反例均形式化；多项式连续性另证。
- 初次 C1 证明使用不存在的 `add_sub_cancel_comm` 导致退出 1；改为从紧集下界调用 `linarith`。端点多项式连续性最初 `fun_prop` 未展开本地定义，显式 `change` 后通过。最终没有遗留错误。
- 最终固定 Lean 4.34.0 / mathlib `5ed2965...` 编译退出 0、错误/警告 0。23 个 `#print axioms` 只有 `propext`、`Classical.choice`、`Quot.sound`；源码禁用词扫描 0 命中、行尾空白 0。
- 源码 SHA256 `32b13ea8e58a5a794ab62f64f5d6b482441a67d001b411965ce66a6437027f48`，最终日志 SHA256 `b8516756a1a9f153dd81a691cf1fdf93ca6ca3faf966ab42060ecd10c290eb10`。原始日志与哈希清单均在独立 tmp 目录。
- 未改正式模块、共享顶层、Scratch、映射/假设/状态/交接或 Git 历史；本批未操作 MathCopilot。正式集成和网站/负责人复核留给原聊天。恢复第一动作见 CHECKPOINT。

## 2026-10-03 01:21 +08:00 — 小扰动初值推广

- 按原聊天新要求，将 `conserved_trajectory_below_barrier_stays_in_ball` 的初始条件从 `q t₀ = q₀` 改为 `q t₀ ∈ ball q₀ r`。IVT 起点使用这一球成员给出的严格距离不等式；增加中心初值推论 `conserved_trajectory_center_below_barrier_stays_in_ball`。
- `open_domain_energy_confinement` 同步改为接受任意球内初始位置，仍推出全给定区间位置属于小球和配置域。原六个 T5 一般目标及其他边界声明未改。
- 固定 Lean 4.34.0 / mathlib `5ed2965...` 最终编译退出 0、错误/警告 0；24 条命名定理均输出标准三公理，无 `sorryAx`。源码禁用词和行尾空白均 0。
- 最终源码 SHA256 `e227b7c17ebb83332c81953497a831d5aeff7923be462f14d01a5be87adebcc2`；输出 SHA256 `57c77ccd99c18325d273c039ac8ab5d6df7e0cbfe082fd31b37aea8b23ee167a`，输入/输出清单已更新。HEAD 现为 `675fcaedbdef7b6ec57393c1ee99e9ca727da649`，由并行 T2 聊天提交推进；本聊天仍只写 T5 独立目录，未执行 Git 写操作或正式集成。

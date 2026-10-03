只做 T3 固定质量 Hamiltonian 的独立只读复核。本会话专用于 T3；项目中另一会话正在做 T2/T5，请不要覆盖或接续它。
固定公开仓库：https://github.com/zhuanxv-G/MolecularDynamicsFormalization
固定提交：21b4d6cbb5121c5f194a4dda9b9d718148b2e1a1；分支名称 chapter01-kinetic-energy-nonneg 仅作来源，不能以当前分支尖端替代固定提交。
禁止修改 /workspace/MolecularDynamicsFormalization 中的文件或执行 Git 写操作（fetch/checkout/switch/reset/add/commit/push/merge）；禁止升级依赖。只在新的独立目录 /workspace/.mathcopilot/reviews/T3_21b4d6cbb512_independent_20261003/ 下载不可变归档、产生检查与报告产物；保留旧 T3、T2/T5 审阅目录。若有已安装且版本核实匹配的隔离 Lean 二进制，可只读复用，不改写其它会话工具目录。
固定工具链 Lean 4.34.0；mathlib commit 5ed2965256430c3649e86755f9576b54eca72435。实际读取：
- MolecularDynamics/Chapter01/Hamiltonian.lean：SHA256 5c62cc4b16f7c3eddf8d2cfc2a1868acd8e991fc20f5c667dd170fc3fa58c54e
- LocalTrajectories.lean、顶层入口、Scratch.lean、scripts/CheckAxioms.lean 及导入闭包
- docs/tasks/T3_implementation/evidence/frozen-inputs/docs/tasks/T3_SPEC.zh-CN.md
- docs/tasks/T3_implementation/continuation-20261003/FormalExactGoals.lean：4728 bytes，SHA256 eab1cf1546a250d0f9afe9b427815aa3534b5c76e0c6e054b0ce935ddfc6dd29
- 同目录 FormalBoundaries.lean：2126 bytes，SHA256 3276cc4df704af5766dd87040152675a7ec574d0f14403c4d6de8c3a1184ee21
请实际使用 Lean Blueprint/Lean Proof 的既有证明复核流程，检查五定义、十八条完整命名定理，按规格原九目标和七边界逐项给出接受/需要修订/阻断。核对假设、教材符号对应、正质量与可逆性、总除法、零维、混合零质量奇异逆、单坐标和负质量，检查是否把结论藏进前提。不得声称真实轨道 Hamilton/Newton 解等价、守恒、ODE 适定/延拓或完整 Theorem 1.1 已由 T3 完成。
在隔离归档实际运行可运行的完整构建、Scratch、公理审计以及两份 Formal 探针，记录每条命令、版本、退出码、诊断与输入/输出 SHA256。若 pwsh 或某检查不可用，明确该项未完成；不得用提交中的旧日志或本地/CI 成功代替本次执行。先完成可行的源码与数学复核并保存报告，再尝试环境恢复，避免环境安装失败造成无报告返回。
交付完整原始报告、逐项台账、原始检查日志和状态 JSON；仅打包新生成的复核文件（不要源码副本、工具链或缓存）到 /workspace/share/T3_READONLY_REVIEW_21b4_20261003.zip，给出可下载链接及 ZIP 字节数和 SHA256。记录报告等产物的字节数与 SHA256，哈希台账不包含它自己的自引用哈希。负责人/学长最终语义签核保留 pending。不要开启其他数学批次。

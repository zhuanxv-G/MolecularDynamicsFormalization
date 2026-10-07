# T4-C1 输入、交付与提速流程

## 交给 MathCopilot 的输入

第一轮只交 `MATHCOPILOT_PROMPT.zh-CN.md` 中的短正文和固定提交号。若网站无法读取固定仓库，再补充下面四个源码文件；不要上传整个项目，也不要把旧任务的附件混入本批：

1. `MolecularDynamics/Chapter01/LocalTrajectories.lean`
2. `MolecularDynamics/Chapter01/LocalExistence.lean`
3. `MolecularDynamics/Chapter01/MechanicalConfinement.lean`
4. `MolecularDynamics/Chapter01/MomentumBounds.lean`

网站输出只作为 API/证明路线参考。用户手动提交、观察和下载；Codex 不控制页面、不轮询任务，也不因网站等待而暂停本地工作。

## 带回后的本地流程

1. 保存原始返回件，并核对提交号、Lean 版本、mathlib 版本和附件字节；缺少原始日志时记为“网站建议已收取、网站检查未验证”。
2. 先在本地固定版本建立一个小探针或新模块，只实现 A（端点极限）或 B（拼接）中的一个；先做单文件/`Scratch.lean` 检查。
3. 只有源码确实变化后才运行一次完整 `pwsh -NoProfile -File scripts/check.ps1`；文档或网站收件不触发完整构建。
4. 保存 `#print axioms`、退出码和输入 SHA；机器编译通过仍需保留教材语义复核 pending，直到负责人确认。

## 快速工作规则

- 一个 MathCopilot 请求只保留一个数学目标；A 和 B 不混成“请完成第一章”。
- 首轮只要 API 签名和最小探针，不要等待网站生成整套证明。
- 页面超时、额度限制或数据库错误只记录一次并继续本地；不重复创建同一请求。
- 简单文档/状态动作使用较快配置；只有复杂定理设计和 Lean 调试才使用 GPT-6.1 Sol。模型设置只有实际生效时才记录。
- 下一次本地源码检查的恢复入口是本目录和 `docs/handoff/CURRENT_STATE.zh-CN.md`，不是浏览器页面。

## 完成判据

本批只有在本地声明、固定版本构建、允许公理审计、输入哈希和语义边界都记录后才算完成。即使 A/B 都完成，也只能更新为“有限端点延拓接口完成”；全局解和 Theorem 1.1 仍需后续批次。

# 第三项：沿用本地检查与 CI 的实际结果

完成时间：2026-10-01 23:27 +08:00。正式工程分支 `chapter01-kinetic-energy-nonneg`，HEAD `6203fc19908312faf9c40d52cb299edb42422973`。这是带有未提交脚本/CI 改动的工作树检查；具体源码绑定见 CHECK_REPORT.json 的 11 项 SHA-256，不仅依据 HEAD。

## 已落实

- 原 check.ps1 保留为唯一验收入口，新增实际版本/固定配置/实际 mathlib checkout 核对、公理依赖与输入稳定性检查，可选保存日志/报告。
- CheckAxioms.lean 对顶层导入的工程命名空间声明进行依赖审计（含私有声明），仅允许三项标准 Lean 逻辑依赖，并输出当前关键定理的 #print axioms；未导入模块不属于此审计范围。
- 原 CI 保留触发，使用 Lean Action 准备工具链/缓存并由同一脚本构建和验收；保存报告 artifact 30 天。新 CI 仅在本地，未提交/推送/远端执行。
- 新增统一本地/CI 验收说明和逐项教材语义模板，README 指向新说明。语义复核有独立记录，机器报告始终保留负责人复核 pending。

## 实际机器检查

最终命令（正式工程根、当前 shell 使用本机固定工具链）：

```powershell
pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory ../deliverables/local-check-20261001-step3-run2
```

2026-10-01T23:20:34.2290142+08:00 结束，退出码 0。实际 Lean 4.34.0（commit 293d5d0）、Lake 5.0.0-src+293d5d0；mathlib checkout `5ed2965256430c3649e86755f9576b54eca72435`，与 manifest 一致且没有已跟踪修改。源码扫描、lake build（8928 jobs）、Scratch 和公理依赖检查均通过，审计导入的 36 项工程声明。现有 `nBodyKineticEnergy_nonneg` 依赖 `[propext, Classical.choice, Quot.sound]`；不称为无任何公理。

[CHECK_REPORT.json](CHECK_REPORT.json) SHA-256：`f030e4cb3fd23d234d1719d4ca5f715a977f084735aee70b596c4fa20aa561de`。10 个原始命令日志及各日志 SHA-256 均已核对，空输出日志也保留。输入 11 项 SHA-256 全部与最终工作树匹配；独立报告见 INDEPENDENT_VERIFICATION.json。这里保留了原始报告/日志的逐字节副本，外部运行目录仍在工作区 deliverables/local-check-20261001-step3-run2。

## 拒绝路径检查

七个隔离测试针对最终脚本通过：错误 lean-toolchain、mathlib manifest revision、lakefile revision、unsafe、sorry、缺少 CheckAxioms、尝试覆盖旧证据。每项预期退出非零并核对失败阶段；均在正式库外的 tmp/step3-validation-final 副本中执行，未改正式 Lean 或版本文件。

另一个隔离 Lean 探针直接引入 sorryAx 依赖，编译原始退出码 1，明确错误为 disallowed logical dependency: sorryAx；验证了仅文本扫描未必发现的依赖会被拒绝。测试 harness 退出码 0 表示预期拒绝发生。文件 AXIOM_LEAK_TEST.log 的警告/错误是负向样例预期输出，不是正式工程失败；未将该探针源码收入正式库。

CI YAML 解析与保留原触发/单一入口/always 保存 artifact 已核对，PowerShell 语法与 git diff --check 通过。没有在 GitHub 实际执行新配置；只读 statuses 及只返回 PR run 的接口为空，不能据此判定当前 CI 不存在或新改动已经通过。

## 进度边界与下一动作

正式库、Scratch、lean-toolchain/lakefile/manifest 原内容保持不变，无新教材证明、网站返回或发送。已有 T1-preparation-v1.zip 原字节/哈希保持不变，仍是陈述/依赖审阅输入；其旧脚本不应覆盖当前脚本。新的证明任务要准备新包并包含当前验收文件，不原位改 v1。

这一步已建立并实际验证验收机制；当前没有新的 MathCopilot 成果可做教材语义验收。负责人语义复核仍为 pending。网站返回后先按任务阶段核对包 ID/哈希及数学陈述；授权集成完整证明后运行入口并填写 SEMANTIC_REVIEW_TEMPLATE，按精确源码哈希登记各项语义结论。

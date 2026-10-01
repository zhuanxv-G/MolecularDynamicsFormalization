# MathCopilot 成果的本地与 CI 验收

网站负责探索、整理、起草和托管试验；正式工程用本地固定环境验收。机器检查和教材语义复核分别记录；只有相关目标已经实现、机器检查通过且语义复核完成，才把该项标为正式完成。

## 1. 根据任务阶段接收返回

- 陈述/依赖审阅（当前 T1）：保存原始报告，核对任务包 ID、输入清单哈希、源文件哈希与网站实际环境；按 T1 验收文档核对陈述和依赖。不要求网站在这一批完成证明。
- 证明实现：先在正式库外保存草稿/补丁及原始检查输出，对照准确陈述和假设，逐项集成完整证明，维护顶层导入及映射/假设/状态。占位代码不进入正式库。
- 网站未提供 Lean/mathlib 版本、完整工程构建或工具缺失时，如实记录 unknown/not_run。网站成功是网站试验证据，固定版本本地结果另记。

## 2. 唯一机器检查入口

在正式工程根使用 PowerShell 7，执行既有入口：

```powershell
pwsh -NoProfile -File scripts/check.ps1
```

需要保存本轮证据时给出一个不存在的新目录；不要覆盖旧报告：

```powershell
pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory ../deliverables/local-check-YYYYMMDD-run1
```

本机若 elan 启动器再次出现联网问题，可在当前 shell 前置已经安装的固定工具链后运行同一入口；这不改变全局配置：

```powershell
$env:PATH = 'C:\Users\ustc\.elan\toolchains\leanprover--lean4---v4.34.0\bin;' + $env:PATH
pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory ../deliverables/local-check-YYYYMMDD-run1
```

脚本依次检查：

1. `lean-toolchain` 的 Lean v4.34.0、lakefile 中的 mathlib v4.34.0、manifest 中唯一的 mathlib 固定提交 `5ed2965256430c3649e86755f9576b54eca72435`。
2. 正式库、顶层、Scratch 和公理检查文件的保守文本扫描，禁止 sorry/admit/axiom/unsafe。扫描也会匹配注释中的独立禁词；不要据此把扫描称为内核验证。
3. 实际 Lake/Lean 版本、实际 mathlib checkout 提交与其已跟踪文件的清洁状态。不自动升级或运行 lake update；缺少完整本地依赖时报告失败。
4. `lake build`、`lake env lean Scratch.lean`。
5. `lake env lean scripts/CheckAxioms.lean`：输出当前关键定理的 `#print axioms`，审计完整顶层导入中 MolecularDynamics 命名空间的声明，包括展开私有名前缀后的声明。只允许 propext、Classical.choice、Quot.sound；其他依赖引发失败。新模块必须加入顶层导入；未导入声明不在此项审计范围。
6. 复核开始时记录的源文件、工具链、manifest、脚本和 CI 配置 SHA-256 未在检查中变化，避免把混合工作树记录成通过。

不另跑一遍 lake build；入口已经包含构建。给出报告目录时生成 `CHECK_REPORT.json` 和各命令日志，保存开始/结束时间、分支、HEAD、未提交状态、实际版本、逐条命令与退出码、输入 SHA-256、失败阶段。未提交工作树不能仅用 HEAD 指代，报告中的文件哈希绑定本轮源码。

新增关键定理时在 `scripts/CheckAxioms.lean` 中加入其 `#print axioms`。命名空间审计会自动检查导入的新声明，但关键定理的依赖原文也应保存，便于复核。允许三个 Lean 标准逻辑依赖不等于“无任何公理”。

## 3. 沿用原 GitHub CI

既有 `.github/workflows/lean_action_ci.yml` 保留 push/pull_request/workflow_dispatch 触发及原 Lean Action。Lean Action 负责工具链、依赖缓存准备，关闭自动构建选择，再调用同一个 check.ps1 完成唯一一次工程构建和全部验收。成功/失败均尝试保存证据 artifact，保留 30 天；若安装/依赖准备先失败，检查报告可能尚未产生，应查看该步骤原始日志。

依据 [Lean Action 官方配置](https://github.com/leanprover/lean-action/tree/v1)，auto-config: false 只禁用自动选取构建/测试/检查特性；不关闭工具链安装和 mathlib 缓存准备。证据保存使用 [GitHub 官方 upload-artifact](https://github.com/actions/upload-artifact/tree/v4)。

本地修改 CI 文件尚未提交/推送时，GitHub 不会执行这些新配置；必须区分“本地配置与脚本已验证”和“远端对应提交的 CI 已通过”。读取旧提交的状态也不能证明未提交的新脚本已在 GitHub 执行。远端运行须记录 run URL、run ID/attempt、实际 head_sha、日志与 artifact；PR 的合并提交可能不同于分支 HEAD，需核对实际构建对象。

## 4. 教材语义验收

复制 `SEMANTIC_REVIEW_TEMPLATE.zh-CN.md` 为每项或每批建立审阅记录。至少核对：印刷/PDF 页号、原陈述与 Lean 类型、变量和量词、N/N_c/N_d 与范数、正/非负/非零质量、位置域与维数、势能正则性、轨道/解区间、符号、增强假设或弱化结论、零维/空索引边界，以及关键依赖。

`CHECK_REPORT.json` 无论机器检查是否通过，都将 `responsible_semantic_review` 留为 pending。完成语义复核后在独立审阅文件记录审阅者、时间、准确源码哈希、判断和未解决项；不要修改原机器报告使其看起来由脚本自动确认了数学语义。源码或数学陈述变化后必须重新关联复核。

## 5. 与已有 T1 ZIP 的关系

`T1-preparation-v1.zip` 是已经冻结的陈述审阅输入，包含当时的旧检查脚本；仍可用于本批陈述/依赖整理。本轮没有修改该 ZIP 或其清单，也没有返回报告或 T1 新证明。导回成果用当前本地脚本验收，并在报告中记录新脚本哈希。不要把旧包里的脚本覆盖回当前工程。

当前工作树中的 check.ps1 已改变，原 19 项清单对应旧冻结快照。以后发证明任务时应准备新包 ID/目录及最新检查文件，核对已提交基线与本地差异，不能原位重打 v1。现有打包器会拒绝与要求 HEAD 不同的已跟踪输入；未提交增强须先在新任务包规范中明确处理，不能通过伪造 committed_HEAD 标签跳过。

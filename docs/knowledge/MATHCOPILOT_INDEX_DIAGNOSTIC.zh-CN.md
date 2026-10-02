# MathCopilot 第四项：实际索引诊断

日期：2026-10-02（Asia/Shanghai）。目标是让 `formal math` 项目检索本工程的 Lean 声明。本文件区分网站界面状态、网站任务报告和真实检索验收。

## 固定目标

- 仓库：`zhuanxv-G/MolecularDynamicsFormalization`。
- 工作分支：`chapter01-kinetic-energy-nonneg`。
- 验收快照：`54b75a14aaa968522903d82eef947ffdc7bbf165`。
- T1 数学实现：`c7d9778fe981c24ba7281db730206d1cfefbba4d`，已有本地及该提交远端 CI 通过证据。
- `main` 仍为 `d5dd5722602fba9ff252311b2c93ff85a6801ed0`，不能替代当前证明库。

## 已直接观察的操作

1. 当前网站项目、Git 仓库选择正确；开启语义检索并保存成功，显示“Lean 语义索引已就绪”。
2. 点击“更新”和“立即重建”，随后界面仍为 ready；界面未显示仓库/索引 HEAD。
3. 项目右侧 Retrieval / Lean 查询“非负质量的动能非负”，返回 `ApiError: LeanDex 返回 522 <unknown status code>`，没有命中。
4. 已在目标项目发送只读验收任务，并完整读回发送后的提示词与结果。随后发送一次有范围限制的定向修复指令；该指令不允许更改 main、源码、依赖、凭据、全局配置或无关测试库，也不允许猜测 API。

## 网站首轮任务报告

以下是网站任务报告的结果。随后已展开第二轮第一条实际调用的入参与原始 structuredContent，直接核实第一条中文查询确实返回测试库；第二条查询的数值按两轮网站报告记录。不能把报告中的普通文件读取当作语义命中。

实际工具：`mcp__mathcopilot__lean_library_semantic_search`。

| 查询 | 返回材料 | 目标命中 |
| --- | --- | --- |
| 非负质量的动能非负 | `lakefile.lean` 包名 `mathcopilot-lean-test`，score 0.03352763503789902；`MathcopilotTest.lean`，score -0.02001981809735298，内容为 add_zero_test / eq_square_test | 未命中 |
| 按粒子展开的动能等于总动能 | 同一测试项目；score 分别为 0.04042823612689972 / -0.02103138342499733 | 未命中 T1 动能恒等式或逆矩阵引理 |

本次私有 MCP 查询没有 522，但语料来自无关测试项目。不能将该索引认定为本工程某个旧提交，也不能据此说我们的引理不存在。

网站任务工作区：分支名正确，但本地 HEAD 为 `bdcd1ecd710db5fbd6b8698e9ee3d3e05d535045`，落后于远端快照 `54b75a14...`。索引 HEAD 未返回；MCP resources/list 与 resources/templates/list 不支持。本地、远端和索引是不同状态，不能混用。

网站另以只读方式取得远端固定提交中的三个完整声明，模块/import 与本地源码一致；这项说明网站能读取已推送的证明输入，但不是语义检索通过。

## 当前边界与下一项检查

目前完整验收未通过。一次定向诊断已完成：网站报告仅暴露 lean_library_semantic_search（query）、lean_project_check 和 lean_project_goal，没有仓库/索引选择、配置重载、索引管理或 HEAD 查询接口。两条原查询各复测一次，仍返回同一测试库，网站克隆与 Git 状态未改变。没有尝试未公开参数、服务端配置或凭据。

已直接观察的原始工具入参为 `{"query":"非负质量的动能非负"}`；结果 structuredContent 第一项为 `package «mathcopilot-lean-test»` 的 `lakefile.lean`，第二项为含 `add_zero_test` / `eq_square_test` 的 `MathcopilotTest.lean`。本地截图 `tmp/knowledge-check-20261002/semantic-query-wrong-corpus.png` 不作为仓库公开文件提交。

给网站方的可复核问题：设置所选仓库、构建索引和 Task 查询绑定之间，至少有一处没有指向目标工程。应核对 project/user scope、仓库分支/提交、索引发布别名及查询是否回退默认测试索引，并在结果中返回仓库与索引 HEAD。这些是排查建议，具体服务层根因未直接核实。本轮未对外发送故障报告。

临时可用路径：后续任务按固定 Git 提交读取本库声明目录及原始 Lean 模块，核对完整类型、模块、文件哈希和固定版本；禁止用测试库搜索结果补造项目依赖。该路径与语义索引验收分别登记。

# 第四项：现有 Lean 库的最小检索验收

2026-10-02 已成功保存启用并更新/重建，界面显示 ready；但实际私有工具返回无关测试库，完整检索验收未通过。两次网站任务已完成诊断，并直接展开原始工具结果核实。可用的固定 Git 源码检索路径和机器验收声明目录另行提供，不能把它记为语义检索通过。

## 固定对象

仓库 zhuanxv-G/MolecularDynamicsFormalization，工作分支 chapter01-kinetic-energy-nonneg，远端/API实际提交 54b75a14aaa968522903d82eef947ffdc7bbf165；main仍为旧d5dd572，不能当作当前证明库。Lean/mathlib v4.34.0，mathlib 提交 5ed2965256430c3649e86755f9576b54eca72435。机器可读对象和源文件哈希见 LEAN_LIBRARY_CHECK.json。

## 已有可复用声明

| 完整名字（均在 MolecularDynamics 下） | 类型/作用 | 实际状态 |
| --- | --- | --- |
| Position / Velocity / Momentum | EuclideanSpace ℝ (Fin n) | 已定义；语义角色须在使用处区分 |
| CoordinateMasses | Fin n → ℝ | 已定义，n=N_c |
| diagonalMassMatrix | 对角坐标质量矩阵 | 已定义，不含质量正性条件 |
| NBodyEquationAt | 给定位置与加速度的点态方程 | 已定义，不能当作时间轨道或 ODE 解 |
| nBodyKineticEnergy | ∑ i, masses i * (velocity i)^2 / 2 | 已定义 |
| nBodyTotalEnergy | 动能加势能 | 已定义，不是能量守恒定理 |
| nBodyKineticEnergy_nonneg | 非负坐标质量下动能非负 | 完整证明及固定版本机器验收通过，负责人语义状态另记 |
| nBodyKineticEnergy_particle_eq | 粒子与坐标的动能一致，对任意实质量成立 | T1完整证明、本地及c7d9778远端CI通过 |
| diagonalMassMatrix_inv_eq | 正质量下逆矩阵等于逐坐标倒数的对角矩阵 | T1完整证明、本地及c7d9778远端CI通过；不可去掉正性 |

## 在网站的最小操作

1. 设置 → Git → Lean 库，核对正式仓库、项目和实际读取的版本；提交不匹配时不能直接声称使用了当前工作分支。
2. 对远端新版本点击“更新”，记录实际仓库 HEAD。若未暴露 HEAD，明确版本未知，任务以冻结源码为准。
3. 检查语义检索/Embedding 的实际可用状态；索引 stale 或不存在时按已有配置重建，不反复重设已确认技能或 GitHub 连接。若需要新增收费模型配置而现有配置不足，记录缺项再处理。
4. 试搜“非负质量的动能非负”和精确名字 MolecularDynamics.nBodyKineticEnergy_nonneg；命中后打开完整声明，核对模块/import、量词、hm : ∀ i, 0 ≤ masses i、结论 0 ≤ nBodyKineticEnergy masses velocity 与源文件。
5. 索引 ready 且与当前仓库版本相符、测试命中且类型正确，才能记为第四项通过。查询失败要区分索引/分支/版本与声明本身，不把未检索到说成库没有。

不将 T1 文档里的候选头当作已证明引理。当前 T1/T3 无新增外部论文瓶颈，暂不连接 Zotero。

## 本轮实际验收结果

- 网站配置：保存成功，语义检索开关开启，更新/重建后仍显示“Lean 语义索引已就绪”。
- 紧凑 Retrieval / Lean：查询返回 LeanDex 522。
- Task 私有工具：`mcp__mathcopilot__lean_library_semantic_search` 实际可调用；两条查询及一次定向复测均返回 `mathcopilot-lean-test`。已直接展开第一条复测的参数和原始 structuredContent 核实，内容是 `lakefile.lean` 与 `MathcopilotTest.lean`，不是本工程。
- 版本：网站任务工作区 HEAD 为 `bdcd1ecd...`，落后于已核对的远端快照；设置中的仓库克隆 HEAD 和查询索引 HEAD 均未暴露，不能把任务工作区 HEAD 当索引 HEAD。
- 修复边界：网站任务报告当前工具仅支持 query，没有切换/重建索引接口；完成一次定向诊断后停止重复重建。具体配置绑定和发布问题仍需网站侧排查，根因尚未直接核实。
- 替代路径：见 `LEAN_DECLARATIONS.zh-CN.md` / `LEAN_DECLARATIONS.json`，包含 14 个实际完整定理头、模块和源文件 SHA-256；以指定发布提交读取目录，再以固定源码快照核对原模块。网站首轮任务已读取远端三条目标声明，但目录新增文件的接收仍需另行验收。

完整证据和网站修复要点见 `MATHCOPILOT_INDEX_DIAGNOSTIC.zh-CN.md`。目前不得将第四项标为完全完成，不阻碍 T2 的本地准备和基于固定源码的依赖检索。

依据 [MathCopilot 知识库指南](https://mathcopilot.cn/help#manual-knowledge)与[检索指南](https://mathcopilot.cn/help#manual-retrieval)。本轮于 2026-10-02 在浏览器实际读取公开说明。

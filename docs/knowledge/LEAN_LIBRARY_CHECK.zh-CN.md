# 第四项：现有 Lean 库的最小检索验收

本地准备已完成，网站操作等待登录。此文件不能代表网站索引已经就绪。

## 固定对象

仓库 zhuanxv-G/MolecularDynamicsFormalization，工作分支 chapter01-kinetic-energy-nonneg，提交 9587329cf646889b6ebbab7133ae76dce156450d。Lean/mathlib v4.34.0，mathlib 提交 5ed2965256430c3649e86755f9576b54eca72435。机器可读对象和源文件哈希见 LEAN_LIBRARY_CHECK.json。

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

## 在网站的最小操作

1. 设置 → Git → Lean 库，核对正式仓库、项目和实际读取的版本；提交不匹配时不能直接声称使用了当前工作分支。
2. 对远端新版本点击“更新”，记录实际仓库 HEAD。若未暴露 HEAD，明确版本未知，任务以冻结源码为准。
3. 检查语义检索/Embedding 的实际可用状态；索引 stale 或不存在时按已有配置重建，不反复重设已确认技能或 GitHub 连接。若需要新增收费模型配置而现有配置不足，记录缺项再处理。
4. 试搜“非负质量的动能非负”和精确名字 MolecularDynamics.nBodyKineticEnergy_nonneg；命中后打开完整声明，核对模块/import、量词、hm : ∀ i, 0 ≤ masses i、结论 0 ≤ nBodyKineticEnergy masses velocity 与源文件。
5. 索引 ready 且与当前仓库版本相符、测试命中且类型正确，才能记为第四项通过。查询失败要区分索引/分支/版本与声明本身，不把未检索到说成库没有。

不将 T1 文档里的候选头当作已证明引理。当前 T1/T3 无新增外部论文瓶颈，暂不连接 Zotero。

依据 MathCopilot 公开知识库指南：https://mathcopilot.cn/help#manual-knowledge。2026-10-01 已重新读取公开说明；用户账号实际索引尚未核对。

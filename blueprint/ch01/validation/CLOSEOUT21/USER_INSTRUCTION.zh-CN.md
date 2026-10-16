# 21号：第1章网站复审结果整合 + 最后一轮修复（2026-10-16 用户指令；第1章不再送网站）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部，并同步 heartbeat lean 的接续 prompt（保留 ACTIVE/15分钟/target/去重），然后执行。

## 0. 优先级
- 第6章：当前批次到最近的已验证检查点提交后暂停。
- 唯一任务：第1章最终收口。第2–5章不动；不进入第7章；正式库 MolecularDynamics/ 保持 0 sorry、字节冻结。

## 1. 登记网站返回（93条全部到齐）
- 已交付到 blueprint/ch01/mathcopilot_results/eaudit/EAUDIT04–23_result.json（用户为减少上传次数，把20批合并成5个任务R1–R5，再由脚本按 source_id 拆回各 EAUDIT 并校验了每条 input_sha256，原始合并返回在仓库外 mathcopilot_inbox/ch01_merged/，无需读取）。文件里有 "merged_from" 字段，属正常。
- 合计：PASS 62 / FAIL 10 / NEEDS_HUMAN 21。登记入 website_audit.json、WEBSITE_SUMMARY.json、PROGRESS.md。
- 对含原文版/修正版/反例的条目，网站普遍给出“原文版忠实 PASS、修正版 PASS、原书疑误 NEEDS_HUMAN”。登记时把这三者分开记录（例如 修正版=网站PASS，原文=原书疑误待导师），不要把整组记成未通过。

## 2. 修复 10 条 FAIL（严格按网站 suggested_fix，不自由发挥、不扩大范围）
| source_id | 修复要求 |
|---|---|
| MD-1.1.2-AngleBond | 加两键长非零/正的有效域谓词（或子类型）；保留现有公式作为总化辅助并在 docstring 说明；同时采纳 corrected_json（删除多余 k）。不改原书有向差约定。 |
| MD-1.1.2-GayBerne | 加 Gay–Berne 有效域谓词：u₁,u₂ 单位、q₁≠q₂、根号内严格正、σₛ/εₛ/μ 及各分母非零、Δ≠0；在该域上给出模型。不改 ε₂ 次数和 Δ。 |
| MD-1.2-NewtonCompact | compactNewton 加 DifferentiableAt ℝ U (q t)（或 HasFDerivAt）；保留现有时间导数条件。 |
| MD-1.2-HarmonicSolution | 补谐振子能量定义 E=‖v‖²/2+Ω²‖x‖²/2 并与本条连接。唯一性：若现有材料能短证（时间盒3次）则补；否则在 [EXTRA]/docstring 明确“本条正式覆盖不含唯一性”，不建大理论。 |
| MD-1.2-ScalarMechanical | 补标量能量定义 E_U(x,v)=v²/2+U(x) 并在本条中显式出现。 |
| MD-1.2-LJTimeScaling | 只把 [EXTRA] 中容差 0.005ps 改为与签名一致的 0.01ps（采纳 corrected_json）；不改定理。 |
| MD-1.5.2-ScalarFirstIntegral | 不补转向点/平衡点理论；在 [EXTRA]/docstring 明确本条为“能量守恒 + 非转向点局部求积”的部分形式化，并把转向点、平衡点列入覆盖缺口记录。 |
| MD-1.6-PeriodicTranslationMomentum | 键能量改为 φ ‖y−x+(if closing then L else 0)‖（即 φ∘|·|），第三定律对 ψ=φ∘|·| 在该差值处的可微性陈述；主定理不动。 |
| MD-1.6-RhombicLattice | 为作为二维格的入口加 a>0、b>0、sin θ≠0（或 0<θ<π）；保留一般生成集合作为辅助定义。不强加 a=b。 |
| MD-1.6-UnitCell | 要求 B 可逆（det B≠0 或列线性无关），motif 有限非空且位于 B([0,1)³)；保留一般平移并集作为辅助定义。 |

修复只改 blueprint/，每条修完单文件编译 + #print axioms；10条全部完成后跑一次完整 check。下游若有声明因签名变化编译失败，最小调整并记录。

## 3. 不再送网站（用户决定）
- 本轮修复的10条状态记为“按网站审校意见修复，本地核验通过（未再送网站）”，在 website_audit.json 中保留原 FAIL 返回和对应 suggested_fix 原文，并逐条记录实际改动 diff 摘要，供人工核对。
- 不生成新的 EAUDIT 复审包。

## 4. 勘误清单补充
- 把本轮 NEEDS_HUMAN 中原清单未覆盖的原书问题补进 docs/review/CH01_ERRATA.zh-CN.md（同样字段：原文逐字、页码、问题、反例、原文版/修正版名称和状态、核查点、选项）。至少核对以下是否已覆盖，未覆盖的新增：
  - MD-1.6-PeriodicImages：原书 vᵢ 类型前后矛盾（全构型重复块 vs 三维位移），Lean 采用按粒子三维块解释。
  - MD-1.6.1-RealNormalMode：原书称任意复系数解可“改写”为实式，仅对实值解（b=ā）成立。
  - MD-1.6.1-MinimumGradientZero：原句“regardless of boundary”对约束边界极小不成立（U(x)=x 在 [0,1] 于 0 处）。
  - MD-1.4-PhaseSpace：“positions and velocities”笔误为 positions and momenta（若已在清单中则补网站结论）。
  - MD-1.1.2-Yukawa：κ 称为长度与 −κr 量纲冲突（同上）。
- 每个勘误条目追加一行“网站复审结论”（原文版/修正版/反例各自的 verdict）。

## 5. 完成标准
- FAIL 修复中 = 0；单文件编译、逐条 #print axioms、一次完整 check 通过；正式库 0 sorry。
- 更新 docs/review/CH01_SUMMARY_FOR_MENTOR.zh-CN.md：用导师能读懂的语言（不出现 sorryAx、checked+documented priors、字节预算等工程术语），给出：网站PASS数、本地按意见修复数、原书疑误数（附勘误清单链接）、已证/未证数及未证原因分类。
- 提交并 push；CURRENT_STATE 顶部写“第1章最终收口完成，等待用户新指令”，然后停止，不自动回第6章。

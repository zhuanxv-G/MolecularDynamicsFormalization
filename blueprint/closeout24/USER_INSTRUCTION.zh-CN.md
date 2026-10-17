# 24号：第2–5章网站复审结果整合 + 最后一轮修复 + 按第1章格式收口（2026-10-17 用户指令）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部（替换“第6章本地流程完成，等待用户新指令”），并同步 heartbeat lean 的接续 prompt（保留 ACTIVE/15分钟/target/去重；接续消息改为“按24号继续第2–5章收口”，停止条件为本文第6节完成标准），然后执行。

## 0. 背景与范围
- 导师已确认：第1章的交付格式（CH01_BLUEPRINT 逐条结构、CH01_ERRATA 勘误清单、CH01_SUMMARY_FOR_MENTOR 摘要）完全可以，后续章节一律按此格式。
- 本轮唯一任务：第2–5章最终收口，做法与21号（第1章）相同。
- 第1章、第6章不动；不进入第7章；正式库 MolecularDynamics/ 保持 0 sorry、字节冻结。

## 1. 登记网站返回（380条全部到齐）
- 已交付到 blueprint/ch0{2,3,4,5}/mathcopilot_results/eaudit/EAUDITxx_result.json（第2章 EAUDIT74–96，第3章 67–85，第4章 69–91，第5章 43–62）。用户把它们合并成28个任务提交，再由脚本按 source_id 拆回并逐条校验了 input_sha256；文件里的 "merged_from" 字段属正常，原始合并返回在仓库外，无需读取。
- 合计：
  - 第2章 75条：PASS 59 / FAIL 4 / NEEDS_HUMAN 12
  - 第3章 78条：PASS 55 / FAIL 10 / NEEDS_HUMAN 13
  - 第4章 110条：PASS 91 / FAIL 7 / NEEDS_HUMAN 12
  - 第5章 117条：PASS 97 / FAIL 6 / NEEDS_HUMAN 14
- 登记入各章 website_audit.json、WEBSITE_SUMMARY.json、PROGRESS.md。含原文版/修正版/反例的条目，原文版、修正版、原书疑误三者分开记录（同21号）。

## 2. 修复 27 条 FAIL
- 严格按各条返回中的 suggested_fix 修改，不自由发挥、不扩大范围。典型两类：
  - 覆盖不全（statement_scope 声称覆盖整段原文，但 Lean 只表达了其中一部分）：优先在 [EXTRA]/docstring 里把本条覆盖范围如实缩小，并把未覆盖的结论列入覆盖缺口记录；只有 suggested_fix 明确要求、且是短陈述时才补声明（补的声明可以 sorry，不建大型理论）。
  - 缺前提/有效域（如 RESPA 的 r>0、DipolarPotentialSum 的非碰撞、WeakAttractor 的 IsProbabilityMeasure μ、HardCoreDomain 的半径非负）：补上前提，保留总化定义作辅助并在 docstring 说明。
- 修复只改 blueprint/。每条修完单文件编译 + #print axioms；每章修完跑一次完整 check。下游声明若因签名变化编译失败，最小调整并记录。
- 不再送网站：状态记为“按网站审校意见修复，本地核验通过（未再送网站）”；website_audit.json 保留原 FAIL 返回、suggested_fix 原文和逐条改动 diff 摘要。不生成新的 EAUDIT 包。

## 3. 特殊条目
- MD-4.2.1-FastVerlet（NEEDS_HUMAN）：网站只因任务包没摘录 Chapter02Review.verlet 的定义体而无法确认。请本地核对该定义确为 kick(h/2)→drift(h)→kick(h/2)，若是，记为“本地核验通过（网站因摘录缺失未判）”，不算原书疑误。
- 其余 NEEDS_HUMAN 若网站正文写的是“签名忠实/修正版正确，仅原书表述有疑”，按原书疑误处理（第4节）。

## 4. 勘误清单（与 CH01_ERRATA 同格式）
- 为每章新建 docs/review/CH0{2,3,4,5}_ERRATA.zh-CN.md。字段与 CH01_ERRATA 相同：原文逐字、页码、问题所在、反例、原文版/修正版声明名及状态、核查点、选项，并加一行“网站复审结论”（原文版/修正版/反例各自的 verdict）。
- 收录：此前已登记的“待导师”条目（PROGRESS 中第2章18、第3章20、第4章27、第5章15条）+ 本轮新的原书疑误类 NEEDS_HUMAN。同一问题出现在多条时合并为一项，注明涉及的 source_id。
- 原文版与修正版都要保留：缺修正版的疑误条目补一个 _corrected 声明（正常尝试证明，时间盒3条路线）；原文版不证明。

## 5. 文档统一为第1章格式
- 各章 CH0x_BLUEPRINT.zh-CN.md 的每条按 CH01_BLUEPRINT 的结构重新生成：原文陈述 → 原文证明 → 完整当前Lean（原文与修正版独立列出）→ 对照表 → [EXTRA] → 审计结论（含网站结论）→ 状态与证明位置。
- 各章写 docs/review/CH0x_SUMMARY_FOR_MENTOR.zh-CN.md，结构照 CH01_SUMMARY_FOR_MENTOR：用导师能读懂的语言（不出现 sorryAx、checked+documented priors、字节预算、历史绑定哈希等工程术语，也不写“等待用户指令/第6章暂停”之类内部流程），给出：网站PASS数、本地按意见修复数、原书疑误数（附勘误清单链接）、已证/未证声明数及未证原因分类（缺大型理论 / 原书疑误不证 / 时间盒止）。
- CH0x_REVIEW_SHORT.zh-CN.md 若统计已过时，按新数字更新或在文件开头标明“已过时，以 SUMMARY_FOR_MENTOR 为准”。

## 6. 完成标准
- 第2–5章 FAIL 修复中 = 0；单文件编译、逐条 #print axioms、每章一次完整 check 通过；正式库 0 sorry、0 axiom。
- 四章各有 BLUEPRINT（第1章格式）、ERRATA、SUMMARY_FOR_MENTOR。
- 提交并 push；CURRENT_STATE 顶部写“第2–5章最终收口完成，等待用户新指令”，然后停止。不回第6章，不进入第7章。

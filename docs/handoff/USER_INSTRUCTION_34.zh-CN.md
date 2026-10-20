# 34号：全书成果汇总，交师兄（2026-10-20 用户指令）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部（替换“全书第1–8章已合并到 main，等待用户新指令”），并同步 heartbeat lean 的接续 prompt（保留 ACTIVE/15分钟/target/去重；接续消息改为“按34号继续全书汇总”，停止条件为第6节完成标准），然后执行。

## 0. 目的与范围
- 师兄要一份全书（第1–8章正文）成果总结。读者是导师：数学语言，不出现工程术语和内部流程话（不出现 heartbeat、EAUDIT、批次、任务包、哈希、R1–R9、Codex、提示词编号等）。
- 分支 main。只新增汇总文件和脚本；**不改任何 .lean 文件、不改各章 BLUEPRINT/ERRATA/SUMMARY 正文**。正式库保持 0 sorry、0 axiom。
- 第1章汇报已经过师兄确认格式（docs/review/CH01_*），全书汇总延续这个风格。

## 1. 统一统计（脚本生成，禁止手填）
- 写 scripts/book_stats.py（或放 docs/review/book/ 下），从各章机器可读来源（PROGRESS.md、website_audit.json、WEBSITE_SUMMARY.json、*_CLAIMS.csv、Blueprint/Ch0x.lean）重新计算，输出 docs/review/book/BOOK_STATS.json 和 BOOK_STATS.csv。
- 每章字段：PDF页/印刷页范围、条目数、网站最终 PASS 数、按审校意见本地修复数、需人工判断数、FAIL 数（应为0）、原书疑误项数（ERRATA 节数）、命名声明数、定义数、已证数、未证数、未证原因分类（缺大理论 / 原书疑误原文版不证 / 尝试次数用尽）、Blueprint 行数、sorry 数。再给全书合计。
- 第2–5章现有 SUMMARY 口径与第1、6–8章不一致（如第2章“160条”），以脚本结果为准；若与某章 SUMMARY 数字不符，在 BOOK_STATS_DIFF.md 里逐条列出差异和原因，不改原 SUMMARY。
- 一致性自检：各章 sorry 数与 grep 结果相等；已证+未证+定义 = 命名声明数；PASS+本地修复+需人工 与条目数的关系说清楚。

## 2. 全书汇报正文 docs/review/book/BOOK_SUMMARY_FOR_MENTOR.zh-CN.md
控制在约 4–6 页，结构：
1. 一段话结论：做了什么、覆盖范围（第1–8章正文，不含习题）、最重要的几个数字。
2. 方法与可信度：每条怎么做（原文 → Lean 陈述 → 对照表 → 独立语义审校 → 证明状态）；编译检查保证什么、语义审校保证什么、各自不能保证什么；[EXTRA] 补充前提的含义；Lean 4.34.0 + 固定 Mathlib，正式库无未完成证明、无新增公理。这里顺带回答师兄之前问过的三个问题：定义是否冗余、编译与语义检查分别查什么、人工怎么看和 EXTRA 怎么理解。
3. 分章总表（来自 BOOK_STATS）+ 每章 2–3 行要点（主题、关键定理、主要缺口）。
4. 原书疑误：全书总数；按类型分组（印刷/符号错误、缺前提、结论过强、记号指代矛盾等）；列出**最需要导师裁定的 15–25 项**，每项一行（章节、页码、问题一句话、建议版本），链接到对应章 ERRATA。注意区分“转录错误已更正”与“原书疑误”，前者不计入。
5. 未证明部分：全书未证总数和三类原因；把“缺大理论”按理论归并（如 Hartman–Grobman、SDE 解存在唯一性、遍历性/混合、Hörmander、反向误差分析等），给每类涉及条目数和章节——这是给导师决定下一阶段优先级用的。
6. 已知局限：定义冗余情况（blueprint 与正式库同名定义、跨章近似重复定义，给数量和代表例子）、只做正文不做习题、语义审校是工具辅助而非人工逐条等。
7. 请导师决定的事项（3–5条）：如疑误裁定方式、下一阶段是否补证明及优先次序、是否去重、交付格式是否需要调整。
8. 文件导航：各章 SUMMARY/ERRATA/BLUEPRINT/Lean 文件的路径和用途，以及仓库地址与标签 book-ch01-08-closeout。

## 3. 辅助文件（docs/review/book/）
- BOOK_ERRATA_INDEX.zh-CN.md：全书疑误一项一行（章、ERRATA 节号、页码、类型、一句话、状态），可排序；转录错误已更正的单列一节。
- BOOK_GAPS.zh-CN.md：未证声明按缺失理论归并的明细表（声明名、章节、原因）。
- BOOK_REDUNDANCY.zh-CN.md：blueprint 与正式库重名/同式定义、跨章近似重复定义清单（只报告，不改代码）。

## 4. 交付包
- 导师能访问 GitHub，**以仓库为主要入口**：新增 docs/review/book/README.zh-CN.md 作为导航页，写明阅读顺序（先 BOOK_SUMMARY，再 ERRATA_INDEX，按需看各章 SUMMARY/ERRATA/BLUEPRINT），并给出各文件在 GitHub 上的链接（用标签 book-ch01-08-closeout 之后的 main 提交或新标签固定版本，不要用会漂移的分支链接）；Lean 文件只给链接，不复制。
- 汇总文件提交后，打新标签 book-ch01-08-summary 并推送，导航页链接指向这个标签。
- 仓库根 README 增加一节“全书审阅入口”，指向 docs/review/book/README.zh-CN.md（只加这一节，不改其他内容）。
- 另生成轻量离线包 deliverables/book-ch01-08-docs.zip（工程外层目录 C:\Users\ustc\Desktop\formal math\deliverables\ 下）：只含 book/ 汇总文件 + 8 章 SUMMARY_FOR_MENTOR 和 ERRATA，不含 BLUEPRINT 和 .lean（这些在 GitHub 看）。不放 CH01_REVIEW_SHORT 等过期文件。
- 检查导航页和汇总文件中的相对链接与 GitHub 链接路径都存在（脚本按标签内文件列表检查，报告坏链接数，应为0）。

## 5. 不做的事
- 不改 .lean、不改各章文档正文、不送网站、不补证明、不去重（只报告）。

## 6. 完成标准
- BOOK_STATS 自检全部通过；BOOK_SUMMARY 无工程术语（grep 检查上面列的词为0）；导航页、标签 book-ch01-08-summary、离线 zip 已生成，坏链接0；正式库 0 sorry、0 axiom；.lean 文件字节与 f4ea1f7b 一致。
- 汇总文件提交并 push 到 main，标签已推送（zip 在工程外，不提交）；CURRENT_STATE 顶部写“全书汇总已生成，等待用户审阅后交师兄”，然后停止。

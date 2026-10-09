# BATCH01 精简提交：三个小Task

原BATCH01的五条内容均保留，分成a/b/c三个独立Task。各Task输入框只粘贴PROMPT.txt，分别关联本行的两个附件。无需把全章JSON、Blueprint或64个依赖文件加入当前Task。

| 顺序 | 提交到输入框 | 需上传/引用的两个附件 | 条数 | 指令+两附件总字节 |
|---|---|---|---|---|
| 1 | [a/PROMPT.txt](a/PROMPT.txt) | [BATCH01a_MATERIALS.md](a/BATCH01a_MATERIALS.md) + [BATCH01a_PAGES.pdf](a/BATCH01a_PAGES.pdf) | 1 | 227515 |
| 2 | [b/PROMPT.txt](b/PROMPT.txt) | [BATCH01b_MATERIALS.md](b/BATCH01b_MATERIALS.md) + [BATCH01b_PAGES.pdf](b/BATCH01b_PAGES.pdf) | 2 | 207628 |
| 3 | [c/PROMPT.txt](c/PROMPT.txt) | [BATCH01c_MATERIALS.md](c/BATCH01c_MATERIALS.md) + [BATCH01c_PAGES.pdf](c/BATCH01c_PAGES.pdf) | 2 | 130539 |

a：MD-1.5.3-Thm1.1。
b：MD-1.2-EnergyConservation、MD-1.3-NewtonEulerLagrange。
c：MD-1.4-LegendreHamiltonian、MD-1.5.1-FlowInverse。

每份指令853字节，各任务的两附件及指令合计均小于256000字节。网站提示的256KB具体计算口径及实际接收尚未验证；不承诺附件转换后的计数与文件字节相同。建议各子任务使用新Task，避免累积全章材料/旧对话。

材料包含完整原文JSON、逐字Lean签名/注释和实际用到的定义；PDF页从原书直接截取，页码映射在材料开头。没有改写正式库、Blueprint或原文条目。附件是审校摘录，不是供独立编译的Lean工程。

已验证：冻结输入哈希、五条完整覆盖且无重复、原文/Lean/定义逐字保留、13个导出页的文本/页面内容/尺寸及渲染像素与原PDF完全一致。各子目录MANIFEST.json记录这些证据和输入哈希。网站审计尚未返回。

结果逐份原样保存到blueprint/ch01/mathcopilot_results/，命名BATCH01a_result.json、BATCH01b_result.json、BATCH01c_result.json，或直接发给Codex。三份合起来构成原BATCH01完整返回；未返回的条目仍待网站审计，不能按子任务完成数将整批标PASS。

这是针对BATCH01输入限制的替代提交方式。BATCH02–BATCH23保持原包；后续如需精简，可按相同原则截取当前批次材料，不能通过只保留名称或省略前提缩短审计。

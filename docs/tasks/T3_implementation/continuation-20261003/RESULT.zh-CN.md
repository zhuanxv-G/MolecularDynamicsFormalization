# T3 承接与正式集成交付

本轮已完成正式集成、本地全工程验收、原九目标与七边界的正式接口验收，以及教材原页本地语义复核。Git提交/推送及远端CI正在收尾；MathCopilot独立报告和负责人最终签核仍待完成，不能将本批称为已通过全部关口。

## 已完成且本轮验证

- 正式`MolecularDynamics/Chapter01/Hamiltonian.lean`：五个定义、十八条完整定理，覆盖七个规格ID/九个一般目标；复用T2算子。顶层导入、Scratch、关键公理打印、映射/假设/状态已同步。
- 全工程`pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory docs/verification/2026-10-03-T3-first-batch-retry03`实际退出0：固定Lean4.34.0/mathlib5ed2965、源码扫描、8932 jobs构建、Scratch、171项目声明公理审计及输入SHA稳定全部通过。
- `FormalExactGoals.lean`：原九个Goal定义与逐一证明对正式模块编译退出0，无新增假设，公理均为propext/Classical.choice/Quot.sound。
- `FormalBoundaries.lean`：七个原边界对正式模块编译退出0，包含m=(0,2)、p=(0,4)的坐标动能4/整体奇异逆动能0、零维、单坐标能量16和负质量例。
- 冻结MANIFEST的56件文件全部重新实哈希验收。正式模块只更新候选的模块说明及换行，数学陈述与证明保留。`.gitattributes`保存T3原始证据字节，避免Git换行转换破坏SHA台账。
- 教材PDF实SHA匹配；重新渲染并查看印刷18--19/PDF41--42、印刷24--25/PDF47--48。逐目标判断与范围见`SEMANTIC_REVIEW.zh-CN.md`。

本轮正式源SHA256：`5c62cc4b16f7c3eddf8d2cfc2a1868acd8e991fc20f5c667dd170fc3fa58c54e`。机器验收原命令/退出码/源及日志SHA见全工程CHECK_REPORT与两份Formal探针result.json。

## 保存的失败与限制

1. 首次入口使用elan包装器时，运行版本检查触发不可访问的网络更新；改为本机已安装的固定工具链，未升级版本。
2. retry01版本检查发现plausible仓库所有权限制；为既有固定依赖添加仅当前进程有效的精确safe.directory，未更改全局Git配置。
3. retry02中Hamiltonian模块构建成功，顶层Lean进程在会话中断期间异常退出1073807364；保留原日志，不把它当作通过或源码报错。retry03重新完成全套验收。
4. 用户更新网站额度后，现有项目页面读取仍超时；更新Browser工具后可列标签，但可见DOM仍超时。未输入或发送T3审阅，当前网站任务/额度没有现场读取证据。
5. 外部Edge成功启动，随后Computer Use因无法可靠确定浏览器当前URL停止电脑控制。本轮停止该路径，没有继续通过电脑控制操作网页。不是自动审批审查拒绝。

## 仍需完成的两项外部关口

- MathCopilot独立完整证明审阅：连接可读后，先确认无重复运行请求，再用冻结输入提交本批审阅，收取原报告和输入/输出SHA台账。原`REVIEW_SEND_BODY.zh-CN.md`与原RESULT是冻结的历史快照，保留原字节；本轮正式集成状态以本目录记录为准。
- 负责人或学长最终语义签核：项目路线图E关口要求人工审阅教材对应关系。本轮原页复核已准备成具体逐目标报告，不能代签。

本批不包括真实时间轨道Hamilton/Newton解等价、能量守恒、解存在唯一性、全局延拓或Theorem1.1；这些不因本批静态恒等式通过而完成。

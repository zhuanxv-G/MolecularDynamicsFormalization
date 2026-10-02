# T2 完整证明独立审阅指令

实际发送前填写固定代码提交与输入 SHA256；以下是待发送正文，不是已发送回执。

请使用 Lean Blueprint/Lean Proof 对本地已完成的 T2 第一批做独立数学与Lean证明审阅。旧S1起草任务因usage limit失败，没有完整输出；本次范围是完整代码审阅，不继续旧任务或重做已证明的T1。

输入必须固定到本次提供的Git提交，或按附件原字节及SHA256读取。仓库分支可变化，不以分支最新HEAD替代固定对象。固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435。托管Lean若版本不同须明确标记；本地scripts/check.ps1已通过，不把网站单文件检查称为本地验收。

审阅 `LocalTrajectories.lean` 的五定义/十五证明，并读取其 Notation、NBody、ParticleCoordinates 依赖及 FORMALIZATION_MAP、ASSUMPTIONS。本批对应教材印刷18–19/PDF41–42、印刷24/PDF47、印刷25–26/PDF48–49。

逐ID检查：L0坐标桥接和两侧逆；S1开放时间域的HasDerivWithinAt→HasDerivAt；B1真实导数动量关系；B2在邻域内的函数等式与二阶导数；B3代数hFU、势能可微应用层和真实HasGradientAt语义；B4不要加不需要的开时间集条件，确认输入的v/a是真导数而非任意点态数据；E1显式初值/正半径/质量与速度动量区别。也审解的限制、连续性及initial_mem。

不得将一般局部存在唯一性、最大解延拓、能量守恒、全局流或Theorem1.1算作本批成果。不得要求Hessian正定作为严格极小稳定性原定理的替代。

交付 `T2_PROOF_REVIEW.zh-CN.md`、逐ID REVIEW_LEDGER.csv、输入/输出文件SHA256及精确提交元数据；列出接受项、实际阻断问题、可选改进以及网站实际运行的检查。先返回报告，不自行修改共享正式源码或推送/合并。若发现错误，给出能在固定版本复现的最小修正建议。

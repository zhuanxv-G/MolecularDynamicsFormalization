# T5 正式集成本地验收

2026-10-03，Asia/Shanghai。检查起始HEAD
`675fcaedbdef7b6ec57393c1ee99e9ca727da649`；固定Lean4.34.0/mathlib
`5ed2965256430c3649e86755f9576b54eca72435`。

## 已实际验证

- `pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory docs/verification/2026-10-03-T5-first-batch` 于01:25–01:28退出0。
- 固定版本、无mathlib tracked修改、源码扫描、8931 jobs构建、Scratch、全命名空间128声明公理审计通过；受检输入SHA在检查期间稳定。
- 对所有T5命名证明显式打印公理，只有propext、Classical.choice、Quot.sound。原完整报告/命令/原日志/输入哈希见CHECK_REPORT.json及同目录。
- 独立T5源和日志SHA在接收时重核匹配，正式集成保留其证明；命名空间改为MolecularDynamics、将匿名x⁴连续性样例命名为公开定理，并将公理打印移至检查脚本。正式模块共五定义/二十五完整命名证明。
- 原页印刷32–33/PDF55–56本轮重新视觉核对；严格极小定义与教材一致，不以Hessian正定代替。小扰动初值版本允许任意球内起点，其IVT起点距离由球成员假设给出。

## 数学边界及待验证

六个一般目标、正球面差、静态低能排除、给定连续守恒曲线的区间留球、组合定理和边界样例均为完整证明。动力学连续、动能非负与能量恒定是条件留球结论的上游输入，尚未从机械ODE证明守恒；没有把“全程留球”放进假设。

提交9baf87f89d07138a95bfbfe1f37d45dd54946cf7已推送；实际远端CI run37041343101/job110951942612成功。原日志确认固定版本、8931 jobs、Scratch与128声明审计；artifact11242057946上传成功。元数据和检查摘录另存在本目录，未套用T2旧CI。

一般真实解存在/唯一性、动量控制、最大解全局延拓、Theorem1.1全相空间稳定和全未来时间严格sup界仍未完成。MathCopilot独立证明审阅及负责人最终教材语义签核pending。

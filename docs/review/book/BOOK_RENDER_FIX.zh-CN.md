# 全书审阅文档公式渲染修复报告

本版本修复了 GitHub 上的公式渲染；数学内容与 book-ch01-08-summary 相同。

## 第8章符号对照表

|原写法|LaTeX 写法|含义或约定|
|---|---|---|
|p̃、q̃、ρ̃、H̃|`\tilde p`、`\tilde q`、`\tilde\rho`、`\tilde H`|保留原有波浪号，不重解释变量|
|Ĉ、Ĥ、Γ̂、ρ̂|`\hat C`、`\hat H`、`\hat\Gamma`、`\hat\rho`|帽号|
|p̄、q̄、θ̄、ξ̄|`\bar p`、`\bar q`、`\bar\theta`、`\bar\xi`|上横线|
|q̇、ṗ、ξ̇、p̃̇|`\dot q`、`\dot p`、`\dot\xi`、`\dot{\tilde p}`|时间导数|
|M¹ᐟ²、M⁻¹ᐟ²、ᵀ|`M^{1/2}`、`M^{-1/2}`、`^{\mathsf T}`|分数幂与转置|
|β γ τ σ θ μ ξ ρ φ Φ Γ Δ ∇ ∂|`\beta \gamma \tau \sigma \theta \mu \xi \rho \varphi \Phi \Gamma \Delta \nabla \partial`|公式中采用命令；普通句子中的希腊字母可保留|
|∑、Σ（求和）、∫、√|`\sum`、`\sum`、`\int`、`\sqrt{...}`|Σ 为噪声矩阵时保留 `\Sigma`|
|N_d、k_BT、p_s|`N_d`、`k_B T`、`p_s`|自由度、温度乘积、共轭动量|
|∇q、∇p、∂ξ|`\nabla_q`、`\nabla_p`、`\partial_\xi`|对指定变量求导；不改变算子作用范围|
|‖p‖、⟨A⟩、⋯|`\lVert p\rVert`、`\langle A\rangle`、`\cdots`|范数、平均、省略号|

## 验收状态

2026-10-22：8项自检全部通过；第8章 `[RENDER?]` 为0，剩余未解释内容差异为0。
只修改公式分隔符、记号写法和必要排版；全部既有二、三级标题及代码块与基线逐字节一致。
Git基线为 `de3b2539`；1,367个已跟踪Lean文件内容与该版本相同，并与接管时原字节快照一致。正式库298个文件为0 sorry、0 axiom声明。Lean源码未变，本轮未重跑完整构建，沿用既有编译证据。

## 重新计数与各章修改数量

旧显示分隔符合计1,390对，旧行内分隔符1对。CH01表格为75个受影响行、95段公式；“75处”是行数，不能当作公式段数。
1,295段旧显示公式改为独立公式，95段表格公式改为行内公式；第5章另有1段原有跨行行内公式改为独立公式，因此现有独立公式共1,296段。

|文件|旧显示公式|其中跨行|表格受影响行|转换后独立公式|转换后行内公式总数|
|---|---:|---:|---:|---:|---:|
|CH01_BLUEPRINT.zh-CN|199|3|75|104|362|
|CH01_ERRATA.zh-CN|15|1|0|15|42|
|CH01_PILOT.zh-CN|6|0|0|6|13|
|CH02_BLUEPRINT.zh-CN|168|0|0|168|323|
|CH02_ERRATA.zh-CN|25|0|0|25|66|
|CH03_BLUEPRINT.zh-CN|140|14|0|140|304|
|CH03_ERRATA.zh-CN|37|6|0|37|81|
|CH04_BLUEPRINT.zh-CN|141|1|0|141|276|
|CH04_ERRATA.zh-CN|35|0|0|35|63|
|CH05_BLUEPRINT.zh-CN|63|6|0|64|481|
|CH05_ERRATA.zh-CN|14|2|0|14|115|
|CH06_BLUEPRINT.zh-CN|247|14|0|247|654|
|CH06_ERRATA.zh-CN|55|1|0|55|172|
|CH07_BLUEPRINT.zh-CN|199|36|0|199|258|
|CH07_ERRATA.zh-CN|46|7|0|46|57|

行内公式总数包含原有公式；完整初始计数见 [BOOK_RENDER_BASELINE.json](BOOK_RENDER_BASELINE.json)。

|第8章文件|新增行内公式|人工改写差异片段|涉及章节条目|
|---|---:|---:|---:|
|CH08_BLUEPRINT|800|220|100|
|CH08_ERRATA|762|119|32|

人工片段按Git逐行差异分组计数，不把重复引文误算成独立数学结论。
第8章正文103条全部逐条对照英文摘要与PDF原页；PDF350–420（印刷329–399，420页仅核对Exercises之前正文）已查看。ERRATA31节及末尾范围汇总中的重复公式同文同步，原印版与修正版始终分开。

## 自检8项

|项目|结果|
|---|---|
|1 代码块外旧数学分隔符|0|
|2 每行美元符成对、显示分隔符独占行|通过|
|3 每个独立公式主体只有一行|通过|
|4 表格公式无裸竖线|通过|
|5 行内公式边缘无空白|通过|
|6 既有二、三级标题与Git基线相同|通过|
|7 全部代码块与Git基线逐字节相同|通过|
|8 全文去分隔符/空白比较及人工记号差异复核|通过；未解释差异0|

完整机器结果见 [BOOK_RENDER_CHECK.json](BOOK_RENDER_CHECK.json)。第1–7章及其他文档的比较只容许分隔符、引用符、空白、竖线写法、文字下划线转义和公式编号排版。第8章另要求精确前后记录匹配，且独立记号规范化比对相等；不会整章跳过检查。
规范化比对用于发现转写差异，不是数学定理验证，也不能单凭它确认上下标位置；上下标及原书疑误由逐条原页核对约束。

## 必要排版修复

- 第1章表格里的公式编号保持可见，用普通公式文字编号代替行内不支持的编号命令；范数的表格竖线改为单个命令，消除Markdown转义层。
- 第4、6章一个公式块内的多个编号改为文字编号，编号和各条公式次序不变。
- 第5章两处伴随符号与后续变量之间补命令间空格；另把原有五行行内公式合并为独立公式。
- 第8章原写 `Γhat` 按同条噪声对象写作帽号Γ；`p½` 依PDF411页表示半步动量，采用下标 `p_{1/2}`；原印符号疑误、遗漏因子和原有范围限定均不修订。
- 6,125段公式经KaTeX 0.16.22解析，错误0；这是附加语法检查，GitHub页面目视抽查另行记录。

## 第8章人工改写条目与原页

全部339个精确前后差异片段（含原行号、条目和SHA256）见 [CH08_RENDER_EDITS.json](CH08_RENDER_EDITS.json)，供逐项人工抽查。下表列出涉及条目及各自页码。

|文件|条目|PDF页|差异片段|
|---|---|---|---:|
|CH08_BLUEPRINT|MD-8.1-CanonicalCorrelation|350–351|1|
|CH08_BLUEPRINT|MD-8.1-HamiltonianStationary|351|2|
|CH08_BLUEPRINT|MD-8.1-ExtendedDensity|352|1|
|CH08_BLUEPRINT|MD-8.1.1-NoseHoover|352|2|
|CH08_BLUEPRINT|MD-8.1.1-NHDensitySplit|353|1|
|CH08_BLUEPRINT|MD-8.1.1-NHFirstIntegralPrinted|354|3|
|CH08_BLUEPRINT|MD-8.1.2-NHReversal|354|1|
|CH08_BLUEPRINT|MD-8.1.2-NHTimestep|354|2|
|CH08_BLUEPRINT|MD-8.1.2-NHTimestepReversible|354|1|
|CH08_BLUEPRINT|MD-8.1.2.1-NoseHamiltoniansPrinted|355|2|
|CH08_BLUEPRINT|MD-8.1.2.1-NPEquations|355|7|
|CH08_BLUEPRINT|MD-8.1.2.1-NPtoNH|356|1|
|CH08_BLUEPRINT|MD-8.1.2.1-NPShadowDensity|356|1|
|CH08_BLUEPRINT|MD-8.2-GeneralThermostat|357|2|
|CH08_BLUEPRINT|MD-8.2.1-ContinuityProductRule|357–358|1|
|CH08_BLUEPRINT|MD-8.2.1-ThermostatCriterion|358|2|
|CH08_BLUEPRINT|MD-8.2.1-Examples81and82|358–359|5|
|CH08_BLUEPRINT|MD-8.2.1-TemperatureIdentity|359|2|
|CH08_BLUEPRINT|MD-8.2.1-Proposition81|359–360|1|
|CH08_BLUEPRINT|MD-8.2.2-NHChains|360–361|3|
|CH08_BLUEPRINT|MD-8.3-ArrheniusRate|363|3|
|CH08_BLUEPRINT|MD-8.4-AdditiveThermostatSDE|363–364|4|
|CH08_BLUEPRINT|MD-8.4-OUStationarityPrinted|364–365|3|
|CH08_BLUEPRINT|MD-8.4-LiftedThermostat|365–366|2|
|CH08_BLUEPRINT|MD-8.4-Proposition82|365–366|5|
|CH08_BLUEPRINT|MD-8.4.1-NHL|366–367|7|
|CH08_BLUEPRINT|MD-8.4.1-Lemma81|368|1|
|CH08_BLUEPRINT|MD-8.4.1-Proposition83|368–369|1|
|CH08_BLUEPRINT|MD-8.4.1-Theorem81|367–369|4|
|CH08_BLUEPRINT|MD-8.4.1-ZeroModeInvariant|367|1|
|CH08_BLUEPRINT|MD-8.4.1-NHLGenerator|369|2|
|CH08_BLUEPRINT|MD-8.4.1-LyapunovCalculation|369–370|2|
|CH08_BLUEPRINT|MD-8.4.1-LyapunovRatePrinted|370|4|
|CH08_BLUEPRINT|MD-8.4.2-NHLTimestep|371|3|
|CH08_BLUEPRINT|MD-8.4.1-NHLWeakStationary|366–367|1|
|CH08_BLUEPRINT|MD-8.4.3-PreEquilibriumMeans|375–376|3|
|CH08_BLUEPRINT|MD-8.4.4-VelocityRescaling|376|2|
|CH08_BLUEPRINT|MD-8.4.4-RescalingStationary|376|4|
|CH08_BLUEPRINT|MD-8.4.5-ThermostatEfficiency|377–378|1|
|CH08_BLUEPRINT|MD-8.5-SLS|378–379|1|
|CH08_BLUEPRINT|MD-8.5-SLSBracketPrinted|379|3|
|CH08_BLUEPRINT|MD-8.5-SLSConservation|379|1|
|CH08_BLUEPRINT|MD-8.5-SLSLeapfrog|379–380|5|
|CH08_BLUEPRINT|MD-8.5-SLSDoubleWell|380|1|
|CH08_BLUEPRINT|MD-8.6-IsokineticField|382–383|1|
|CH08_BLUEPRINT|MD-8.6-IsokineticProjector|383|1|
|CH08_BLUEPRINT|MD-8.6-IsokineticDivergencePrinted|383–384|3|
|CH08_BLUEPRINT|MD-8.6-IsokineticGibbsShell|384|1|
|CH08_BLUEPRINT|MD-8.6.1-StochasticIsokinetic|385–386|2|
|CH08_BLUEPRINT|MD-8.6.1-SINWeightPrinted|386|3|
|CH08_BLUEPRINT|MD-8.6.2-SINHarmonic|387|2|
|CH08_BLUEPRINT|MD-8.6.2-SINProjectedBracketsPrinted|388|3|
|CH08_BLUEPRINT|MD-8.6.2-SINThirdBracketPrinted|389|3|
|CH08_BLUEPRINT|MD-8.6.2-SINBracketRank|387–389|3|
|CH08_BLUEPRINT|MD-8.6.2-SINLyapunov|389–390|6|
|CH08_BLUEPRINT|MD-8.6.3-SINForceSplitting|391–392|2|
|CH08_BLUEPRINT|MD-8.6.3-SINRAlgorithm|392|2|
|CH08_BLUEPRINT|MD-8.6.3-SINNoseSubsplitting|393|2|
|CH08_BLUEPRINT|MD-8.6.3-SINForceExactPrinted|393|3|
|CH08_BLUEPRINT|MD-8.6.4-SINThreeLevelPotential|394|1|
|CH08_BLUEPRINT|MD-8.7-GeneralizedLangevin|395|1|
|CH08_BLUEPRINT|MD-8.7-GLEFluctuationDissipationPrinted|395|2|
|CH08_BLUEPRINT|MD-8.7-PronyKernel|396|2|
|CH08_BLUEPRINT|MD-8.7.1-PronyMemoryODE|396|1|
|CH08_BLUEPRINT|MD-8.7.1-PronyOUStationarity|397|6|
|CH08_BLUEPRINT|MD-8.7.1-CombinedPronyVariable|397|2|
|CH08_BLUEPRINT|MD-8.7.1-PronyLangevinLimit|397–398|2|
|CH08_BLUEPRINT|MD-8.7.1-GeneralizedLangevinIntegrator|398|1|
|CH08_BLUEPRINT|MD-8.7.1-GLEConsistentCoefficients|398|2|
|CH08_BLUEPRINT|MD-8.8-NPTThermodynamics|399|1|
|CH08_BLUEPRINT|MD-8.8-NPTBathTaylor|399|1|
|CH08_BLUEPRINT|MD-8.8-NPTDensity|399–400|1|
|CH08_BLUEPRINT|MD-8.8-AndersenCoordinates|400–401|1|
|CH08_BLUEPRINT|MD-8.8-AndersenKineticEnergy|400|1|
|CH08_BLUEPRINT|MD-8.8-AndersenHamiltonianPrinted|401|2|
|CH08_BLUEPRINT|MD-8.8.1-NHLPistonEquations|402–403|2|
|CH08_BLUEPRINT|MD-8.8.1-PistonHamiltonianSubfield|402|6|
|CH08_BLUEPRINT|MD-8.8.1-PistonThermostatWeightPrinted|402|5|
|CH08_BLUEPRINT|MD-8.8.1-PistonReducedPDE|403|1|
|CH08_BLUEPRINT|MD-8.8.1-PistonStationaryWeight|403|1|
|CH08_BLUEPRINT|MD-8.8.2-PistonIntegrator|404|2|
|CH08_BLUEPRINT|MD-8.8.3-ParrinelloRahman|406|1|
|CH08_BLUEPRINT|MD-8.9-TotalMomentum|407|1|
|CH08_BLUEPRINT|MD-8.9.1-DPDSoftPotential|408–409|2|
|CH08_BLUEPRINT|MD-8.9.1-DPDPairForces|409|2|
|CH08_BLUEPRINT|MD-8.9.1-DPDPairWiener|409–410|2|
|CH08_BLUEPRINT|MD-8.9.1-DPDIntegralSystem|410|2|
|CH08_BLUEPRINT|MD-8.9.1-DPDCanonicalLeaf|410|1|
|CH08_BLUEPRINT|MD-8.9.1-DPDMassOrderPrinted|410|4|
|CH08_BLUEPRINT|MD-8.9.2-DPDVelocityVerlet|410–412|2|
|CH08_BLUEPRINT|MD-8.9.2-DPDSplitGenerator|412|1|
|CH08_BLUEPRINT|MD-8.9.2-DPDPairGeneratorPrinted|413|3|
|CH08_BLUEPRINT|MD-8.9.2-DPDPairOUUpdate|414|4|
|CH08_BLUEPRINT|MD-8.9.3-PairwiseNoseHoover|415|2|
|CH08_BLUEPRINT|MD-8.9.3-PairwiseCanonicalWeight|415|1|
|CH08_BLUEPRINT|MD-8.9.4-PairwiseNHLSDE|416|1|
|CH08_BLUEPRINT|MD-8.9.4-PairwiseNHLGenerator|416|1|
|CH08_BLUEPRINT|MD-8.9.4-PNHLSplittingAlgorithms|417|2|
|CH08_BLUEPRINT|MD-8.10-BerendsenRelaxation|417–418|1|
|CH08_BLUEPRINT|MD-8.10-NHLTotalMomentumSign|419|1|
|CH08_ERRATA|1. MD-8.1.1-NHFirstIntegralPrinted|354|4|
|CH08_ERRATA|2. MD-8.1.2.1-NoseHamiltoniansPrinted|355|4|
|CH08_ERRATA|3. MD-8.1.2.1-NPEquations|355|4|
|CH08_ERRATA|4. MD-8.2.1-Examples81and82|358–359|4|
|CH08_ERRATA|5. MD-8.4-AdditiveThermostatSDE|363–364|4|
|CH08_ERRATA|6. MD-8.4-OUStationarityPrinted|364–365|3|
|CH08_ERRATA|7. MD-8.4-Proposition82|365–366|4|
|CH08_ERRATA|8. MD-8.4.1-NHL|366–367|4|
|CH08_ERRATA|9. MD-8.4.1-Proposition83|368–369|4|
|CH08_ERRATA|10. MD-8.4.1-Theorem81|367–369|4|
|CH08_ERRATA|11. MD-8.4.1-LyapunovRatePrinted|370|4|
|CH08_ERRATA|12. MD-8.4.3-PreEquilibriumMeans|375–376|4|
|CH08_ERRATA|13. MD-8.4.4-RescalingStationary|376|4|
|CH08_ERRATA|14. MD-8.5-SLSBracketPrinted|379|4|
|CH08_ERRATA|15. MD-8.5-SLSLeapfrog|379–380|4|
|CH08_ERRATA|16. MD-8.6-IsokineticDivergencePrinted|383–384|3|
|CH08_ERRATA|17. MD-8.6.1-SINWeightPrinted|386|4|
|CH08_ERRATA|18. MD-8.6.2-SINProjectedBracketsPrinted|388|3|
|CH08_ERRATA|19. MD-8.6.2-SINThirdBracketPrinted|389|3|
|CH08_ERRATA|20. MD-8.6.2-SINBracketRank|387–389|3|
|CH08_ERRATA|21. MD-8.6.2-SINLyapunov|389–390|5|
|CH08_ERRATA|22. MD-8.6.3-SINForceExactPrinted|393|3|
|CH08_ERRATA|23. MD-8.7-GeneralizedLangevin|395|1|
|CH08_ERRATA|24. MD-8.7-GLEFluctuationDissipationPrinted|395|2|
|CH08_ERRATA|25. MD-8.7.1-PronyOUStationarity|397|4|
|CH08_ERRATA|26. MD-8.8-AndersenHamiltonianPrinted|401|2|
|CH08_ERRATA|27. MD-8.8.1-PistonHamiltonianSubfield|402|5|
|CH08_ERRATA|28. MD-8.8.1-PistonThermostatWeightPrinted|402|4|
|CH08_ERRATA|29. MD-8.9.1-DPDMassOrderPrinted|410|4|
|CH08_ERRATA|30. MD-8.9.2-DPDPairGeneratorPrinted|413|4|
|CH08_ERRATA|31. MD-8.9.2-DPDPairOUUpdate|414|3|
|CH08_ERRATA|覆盖缺口|见同条页码|7|

## 剩余待确认

渲染转写的 `[RENDER?]`：0。没有以猜测补入新公式。原书疑误的数学裁定与尚未完成的证明维持原状态，不因排版修复而视为通过。
尚需用户在GitHub抽查阅读效果，然后交师兄。自动额度恢复接续尚未端到端实测。

## 交付

固定标签：[本修复版本](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/tree/book-ch01-08-render-v2)。旧 `book-ch01-08-summary` 和 `book-ch01-08-closeout` 标签保持原对象不变。
导航页、导师汇总、疑误索引等book辅助页与根README的审阅链接改指修复标签，避免从新导航跳回旧公式；离线包同名覆盖 `deliverables/book-ch01-08-docs.zip`，只含book汇总材料及8章SUMMARY/ERRATA，不含BLUEPRINT、Lean、Python脚本或缓存。

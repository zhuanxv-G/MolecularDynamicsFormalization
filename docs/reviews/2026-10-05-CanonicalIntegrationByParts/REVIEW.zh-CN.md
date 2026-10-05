# Proposition6.1实际全域Gibbs分部积分与温度比值

原印刷222/PDF243目视核对 ../tmp/pdfs/chapter6-temperature/page-243.png 与前后221/223。19public，此批给原完整温度比值明确模型的真实证明，不仅compact special case。H/G C1（书中smooth包含）、phase real2Nc=SymplecticCoordinates Nc；Gibbs Z正有限来自actualρ integrable，两个weighted observable Lebesgue integrable，Avdiv正，weighted G统一有界，kB/T正。finite Nc，Nc0正Avdiv不可能，不用该vacuous case证明任何非零维结论。任意Hamiltonian H包含实际质量，无unit-mass/torus限制。

## 原语义与替代证明
原第三条|G exp(-βH)|<∞按有界向量场解释为∃C∀z‖ρG‖≤C；原sphere max估计要统一R界，此解释须负责人签核。若只读成每point有限，不能冒称同一前提。书中除ball volume的O(1/R)相对边界界本身不能得到两个未除volume weighted积分相等；使用下列实际截断替代证明。没有声称原命题假或反例已证。Lean Pi坐标norm是有限维统一有界表示，实际G·∇H和divG均已真实展开coordinate sums；负责人与原Norm表示语义pending。

## 实际证明链
固定actual ContDiffBump(0) inner1/outer2，η_R(z)=η(R^-1 z)。真实scalar homeomorphism给compact support，真实fderiv链式规则给R^-1 dη，compact derivative连续给单一C界，故‖dη_R‖≤C/R。每point η_(n+1)最终exact1及0..1。actual η_RF C1 compact，所以前批真compact div积分0；normdiv(η_RF)≤‖divF‖+C‖F‖且pointwise div→divF，DCT给F L1/divF L1时全域∫divF=0。只要求divsum L1，不偷增每partial全域L1。

实际smoothTransition derivative在outside[0,1]局部constant为0，所以derivative真正紧支/连续，全域单一D界。前批actual density-cutoff Fn=χ_(n+1)ρG在原weighted G仅bounded条件下由ρ支配得到L1；真实divFn=χ div(ρG)−β/(n+1)transitionDerivative*(LieG H)ρ也从原two weighted observables推导L1。应用全域IBP给每n∫divFn=0。第二DCT使用bound ‖div(ρG)‖+|β|D‖(LieG H)ρ‖；χ最终1，1/(n+1)error→0，因此原ρG即使未假设L1，也得到∫div(ρG)=0。

真实weighted divergence公式和integral_sub/const_mul推出∫divGρ=β∫LieG Hρ；actual Z^-1 canonical averages归一化给Avdiv=βAvLie。Avdiv正/β正推导AvLie本身正（比原abs正更强，故该原额外假设无需输入）；除法得到ratio=β^-1，proposition_6_1用β=(kBT)^-1得到物理温度等式。绝无IBP/ratio/边界通量结论作假设。

## 验证
api01 ContDiffBump.mem_Icc不存在，其他固定API输出真实；此failed probe不当验收。local01两个实际bump/constant scaling API用法错误；local02改nonneg/le_one/contDiff_const_smul后8空间cutoff全退出0。local03 full-space IBP漏传phase z；local04真实full-space IBP共10public退出0零诊断。local05 isClosed_tsupport漏函数参数；local06修正后实际transition bound/density divL1/第二DCT全14退出0零诊断。local07温度公式全部17退出0。local08另加original coordinate/分子正性后只有pos_of_mul_pos_left乘序错误；local09显式mul_comm后全部19退出0空日志/零Lean警告。
full-check01 passed：9062 jobs、1164 audited declarations、145 exact inputs；10 checks退出0，全部输入/原始日志SHA256复核匹配，新增19项逐名公理审计仅propext/Classical.choice/Quot.sound，Lean警告0。固定Lean4.34.0/mathlib5ed2965。负责人第三条统一有界解释、替代证明与教材语义仍pending。Theorem6.2 actual generator/density/Harris、Theorem6.1谱和其他正文/CORE_SCOPE仍未完成。

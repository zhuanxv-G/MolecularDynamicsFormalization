# Theorem6.2 的真实 future Wiener 概率规律与实际 Langevin 历史独立依赖

原页印刷252/PDF273重新目视，工作区tmp/chapter6-causal/page-273.png。Assumption1使用真实Markov process与transition kernel；本批只补其概率模型必要依赖，不能把独立性和pathwise restart计作完整条件Markov或Harris遍历。

## 真实证明链

WienerVectorFuture.lean 从已接受 textbookIsWienerVector 的原始联合Gaussian、均值、协方差和AE连续字段出发。未来路径为原B(S+t)-B(S)，S为任意确定非负时间；真实有限线性变换推出全坐标联合Gaussian，标量shift及跨坐标协方差展开推出同一标准vector Wiener条件，端点law是中心Gaussian variance t的有限乘积。用未来/过去联合Gaussian与真实零交叉协方差证明整段未来增量过程与整段向量历史独立，包含各坐标全部时间，而非只独立于B(S)。

实际独立whole-coordinate law与已有scalar countable sample law推出任意可数vector samples law；实际C(Icc0T,FinNc→ℝ)稠密序列eval是连续单射，Polish可测嵌入确定Borel路径law。未来与原过程的真实continuous-map law相同。借助ContinuousMap Borel=comap eval和共AE真实版本一致，将原过程整段独立性转到真正Cpath历史/未来随机变量。

LangevinFutureLaw.lean 在同一AE连续样本集证明所有确定S和real非负T的真实segment=实际future Cpath；与旧已接受all-time restart组合，得到同一实际global phase的future-path restart。全部实际过去状态作为noise-history的可测函数，derived AE-measurable（不交换不可数AE），future Cpath与整个实际实空间及periodic模型历史独立；联合law为原noise continuous-path law与实际history law的乘积。

标准vector Wiener是真实模型定义，不输入未来规律/历史独立/路径joint AEm结论。Nc有限，S确定非负、law finite horizon T≥0；auxiliary real解模型C² U和显式真实global forceLip、unit mass、任意γ/σ。periodic历史独立直接使用明确同一projected模型；代表独立周期主模型的C∞整数周期势能条件沿用既有证明。

## 本地诊断与验收边界

local01类型/if化简/IndepFun.comp参数，local03不可数ℝ≥0 .of_eval AEm接口限制，均留原日志；改用可数稠密sampling与真实Cpath Borel law后local04退出0零警告。未声明任意preBrownian不可数product-space joint AEm。module-build01退出0/3256jobs零警告。Langevin-local01的ContDiff作用域ω记号冲突改sample，local02仅最后乘积分布rewrite调用，改明确iff.mp；最终局部/统一验收见CHECK_REPORT与ACCEPTANCE。

full-check01 10/05/2026 19:31:50--10/05/2026 19:37:44退出0；9053jobs/零Lean警告/1054audit基础三公理/136inputs及全部raw SHA复核一致；17public逐名覆盖。 17public已接root/Scratch/逐名公理，机器验收通过。负责人教材语义签核pending。joint初值可测性、completed filtration/适应性、真正条件Markov、transition density、实际generator识别、Harris及全CORE_SCOPE仍未完成。

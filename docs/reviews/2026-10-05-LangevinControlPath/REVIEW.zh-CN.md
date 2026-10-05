# 引理6.1真实光滑控制构造验收

- LangevinControlPath真实光滑控制接受，待本地保存。full-check01/session7992：2026-10-05T12:30:21.3586603+08:00--2026-10-05T12:31:28.3847670+08:00退出0；9032 jobs、零Lean警告、853项审计声明仅基础三公理、115项输入及全部原始日志SHA256实查一致，10项public全覆盖。原255--256/PDF276--277已目视；实际三次Hermite q/p端点、真实q/p导数、真实force反解control rate与Bochner积分R0=0/C∞、实际controlled Langevin ODE和任意phase endpoints存在完整。Lemma6.1的Wiener tube概率支持/实际噪声路径连续依赖仍未证明，不能误计完整概率可达；负责人和整个CORE_SCOPEpending。下一必要LangevinNoiseStability.lean，从实际连续噪声积分解推出变换轨迹/真实Gronwall扰动界，先globally Lipschitz force辅助，再明确局部C1扩展缺口。
- 任意真实x/y phase与T>0，按实际三次Hermite系数构造q和p。原q0/p0/qT/pT四端点由真实field arithmetic验证；真scalar/vector导数验证p=q'、a=p'。
- control rate=sigma^-1*(a-force(q)+gamma*p)使用实际partial gradient，而非形式自由force。真实有限维Bochner积分构造R，FTC得到真实deriv R=rate，实际deriv C∞推出R C∞，积分起点为0。真实ODE完整并给实际存在见证；不输入控制或端点结论。
- whole real coordinate domain与C∞潜力明确，singular configuration domain/torus projection另行。概率支持与实际解路径稳定性尚未验收，不能把本必要控制构造计为完整Lemma6.1。
- local01 Pi normed/module/topology HasDerivAt diamonds导致simpa失败；convert!自动桥接后local02通过，仅unused simp；local03零警告，固定版本full01接受并重新实查全部hash/公理。原始失败日志保留。

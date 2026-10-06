# Theorem 6.2 依赖：同一实际核时刻的漂移与条件性小集输入

对应印刷251–254/PDF272–275原Theorem6.2原过程、density clause和H^l证明链。原PDF哈希重新核对一致，复用同一PDF272、273页既有视觉核对，未新增274、275页视觉检查。本批4个公开声明只补sameκ drift时刻和smallset时刻衔接必要依赖。

前一compact minorization固定总时刻2，原真正Hamiltonian drift的时刻τ=log6/γ未必为2。本批对指定任意T>0取u=T/2，两段真实开放可达性及density局部界，经原actual Chapman–Kolmogorov组成总T。将真实flat Haar×Lebesgue ball限制测度归一化，实际生成η>0/η≤1/η≠∞和probabilityν，η•ν≤κ_T x对C全部初值成立。Haar本地实例使用本批唯一名字，不添加或改变参考测度。原physical σ=√(2γβ⁻¹)、γβ>0给noise非零，并得到指定T的samephysical能量集合小集；仍以原明确density clause为输入，不声称存在density。

实际H^l halfdrift推有限D及R=4D+H^l(0,0)+1，故R>4D且含非空interior。对R<H^l(x)，真正κ期待≤3H^l(x)/4。已验原H^l矩及proper性给derived C_R compact。统一same正τ对所有l≥1，在同一κ_τ下组合原H^l可积、halfdrift和带C_R indicator的3/4漂移；若原density clause在这个derived C_R成立，得到同一κ_τ的真实smallset。目标drift与可积性均内部从实际过程推导，未放入假设。

密度输入必须在本批新导出的C_R上成立；未从教材原固定C上的density clause推出更大集合的密度表示。因此此包是条件性替代证明路线的中间输入，不能视为字面Theorem6.2的全部原假设已满足。字面原closed-time joint continuity的time0端点语义继续待负责人核对，没有偷偷改为正时刻连续。实际density存在与连续generator身份、Harris完整唯一不变律/weighted-test几何收敛、Theorem6.2整体和全CORE_SCOPE仍未完成。

local01仅indicator调用把实数≤错误自动推断为Real.le集合与notMem接口命名；local02显式energy集合membership、使用固定版indicator_of_notMem，全4退出0零error/Leanwarning。原失败保留，Draft与正式source exact SHA一致，DEP110/NOT119等待full-check01。下一从same实际CK和已验powerdrift导出所有nτ真实几何矩与proper能量紧性，独立于density存在。

full-check01 passed：9145 jobs/2397公理声明/228exact inputs；10checks退出0、全部input/rawlog SHA匹配、4public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。原densityclause→指定positiveT小集、实际Hl漂移→derivedR/outside收缩和同κτ的moments/indicator漂移及conditional小集已机器验证；derivedC_R的density未从原fixedC推出，continuousgenerator/densityexists/Harris未证，owner semanticpending，Theorem6.2整体未完成。

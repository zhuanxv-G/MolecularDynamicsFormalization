# NHL零特征模式的真实路径全区间不变

- 原346/PDF367已目视；正文Vi是实际orthogonal eigenmode下q·u_i=p·u_i=0，使用已接受真实EigenCoordinates/dotProduct对应。actual Vi集合与D为其并集补集均完整，未仅登记符号。
- actual q/p路径在Icc a b连续、ξ路径在同区间连续；在Ico a b满足q'=p、p'=-Aq-ξp的真实HasDerivWithinAt (Ici t)右侧方程，支持起始端点，无全程零前提。按真实fixed谱坐标/CLM链规则推出m_i'=(P_i,-λ_i Q_i-ξP_i)。
- 真时变mode CLM的算子范数在compact时间区间有界，actual norm inequality导出统一Lipschitz；真实ODE_solution_unique_of_mem_Icc_right与真实零解比较推出整个Icc上的两mode分量均零。该证明没有以初始点导数零替代全程唯一性，也不供误差/Lipschitz/唯一性作为输入。
- 只需A.IsHermitian；SPD和distinct spectrum无需用于此不变性结论，后续Hörmander结论的原要求已在接受模块中保留。实际NHL noise只作用ξ，故结论适用于满足实际q/p路径方程的样本路径；没有构造SDE解或形式化子流形的独立codimension/atlas结构。
- local01/02真实const/函数零/logic simp/负积/CLM展开接口失败保留，最终local03退出0零警告。唯一full-check01/session71619：2026-10-05T08:35:23.5266747+08:00--2026-10-05T08:36:28.7818372+08:00退出0；9023jobs、零警告、734项审计声明仅基础三公理、106项输入稳定，固定版本/Scratch/扫描/公理全部通过，全部输入和原始日志SHA256实查一致。3public接受，公理恰为propext、Classical.choice、Quot.sound，无项目新增；负责人语义pending。
- 此未编号正文路径不变结论机器完成；其他独立正文、全ergodicity/SDE存在与整个CORE_SCOPE仍pending。下一230/PDF251真正Stratonovich时间中点和均方极限，不能以trapezoid或每步O(sqrt δt)符号余项直接代替。

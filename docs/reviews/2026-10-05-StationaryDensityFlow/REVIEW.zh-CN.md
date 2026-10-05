# 命题8.1实际解族与不变概率测度验收

- full-check01/session10233：2026-10-05T11:08:11.6616372+08:00--2026-10-05T11:09:19.0920373+08:00退出0；9028 jobs、零Lean警告、793项审计声明仅基础三公理、111项输入与全部原始日志SHA256实查一致；固定版本/扫描/build/Scratch/公理全部通过，新增8项public全部覆盖。
- 原338--339/PDF359--360已目视；8public结合已接受ThermostatDensity链，验证真实PDE下实际指定解族的密度概率不变解释。
- 真实时间ODE和真实mixed derivative导出Jacobian ODE，矩阵det真实求导与密度真实chain rule相消。真实finite basis/可逆坐标把weighted Jacobian传回任意有限维E，无det恒等式前提。非负密度允许零点，取绝对值推出真正换元权重。
- 真C1 ODE uniqueness得injective，真实Haar换元得所有可测image密度measure相等。normalized probability给range满测度，因此真实map等于原measure，不要求surjectivity，不把概率不变输入。
- 两次真正prod_withDensity得到三factor product measure，原非负normalized factors推出实际联合density概率归一化。真Gibbs正性和原两单thermostat PDE推出正文combined flow不变概率；实际product Haar通过两次固定API构造。
- 显式限定：共同C2真实解族定义在全初始参数空间并在所给闭区间满足实际ODE/初值。并未由原C1反馈构造C2 flow、任意feedback全局存在或配分函数。该较强正则性数据与教材隐式流假设的对应仍需负责人最终语义签核；较弱flow构造独立pending。
- local01/02实际basis实例/复合求导点/Haar命名和density命名失败；local03通过但有tactic style警告；local04双product Haar自动搜索失败，实际haar-api02构造成功，去除多余helper前提；local05/session44613退出0零警告。全部失败日志保留，不计为接受。
- 下一正文Prop7.1原297/PDF318目视；render第一次缺目录退出1，建目录后原页渲染成功，无外部阻塞。其他正文与整个范围仍pending。

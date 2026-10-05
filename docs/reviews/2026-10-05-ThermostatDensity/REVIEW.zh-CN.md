# 命题8.1真实Liouville密度链验收

- full-check02/session50156：2026-10-05T10:15:12.6155527+08:00--2026-10-05T10:15:56.2619028+08:00退出0；9027 jobs、零Lean警告、785项声明审计仅基础三公理、110项输入与全部原始日志SHA256实查一致；固定版本/扫描/build/Scratch/公理全部通过，新增24项public覆盖完整。
- 原338--339/PDF359--360已渲染并目视，映射单恒温器、各自辅助变量、联合实际Γ及乘积density。真实散度定义是实际fderiv的trace，不是任意抽象linear算子。
- 真实rank-one trace推乘积density散度，实际产品partial trace、线性共轭trace、idle lift和flux加减闭包均由真实Fréchet导数推出。联合Γ=两真实lift场之和减重复Hamiltonian场，物理与两辅助分量逐项核实。
- 实际J/Hessian散度零及Poisson self消去导出Hamiltonian Gibbs weight平稳性。常数c可表示已有配分函数的倒数；不假设或声称构造配分函数。最终正文PDE结论不以Hamiltonian底场平稳性为额外假设。非负density由原非负因素推出。
- local01--08实际接口失败均保留，local09/session84195退出0零警告。full-check01虽build通过，新增审计覆盖未完成；前缀误判脚本已修复，只有full-check02作为完整接受。
- 已验证部分：原证明的stationary Liouville PDE可加性。仍待验证：由PDE导出指定真实解族下density transport，以及实际归一化概率测度的不变性；后续继续补，不能仅凭PDE宣称全局flow/概率存在。C1场和联合C2解族的强度差异需要显式记录，负责人最终语义签核pending。

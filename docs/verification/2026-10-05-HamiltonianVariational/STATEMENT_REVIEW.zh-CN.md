# Hamiltonian时变变分方程原文核对

- 原页印刷79/PDF101 §2.3.4已目视核对；与Chapter1旧常系数VariationalEquation明确区别。
- 实际W曲线的HasDerivWithinAt为W′=JS(t)W，S可随时间变，只需在时点对称，不要求S可微。Elementwise范数对应有限矩阵的逐坐标真实导数。
- 转置和矩阵乘法的真实导数通过有限Pi/有限sum/实数乘法法则证明。利用Jᵀ=-J、J²=-I、Sᵀ=S实际消去导数两项，得到HasDerivWithinAt(WᵀJW) 0。
- 从闭区间全部点的实际变分导数推出连续性及右导数为零，故整个[0,τ]上WᵀJW等于初值；W(0)=I导出矩阵辛条件。包含τ=0（以及空区间），不只证明内部点。
- textbookHamiltonianHessian是实际第二Fréchet导数在坐标基下的矩阵；C²真实对称导出S=Hzz(z(t))对称，不假设自由矩阵已满足目标。
- 实际Jacobian条件桥接取W(t)=textbookJacobian(F t)z，使用真实初时F0=id与C¹空间映射。其实际Jacobian变分方程是公开前提；该前提还未从一般非线性Hamiltonian ODE推出。一般真实流的初值可微/变分识别独立登记pending，本批不能计完整“所有Hamiltonian流辛”证明。
- 最终session50490局部退出0、零警告，8项公共声明通过并统一接入。唯一整库full-check01实际00:08:18--00:10:57退出0，8995jobs、零警告、455项审计声明（新增仅基础三公理）、78稳定输入、固定版本/扫描/Scratch/公理通过；负责人最终语义签核pending。

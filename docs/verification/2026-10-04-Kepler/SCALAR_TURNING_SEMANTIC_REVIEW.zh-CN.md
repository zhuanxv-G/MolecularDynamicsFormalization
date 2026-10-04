# 一自由度转向点与平衡分支真实证明语义复核

印刷20/PDF43 Example1.4把η=0列为case-by-case；印刷28/PDF51 Example1.6援用energy第一积分。真实U∈C2单位质量系统保留。

交换坐标(v,x)后实际场=(-U′(x),v)、实际energy=v²/2+U(x)，C1/first-integral从原系统导出；真实∂yE=U′。当U′(x0)≠0时两个必要非零条件成立，真实积分∫dv/(-U′(ψ(v)))的局部strict逆给v(t)=g(t-t0)、x(t)=ψ(g(t-t0))、双inverse和g′(0)=-U′(x0)。无需假设非零初速度，因此覆盖普通转向点。

当v0=0且U′(x0)=0，常轨迹是真ODE解；C1导出局部Lipschitz，真实ODE唯一性使任意同初值真解局部恒定。相等时间集合因局部唯一性开、轨迹连续而在Ioo相对闭，Ioo连通推出整个给定解区间恒定。没有把全区间常解当作假设。三个initial cases覆盖所有实初值，但尚未封装真实任意初值IVP的三分支总定理；非平衡全局拼接另待后续。

candidate03八关键退出0、无警告，仅propext/Classical.choice/Quot.sound。三次原日志保留；full-check16实际12:32:51--12:34:28退出0，8980jobs/702声明，Scratch/固定版本/扫描/输入SHA稳定通过。负责人最终教材语义签核pending、新远端CI未跑、全书未完成。

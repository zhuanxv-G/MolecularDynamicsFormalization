# 局部 Flow Map 与初值连续依赖语义复核

印刷26/PDF49原页视觉核对：教材把初值问题解定义为Flow Map并说明组合/逆；本模块先严格完成局部部分，不冒称全局Flow。

固定Lean4.34.0/mathlib API中的Picard–Lindelöf数据实际构造Φ(z,t)：每个初值满足真实HasDerivWithinAt，缩为Ioo后提升HasDerivAt；同一product上的ContinuousOn来自初值方向统一Lipschitz和时间方向轨迹连续。机械场由velocityOperator和force的真实复合导数桥接。若位置域Q开放，基点真实Φ(z0,t0)=z0且联合连续推出共同初值/时间半径使所有轨迹留在Q；不是把留域放入假设。

candidate04三关键退出0、无警告，仅propext/Classical.choice/Quot.sound。full-check19实际12:56:20--13:00:00退出0，8983jobs/724声明，Scratch/固定版本/源码扫描/输入SHA稳定均通过；只证明局部family，global flow laws已有单独结果，Hartman--Grobman/全书仍待完成。负责人最终签核pending，无新远端CI。

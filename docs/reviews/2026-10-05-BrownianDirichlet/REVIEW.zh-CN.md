# Theorem6.1原页与平均语义核对

原印刷250–251/PDF271–272已目视。实际mass diagonal M保留m_i^-1；单位torus lift通过整数格点periodicity表示。原印刷250实际IBP证明以M=I书写，Theorem生成元保留M。本批候选以所有实际质量给weighted Dirichlet identity、smooth tests formal symmetry、nonpositive quadratic form、nonzero L2 eigenfunction real eigenvalue≤0；Hilbert unbounded self-adjoint realization/compact resolvent/discrete spectrum/gap与time-dependent expectation指数收敛均未完成。

实际回查原式(5.6)印刷190/PDF211（父工作区tmp/pdfs/chapter6-brownian/time-average-211.png，已目视）：φbar(t)=∫φ(q,p)ρ(q,p,t)dω/∫ρ(q,p,t)dω，是时刻t的演化分布平均。轨道无限时间平均是原印刷195/PDF216的式(5.9)，此前文档将“time average”读为轨道平均的疑虑已通过原公式澄清；不能据此声称Theorem6.1第三条错误或存在反例。后续推进真实semigroup/distribution期望，原K/α量词与初始density规范仍需逐项签核。

当前C∞周期测试functions；真实finite cube Lebesgue integral，opposite faces经整数unit平移抵消，包含Nc=0按空sum处理；不是R^n compact special case。正式quotient torus概率测度/normalized Haar对接及C²/closed domain待后续证明，不把此批当全部原Theorem6.1。

失败证据：api01查到ContinuousLinearMap.continuous_apply、ContDiff.contDiff_fderiv、Fin.insertNth_apply、integral_mul_left不存在；采用实际Continuous.clm_apply/ContDiff.fderiv_right/insertNth_apply_same+succAbove/integral_const_mul。local01 face single lattice类型漏annotation、ContDiff.const_mul不存在、fderiv function unfold未匹配；local02已修前两仍Gibbs函数匹配失败。local03 actual full unnormalized Dirichlet候选因Gibbs/pointwise multiplication函数匹配和compact integrability measure inference失败；local04用显式HasFDerivAt function change与IntegrableOn volume target后退出0，留1deprecated add_apply警告。local05替换为add_apply并新增真实normalized form/norm正/eigen非正/weak stationarity，待结果。

local05 NeZero restrict≠0的rw目标不匹配、λ是Lean关键字、constant second partial未化简；local06显式restrict_zero推反证/改ℓ/真实partial_const后仅乘积非正API不存在及partial0未化简；local07用positive product反证和真实partial_zero后29public单文件退出0空日志/零Lean警告。full-check01启动，Lean/root/Scratch/audit全部冻结至结束。

full-check01 passed：9063 jobs/1193公理声明/146exact输入；10checks退出0，全部input/rawlog SHA256复核匹配，29public逐名审计仅propext/Classical.choice/Quot.sound，Lean警告0；Lean4.34.0/mathlib5ed2965；负责人语义pending。

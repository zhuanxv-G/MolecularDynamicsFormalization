# Theorem 6.1：实际稠密 Brownian 算子的可闭性与图闭包

原印刷250–251/PDF271–272已核对，沿用full unit torus、actual normalized Gibbs Hilbert L²、前批所有C∞整数周期real lifts的真实dense domain及literal全diagonal质量Brownian算子。U C∞ integer-periodic；β≠0用于对称/可闭/闭图闭包；β>0和各m_i>0用于闭包二次型非正。质量没有单位质量限制。

将同一actual domain和same actual linear operator直接打包成mathlib LinearPMap。真正proved dense/formal symmetry推T≤T.adjoint，actual adjoint由dense构造（非junk nondense case），真正closed且domain含原dense domain所以dense。这个真实closed extension推出T.IsClosable；无closed-extension/density/closure结论作为原模型前提。

actual ClosedOperator=T.closure，β≠0下IsClosable证明其graph就是原graph的topologicalClosure，故closed；真实domain包含全smooth domain而dense，closureHasCore给原smooth domain是真core，inclusion保持每个原domain值和literal generator image、所有constant zero modes；closed extension minimality真实证明。

闭包全domain形式对称并非假设：对固定原domain y，内积等式是H×H图空间的closed condition，closure_minimal把原graph identity扩展到第一闭包变量；再固定闭包x，第二个closed inner condition把另一变量扩展，得到全actualclosed domain的formal symmetry。同理inner(z1,z2)≤0是closed condition，原actualgraph nonpositive推出整个closedgraph quadratic非正。采用两次真实图闭包传递，未把desired operator property藏进premise。

尚未证明selfadjointness（closed+dense+formal symmetry不能替代）、compact resolvent、离散谱、Poincare/spectralgap/实际semigroup期待。原C²表述到精确closed realization仍需语义复核；β=0只存在mathlib closure定义，未声称该参数genuine closed realization。全Theorem6.1和CORE_SCOPE未完成，负责人教材语义pending。

api01全部需要LinearPMap/adjoint/closure固定API退出0。local01仅apply_comp_inclusion的dot接收LE conjunction而被寻找And方法：改为显式LinearPMap.apply_comp_inclusion，加入真实graph闭条件传递formal symmetry/非正后，local02全部候选退出0空日志零警告。未使用任何占位或新项目公理。full-check01进行中，正式Lean输入冻结。

full-check01 passed：9068jobs/1297公理声明/151exact inputs；10checks退出0，全部input/rawlog SHA256匹配，22public逐名只基础三公理，Lean警告0；Lean4.34.0/mathlib5ed2965；负责人semanticpending。

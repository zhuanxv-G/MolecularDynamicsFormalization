# Theorem3.1原页与未完成依赖

- 印刷114--116/PDF136--138的陈述及完整正文证明已渲染/目视核对。定理并未完整Lean形式化，不能计完成。
- 实际r阶辛方法的高阶修正Hamiltonian须由匹配构造，Hbar_k=H+Σ_{j=r}^k h^j H_j是有限截断，不能假定无限级数收敛或数值映射恰为其时间h流。
- 证明中的“by construction”要求导出实际G_h(z)-F_h^(k)(z)的统一O(h^(k+1))匹配，并确保修正流终点和实际数值轨道都在可应用估计的域内。供应这条局部误差只得到条件依赖估计，不能称整个教材定理完成。
- Hbar_k随h变化。需要从真正截断系数的C¹正则性、紧凸域与有界小h范围推导统一Lipschitz和Hbar_k-H的统一O(h^r)，不能只使用本页H的Lipschitz替代。
- Hamiltonian真实流守恒依赖已由LiePoisson证明；原文有限望远镜误差累积、长时间νh=O(h^(-k+r))及原Hamiltonian漂移仍需完整接通。
- §3.3 Lie交换子的一处符号反序已记录在LiePoisson审阅；实际pullback算子与状态映射合成次序也须核对，再使用对应修正项。
- 下一必要动作：形式指数的真实非交换系数/BCH匹配，随后构建实际修正Hamiltonian和误差界。负责人最终语义签核pending。

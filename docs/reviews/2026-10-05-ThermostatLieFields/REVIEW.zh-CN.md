# Lemma8.1真实线性恒温场与Lie闭包

- 原346--348/PDF367--369已渲染目视；本批对应印刷347/PDF368的Lemma8.1，不计整个Theorem8.1。
- 真实phase=(Fin Nc→ℝ)×(Fin Nc→ℝ)，实际矩阵A的线性场F=(p,-Aq)、G=(0,p)。内部k从0起，Ck=(A^k p,A^(k+1)q)、Dk=(A^(k+1)q,-A^(k+1)p)，对应原C_(k+1)、D_(k+1)。未假定SPD或distinct spectrum，因为该代数结论对任意真实A成立；这些原假设仍保留在后续Prop8.3。
- genuine fderiv给VectorField.lieBracket(X,Y)=Y∘X-X∘Y，是End规范括号XY-YX的负号。桥接定理明确证明符号；真实LieSpan的neg_mem与lie_mem给actual VectorField bracket的实际Z=-[X,Y]见证，非自由符号Lie冒充导数。实线性子空间对负号封闭，因此两约定生成同一子空间。
- 实际End括号[F,G]=C0、[F,Ck]/2=Dk、[Dk,F]/2=C(k+1)全部由真实矩阵mulVec/幂计算，真正LieSpan归纳推出所有C/D成员。结果没有藏入假设。
- local01实际固定API失败保留；修复后local02、加实际VectorField闭包见证后local03均退出0零警告。唯一full-check01/session48630：2026-10-05T07:28:44.9656552+08:00--2026-10-05T07:29:49.5663795+08:00退出0；9019jobs、零警告、685项审计声明仅基础三公理、102项输入稳定，固定版本/Scratch/扫描/公理全部通过，全部输入和原始日志SHA256实查一致。16public（含phase abbrev）全部审计，公理恰为propext、Classical.choice、Quot.sound，无项目新增。
- 原348证明的q/p坐标与347的实际C/D公式交换；本批没有用该行。下一Prop8.3须按真实347公式得(p²+λq²)π(λ)=0并证明两组系数均为零，正定谱互异与真正坐标变换待推进。
- 负责人最终语义pending；Prop8.3实际独立性、Prop8.2 Hörmander lift、Theorem8.1及其他正文/整个CORE_SCOPE仍pending。

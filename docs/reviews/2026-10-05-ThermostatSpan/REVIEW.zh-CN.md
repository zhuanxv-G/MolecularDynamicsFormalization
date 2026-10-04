# Proposition8.3真实谱坐标、C/D独立性与张成

- 原347--348/PDF368--369目视。真正SPD矩阵A自带Hermitian，mathlib spectral theorem实际构造正交eigenvectorUnitary及实际特征值，正性由PosDef.eigenvalues_pos推出；distinct eigenvalues是原明确假设Function.Injective。未供对角化/独立性/张成结论作输入。
- 实际UT的linear map定义EigenCoordinates，并证明等于v与实际eigenvectorBasis的dotProduct；模式domain真实等价原q·u_i与p·u_i不同时零。实际坐标连续推出D开性，包括Nc=0。
- 真谱intertwine与幂归纳推出C/D真实坐标。原348写成π(λ)q+λσ(λ)p等，与347定义交换q/p。按347真实定义重算：π(λ)p+λσ(λ)q=0，λπ(λ)q-λσ(λ)p=0。p乘首式加q乘次式得(p²+λq²)π=0；λq乘首式减p乘次式得λ(p²+λq²)σ=0。两个权重真正且非零，分别推出两组系数的多项式全零。
- actual Vandermonde determinant/injectivity推出两组全部真实系数零；真实finite sum投影得到上述方程，Fintype.linearIndependent_iff证明 actual C1,D1,...,CNc,DNc共2Nc族线性独立，actual finrank/card matching证明span=top。原证明只显式提到π矛盾，本形式化同时证明σ系数，避免π原本就是零时的逻辑缺口。
- 由已验收Lemma8.1的真实LieSpan成员进一步推出生成Lie空间在每个D点的actual value span=top。末结论不是直接假定点张成。
- local01/02谱API与第二组消元失败、local04真有限和投影类型桥接、local06补集开性simp接口失败保留；local03/05及最终local07均退出0零警告。唯一full-check01/session71698：2026-10-05T07:50:48.1727780+08:00--2026-10-05T07:51:56.9744487+08:00退出0；9020jobs、零警告、699项审计声明仅基础三公理、103项输入稳定，固定版本/Scratch/扫描/公理全部通过，全部输入和原始日志SHA256实查一致。14public接受，公理恰为propext、Classical.choice、Quot.sound，无项目新增。
- 254/PDF275及344--345/PDF365--366已渲染目视，Definition6.1明确C∞且包含drift b0；Prop8.2中的variable coefficients需要真实平滑系数闭包与实际迭代括号点张成的桥接，且σ≠0必需。下一推进该依赖；Theorem8.1整体和其他正文未由本批完成，负责人语义pending。

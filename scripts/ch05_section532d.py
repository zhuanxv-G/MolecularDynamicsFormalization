"""Printed distribution defect and both analytic microcanonical examples."""
from ch05_data import add,copied,D,NS
add('ShellPointValuePrinted','5.3.2',191,[],r'''The proof that (5.8) can be taken and that
\[\lim_{\varepsilon\to0}Z_\varepsilon^{-1}\int_D\phi(q,p)\rho_\varepsilon d\omega=\rho_0(q,p)=Z_{H=E}^{-1}\int_D\phi(q,p)\delta[H(q,p)-E]d\omega\]
may be found in the PhD thesis of Hartmann [171, Appendix D].''',f'''def shellWeakPairing {{n : ℕ}} (H : {NS}E n → ℝ) (c : ℝ) (φ : {NS}E n → ℝ) :=
  {NS}microAverage H c φ''',kind='notation',verdict='NEEDS_HUMAN',explanation='[ERRATUM?]右侧印刷为分布的点值ρ0(q,p)，左侧是依赖φ的标量；一般分布无这种点值。字面式无法忠实成为良类型等式，保留逐字原式并登记待解释。',extra=['[EXTRA]Lean仅提供良类型的测试函数配对记号，不把配对记号的编译当原印刷等式的证明；完整正确弱极限另条，重复Z版本也保留。'],missing='需裁定原分布点值的类别错误；不伪造等式证明。')
add('HarmonicEnergy','5.3.2',193,[],r'''Example 5.1 Consider the harmonic oscillator $H(q,p)=p^2/2+\Omega^2q^2/2$. The energy surface $H=E>0$ is an ellipse.''',f'''def harmonicEnergy (Ω : ℝ) (z : {NS}E 2) := (z 1)^2/2+Ω^2*(z 0)^2/2''',kind='definition',label='Example 5.1')
add('HarmonicQuadraturePrinted','5.3.2',193,[],r'''Parameterizing the surface by $q$, we have $p=\sqrt{2E-\Omega^2q^2}$, then
\[\mu(\Sigma_E)=4\int_0^{\sqrt{2E}}\frac{\sqrt{1+p_q^2}}{\sqrt{H_p^2+H_q^2}}dq
=4\int_0^{\sqrt{2E}/\Omega}\frac1{\sqrt{2E-\Omega^2q^2}}dq=2\pi/\Omega.\]''',f'''theorem harmonicQuadraturePrinted : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  (4*(∫ q in (0 : ℝ)..Real.sqrt (2*c),
    Real.sqrt (1+(Ω^2*q/Real.sqrt (2*c-Ω^2*q^2))^2)/Real.sqrt (2*c-Ω^2*q^2+Ω^4*q^2)))=
  4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,1/Real.sqrt (2*c-Ω^2*q^2)) := by
  sorry''',verdict='NEEDS_HUMAN',explanation='[ERRATUM?]第一行上界印刷为√(2E)，下一行是√(2E)/Ω，二者对一般Ω不一致；不静默补Ω。',extra=['[EXTRA]Ω>0及E>0，保存两个不同实际积分上界；端点导数用实平方根总化表达，不提升为已识别曲面面积。'],missing='原上界疑误需裁定，局部曲面参数化尚缺接口。')
add('HarmonicPartition','5.3.2',193,[51],r'''$\mu(\Sigma_E)=4\int_0^{\sqrt{2E}/\Omega}\frac1{\sqrt{2E-\Omega^2q^2}}dq=2\pi/\Omega$.''',f'''theorem harmonicPartition : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  {NS}microPartition (harmonicEnergy Ω) c=2*Real.pi/Ω := by
  sorry''',label='Example 5.1',extra=['[EXTRA]正频率和正能量；是真实Hausdorff加权测度的分区函数，不把参数积分写成定义冒充面积识别。'],missing='缺椭圆真实Hausdorff面积/coarea及加权曲面积分桥接，不建设大型几何理论。')
add('IdealGasEnergy','5.3.2','193–194',[],r'''Example 5.2 Consider a system of $N$ non-interacting particles of mass $m$ moving in periodic boundary conditions within a box of volume $V$. The Hamiltonian is
\[H=\frac1{2m}\sum_{i=1}^N\|p_i\|^2.\]''',f'''def idealGasEnergy (N : ℕ) (m : ℝ) (z : {NS}E (3*N+3*N)) :=
  (∑ i : Fin (3*N),(z (Fin.natAdd (3*N) i))^2)/(2*m)''',kind='definition',label='Example 5.2',context=['前三N个分量是位置，后三N个分量是动量；每粒子的三维平方范数展开成真实3N项。'])
add('IdealGasPositionDomain','5.3.2','193–194',[],r'''$Z_E=V^N\int_S(m/r)d\sigma$, where $S$ is the $3N-1$ dimensional sphere in $3N$ dimensions of radius $r=\sqrt{2mE}$, and $d\sigma$ is the surface area element on this sphere. $V^N$ is the contribution due to integration over positions.''',f'''def idealGasPositionDomain (N : ℕ) (L : ℝ) : Set ({NS}E (3*N+3*N)) :=
  {{z | ∀ i : Fin (3*N),z (Fin.castAdd (3*N) i) ∈ Icc (0 : ℝ) L}}''',kind='definition',extra=['[EXTRA]选择边长L的三维立方基本胞，V=L³；实际位置域有限，不能对无限全位置空间积分再声称分区函数有限。周期边界的基本胞面零测度识别未证明。'])
add('IdealGasPartition','5.3.2','193–194',[51],r'''Thus we have
\[Z_E=V^N\frac{m}{\sqrt{2mE}}A(S)
=V^N\frac{\sqrt m}{\sqrt{2E}}\frac{3N\pi^{3N/2}(2mE)^{(3N-1)/2}}{\Gamma(3N/2+1)}
=V^N\frac{(2\pi mE)^{3N/2}}{E\Gamma(3N/2)}.\]''',f'''theorem idealGasPartition : ∀ (N : ℕ) (m c L : ℝ),0 < N → 0 < m → 0 < c → 0 < L →
  (({NS}microRaw (idealGasEnergy N m) c) (idealGasPositionDomain N L)).toReal=
    (L^3)^N*Real.rpow (2*Real.pi*m*c) ((3*N : ℝ)/2)/(c*Real.Gamma ((3*N : ℝ)/2)) := by
  sorry''',label='Example 5.2',extra=['[EXTRA]正N/m/E/L、有限基本胞V=L³；微正则raw测度在位置胞上实际限制。3N系数是球面积的正确系数，不登记伪造勘误。'],missing='缺真实3N球面积、曲面产品测度与微正则权积分桥接；不建设coarea/大型几何理论。')

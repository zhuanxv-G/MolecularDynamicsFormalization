"""Finite oscillator bath: the exact Hamiltonian, ODE solution and sign issue."""
import re
from ch06_data import add,copied,proposition,D
def physical_bath_definition(name):
    code=copied(D,name).replace('{k : ℕ}', '{k : ℕ} (_hk : 0 < k)',1)
    m=re.search(r'\(μ(?P<others> q0 p0)? : (?P<type>[\w.]+ k)\)',code)
    assert m,name
    binder=f'(μ : {m["type"]}) (_hμ : ∀ i, 0 < μ i)'
    if m['others']:binder+=f' (q0 p0 : {m["type"]})'
    return code[:m.start()]+binder+code[m.end():]
add('BathHamiltonian','6.3.3',236,[56],r'''We assume as in [138] that we are given a system of $k$ coupled oscillators (a “heat bath”) in contact with a distinguished particle. The Hamiltonian is
\[H=\frac{P^2}{2}+\sum_{i=1}^k\frac{p_i^2}{2\mu_i}+U(Q)+\frac1{2k}\sum_{i=1}^k(q_i-Q)^2\]
where $Q$ and $P$ represent the position and momentum of the distinguished particle and $\{q_i,p_i\}$ are the positions and momenta of the particles of the bath, $\mu_i$ giving the mass of the $i$th light particle.''',physical_bath_definition('bathHamiltonian'),kind='definition',context=['重粒子质量1；全部轻粒子质量μi>0，k>0；真实k项耦合Hamiltonian。'],extra=['[EXTRA]显式k>0及全部μi>0，避免零质量/零热浴大小的总化除法冒充物理模型。'])
add('BathHamiltonEquations','6.3.3',236,[57],r'''The equations of motion for the combined system are
\[\dot Q=P;\tag{6.22}\quad\dot P=-U'(Q)-k^{-1}\sum_{i=1}^k(Q-q_i);\tag{6.23}\]
where, for $i=1,2,\ldots,k$,
\[\dot q_i=p_i/\mu_i;\tag{6.24}\quad\dot p_i=(Q-q_i)/k.\tag{6.25}\]''',proposition('bathHamiltonEquations_statement','bathHamiltonEquations'),label='(6.22)–(6.25)',extra=['[EXTRA]实际Hamiltonian全部偏导、正质量、k>0和U沿Q可微；全部四组等式，不只定义方程。'],missing='待真实Fréchet有限和导数桥接；不恢复封存长证明。')
add('BathFrequency','6.3.3',237,[58],r'''where $\Omega_i=k^{-1/2}\mu_i^{-1/2}$ is the frequency of the $i$th oscillator.''',physical_bath_definition('bathFrequency'),kind='definition',context=['k>0,μi>0，(√(kμi))⁻¹等价于原正参数乘积。'],extra=['[EXTRA]k>0和全部μi>0已编码为真实参数资格。'])
oscillator_code='''theorem bathOscillatorSolution : ∀ (Q q : ℝ → ℝ) (k : ℕ) (μ p0 t : ℝ),
  0 < k → 0 < μ → ContDiff ℝ 2 q → Continuous Q → 0 ≤ t →
  (deriv q 0=p0/μ) →
  (∀ s ∈ Icc 0 t, deriv (deriv q) s=(Q s-q s)/((k : ℝ)*μ)) →
  let Ω : ℝ := (Real.sqrt ((k : ℝ)*μ))⁻¹
  q t=Real.cos (Ω*t)*q 0+Ω⁻¹*Real.sin (Ω*t)*p0/μ+
    (k : ℝ)⁻¹*μ⁻¹*(∫ s in 0..t, Ω⁻¹*Real.sin (Ω*(t-s))*Q s) := by
  sorry'''
add('BathOscillatorSolution','6.3.3','236–237',[58],r'''Because the system (6.24)–(6.25) is linear, we may solve it analytically for $\{q_i,p_i\}$; this yields:
\[q_i(t)=\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i+k^{-1}\mu_i^{-1}\int_0^t\Omega_i^{-1}\sin(\Omega_i(t-s))Q(s)ds.\tag{6.26}\]''',oscillator_code,label='(6.26)',extra=['[EXTRA]实际二阶受迫振子ODE、C²q、连续Q及t≥0；显式全部k>0、正μ、原初始动量p0与真实初始化q′0=p0/μ，Ω实际计算为(kμ)⁻¹/²；保留原k⁻¹μ⁻¹卷积系数，不以解公式作前提。'],missing='缺现成受迫振子变常数解完整桥接；不恢复封存证明。')
add('BathConvolutionIBP','6.3.3',237,[59],r'''Integrating by parts, we have
\[\int_0^t\Omega_i\sin(\Omega_i(t-s))Q(s)ds=[\cos(\Omega_i(t-s))Q(s)]_0^t-\int_0^t\cos(\Omega_i(t-s))P(s)ds
=Q(t)-\cos(\Omega_i t)Q(0)-\int_0^t\cos(\Omega_i(t-s))P(s)ds.\]''',proposition('bathConvolutionIBP_statement','bathConvolutionIBP'),extra=['[EXTRA]真实C¹ Q和Q′=P；完整实际卷积IBP，不以通量结论作假设。'],missing='待正弦余弦和实际区间IBP完整短桥；不开展长证明。')
add('BathForce','6.3.3',237,[61],r'''where we define
\[f(t)=-k^{-1}\sum_{i=1}^k[\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i-\cos(\Omega_i t)Q(0)].\]''',physical_bath_definition('bathForce'),kind='definition',extra=['[EXTRA]按(6.23)推导得到正k⁻¹实际合力；原页负号与+f项冲突，字面版本另列；不宣称更正已由网站裁定。','[EXTRA]k>0和全部μi>0已编码，排除非物理逆质量/频率总化值。'])
add('BathForcePrinted','6.3.3',237,[61],r'''where we define
\[f(t)=-k^{-1}\sum_{i=1}^k[\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i-\cos(\Omega_i t)Q(0)].\]''',physical_bath_definition('bathForcePrinted'),kind='definition',verdict='NEEDS_HUMAN',issues=['印刷f含负k⁻¹，而(6.29)写+f；从(6.23)代入振子解得到正k⁻¹合力。'],extra=['[EXTRA]保持原物理k>0与全部μi>0资格；字面符号仍待裁定。'],missing='保留字面负号，导师/网站待裁定；完整两种约化陈述下一批保留。')
add('MemoryKernel','6.3.3',237,[61],r'''\[\psi(t)=k^{-1}\sum_{i=1}^k\cos(\Omega_i(t)).\]''',physical_bath_definition('memoryKernel'),kind='definition',context=['真实有限k项记忆核；不将有限核当作Dirac δ。'],extra=['[EXTRA]实际k>0与全部μi>0参数资格。'])

"""Full Langevin brackets, density gap, and original accessibility argument."""
from ch06_data import add,copied,proposition,NS
F='MolecularDynamics/Chapter06/LangevinHormander.lean'
add('LangevinNoiseBracket','6.4.4',255,[110],r'''For $i=1,\ldots,N_c$, using the fact that $b_i$ is a constant vector field and so its Jacobian matrix vanishes,
\[[b_0,b_i]=-\begin{bmatrix}0&I\\-U''(q)&-\gamma I\end{bmatrix}b_i
=-\sigma\begin{bmatrix}e_i\\-\gamma e_i\end{bmatrix}.\]''',copied(F,'textbookLangevinDrift_noise_bracket','langevinNoiseBracket'),prior=['MolecularDynamics.textbookLangevinDrift_noise_bracket'],extra=['[EXTRA]真实C²势的Fréchet Jacobian、全部噪声坐标；σ任意，非零条件在独立性条明确。'])
add('LangevinBracketIndependent','6.4.4',255,[110],r'''These $N_c$ vectors, taken together with the original $b_i$, clearly provide a linearly independent set of $2N_c$ vectors.''',copied(F,'textbookLangevinBracketFamily_linearIndependent','langevinBracketIndependent'),prior=['MolecularDynamics.textbookLangevinBracketFamily_linearIndependent'],extra=['[EXTRA]真实Fin Nc⊕Fin Nc的全部2Nc向量族、σ≠0；不以维数计数代替独立性。'])
add('LangevinHormander','6.4.4',255,[111],r'''We have verified Hörmander's condition. Thus Assumption 1(ii) holds in the case of Langevin dynamics.''',copied(F,'textbookLangevin_hormander_physicalNoise','langevinHormander'),prior=['MolecularDynamics.textbookLangevin_hormander_physicalNoise'],extra=['[EXTRA]完整物理σ=√(2γθ)、γ/θ>0、C∞ U的实际噪声及括号span；本桥只证rank，转移密度存在另条未证。'])
density=proposition('hormanderDensity_statement','langevinTransitionDensity')
add('LangevinTransitionDensity','6.4.4',255,[112],r'''Thus Assumption 1(ii) holds in the case of Langevin dynamics.''',density,extra=['[EXTRA]具体实际单位周期Langevin、C∞势、正γ/β，全部点初值的正时间连续转移密度及真实平坦相空间测度表示；没有从含drift的任意原Definition6.1断言一般parabolic密度定理。'],missing='缺实际Langevin hypoelliptic/Malliavin转移密度存在桥接；不建设大型理论。')
raw=proposition('lemma61_statement','lemma61Printed').replace('IsOpen C → C.Nonempty →','IsOpen C →')
add('Lemma61Printed','6.4.4',255,[113],r'''Lemma 6.1 For all $t>0$ and all open $C\subset D$, we have that
\[\Pr(X(t)\in C\mid X(0)=X_0)>0,\quad\forall X_0\in D,\]
where $X(t)=(q(t),p(t))^T$ is a solution to Langevin dynamics (6.47).''',raw,label='Lemma 6.1',verdict='NEEDS_HUMAN',issues=['字面all open C包括空集，概率为0；需Nonempty。原(6.47)单位质量，旧清单一般质量扩展须另标技术范围。'],missing='保留原缺非空的完整字面断言，不证；下一条桥接原单位周期实际过程的完整非空版本。')
kernel=copied('MolecularDynamics/Chapter06/LangevinWeakFeller.lean','textbookLangevinPeriodicTransitionKernel_open_pos','lemma61Nonempty')
kernel=kernel.replace('theorem lemma61Nonempty','''theorem lemma61Nonempty {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)''',1)
add('Lemma61Nonempty','6.4.4',255,[113],r'''\[\Pr(X(t)\in C\mid X(0)=X_0)>0,\quad\forall X_0\in D.\]''',kernel,prior=['MolecularDynamics.textbookLangevinPeriodicTransitionKernel_open_pos'],extra=['[EXTRA]补非空目标；桥接实际单位周期相空间、原单位质量、真实Wiener/实际完整Langevin核，σ≠0。原一般质量扩大版不计已证。'])
add('ControlPath','6.4.4',255,[114],r'''Consider the ODE
\[\frac{d^2q}{dt^2}+\nabla U(q)+\gamma\frac{dq}{dt}=\sigma\frac{dR}{dt}.\tag{6.49}\]
Choose $q$ to be a $C^\infty$ path such that for a given $t>0$,
\[(q(0),\dot q(0))^T=X_0;\quad(q(t),\dot q(t))^T=y.\]
Taking $R(0)=0$, we can obtain a $C^\infty$ function $dR/dt$ by substitution.''',copied('MolecularDynamics/Chapter06/LangevinControlPath.lean','textbookLangevinControlledEndpoint','controlPath'),prior=['MolecularDynamics.textbookLangevinControlledEndpoint'],extra=['[EXTRA]完整实际任意位置/速度端点、q/p/R全光滑、R0=0及真实全时ODE；σ≠0，未冒充随机正概率。'])
add('ControlEndpointStable','6.4.4',256,[115],r'''For any $\delta>0$, there exists a sufficiently small $\varepsilon>0$ such that if a realization of the Wiener process $W$ remains close to our solution $R$,
\[\sup_{0\le s\le t}\|W(s)-R(s)\|\le\varepsilon,\tag{6.50}\]
then $X(t)\in B_\delta(y)$.''',copied('MolecularDynamics/Chapter06/LangevinSmoothCutoff.lean','textbookLangevinControlledEndpoint_stable','controlEndpointStable'),prior=['MolecularDynamics.textbookLangevinControlledEndpoint_stable'],extra=['[EXTRA]实际完整受控积分方程和原平滑势局部cutoff稳定性，全部端点/δ/ε；未假设全局Lipschitz势，原环面投影由上一真实核桥接。'])

from ch07_data import add

add('ConjugateSymmetricCorrections','7.9.1','300–301',
r'''\[\widehat\rho_{[ZYOYZ]}=\exp((h/2)\mathcal L_Z^\dagger)\exp((h/2)\mathcal L_Y^\dagger)\exp((h/2)\mathcal L_O^\dagger)\widehat\rho_{[OYZYO]}.\]
\[f_{2,[ZYOYZ]}\rho_\beta=f_{2,[OYZYO]}\rho_\beta+\tfrac14\mathcal L_{1,[OYZ]}^\dagger\rho_\beta.\]
\[\mathcal L_{1,[OAB]}^\dagger\rho_\beta=\tfrac12\mathcal L_H^\dagger(g\rho_\beta),\qquad
\mathcal L_{1,[OBA]}^\dagger\rho_\beta=-\tfrac12\mathcal L_H^\dagger(g\rho_\beta),\]
\[\mathcal L_H^\dagger(g\rho_\beta)=\beta(|\nabla U|^2-p^T\nabla^2Up)\rho_\beta,\]
\[f_{2,[ABOBA]}=f_{2,[OBABO]}-\tfrac\beta8(|\nabla U|^2-p^T\nabla^2Up),\tag{7.30a}\]
\[f_{2,[BAOAB]}=f_{2,[OABAO]}+\tfrac\beta8(|\nabla U|^2-p^T\nabla^2Up).\tag{7.30b}\]''',
'''def gradNormSq (U : V n → ℝ) (q : V n) : ℝ := ∑ i, gradient U q i^2
def hessianQuadratic (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, ∑ j, x.2 i*hessianU U x.1 i j*x.2 j
def conjugateCorrectionChange (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β/8*(gradNormSq U x.1-hessianQuadratic U x)
def conjugateCorrections (U : V n → ℝ) (β : ℝ) (fABOBA fOBABO fBAOAB fOABAO : Phase n → ℝ) : Prop :=
  fABOBA = fOBABO-conjugateCorrectionChange U β ∧ fBAOAB = fOABAO+conjugateCorrectionChange U β
theorem conjugateCorrection_coefficient {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L0 L1 : Module.End ℝ E) (p : ℕ → E) (q2 : E)
    (hL : L0 (p 0) = 0) (hp : p 1 = 0)
    (htransfer : q2 = p 2+(1/2 : ℝ) • L0 (p 1)+
      (1/4 : ℝ) • L1 (p 0)+(1/8 : ℝ) • (L0*L0) (p 0)) :
    q2 = p 2+(1/4 : ℝ) • L1 (p 0) := by
  simpa [hp,hL,Module.End.mul_apply] using htransfer''',label='(7.30a)–(7.30b)',
issues=['已目视核对PDF321：所印传播子展开末项为(h²/2)L_LD，按exp的二阶展开应为(h²/8)(L_LD)²；该项作用ρβ为零，不改变后续修正关系。'],
extra=['Lean证明给定真实二阶传递系数的消项，(7.30)完整作为两关系的命题定义；ST/TS指数系数识别、Hamiltonian微分及实际两组修正系数识别仍列缺口。'],
scope='形式传递系数的消项及(7.30)全部目标；未证明从具体分裂映射导出这些系数。',verdict='NEEDS_HUMAN')

add('ReciprocalFrictionExpansion','7.9.2','301–302',
r'''We will denote
\[f_2(q,p)=f_{2,0}(q,p)+\epsilon f_{2,1}(q,p)+\epsilon^2f_{2,2}(q,p)+\cdots,\tag{7.31}\]
with each $\langle f_{2,i}\rangle=0$. Dividing by the friction in (7.28) we obtain
\[(\overline{\mathcal L}_O^\dagger+\epsilon\mathcal L_H^\dagger)(f_2\rho_\beta)=-\epsilon\mathcal L_2^\dagger\rho_\beta,\]
where $\overline{\mathcal L}_O^\dagger\vartheta=\epsilon\mathcal L_O^\dagger\vartheta=\nabla_p\cdot(p\vartheta)+\beta^{-1}\Delta_p\vartheta$.
\[w(q,p)=-\tfrac\beta{24}(6p^T(\nabla^2U)\nabla U-\nabla^3U:p\otimes p\otimes p).\]
Equating powers gives
\[\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,0})=0,\quad
\mathcal L_H^\dagger(\rho_\beta f_{2,0})+\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,1})=-w\rho_\beta,\]
\[\mathcal L_H^\dagger(\rho_\beta f_{2,1})+\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,2})=0,\quad
\mathcal L_H^\dagger(\rho_\beta f_{2,2})+\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,3})=0.\]''',
'''def phaseH (U : V n → ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ := aForward (fun _ ↦ 1) ρ+bForward U ρ
def reciprocalHierarchy (U : V n → ℝ) (β : ℝ) (f : ℕ → Phase n → ℝ) : Prop :=
  let ρ := gibbsWeight (fun _ ↦ 1) U β
  phaseO (fun _ ↦ 1) 1 β (ρ*f 0) = 0 ∧
  phaseH U (ρ*f 0)+phaseO (fun _ ↦ 1) 1 β (ρ*f 1) = (fun x ↦ -(-symmetricRHS false U β x)*ρ x) ∧
  ∀ k, 0 < k → phaseH U (ρ*f k)+phaseO (fun _ ↦ 1) 1 β (ρ*f (k+1)) = 0''',kind='definition',label='(7.31) / (7.32)',
extra=['ε=1/γ；使用真实偏导、单位质量、β>0；形式层级包含所有后续阶。各阶零均值及归一性需另加centeredCorrections，不把其当作已证。'])

add('OUKernelQualification','7.9.2',302,
r'''The first equation at order one tells us that $f_{2,0,[OABAO]}(q,p)$ must be a function of position only, as the kernel of $\overline{\mathcal L}_O^\dagger$ is the set of functions that are constant with respect to $p$. Hence we shall denote $f_{2,0,[OABAO]}(q,p)=\nu(q)$, where $\langle\nu\rangle=0$.''',
'''def ouKernelPrinted (β : ℝ) : Prop :=
  ∀ f : V n → ℝ, ouForward (fun _ ↦ 1) 1 β⁻¹ f = 0 → ∃ c : ℝ, f = fun _ ↦ c
theorem ouKernelPrinted_corrected (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ)
    (hβ : 0 < β) (hf : ContDiff ℝ ⊤ f)
    (hL2 : ∀ q, MemLp (fun p ↦ f (q,p)) 2 (momentumGibbs (fun _ ↦ 1) β))
    (hzero : phaseO (fun _ ↦ 1) 1 β (gibbsWeight (fun _ ↦ 1) U β*f) = 0) :
    ∃ ν : V n → ℝ, ∀ q p, f (q,p) = ν q := by
  sorry''',
issues=['已目视核对PDF323：前向OU生成元的核实际是Gaussian密度倍数；对ρβf共轭后，合适L²域中的f才对p为常数。原文此句缺少共轭与定义域限定。'],
extra=['修正版明确实际Gaussian L²域和光滑性；原文目标定义保留但不证明。零均值仅限制ν常数方向，不由OU核自动给出。'],
missing='需要OU生成元加权Dirichlet型、域闭包及核刻画理论，本轮不建设。',verdict='NEEDS_HUMAN')

add('OUHermiteIdentities','7.9.2',302,
r'''\[\overline{\mathcal L}_O^\dagger(\rho_\beta\nabla^3U:p\otimes p\otimes p)=-3\rho_\beta\nabla^3U:p\otimes p\otimes p+\tfrac{6\rho_\beta}{\beta}p^T\nabla_q\Delta_qU,\]
\[\overline{\mathcal L}_O^\dagger(\rho_\beta p^T\nabla_q\Delta_qU)=-\rho_\beta p^T\nabla_q\Delta_qU,\]
\[\overline{\mathcal L}_O^\dagger(\rho_\beta p^T(\nabla^2U)\nabla U)=-\rho_\beta p^T(\nabla^2U)\nabla U.\]
\[w\rho_\beta=\tfrac\beta{24}\overline{\mathcal L}_O^\dagger([6p^T(\nabla^2U)\nabla U-\tfrac13\nabla^3U:p\otimes p\otimes p-\tfrac2\beta p^T\nabla_q\Delta_qU]\rho_\beta).\tag{7.33}\]
\[\mathcal L_H^\dagger(\rho_\beta\nu)=-p^T\nabla\nu\rho_\beta=\overline{\mathcal L}_O^\dagger([p^T\nabla\nu+\mu(q)]\rho_\beta).\tag{7.34}\]''',
'''def laplacian (U : V n → ℝ) (q : V n) : ℝ := ∑ i, hessianU U q i i
def pGradLaplacian (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, x.2 i*gradient (laplacian U) x.1 i
def hermitePrimitive (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  6*hessianGrad U x-(1/3)*cubicThird U x-2/β*pGradLaplacian U x
theorem ouHermiteIdentities (U ν μ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U) (hν : ContDiff ℝ ⊤ ν) :
    let ρ := gibbsWeight (fun _ ↦ 1) U β
    let O := phaseO (fun _ ↦ 1) 1 β
    O (ρ*cubicThird U) = (fun x ↦ -3*ρ x*cubicThird U x+6*ρ x/β*pGradLaplacian U x) ∧
    O (ρ*pGradLaplacian U) = -(ρ*pGradLaplacian U) ∧
    O (ρ*hessianGrad U) = -(ρ*hessianGrad U) ∧
    (fun x ↦ -symmetricRHS false U β x*ρ x) = (fun x ↦ β/24*O (hermitePrimitive U β*ρ) x) ∧
    phaseH U (fun x ↦ ρ x*ν x.1) =
      O (fun x ↦ ((∑ i, x.2 i*gradient ν x.1 i)+μ x.1)*ρ x) := by
  sorry''',label='(7.33)–(7.34)',
extra=['OU仅对p微分，μ(q)不需对p额外正则；U,ν光滑且β>0。全部三个Hermite式和两个合成恒等式都在Lean结论中。'],
missing='需三阶张量的Gaussian共轭微分与混合导数交换；保留未证，不发展一般Hermite谱理论。')

add('FirstReciprocalCorrection','7.9.2','303–304',
r'''\[f_{2,1,[OABAO]}=-\tfrac\beta{24}(6p^T(\nabla^2U)\nabla U-\tfrac13\nabla^3U:p\otimes p\otimes p-\tfrac2\beta p^T\nabla_q\Delta_qU)-p^T\nabla\nu-\mu.\]
\[\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,2,[OABAO]})=-\mathcal L_H^\dagger(\rho_\beta f_{2,1,[OABAO]}).\tag{7.35}\]
\[\int_{\mathcal P}\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,2,[OABAO]})d\omega_p=0,\qquad
\int_{\mathcal P}\mathcal L_H^\dagger(\rho_\beta f_{2,1,[OABAO]})d\omega_p=\overline\pi\mathcal L_H^\dagger f_{2,1,[OABAO]}=0,\tag{7.36}\]
where $(\overline\pi f)(q)=\int_{\mathcal P}f(q,p)\rho_\beta d\omega_p$.''',
'''def firstReciprocalCorrection (U ν μ : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  -β/24*hermitePrimitive U β x-(∑ i, x.2 i*gradient ν x.1 i)-μ x.1
def momentumAverage (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  ∫ p, f (q,p) ∂momentumGibbs (fun _ ↦ 1) β
def momentumAveragePrinted (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  ∫ p, f (q,p)*gibbsWeight (fun _ ↦ 1) U β (q,p)
theorem firstReciprocalCorrection_pde (U ν μ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U) (hν : ContDiff ℝ ⊤ ν) :
    let ρ := gibbsWeight (fun _ ↦ 1) U β
    phaseO (fun _ ↦ 1) 1 β (ρ*firstReciprocalCorrection U ν μ β)+
      phaseH U (fun x ↦ ρ x*ν x.1) = (fun x ↦ symmetricRHS false U β x*ρ x) := by
  sorry''',label='(7.35)–(7.36)',
issues=['已目视核对PDF324–325：π̄定义带联合ρβ权，后续M公式却使用归一条件动量平均并隐含ρβ共轭。本文区分原文加权积分与修正的条件Gaussian平均，避免遗漏位置密度因子。'],
extra=['给出全部f2,1公式并陈述其一阶PDE；二阶可解相容性需OU积分通量消失及实际域条件，尚未证明。'],
missing='需要OU线性、Hermite恒等式应用和边界通量桥接；不建设Fredholm替代理论。',verdict='NEEDS_HUMAN')

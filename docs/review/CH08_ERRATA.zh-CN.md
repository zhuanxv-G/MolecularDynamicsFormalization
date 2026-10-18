# 第8章原书疑误与双版本审阅单

教材：Leimkuhler–Matthews《Molecular Dynamics》（2015）。正文印刷329–399页、PDF350–420页，末页仅取Exercises之前。
所有公式疑点均已目视核对原页。以下为待导师裁定的工作版本；书中省略条件、符号歧义、明确代数矛盾分别说明。网站尚未审阅。
原页引文保留文字层字符；公式的分式、上下标和特殊字形以附原页排版为准。原文版不作为修正版的证明依据。

## 1. MD-8.1.1-NHFirstIntegralPrinted

- source_id：MD-8.1.1-NHFirstIntegralPrinted；印刷333 / PDF354。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF354（印刷333）：
> 8.1
> Dynamics-Based Thermostat Techniques
> 333
> Let a further dynamical variable s be deﬁned by
> ds
> dt D :
> The extended Nosé-Hoover system then has a conserved quantity (see Exercise 2):
> INH.q; p; ; s/ D H.q; p/ C 2
> 2
> C Ndˇ1 ln s:
> (8.8)
> This integral can be used to monitor the performance of numerical methods.
> 8.1.2
> Numerical Methods for Extended System Thermostats
> We next describe some numerical procedures (based on the concept of splitting
> introduced in Chaps. 2 and 3) which are appropriate for thermostats based on the
> incorporation of auxiliary variables.
> Nosé-Hoover dynamics is not a Hamiltonian system, despite the presence of the
> mentioned ﬁrst integral. It is, however, time-reversible: changing the sign of p and
>  simultaneously in the equations of motion is equivalent to reversing the arrow of
> time t ! t. For this reason, time-reversible numerical methods are often proposed
> for Nosé-Hoover. A typical integrator is described below.
> To simplify the notation and to use a format that might more closely match what
> would be implemented in software, we write the algorithm for a single timestep of
> the method in which positions, momenta and auxiliary variables are updated in situ.
> Nosé-Hoover Timestep Map
> q :D q C .h=2/M1p
> p :D eh=2p  c.h=2; /rU.q/
>  :D  C h1 
> pTM1p  NdkBT
> 
> 
> p :D eh=2p  c.h=2; /rU.q/
> q :D q C .h=2/M1p
> Here we have solved successively, the ﬁrst, second and third equations, sequen-
> tially, and then in reverse order to make a symmetric (and second order) integrator.
> The auxiliary function involved c.t; / D 1et
> 
> is easily evaluated from a few terms
> of its Maclaurin series expansion
> c.t; / D t  t2=2 C : : :
> It is easy to verify that this method is time-reversible. If we write the timestep map
> as .q; p; / 7! Gh.q; p; /, then we may check that
> R ı Gh ı R D G 1
> h ;
> R.q; p; / D .q; p; /:

- 本条公式定位：ds/dt=ξ. I_NH=H+μξ²/2+N_dβ⁻¹ ln s is conserved.
- 问题所在、反例或理由：已目视核对原页PDF354：上行ds/dt=ξ，与(8.8)的ln s不相容；改为ds/dt=sξ（亦见PDF356和Exercise2）。
- 工作修正及限定：s>0；原文版不证明，修正版另列；两版均保留原文H形式。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.nhIntegral`：定义或记号。
  - `MD.Ch08.nhIntegralPrinted`：未证。
  - `MD.Ch08.nhIntegral_corrected`：未证。
- 待人工核查点：第一积分候选、原印s导数与修正s导数各自对应的沿解零导数目标；原印版不证。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 2. MD-8.1.2.1-NoseHamiltoniansPrinted

- source_id：MD-8.1.2.1-NoseHamiltoniansPrinted；印刷334 / PDF355。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF355（印刷334）：
> 334
> 8
> Extended Variable Methods
> 8.1.2.1
> Nosé-Poincaré Dynamics: A Symplectic Approach
> As we have seen in earlier chapters, there is a strong foundation for using symplectic
> integrators, for example the existence of perturbative backward error expansions
> which are relatively easily calculated, it is desirable to work within this class. On
> the other hand, as we have mentioned, Nosé-Hoover dynamics is not a Hamiltonian
> system. The Nosé-Poincaré method resolves this issue by providing a Hamiltonian-
> based extension of the physical system whose projected trajectories are actually
> equivalent to Nosé-Hoover trajectories, in the absence of numerical errors. This
> extended Hamiltonian system can then be discretized using a symplectic method.
> Nosé’s original proposal involved using the dynamics of the Hamiltonian
> HN D 1
> 2s2 QpTM1Qp C 2
> 2 C U.q/ C .Nd C 1/kBT ln s
> to deﬁne an extension which can be used for canonical sampling. The dynamics
> for constant Nosé extended energy, when reduced to the .q; p D Qp=s/ plane will
> preserve the canonical measure ˇ. However, the scaling of kinetic energy induces
> a time transformation, which is inconvenient for molecular modelling purposes. The
> Nosé-Poincaré method introduces an explicit unraveling of the time transformation.
> One works with the modiﬁed Nosé-Poincaré (NP) Hamiltonian [41, 102]:
> HNP D sŒHN  EN	 D s
>  1
> 2s2 QpTM1Qp C 2
> 2 C U.q/ C NdkBT ln s  EN
> 
> ;
> (8.9)
> where EN is a constant equal to the initial Nosé energy of the system. Trajectories of
> this system unfold on a timescale which is in some sense commensurate with that of
> Hamiltonian dynamics. The NP Hamiltonian system can be treated with symplectic
> integrators, conferring a possible stability advantage. Symplectic integrators for this
> system are compared in [41].
> The equations of motion associated to (8.9) are
> d
> dtq D M1Qp=s;
> (8.10)
> d
> dt Qp D sF;
> (8.11)
> d
> dts D sps=;
> (8.12)
> d
> dtps D QpTM1Qp
> s2
>  NdkBT  HN;
> (8.13)
> where HN D HN  H0
> N (H0
> N represents the value of the Nosé Hamiltonian at the
> initial point).

- 本条公式定位：H_N= p̃ᵀM⁻¹p̃/(2s²)+π²/(2μ)+U(q)+(N_d+1)k_BT ln s; H_NP=s[H_N-E_N]=s[p̃ᵀM⁻¹p̃/(2s²)+π²/(2μ)+U(q)+N_d k_BT ln s-E_N].
- 问题所在、反例或理由：已目视核对原页PDF355：H_N先用(N_d+1)，(8.9)展开却用N_d；同名H_N等号不一致。工作修正显式减去β⁻¹ln s。
- 工作修正及限定：物理定义域s>0、β,Q及质量正；总函数在此域外不作物理解释。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.noseHamiltonian`：定义或记号。
  - `MD.Ch08.npHamiltonian`：定义或记号。
  - `MD.Ch08.nosePoincarePrinted`：未证。
  - `MD.Ch08.nosePoincare_corrected`：已证。
- 待人工核查点：两个原印Hamiltonian定义、所印等式目标及减去对数差项后的代数修正。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 3. MD-8.4-OUStationarityPrinted

- source_id：MD-8.4-OUStationarityPrinted；印刷343–344 / PDF364–365。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF364（印刷343）：
> 8.4
> Ergodic Stochastic-Dynamic Thermostats
> 343
> dp D rU.q/dt  ˚.; z/   pdt C
> p
> 2kBTM1=2 1=2dW;
> (8.23)
> d D g.; q; p/dt  O dt C
> p
> 2kBT OM
> 1=2 O
> 1=2d OW:
> (8.24)
> Here  ; O
> are symmetric, square matrices of appropriate dimension, W is a
> vector of Nc Wiener processes, and OW is a vector of m Wiener processes, all
> independent of each other. We assume that the deterministic thermostat represented
> by the ˚ and g terms preserves the extended distribution O./ˇ, where O./ D
> exp
> 
> ˇT OM
> 1=2
> 
> . The matrix OM is symmetric and positive deﬁnite; one could
> take it to be diagonal.
> The additivity property of thermostats mentioned above holds also for stochastic
> thermostats, since the Fokker-Planck equation is constructed from linear operations
> on the vector ﬁelds involved, thus it is enough to require that the newly introduced
> terms satisfy appropriate ﬂuctuation-dissipation relationships so that they are
> compatible with the extended Gibbs distribution of the deterministic part. That is,
> we require
> dp D  pdt C
> p
> 2kBTM1=2 1=2dW
> to preserve the distribution with density N D exp
> 
> ˇpTM1p=2
> 
> , and
> d D  O dt C
> p
> 2kBT OM
> 1=2 O
> 1=2d OW
> to preserve O. These two problems are essentially the same. Considering the former,
> the stationary Fokker-Planck equation reads
> rp  . p N/
> „
> ƒ‚
> …
> drift
> C ˇ1Tr
> 
>  1=2M1=2r2
> p NM1=2 1=2
> „
> ƒ‚
> …
> diffusion
> D 0:
> The drift term here equates to
> Tr. / N C .ˇ/pT M1p N:
> For the diffusion term, we calculate
> r N D ˇ NM1p;
> thus
> r2 N D NŒˇ2M1ppTM1  ˇM1	;
> 
> 
> PDF365（印刷344）：
> 344
> 8
> Extended Variable Methods
> so the diffusion term is
> ˇ1Tr
> 
>  1=2M1=2ŒˇM1ppTM1  M1	M1=2 1=2
> N D drift;
> where we have used the cyclic property of the trace (and the symmetry of  ) to
> reduce the expression. The validity of the term involving  is easily veriﬁed by a
> similar argument.
> Thus we know that the Gibbs distribution will be invariant. It remains to prove
> that the SDE (8.22)–(8.24) is ergodic. Certainly this would be expected in the case
> where a full Langevin dynamics contribution is present ( positive deﬁnite), but as
> we shall see next there are cases where noise only contacts the auxiliary degrees of
> freedom but the system is nonetheless ergodic.
> We state here a useful observation that allows to simplify the commutator
> calculations in the case of an SDE of the following type:
> dz D F.z/dt C G.z/dt;
> (8.25)
> d D g.z/dt  
> dt C dW;
> (8.26)
> where z 2 Rm, F; G W Rm ! Rm.
> Proposition 8.2 If the Lie algebra generated by F and G in (8.25) spans Rm, then
> the Hörmander condition holds for the system (8.25)–(8.26).
> Proof First observe that the premise holds if and only if the Lie algebra of the
> vectors in RmC1 deﬁned by
> QF D
>  F
> 0
> 
> ;
> QG D
> G
> 0
> 
> ;
> together with emC1 spans RmC1. Thus the problem is to show that we can generate
> QF and QG from the vector ﬁelds that deﬁne (8.25)–(8.26), which are
> b0 D
> F C G
> g  
> 
> 
> ;
> b1 D
>  0
> 
> 
> :
> Computing the commutator gives
> c D Œb0; b1	 D
>  G
> 
> 
> ;
> hence
> QG D 1
>  Œc  
> b1	 :

- 本条公式定位：The OU momentum process with drift -Γp and noise √(2k_BT) M^{1/2}Γ^{1/2} preserves exp(-βpᵀM⁻¹p/2). The displayed diffusion term is β⁻¹Tr(Γ^{1/2}M^{1/2}[βM⁻¹ppᵀM⁻¹-M⁻¹]M^{1/2}Γ^{1/2})ρ̄=-drift.
- 问题所在、反例或理由：已目视核对原页PDF364–365：一般M与Γ仅对称不足保证原噪声协方差匹配，应加ΓM=MΓ或直接给涨落耗散关系；PDF365将Hessian的β提取后仍留β⁻¹，标量β=2,p=0已反例。
- 工作修正及限定：Printed保留显示抵消式的M=Γ=1,p=0标量特例；修正版为完整匹配协方差后的OU驻定式；不将转移分布存在性作为已证。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.ouFokkerPlanck`：定义或记号。
  - `MD.Ch08.ouStationarity_corrected`：未证。
  - `MD.Ch08.diffusionPrinted`：未证。
  - `MD.Ch08.diffusionPrinted_counterexample`：已证。
- 待人工核查点：协方差匹配的完整OU局部驻定目标；所印扩散抵消的标量特例及数值反例。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 4. MD-8.4-Proposition82

- source_id：MD-8.4-Proposition82；印刷344–345 / PDF365–366。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF365（印刷344）：
> 344
> 8
> Extended Variable Methods
> so the diffusion term is
> ˇ1Tr
> 
>  1=2M1=2ŒˇM1ppTM1  M1	M1=2 1=2
> N D drift;
> where we have used the cyclic property of the trace (and the symmetry of  ) to
> reduce the expression. The validity of the term involving  is easily veriﬁed by a
> similar argument.
> Thus we know that the Gibbs distribution will be invariant. It remains to prove
> that the SDE (8.22)–(8.24) is ergodic. Certainly this would be expected in the case
> where a full Langevin dynamics contribution is present ( positive deﬁnite), but as
> we shall see next there are cases where noise only contacts the auxiliary degrees of
> freedom but the system is nonetheless ergodic.
> We state here a useful observation that allows to simplify the commutator
> calculations in the case of an SDE of the following type:
> dz D F.z/dt C G.z/dt;
> (8.25)
> d D g.z/dt  
> dt C dW;
> (8.26)
> where z 2 Rm, F; G W Rm ! Rm.
> Proposition 8.2 If the Lie algebra generated by F and G in (8.25) spans Rm, then
> the Hörmander condition holds for the system (8.25)–(8.26).
> Proof First observe that the premise holds if and only if the Lie algebra of the
> vectors in RmC1 deﬁned by
> QF D
>  F
> 0
> 
> ;
> QG D
> G
> 0
> 
> ;
> together with emC1 spans RmC1. Thus the problem is to show that we can generate
> QF and QG from the vector ﬁelds that deﬁne (8.25)–(8.26), which are
> b0 D
> F C G
> g  
> 
> 
> ;
> b1 D
>  0
> 
> 
> :
> Computing the commutator gives
> c D Œb0; b1	 D
>  G
> 
> 
> ;
> hence
> QG D 1
>  Œc  
> b1	 :
> 
> 
> PDF366（印刷345）：
> 8.4
> Ergodic Stochastic-Dynamic Thermostats
> 345
> This means that we have built one of our two vectors. The second follows as a linear
> combination of the others:
> QF D b0   QG  .g  
> /1b1:
> ut
> The fact that the Hörmander condition holds is, as we know from Chap. 6, only
> part of the story. However based on known results for Langevin dynamics, we
> conjecture that ergodicity will hold if (i) the Hörmander condition holds, (ii) U
> is sufﬁciently smooth, and (iii) the conﬁgurational phase space is compact, e.g.
> periodic boundary conditions are employed. However we stress that each possible
> method will ultimately need to be carefully and systematically checked to verify the
> ergodic properties.
> 8.4.1
> Nosé-Hoover-Langevin: An Ergodic Weakly Coupled
> Thermostat
> The Nosé-Hoover-Langevin (NHL) method is based on a simple idea: replace the
> “chain” in the Nosé-Hoover Chain, whose sole purpose is to maintain a Gaussian
> distribution in the auxiliary variable, by a stochastic Langevin-type thermostat. The
> method was ﬁrst proposed in [323]. The proof of ergodicity (more precisely the
> conﬁrmation of the Hörmander condition), for a problem with harmonic internal
> interactions, was given in [226] and we roughly follow the treatment from this paper.
> The Nosé-Hoover-Langevin equations are
> dq D M1pdt;
> (8.27)
> dp D rU.q/dt  pdt;
> (8.28)
> d D 1ŒpTM1p  NdkBT	dt  
> dt C
> p
> 2kBT
> 1dW;
> (8.29)
> where .q; p/ 2 D with  2 R. Let us emphasize that the principal features of this
> thermostat: (1) it is essentially Nosé-Hoover plus a perturbation, (2) it incorporates
> a single Wiener process, (3) it has two free parameters 
>  and .
> Let us ﬁrst demonstrate that the Nosé-Hoover-Langevin method, is, in fact, a
> thermostat. We observe that we have already shown that the Nosé-Hoover method
> preserves the extended canonical distribution ˇ exp.ˇ2=2/. Therefore, by the
> additivity property, all that is needed is to show that the additional part
> d D 
> dt C
> p
> 2kBT
> 1dW

- 本条公式定位：If the Lie algebra generated by F and G in (8.25) spans R^m, then the Hörmander condition holds for (8.25)–(8.26).
- 问题所在、反例或理由：已目视核对原页PDF365–366：证明除以σ，定理需σ≠0；光滑向量场资格明确补足。
- 工作修正及限定：Printed版保留未要求非零σ的原文强度，不证明；修正版完整使用真实迭代Lie括号张成定义。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.proposition82Printed`：未证。
  - `MD.Ch08.proposition82_corrected`：已证。
- 待人工核查点：所印及补σ≠0后的真实Lie括号张成命题；不含解存在、平滑转移核或遍历性。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 5. MD-8.4.1-Theorem81

- source_id：MD-8.4.1-Theorem81；印刷346–348 / PDF367–369。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF367（印刷346）：
> 346
> 8
> Extended Variable Methods
> preserves O./ D exp.ˇ2=2/. However, this is obvious from our earlier
> investigations of Ornstein-Uhlenbeck equations.
> In order to show that this thermostat is ergodic, we need to demonstrate that
> the assumptions presented in Sect. 6.4.4 are valid. Assumption 1(ii) requires us to
> verify that a Hörmander condition (see Deﬁnition 6.1) holds for the Nosé-Hoover-
> Langevin system. Because of the complexity of the high order commutators, we
> will work here with the assumption of a quadratic potential in the physical model.
> In some sense this is the most difﬁcult case for a thermostat, but paradoxically, the
> assumption facilitates the mathematical analysis. We will assume throughout the
> following that Nd D Nc, i.e. that there are no constraints in the system. Our potential
> will therefore be assumed to be
> U.q/ D 1
> 2qTAq;
> for A a symmetric, positive deﬁnite Nc  Nc matrix, with
> rU.q/ D Aq:
> We will further assume M D I. If this is not the case, then one may introduce the
> rescaling Qq D M1=2q; Qp D M1=2p in order to rewrite the system in a form that does
> not involve M. Thus the system under study is
> dq D pdt;
> (8.30)
> dp D Aqdt  pdt;
> (8.31)
> d D 1Œkpk2  NdkBT	dt  
> dt C dW:
> (8.32)
> Let u1; u2; : : : ; uNc be the eigenvectors of A with 1; : : : ; Nc the corresponding
> eigenvalues. Observe that if q0 uk D p0 uk D 0, then, using (8.30)–(8.31), we have
> at this point
> uk  p D 0;
> uk  ŒAq  p	 D kuk  q D 0;
> which implies that Vk D f.q; p/juk  q D 0; uk  p D 0g is an invariant submanifold.
> Therefore we must require that uk  q and uk  p do not simultaneously vanish, that
> is, .q; p/ 2 D D R2Nc n SNc
> kD1 Vk.
> Theorem 8.1 If A is symmetric positive deﬁnite and has distinct eigenvalues, then
> (8.30)–(8.32) satisﬁes the Hörmander condition on D  R.
> 
> 
> PDF368（印刷347）：
> 8.4
> Ergodic Stochastic-Dynamic Thermostats
> 347
> Proof Observe that Nosé-Hoover-Langevindynamics is a special case of the system
> (8.25)–(8.26) Applying the proposition in our case, the problem is to show that the
> Lie algebra generated by
> F D
> 
> p
> Aq
> 
> ;
> G D
> 0
> p
> 
> ;
> spans R2Nc. We shall write SfF; Gg for the Lie algebra generated by F and G.
> Next we note:
> Lemma 8.1 For k D 1; 2; : : :,
> Ck D
>  Ak1p
> Akq
> 
> 2 SfF; Gg;
> and
> Dk D
>  Akq
> Akp
> 
> 2 SfF; Gg:
> The proof of this is straightforward by induction on k. (See exercises.)
> The conclusion of the proof of the theorem is based on the following proposition:
> Proposition 8.3 Assume A to be a symmetric positive deﬁnite matrix with distinct
> eigenvalues, and let Ck, Dk be deﬁned as in Lemma 8.1, then the 2Nc vectors
> C1; D1; C2; D2; : : : ; CNc; DNc form a linearly independent set on D.
> Proof A, being symmetric positive deﬁnite is unitarily similar to a diagonal matrix
> 
> , so A D U
> UT. Deﬁne Op D UTp, Oq D UTq. The domain D is deﬁned by the
> condition that Opi and Oqi are not simultaneously zero.
> With the change of variables, the problem is to show that OC1; OD1; : : : ; OCNc; ODNc
> are linearly independent, where
> OCk D
>  
> k1Op
> 
> kOq
> 
> ;
> ODk D
>  
> kOq
> 
> kOp
> 
> :
> Suppose the vectors are linearly dependent, then there exist coefﬁcients
> ˛0; ˛1; : : : ; ˛Nc1 and ˇ0; ˇ1; : : : ; ˇNc1 not all zero such that:
> Nc
> X
> jD1
> ˛j OCj C
> Nc
> X
> jD1
> ˇj ODj D 0:
> 
> 
> PDF369（印刷348）：
> 348
> 8
> Extended Variable Methods
> Deﬁne polynomials .x/ D PNc1
> jD0 ˛jxj, .x/ D PNc1
> jD0 ˇjxj, then, for each j, we
> have
> .j/Oqj C j.j/Opj D 0;
> j.j/Opj  j.j/Oqj D 0;
> multiplying the ﬁrst equation by Oqj and the second by Opj and adding, we obtain
> ŒOq2
> j C jOp2
> j 	.j/ D 0:
> The ﬁrst factor is nonzero by the condition of being in D and the positive
> deﬁniteness of A, thus we must have .j/ D 0 for all Nc distinct j. But as
>  has degree Nc  1, this is a contradiction. Thus the collection must be linearly
> independent.
> Demonstrating the Hörmander condition is sufﬁcient for Assumption 1(ii) in
> Sect. 6.4.4. Assumption 1(i) can be veriﬁed by proving that solutions are able to
> access an open set around any point y 2 D  R. We omit the proof of Assumption
> 1(i) for Nosé-Hoover-Langevin dynamics as it is follows the same structure as the
> proof of Lemma 6.1 for Langevin dynamics. The details of the proof can be found
> in [283], with examples for more general SDEs given in [256, 257].
> The ﬁnal requirement for geometric ergodicity (speciﬁed in Assumption 2 in
> Sect. 6.4.4) requires a function  W D  R ! .0; 1/ such that
> L 	 ˛ C ı;
> for positive constants ˛ and ı and where L is the generator of the stochastic process.
> Such a function is called a Lyapunov function.
> The generator for Nosé-Hoover-Langevin dynamics (8.27)–(8.29), acting on a
> suitable test function f.q; p; / is
> LNHLfD M1p  rqf  rU.q/  rpf  p  rp C 1 
> pTM1p  NdkBT
> 
>  @f
> @
>  
>  @f
> @ C kBT
> 1 @2f
> @2 :
> If we consider M D I for simplicity, a Lyapunov function is given in [283] as
> .q; p; / D 1
> 2kpk2 C U.q/ C 
> 2 .  a/2;
> where a is a constant. As our potential is smooth, it is reasonable to make the
> assumption that
> 1 < Umin 	 U.q/ 	 Umax < 1;
> 8q 2 Q;

- 本条公式定位：If A is symmetric positive definite with distinct eigenvalues, (8.30)–(8.32) satisfies the Hörmander condition on D×R.
- 问题所在、反例或理由：已目视核对原页PDF367–369：继承Proposition8.2证明，必须排除σ=0；只证明Hörmander张成，不自动获得全局几何遍历性。
- 工作修正及限定：D严格采用每个特征模态q、p不同时为零；正温度、质量、摩擦及非零噪声明确写出。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.theorem81Printed`：未证。
  - `MD.Ch08.theorem81_corrected`：已证。
- 待人工核查点：所印及补参数资格后的NHL点态Hörmander条件；不含由其推出全局几何遍历性。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 6. MD-8.4.1-LyapunovRatePrinted

- source_id：MD-8.4.1-LyapunovRatePrinted；印刷349 / PDF370。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF370（印刷349）：
> 8.4
> Ergodic Stochastic-Dynamic Thermostats
> 349
> for some constants Umin and Umax. Hence  is strictly positive over the entire space,
> and we can compute that
> LNHL D p  rU.q/  rU.q/  p  kpk2 C
> 
> kpk2  NdkBT
> 
> 
> .  a/
>  
> .  a/ C kBT
> ;
> 	 akpk2  
> 2 C .a
>   NdkBT/  C aNdkBT C kBT
> :
> Choosing a so that a
>   NdkBT D 0, we obtain
> LNHL D akpk2  
> 2  
> a2 C 
> a2 C aNdkBT C kBT
> :
> Using 2  a2 	 .  a/2=2 gives
> LNHL 	 2a1
> 2kpk2  
> 1
> 2.  a/2 C 
> a2 C aNdkBT C kBT
> :
> Now choosing
> ˛ D min .2a; 
> / ;
> we have
> LNHL 	 ˛ C ˛U.q/ C 
> a2 C aNdkBT C kBT
> ;
> 	 ˛ C ı;
> for constants ˛ and ı as required, where
> ı D ˛Umax C 
> a2 C aNdkBT C kBT
> :
> This gives the necessary Lyapunov condition for the Nosé-Hoover-Langevin equa-
> tions, and hence the dynamics are geometrically ergodic. Solution trajectories will
> sample the extended canonical distribution, and it remains to compute solutions
> using an appropriate discretization scheme.
> 8.4.2
> Numerical Integration of the Nosé-Hoover-Langevin
> Equations
> Many older schemes for Nosé-Hoover and Langevin dynamics make use of
> computational shortcuts to (for example) reduce the number of computed random
> values per iteration, reduce the data storage needed for an algorithm or replace
> functions that are costly to evaluate (e.g. exponential or trigonometric functions)

- 本条公式定位：Choose aγμ-N_dk_BT=0, α=min(2a,γμ), δ=αU_max+γμa²+aN_dk_BT+k_BTγ; then Lφ≤-αφ+δ.
- 问题所在、反例或理由：已目视核对原页PDF370：与φ热浴项μ(ξ-a)²/2比较时衰减系数应≤γ，所印min(2a,γμ)对一般μ不足；正参数数值反例已列。
- 工作修正及限定：修正为min(2a,γ)，仅修正漂移代数估计；几何遍历还需完整概率半群、小集条件和解理论，未声称已证。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.lyapunovAlphaPrinted`：定义或记号。
  - `MD.Ch08.lyapunovAlpha_corrected`：定义或记号。
  - `MD.Ch08.lyapunovRatePrinted`：未证。
  - `MD.Ch08.lyapunovRate_counterexample`：已证。
  - `MD.Ch08.lyapunovRate_corrected`：未证。
- 待人工核查点：所印与修正衰减系数、两版漂移界目标及所印界的正参数数值反例。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 7. MD-8.5-SLSBracketPrinted

- source_id：MD-8.5-SLSBracketPrinted；印刷358 / PDF379。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF379（印刷358）：
> 358
> 8
> Extended Variable Methods
> R2NcC1, the Wi are independent Wiener processes, and D is the “deterministic part:”
> D D
> 2
> 4
> p
> p
> p  rU  
> 3
> 5 :
> Then we calculate directly
> D0 D ŒD; YNcC1	 D
> 2
> 4
> p
> 0
> 1
> 3
> 5 ;
> and from this we see that ŒD0; Yi	 D ei for i D 1; 2; : : : ; Nc. Thus all the basis
> vectors of R2NcC1 are found in the Lie algebra of the components of the Hörmander
> decomposition; as we know, this is the key step in the proof of ergodicity. Thus
> the method (8.33)–(8.35) is an alternative for molecular sampling dynamics, even
> though it is not based on a Newtonian model. Leaving the stochastic term off the
> ﬁnal equation (i.e. in ) is easily shown to destroy the ergodicity property (the
> Hörmander condition is then violated).
> Now consider the splitting into deterministic and OU parts. The deterministic
> part
> Pq D M1p;
> Pp D 0;
> P D .M1p/  rU.q/=;
> (8.36)
> preserves volume and the function U.q/ C 2=2 and hence also the distribution
> with density QA.q; / D eˇ.U.q/C2=2/. By the same token the OU processes
> collectively preserve QB.p; / D eˇ.pTM1p=2C2=2/. In combination the full
> dynamics preserves the extended canonical measure. If we iterate the two parts
> (assuming the deterministic part is solved exactly) the distribution will converge
> to the exact canonical distribution, due to especially to incorporation of Nc C1 noise
> processes.
> The OU process deﬁning the ﬂuctuations in p is completely decoupled from q
> and , so it is perhaps most natural to think of the iteration as a random walk on
> the reduced space .q; / where the directions are generated by an auxiliary OU
> process. Then the algorithm proceeds as follows: (1) choose a random direction
> p using the OU process, and (2) sample the reduced (stochastic) dynamics for .q; /
> in the direction p. We refer to this procedure as stochastic line sampling (SLS), for
> the following reason. With p ﬁxed in step (2), the motion of q is conﬁned to the
> straight line: q D q0 C M1p, where  is a scalar function of time. Inserting
> this coordinate change in (8.36) we see that the equations reduce to P D ,
> P D @=@U.q0 C M1p/. This is a one-degree of freedom system and hence
> is theoretically exactly solvable in quadratures, although the complexity of the force
> will render this impractical in calculations, and, as mentioned above, an additional
> stochastic process must be incorporated to drive .

- 本条公式定位：D=(ξp,-p,-p·∇U-ξ), D′=[D,Y_{Nc+1}]=(p,0,1), [D′,Y_i]=e_i.
- 问题所在、反例或理由：已目视核对原页PDF379：沿用Proposition8.2所用括号约定[D,Y]=DY·D-DD·Y，q分量应为-p；整体反号也不能同时保留热浴分量+1。
- 工作修正及限定：只纠正第一括号；二次括号的整体符号不影响生成空间张成。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.slsBathNoise`：定义或记号。
  - `MD.Ch08.slsBracketPrinted`：未证。
  - `MD.Ch08.slsBracket_corrected`：未证。
- 待人工核查点：第一漂移/热浴括号的原印与符号修正目标；二重括号在Hörmander另条处理。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 8. MD-8.6-IsokineticDivergencePrinted

- source_id：MD-8.6-IsokineticDivergencePrinted；印刷362–363 / PDF383–384。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF383（印刷362）：
> 362
> 8
> Extended Variable Methods
> Pq D M1p;
> (8.37)
> Pp D F.q/  pTM1F.q/
> pTM1p
> p:
> (8.38)
> These equations preserve pTM1p D constant. (Note: It is tempting to replace the
> denominator in this expression by K0, the value of kinetic energy, but this is not
> recommended since it then destroys the ﬁrst integral.) The system (8.37)–(8.38) can
> be rewritten in the alternative form
> Pq D M1p;
> Pp D ŒI  H	 F.q/;
> where H D p.pTM1p/1pTM1 is a projector matrix which is idempotent: H2 D
> H. The invariant subspace associated to this projector is span.p/:
> Hp D p:
> Isokinetic dynamics has nonvanishing divergence, which requires a special
> treatment to elucidate its statistical mechanical properties [338, 376]. In order to
> ﬁnd a stationary solution, one substitutes
> .q; p/ D ew.q;p/˚.K.p//;
> (8.39)
> (with ˚ a nonvanishing function of K) into the continuity equation for the isokinetic
> system, the function w being at this point unknown. Then one obtains, with f iso
> denoting the vector ﬁeld in (8.37)–(8.38), that
> 0 D r  .f iso/ D .r/  f iso C .r  f iso/
> D .rw C ˚0.K/
> ˚.K/ rK/  f iso C .r  f iso/:
> Using the isokinetic property, the term involving K drops out. One next calculates
> the divergence of the isokinetic vector ﬁeld and ﬁnds that (see Exercise 5)
> r  f iso D .Nc  1/pTM1F
> pTM1p :
> 
> 
> PDF384（印刷363）：
> 8.6
> Isokinetic Methods and Integration with Very Large Timestep
> 363
> Thus the condition to have a stationary state of the form (8.39) is that
> rw  f iso D .Nc  1/pTM1F
> pTM1p :
> A solution of this equation for w is easily found, it is
> w D .Nc  1/U.q/
> K.p/:
> The invariant probability density, which is associated to a surface of constant kinetic
> energy, can be written as a generalized function using the Dirac notation:
> .q; p/ D Z1e.Nc1/U.q/=K.p/ıŒK.p/  K0	:
> If we work on the surface of constant kinetic energy K.p/ D K0
> def
> D ˇ1.Nc  1/, the
> invariant density is of the form
>  / NˇıŒK.p/  kBT.Nc  1/	
> which demonstrates that the isokinetic method, with this choice for the total kinetic
> energy, leaves invariant the conﬁgurational Gibbs distribution. Ergodicity has not
> been demonstrated, so it is not possible to conclude that the invariant distribution is
> unique; as we have seen before, the incorporation of stochastic terms can allow the
> formulation of strong statements regarding the ergodicity and mixing properties.
> 8.6.1
> A Stochastic, Isokinetic Method for Gibbs Sampling
> Minary et al. [271, 272] studied the isokinetic method as a means to control
> the instability in multiple timestepping due to resonance. They suggested that
> each physical degree of freedom be coupled to its own NHC thermostat through
> an isokinetic constraint in a “massive” thermostatting approach. These massive
> thermostats introduced some complexity (each degree of freedom had an associated
> Nosé-Hoover chain system as well as the constraint); obtaining an accurate solution
> for this large system is involving. A potentially more serious problem is that,
> although Nosé-Hoover chains and the isokinetic method may in some cases appear
> to be “practically ergodic,” no proof of ergodicity exists. A recent article (by one
> of us, together with Margul and Tuckerman [220]) addressed these problems by
> replacing the Nosé-Hoover chains with stochastic terms (of Ornstein-Uhlenbeck
> type).

- 本条公式定位：ρ=e^{-w(q,p)}Φ(K(p)); div f_iso=(N_c-1)pᵀM⁻¹F/(pᵀM⁻¹p), w=(N_c-1)U/K.
- 问题所在、反例或理由：已目视核对原页PDF383–384：ṗ=F-λp的散度应为-(N_c-1)λ，所印正号与后续w=(N_c-1)U/K也冲突。
- 工作修正及限定：Φ为正光滑非零函数时称权重；使用K≠0域上的实际散度。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.isoAnsatz`：定义或记号。
  - `MD.Ch08.isoDivergencePrinted`：未证。
  - `MD.Ch08.isoDivergence_corrected`：未证。
- 待人工核查点：一般光滑力的原印/符号修正散度目标及权重ansatz；w方程和概率不变另列缺口。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 9. MD-8.6.1-SINWeightPrinted

- source_id：MD-8.6.1-SINWeightPrinted；印刷365 / PDF386。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF386（印刷365）：
> 8.6
> Isokinetic Methods and Integration with Very Large Timestep
> 365
> Let 1 D pF  12
> 12=2, 2 D p2 C 12
> 1=2, so  D 1=2, then calculate
> d
> dp D .2F  21p/=2
> 2;
> d
> d1
>  D .1122  111/=2
> 2;
> to see that
> pd
> dp C 1
> d
> d1
> D .pF  12
> 12/2  .2p2 C 12
> 1/1
> 2
> 2
> D 2
> 
>  pF
> 22
> C   
> 
> D pF
> 2
> ;
> hence
> div.f/ D pF
> 2
>  2  2
> D pF  2.pF  12
> 12=2/
> p2 C 12
> 1=2
>  2
> D pF C 12
> 12
> p2 C 12
> 1=2  2:
> We ﬁnd that a solution of the equation rw  f D div.f/ is then given by
> w D
> U C 1
> 22
> 2
> p2 C 1
> 212
> 1
> :
> Integrating over the isokinetic surface p2 C 1
> 212
> 1 D ˇ1, and with respect to the
> variable 2, yields the Gibbs conﬁgurational density.
> The exciting prospect here is that we now have a new variable 2 which
> has, in equilibrium, a Gaussian distribution. The Ornstein-Uhlenbeck terms are
> therefore compatible with this extended distribution and can be incorporated (as
> in Nosé-Hoover-Langevin) to provide ergodicity and control of the convergence to
> equilibrium.

- 本条公式定位：w=(U+ξ₂²/2)/(p²+μ₁ξ₁²/2); integration over the isokinetic surface gives the Gibbs configurational density.
- 问题所在、反例或理由：已目视核对原页PDF386：ξ₂方程含μ₂⁻¹，而w的ξ₂二次项缺μ₂；一般μ₂时应为μ₂ξ₂²/2。
- 工作修正及限定：仅证明正约束面处的实际通量散度陈述；曲面概率测度、边缘分布和遍历性列缺口。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.sinWeightPrinted`：定义或记号。
  - `MD.Ch08.sinWeight_corrected`：定义或记号。
  - `MD.Ch08.sinWeight_stationary_corrected`：未证。
- 待人工核查点：原印及补热浴质量的权重、正约束面局部驻定目标；曲面边缘分布及遍历性未覆盖。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 10. MD-8.6.2-SINProjectedBracketsPrinted

- source_id：MD-8.6.2-SINProjectedBracketsPrinted；印刷367 / PDF388。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF388（印刷367）：
> 8.6
> Isokinetic Methods and Integration with Very Large Timestep
> 367
> The proof requires calculation of the vector ﬁelds
> u0 D ˘ f;
> u1 D ˘ Œf; g	 ;
> u2 D ˘ Œf; Œf; g		;
> u3 D ˘ Œf; Œf; Œf; g			;
> where ˘ is the projector onto the ﬁrst three components. Because g D e4,
> it is enough to show that any pair from among these four vectors are linearly
> independent, except possibly on M0. Note that projection can only be performed
> after the full calculation of the relevant commutator. Because the commutators
> quickly become quite messy, we used a symbolic computing package to assist in
> these calculations.
> The ﬁrst two vectors are:
> u0 D p@q  .q C p/@p  .1 C 12/@1;
> (8.48)
> and
> u1 D p @
> @2
> @p C 1
> 
> 1 C @
> @2
> 	
> @1:
> (8.49)
> After expanding the derivatives of  we have
> u1 D p@q C 2
> 1
> q C p2
> D
> 	
> @p  21p
> q C p2
> D
> 	
> @1;
> (8.50)
> and
> u2 D .2
> 1p=D/@p C .21p2=D/@1;
> (8.51)
> where D D 2p2 C 2
> 1.
> If q ¤ 0 and p ¤ 0, then clearly u1 and u2 are linearly independent. However, if
> p D 0 then u2 D 0. We proceed to compute the commutator Œf; Œf; g		. Projecting to
> the ﬁrst three components results in
> u2 D 
> 2
> 1p
> D
> 	
> @q  
> 2
> p3 C 
> 2
> 1p  2
> 1q
> D2
> 	
> @p C 21p
> 2
> p3 C 
> 2
> 1p  2
> 1q
> D2
> 	
> @1:
> (8.52)
> Again, we substitute p D 0 and ﬁnd that
> u2jpD0 D .2
> 1q=D2/@p:
> (8.53)
> Unfortunately, this is parallel to u1 (for p D 0), and hence yet one more commutator
> is required in this case.

- 本条公式定位：u₀=Πf, u₁=Π[f,g], u₂=Π[f,[f,g]], u₃=Π[f,[f,[f,g]]]. The displayed equations (8.48)–(8.53) give their components, with D=2p²+ξ₁².
- 问题所在、反例或理由：已目视核对原页PDF388：(8.50)的u₁公式实际重写u₀，(8.51)的u₂公式实际为首交换子；(8.49)第三分量似缺共同σ。原印与真实迭代交换子独立保留。
- 工作修正及限定：总化分式只在θ>0的约束面D=2θ>0使用；实际交换子先在四维完整计算再投影。；本条记录原印显式式和真实微分定义；显式式与真实二/三重交换子的等式尚未证明，列覆盖缺口。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.bracket4`：定义或记号。
  - `MD.Ch08.sinBracket`：定义或记号。
  - `MD.Ch08.projectFirstThree`：定义或记号。
  - `MD.Ch08.sinD`：定义或记号。
  - `MD.Ch08.sinU0Printed`：定义或记号。
  - `MD.Ch08.sinU1Printed`：定义或记号。
  - `MD.Ch08.sinU2Printed`：定义或记号。
  - `MD.Ch08.sinU1DerivativePrinted`：定义或记号。
  - `MD.Ch08.sinProjected_corrected`：定义或记号。
  - `MD.Ch08.sinU2LongPrinted`：定义或记号。
  - `MD.Ch08.sinU2Long_at_p0`：已证。
- 待人工核查点：原印(8.48)–(8.53)的主要分量与实际交换子定义，(8.49)导数写法保存在逐字原页；未把错标指标视为已证恒等式。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 11. MD-8.6.2-SINThirdBracketPrinted

- source_id：MD-8.6.2-SINThirdBracketPrinted；印刷368 / PDF389。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF389（印刷368）：
> 368
> 8
> Extended Variable Methods
> We calculate Œf; Œf; Œf; g			 and project onto the space spanned by the ﬁrst three
> components to ﬁnd
> u3 D 
> 2
> p3  4p32 C 4p2q C 2
> 1p2 C 
> 2
> 1p  22
> 1q
> D2
> 	
> @q
>  2
> 1
>  
> D3
> 
> @p C 21p
>  
> D3
> 
> @1:
> (8.54)
> with
>  D 4p5
> 2  8p52
> 1  42
> 1p3 C 4p3
> 22
> 1  4p34
> 1
>  2
> 2
> 1p2q C 4p2q22
> 1  42
> 1q2p  24
> 1p C p
> 24
> 1  q
> 4
> 1 C 4
> 12q:
> (8.55)
> Along p D 0, u3 becomes
> u3jpD0 D 2q@q  
> q
> 4
> 1 C 4
> 12q
> 4
> 1
> 	
> @p
> D 2q@q  q.
>  C 2/@p:
> (8.56)
> Together with u0 we obtain a linearly independent set as long as q ¤ 0.
> If p D 0 and q D 0 then we are on M0. If p ¤ 0 then u2 and u0 are linearly
> independent. If q ¤ 0 then u3 and u0 are linearly independent. From these we
> establish that the Hörmander condition holds everywhere except on a space of co-
> dimension 2 (that is except on the one-dimensional set M0).
> In this case, it is possible to complete the proof by introducing a Lyapunov
> function  to demonstrate the necessary contractivity in the 2 direction. The
> generator of this system is
> Lisok D p @
> @q C
> 
> F  .p2=/F
> 
>  @
> @p  p1F
> 
> @
> @1
> C LN C LO
> with  D p2 C 2
> 1=2,
> LN D 1
> 2
> 2
> 12p
> 
> @
> @p C 1
> 2
> 3
> 12
> 
> @
> @1
>  21
> @
> @1
> C Œ2
> 1  ˇ1	 @
> @2
> ;
> and
> LO D 
> 2
> @
> @2
> C 2
> 2
> @2
> @2
> 2
> :

- 本条公式定位：The third projected commutator is displayed in (8.54), with polynomial η in (8.55); its p=0 specialization is printed as u₃=-2σq∂q-σq(-γ+ξ₂)∂p in (8.56).
- 问题所在、反例或理由：已目视核对原页PDF389：(8.54)q分量代p=0得到-2σq/ξ₁²，(8.56)遗漏ξ₁²分母；原印多项式的其他系数仍待独立微分核对。
- 工作修正及限定：ξ₁≠0用于分式化简；此处只核对原印(8.54)与(8.56)内部的代数关系，不声称(8.54)已被确认为实际三重交换子。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.sinEtaPrinted`：定义或记号。
  - `MD.Ch08.sinU3Printed`：定义或记号。
  - `MD.Ch08.sinU3ZeroPrinted`：定义或记号。
  - `MD.Ch08.sinU3Zero_corrected`：定义或记号。
  - `MD.Ch08.sinU3Zero_specialize`：已证。
- 待人工核查点：原印三重交换子候选及p=0内部代数核对；真实三重交换子等式列覆盖缺口。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 12. MD-8.6.3-SINForceExactPrinted

- source_id：MD-8.6.3-SINForceExactPrinted；印刷372 / PDF393。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF393（印刷372）：
> 372
> 8
> Extended Variable Methods
> We stress that the implementation of this method is in fact quite straightforward,
> despite its apparent complexity. The following details regarding the implementation
> are discussed in [220]:
> •
> For the integration of the Nosé terms, it is recommended to use a further splitting:
> LN D L.1/
> N C L.2/
> N ;
> where
> L.1/
> N D 1
> 2
> 12
> 12p
> 
> @
> @p C 1
> 2
> 13
> 12
> 
> @
> @1
>  21
> @
> @1
> ;
> and
> L.2/
> N D 1
> 2 Œ12
> 1  ˇ1	 @
> @2
> :
> Moreover a Yoshida/Suzuki type higher order decomposition is used to obtain
> more accuracy in this component.
> •
> The term exp ŒhLF	 (like similar terms) is completely integrable. Note that in
> general this reduces to solving
> Pp D F  p2F=;
> P1 D p1F=;
> with F a constant.
> The solution in a timestep h is
> p.h/ D p.0/ C .F=m/s.h/
> Ps.h/
> ;
> 1.h/ D 1.0/
> Ps.h/ ;
> where
> s.t/ D b1=2 sinh.t
> p
> b/ C a
> b.cosh.t
> p
> b/  1/
> with a D Fp.0/= and b D F2=,  D ˇ1.
> Care must be taken in the evaluation of s and Ps for a; b close to zero.
> Note that other decompositions are possible [220].

- 本条公式定位：ṗ=F−p²F/Λ, ξ̇₁=pξ₁F/Λ. The printed solution is p(h)=(p(0)+(F/m)s(h))/ṡ(h), ξ₁(h)=ξ₁(0)/ṡ(h), with s(t)=b⁻¹/²sinh(t√b)+(a/b)(cosh(t√b)−1), a=Fp(0)/Λ, b=F²/Λ.
- 问题所在、反例或理由：已目视核对原页PDF393：所印ξ̇₁为正号，与前页力子场及ξ₁(h)=ξ₁(0)/ṡ(h)的负号导数冲突。保留原印和负号工作修正版。
- 工作修正及限定：质量按本节假设取1；Q₁、Λ正，排除ṡ=0；F=0用b=0的解析延拓，避免总化除法假装极限。；只声明候选流在有效域满足校正ODE，不证明全局流、组合方法精度或遍历性。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.sinForceAux`：定义或记号。
  - `MD.Ch08.sinForceFlow`：定义或记号。
  - `MD.Ch08.sinForceODEPrinted`：定义或记号。
  - `MD.Ch08.sinForceODE_corrected`：定义或记号。
  - `MD.Ch08.sinForceFlow_solution_corrected`：未证。
- 待人工核查点：原印子场、显式候选与校正ODE的局部导数目标。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 13. MD-8.7-GLEFluctuationDissipationPrinted

- source_id：MD-8.7-GLEFluctuationDissipationPrinted；印刷374 / PDF395。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF395（印刷374）：
> 374
> 8
> Extended Variable Methods
> and have to be modelled as part of the simulation process. Our presentation of this
> topic follows that of [19] and earlier works [69, 85, 204, 276] which treat the non-
> Markovian Generalized Langevin equation as a Markov system in an extended phase
> space.
> The equations of Generalized Langevin dynamics are normally written in the
> form
> dq D M1pdt;
> (8.57)
> dp D rU.q/dt 
> t
> Z
> 0
>  .t  s/p.s/dsdt C dB;
> (8.58)
> subject to initial conditions q.0/ D q0, p.0/ D p0. Here  .t/ D .
> ij.t// is a Nc  Nc
> matrix-valued function of t which we refer to as the “memory kernel”. The term
> Fd D 
> t
> Z
> 0
>  .t  s/p.s/dsdt
> represents a drag force acting on the system due to the interaction with the particles
> of the bath. dB is the increment of the colored-noise (non-Gaussian) stochastic
> process. Often this increment is treated formally as an impulse R.t/dt, where R
> is referred to as a “random force,” which calls to mind the origin of the stochastic
> term as the model for interaction with a large (but ﬁnite) heat bath. We use this
> language for consistency with the literature. The driving forces are correlated in a
> way that is described by the ﬂuctuation-dissipation theorem [202, 402]. This states
> that at temperature T the components of the random forces satisfy
> hRi.t C s/Rj.t/i D kBT 
> ij.s/ıij;
> s  0:
> (8.59)
> Here, ıij is the Kronecker delta, and kB is Boltzmann’s constant.
> Numerical methods for treating (8.57)–(8.58) include calculation of the drag
> force Fd which requires a convolution of the momenta with  .t/ and therefore
> storage of some portion of the time-history of p. Typically we will compute a
> discrete sequence of p0; p1; : : : ; and so it will be necessary to store a collection
> of, say ` > 0, previous momentum vectors. This may be somewhat demanding in a
> large scale simulation setting. Moreover, computing R requires the generation of a
> sequence of random numbers with prescribed correlation, as speciﬁed in Eq. (8.59).
> Both these issues may be addressed sensibly using the technique of Prony series and
> an extended variable representation
> In the remainder of this discussion, for the purpose of simpliﬁed presentation, we
> conﬁne ourselves to the simple case of a scalar memory kernel, writing
>  .t/ D 
> .t/I:

- 本条公式定位：⟨Rᵢ(t+s)Rⱼ(t)⟩=k_BT γᵢⱼ(s)δᵢⱼ, s≥0. Γ(t)=γ(t)I in the scalar-kernel specialization. (8.59).
- 问题所在、反例或理由：已目视核对原页PDF395：一般矩阵核后额外乘δᵢⱼ会消掉交叉相关，只在对角核/独立分量解释下成立；标量核特化没有此问题。颜色与非Gaussian不是同义条件。
- 工作修正及限定：修正版作为单位质量下的一般矩阵协方差目标，不声称任意Γ均可实现为随机过程；正定协方差/核存在性列缺口。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.randomForceQualification`：定义或记号。
  - `MD.Ch08.gleFDPrinted`：定义或记号。
  - `MD.Ch08.gleFD_corrected`：定义或记号。
  - `MD.Ch08.scalarMemoryMatrix`：定义或记号。
- 待人工核查点：Printed与一般矩阵协方差目标及标量核定义；不包含涨落耗散定理的物理推导。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 14. MD-8.8-AndersenHamiltonianPrinted

- source_id：MD-8.8-AndersenHamiltonianPrinted；印刷380 / PDF401。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF401（印刷380）：
> 380
> 8
> Extended Variable Methods
> D mi
> 1
> 3V1=3 PV Nqi C V2=3PNqi
> 
> ;
> from which, we observe
> Npi D miV1=3Pqi:
> (8.72)
> There is still the question of how to adjust the volume in simulation. The idea
> of Andersen was to view the volume V as a dynamical quantity on equal footing
> with the coordinates of the system by viewing PV as the potential energy term and
> introducing an artiﬁcial kinetic energy term of the form V PV2. The barostat mass V
> becomes a free parameter, analogous to the thermal mass used in Nosé dynamics.
> An extended Hamiltonian may then be written by introducing a momentum variable
> pV conjugate to V:
> OH.Nq; Np; V; pV/ D
> N
> X
> iD1
> kNpik2
> 2miV2=3 C NU.NqI V/ C p2
> V
> 2V
> C PV;
> (8.73)
> where we have written NU.NqI V/ D U.V1=3Nq/.
> In the extended space, we then observe that
> NPT D
> s
> ˇ
> 2V
> Z
> eˇ OH.Nq;Np;V;pV/dpV;
> from the deﬁnitions (8.71) and (8.72).
> There are several ways to proceed. Andersen suggested to use a Monte-
> Carlo method to control the temperature during simulation. This approach has
> the advantage of simplicity, but only allows the determination of conﬁgurational
> averages. If dynamical information is required (e.g. an autocorrelation function
> or a diffusion coefﬁcient), some sort of dynamics-based scheme is needed. The
> progress in developing formulations and numerical methods can be charted in
> [11, 32, 128, 183, 199, 248, 252, 288, 373].
> Deterministic methods can be used based on Nosé-Hoover to control the
> temperature. A problem with methods of this type that one sometimes encounters
> “ringing” or “breathing” depending on the tuning of various parameters.
> Stochastic-dynamical thermostats greatly improve control of the convergence to
> equilibrium. We have already seen several methods of this type, speciﬁcally the
> Langevin dynamics method and the Nosé-Hoover-Langevinmethod. These schemes
> may be applied in conjunction with the Andersen Hamiltonian OH. The extended
> system approach outlined here was developed in collaboration with R. Elber and
> M. Di Pierro; it is close in spirit to the method of Klein [199], but incorporates
> stochastic terms as in Nosé-Hoover-Langevin in the equations deﬁning the auxiliary
> variables to ensure ergodicity.

- 本条公式定位：Ĥ=Σᵢ|p̄ᵢ|²/(2mᵢV^{2/3})+Ū(q̄;V)+p_V²/(2μ_V)+PV, and ρ_NPT=√(β/(2πμ_V))∫exp(−βĤ)dp_V. (8.73).
- 问题所在、反例或理由：已目视核对原页PDF401：边缘公式未写此前ρ_NPT定义中的Z_NPT⁻¹；字面右端给未归一Boltzmann权。修正版独立加入正配分常数，需导师确认作者是否在此省略归一因子。
- 工作修正及限定：m,QV,V,β正为物理域；QV是活塞质量，pV取实数。仅高斯消元的点态权重式，不把它当成任意U下的归一概率或完整坐标Jacobian定理。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.andersenHamiltonian`：定义或记号。
  - `MD.Ch08.andersenMarginalPrinted`：定义或记号。
  - `MD.Ch08.andersenMarginal_corrected`：定义或记号。
  - `MD.Ch08.andersenGaussian_marginal`：未证。
- 待人工核查点：活塞Hamiltonian、原印/修正边缘权重和Gaussian积分目标。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 15. MD-8.8.1-PistonThermostatWeightPrinted

- source_id：MD-8.8.1-PistonThermostatWeightPrinted；印刷381 / PDF402。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF402（印刷381）：
> 8.8
> Constant Temperature and Pressure Molecular Dynamics
> 381
> 8.8.1
> Equations of Motion for the NHL Piston
> In the framework of [199], rewriting the equations of motion for the physical
> variables q and p, the dynamics takes the form
> Pq D M1p C q;
> Pp D rU.q/  p  p;
> PV D V;
> with auxiliary variables  and  governed by additional dynamical equations of
> motion
> P D hT
> def
> D .pTM1p  NdkBT/=T;
> P D hP
> def
> D .V˘.q; p; V/  PV C kBT/=P;
> where
> ˘.q; p; V/
> def
> D 1
> V
> 
> pTM1p  q  rU.q/  V @
> @V U.q/
> 	
> ;
> is the expression for the pressure.
> Now let us examine the distribution conserved by the dynamics. First, we observe
> 1 D '1.pTM1p=2 C U.q//  .V; ; /
> is stationary for the Liouvillian operator for the vector ﬁeld .p; rU; 0; 0; 0/.
> The function can be chosen as any smooth function that integrates out with
> respect to V; ;  over Œ0; 1	  R  R. We already know from our discussion of
> Nosé-Hoover that Pp D p; P D .pTM1p  NdkBT/=T will have as stationary
> states functions of the form
> 2 D exp.ˇŒpTM1p C T2=2	/ 2.q; ; V/:
> Finally the remaining terms Pq D q, Pp D p, PV D V, P D .V˘.q; p; V/  PV C
> kBT/=P give rise to the Liouvillian
> L D rq .q/Crp .p/ @
> @V .V/ @
> @Œ.V˘.q; p; V/PV CkBT/=P	:

- 本条公式定位：The book prints ρ₂=exp(−β[pᵀM⁻¹p+μ_Tξ²/2])ψ₂(q,η,V) for ṗ=−ξp, ξ̇=(pᵀM⁻¹p−N_dk_BT)/μ_T.
- 问题所在、反例或理由：已目视核对原页PDF402：ρ₂动能项缺1/2；所印反馈仍为pᵀM⁻¹p−N_dk_BT。原印权重保留，工作修正采用标准动能的一半。
- 工作修正及限定：仅取ψ₂=1的局部权重等式；任意冻结变量乘子和可归一概率还需额外资格，列覆盖缺口。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.pistonThermostatPart`：定义或记号。
  - `MD.Ch08.pistonRho2Printed`：定义或记号。
  - `MD.Ch08.pistonRho2_corrected`：定义或记号。
  - `MD.Ch08.pistonRho2_stationary_corrected`：未证。
- 待人工核查点：原印/修正权重及ψ₂=1时的实际子场驻定目标。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 16. MD-8.9.1-DPDMassOrderPrinted

- source_id：MD-8.9.1-DPDMassOrderPrinted；印刷389 / PDF410。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF410（印刷389）：
> 8.9
> Momentum-Conserving Thermostats and the Dissipative Particle. . .
> 389
> white-noise term with the following stochastic property
> hij.t/i D 0;
> hij.t/kl.t0/i D .ıikıjl C ıilıjk/ı.t  t0/;
> (8.88)
> and are independent for each pair of interacting particles at each time step.
> Invariance of the canonical distribution under these equations of motion follows if
> !D.rij/ D Œ!R.rij/	2;
> 2 D 2
> kBT;
> (8.89)
> where kB is the Boltzmann constant and T the equilibrium temperature. Note that
> the “canonical distribution” in the case of the DPD system or other momentum-
> conserving thermostat should have a density which is reduced to the leaves of
> constant total momentum, i.e.
> Oˇ
> def
> D Z1eˇH.q;p/  ı
> " N
> X
> iD1
> pi;x  x
> #
> ı
> " N
> X
> iD1
> pi;y  y
> #
> ı
> " N
> X
> iD1
> pi;z  z
> #
> where  D .x; y; z/ is the total momentum vector.
> The conservation of the total momentum is a direct result of the symmetric form
> of the various forces, thus DPD may be viewed as an isotropic Galilean-invariant
> thermostat which preserves hydrodynamics [8]. The ergodicity of DPD (i.e. that Oˇ
> is the unique measure sampled by the dynamics) has only been demonstrated in the
> case of a high density of particles in one dimension [334].
> The DPD system may be viewed as a special case of the generalized Langevin
> dynamics with equations
> dq D M1pdt;
> dp D rU.q/dt  .q/pdt C ˙.q/dW;
> (8.90)
> where the potential U is given in (8.84), and the damping matrix  and stochastic
> multiplier matrix ˙ are related by
>  D M1
> 2kBT˙˙ T:
> In the next subsection we describe the numerical treatment of the DPD system.
> We then take up the alternative scheme, the pairwise Nosé-Hoover-Langevin
> (PNHL) method, of [228] which also conserves momentum exactly. Other alter-
> natives to the DPD system include the Peters thermostat [299], the Lowe-Andersen
> method [241], and the Nosé-Hoover-Lowe-Andersen thermostat [347]. We do not
> discuss these schemes here, but note that they are compared to DPD and some of
> the other schemes introduced below in [228].

- 本条公式定位：For dp=−∇Udt−Δ(q)pdt+Σ(q)dW, the book gives Δ=M⁻¹ΣΣᵀ/(2k_BT).
- 问题所在、反例或理由：已目视核对原页PDF410：对动量漂移−Δp、动量协方差k_BT M，应为Δ=ΣΣᵀM⁻¹/(2k_BT)；原印左乘仅在相应矩阵可交换（如等质量）时一致。两粒子不等质量的矩阵反例已证。
- 工作修正及限定：M应正定、θ>0；本条记录两个矩阵关系目标与不交换反例，不声称由形式关系自动得到不变概率。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.dpdMatrixFDPrinted`：定义或记号。
  - `MD.Ch08.dpdMatrixFD_corrected`：定义或记号。
  - `MD.Ch08.dpdMassOrder_counterexample`：已证。
- 待人工核查点：原印/校正的质量矩阵次序及具体代数反例。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 17. MD-8.9.2-DPDPairGeneratorPrinted

- source_id：MD-8.9.2-DPDPairGeneratorPrinted；印刷392 / PDF413。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF413（印刷392）：
> 392
> 8
> Extended Variable Methods
> As an example, the phase space propagation of Shardlow’s method [333], may
> be written as
> exp
> 
> h OLDPD-S
> 
> D exp .hLO/ exp
> h
> 2LB
> 	
> exp .hLA/ exp
> h
> 2LB
> 	
> ;
> (8.99)
> where h is the stepsize and, as usual, exp
> 
> hLf
> 
> represents the phase space propaga-
> tor associated to the corresponding vector ﬁeld f. In practice, Shardlow’s method is
> typically implemented by further reducing the vector ﬁeld O into interacting pairs:
> exp
> 
> h OLO
> 
> D exp
> 
> hLON1;N
> 
>    exp
> 
> hLO1;3
> 
> exp
> 
> hLO1;2
> 
> ;
> with the operators associated to each interacting pair deﬁned as
> LOi;j D
> 
> 
> !D.rij/.Oqij  vij/ C 2
> 2 Œ!R.rij/	2Oqij 
> 
> rpi  rpj
> 	
> Oqij  rpi:
> (8.100)
> Each interacting pair thus preserves the invariant distribution Oˇ.
> 8.9.2.3
> DPD Trotter Scheme
> In the stochastic DPD-Trotter scheme, the standard DPD system (8.90) is split into
> two parts, which are labelled “A” and “S” as indicated below
> d
> qi
> pi
> 
> D
>  m1
> i pi
> 0
> 
> dt
> „
> ƒ‚
> …
> A
> C
> 
> 0
> FC
> i dt C FD
> i dt C Ri
> 
> „
> ƒ‚
> …
> S
> :
> (8.101)
> The corresponding operator of part A is exactly the same as in Shardlow’s method,
> while the operator of part S is actually the sum of the operators of B and O deﬁned
> above
> LS D LB C LO:
> (8.102)
> As in Shardlow’s method, the vector ﬁeld S is typically split into exactly solvable
> interacting pairs. Subtracting dvj from dvi and multiplying Oqij on both sides gives
> mijdvij D FC
> ij .rij/dt  
> !D.rij/vijdt C !R.rij/dWij;
> (8.103)

- 本条公式定位：(8.100) prints L_Oij=[−γωᴰu+(σ²/2)(ωᴿ)² e·(∂pi−∂pj)] e·∂pi for each unordered pair i<j.
- 问题所在、反例或理由：已目视核对原页PDF413：单个无序对算子的最外层只对pᵢ求导，会对总动量产生非零漂移；对两粒子成对守恒更新应将最外层改为e·(∂pᵢ−∂pⱼ)。完整有序双和(8.97)另含反方向项，不能直接同样判错。
- 工作修正及限定：本条只分别定义原印和成对修正版；不声称已证明驻定概率或原书单对不变性。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.pairDerivative`：定义或记号。
  - `MD.Ch08.dpdPairGeneratorPrinted`：定义或记号。
  - `MD.Ch08.dpdPairGenerator_corrected`：定义或记号。
- 待人工核查点：冻结配置下单对动量生成元的原式和守恒方向修正版。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

## 18. MD-8.9.2-DPDPairOUUpdate

- source_id：MD-8.9.2-DPDPairOUUpdate；印刷393 / PDF414。
- 原页核对：已目视核对原页。
- 原文引文（对应原页文字层逐字保留）：

> PDF414（印刷393）：
> 8.9
> Momentum-Conserving Thermostats and the Dissipative Particle. . .
> 393
> where mij D mimj=.mi C mj/ is the “reduced mass”, vij D Oqij  vij and FC
> ij .rij/ is the
> magnitude of the conservative force (8.82). This equation is an Ornstein-Uhlenbeck
> process with the exact (in the sense of distributions) solution [200]
> vij.t/ D
> FC
> ij
> mij
> C et
>  
> vij.0/ 
> FC
> ij
> mij
> !
> C
> s
> kBT.1  e2t/
> mij
> Rij.t/;
> (8.104)
> for i < j with  D 
> !D=mij, where vij.0/ are the initial relative velocities and
> Rij.t/ are normally distributed variables with zero mean and unit variance. Thus the
> incremental velocities are given by
> ij D vij.t/  vij.0/ D
>  
> vij.0/ 
> FC
> ij
> mij
> !
> .et  1/ C
> s
> kBT.1  e2t/
> mij
> Rij.t/:
> (8.105)
> The momenta are then obtained from
> pnC1
> i
> D pn
> i C mijijOqn
> ij;
> (8.106)
> pnC1
> j
> D pn
> j  mijijOqn
> ij;
> (8.107)
> thus deﬁning the propagator ehLSi;j for each particle pair. The DPD-Trotter propaga-
> tor is then
> exp
> 
> h OLDPD-Trotter
> 
> D exp
> h
> 2LS
> 	
> exp .hLA/ exp
> h
> 2LS
> 	
> ;
> where the momentum part is deﬁned by
> exp
> h
> 2
> OLS
> 	
> D exp
> h
> 2LSN1;N
> 	
>    exp
> h
> 2LS1;3
> 	
> exp
> h
> 2LS1;2
> 	
> :
> 8.9.3
> Extended Variable Momentum-Conserving Thermostats:
> Pairwise Nosé-Hoover/Nosé-Hoover-Langevin Methods
> Because of the form of the force laws, the number of interaction terms (and
> computational cost) involved in the three force terms in DPD are roughly balanced.
> In this setting the computational time needed to generate the independent random
> number streams can be signiﬁcant (depending on the particle density and cutoff
> radius), particularly in very large systems solved in parallel where communication
> between cells can require a signiﬁcant amount of time [1, 301]. For this reason,
> Allen and Schmid [8] proposed a Nosé-Hoover type thermostatting scheme in

- 本条公式定位：mred=mi mj/(mi+mj); mred du=Fdt−γωᴰu dt+σωᴿdW. a=γωᴰ/mred. u(t)=F/(a mred)+exp(−at)(u0−F/(a mred))+√[θ(1−exp(−2at))/mred]R. Δu=u(t)−u0; pi+=mred Δu e, pj−=mred Δu e. (8.103)–(8.107).
- 问题所在、反例或理由：已目视核对原页PDF414：原印F/(amred)须a>0；γ=0或截断外ωᴰ=0时需用积分系数连续延拓。修正版显式定义a=0为自由加速，噪声退化为零。
- 工作修正及限定：原印转移律要求mr>0、a>0、θ>0、t≥0及R独立标准正态；F为冻结配置的成对保守力标量，FDT用于方差。；单对精确分布律及其随机积分推导未证明；已证明质量正性、零率值与逐对总动量代数守恒。
- 原文版及修正版Lean名称与证明状态：
  - `MD.Ch08.reducedMass8`：定义或记号。
  - `MD.Ch08.reducedMass8_pos`：已证。
  - `MD.Ch08.dpdPairOUPrinted`：定义或记号。
  - `MD.Ch08.dpdPairOU_corrected`：定义或记号。
  - `MD.Ch08.dpdPairOU_zeroRate`：已证。
  - `MD.Ch08.dpdPairMomentumStep`：定义或记号。
  - `MD.Ch08.dpdPairMomentumStep_conserves`：已证。
- 待人工核查点：原印/零率延拓的OU转移公式、速度增量所用动量更新及总动量守恒。
- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。
- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。

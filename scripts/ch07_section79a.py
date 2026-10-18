from ch07_data import add

add('Proposition71','7.9',297,
r'''Proposition 7.1 Let $\mathcal L_X^\dagger$, $\mathcal L_Y^\dagger$ and $\mathcal L_Z^\dagger$ be general operators to which BCH can be applied, then defining
\[e^{h\widehat{\mathcal L}^\dagger}=e^{\frac h2\mathcal L_X^\dagger}e^{\frac h2\mathcal L_Y^\dagger}e^{h\mathcal L_Z^\dagger}e^{\frac h2\mathcal L_Y^\dagger}e^{\frac h2\mathcal L_X^\dagger},\tag{7.26}\]
gives $\widehat{\mathcal L}^\dagger=\mathcal L_0^\dagger+h^2\mathcal L_2^\dagger+O(h^4)$, where
\[\mathcal L_0^\dagger=\mathcal L_X^\dagger+\mathcal L_Y^\dagger+\mathcal L_Z^\dagger,\]
\[\mathcal L_2^\dagger=\frac1{12}([\mathcal L_Z^\dagger,\mathcal L_Z^\dagger,\mathcal L_Y^\dagger]+[\mathcal L_Y^\dagger+\mathcal L_Z^\dagger,\mathcal L_Y^\dagger+\mathcal L_Z^\dagger,\mathcal L_X^\dagger])
-\frac1{24}([\mathcal L_Y^\dagger,\mathcal L_Y^\dagger,\mathcal L_Z^\dagger]+[\mathcal L_X^\dagger,\mathcal L_X^\dagger,\mathcal L_Y^\dagger+\mathcal L_Z^\dagger]).\]''',
'''theorem proposition71 {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    ∃ Q : PowerSeries R, MolecularDynamics.textbookSymmetricModifiedGenerator X Y Z =
      PowerSeries.C (X+Y+Z)+
      PowerSeries.C (MolecularDynamics.textbookSymmetricOperatorCorrection X Y Z)*PowerSeries.X^2+
      PowerSeries.X^4*Q := MolecularDynamics.textbookSymmetricModifiedGenerator_formal_proposition71 X Y Z
theorem symmetricOddCorrections {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) (k : ℕ) :
    PowerSeries.coeff (2*k+1) (MolecularDynamics.textbookSymmetricModifiedGenerator X Y Z) = 0 :=
  MolecularDynamics.textbookSymmetricModifiedGenerator_odd_coeff_zero X Y Z k''',kind='proposition',label='Proposition 7.1 / (7.26)',
extra=['桥接正式库已证的实际非交换形式log/exp及完整对称修正定义体；余项为h⁴形式因子，未声称无界算符级数收敛。'],
prior=['MolecularDynamics.textbookSymmetricOperatorCorrection','MolecularDynamics.textbookSymmetricModifiedGenerator_formal_proposition71'])

add('EvenDensityPerturbation','7.9',298,
r'''If we suppose that the odd order correction functions are zero, then we are left with
\[\widehat\rho=\rho_\beta(1+h^2f_2+h^4f_4+\cdots),\tag{7.27}\]
where each $\langle f_i\rangle=0$ as usual. Equating the second order terms we obtain
\[\mathcal L_{LD}^\dagger(\rho_\beta f_2)=-\mathcal L_2^\dagger\rho_\beta.\tag{7.28}\]
The condition on the existence of such a solution requires us to use the Fredholm alternative, which requires us to verify that the inhomogeneous term $\mathcal L_2^\dagger\rho_\beta$ integrates to zero.''',
'''def evenDensityExpansion (ρ : Ω → ℝ) (f : ℕ → Ω → ℝ) (k : ℕ) : Ω → ℝ :=
  if k = 0 then ρ else if Even k then fun x ↦ ρ x*f k x else 0
theorem evenPerturbationEquation {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : ℕ → Module.End ℝ E) (ρ : ℕ → E)
    (hL1 : L 1 = 0) (hρ1 : ρ 1 = 0) (h2 : actionCoefficient L ρ 2 = 0) :
    L 0 (ρ 2) = -L 2 (ρ 0) := by
  have he : L 0 (ρ 2)+L 2 (ρ 0) = 0 := by
    simpa [actionCoefficient,Finset.sum_range_succ,hL1,hρ1] using h2
  exact eq_neg_of_add_eq_zero_left he''',label='(7.27)–(7.28)',
extra=['系数相消得到必要方程；Fredholm可解性的充分性需核、余核、函数空间和域的闭值域资格，本条不证明。原书将奇阶修正零作为假设，本条保留。'])

add('OYZYOInhomogeneity','7.9.1','298–299',
r'''For methods $[OYZYO]$, substituting $\mathcal L_X^\dagger=\mathcal L_O^\dagger$, $\mathcal L_Y^\dagger+\mathcal L_Z^\dagger=\mathcal L_A^\dagger+\mathcal L_B^\dagger=\mathcal L_H^\dagger$ simplifies the computation to
\[\mathcal L_{2,[OYZYO]}^\dagger\rho_\beta=\frac1{12}[\mathcal L_Z^\dagger,\mathcal L_Z^\dagger,\mathcal L_Y^\dagger]\rho_\beta-\frac1{24}[\mathcal L_Y^\dagger,\mathcal L_Y^\dagger,\mathcal L_Z^\dagger]\rho_\beta.\tag{7.29}\]''',
'''theorem oyzyoInhomogeneity {E : Type*} [AddCommGroup E] [Module ℝ E]
    (O Y Z : Module.End ℝ E) (ρ : E) (hO : O ρ = 0) (hH : (Y+Z) ρ = 0) :
    MolecularDynamics.textbookSymmetricOperatorCorrection O Y Z ρ =
      (1/12 : ℝ) • comm Z (comm Z Y) ρ-(1/24 : ℝ) • comm Y (comm Y Z) ρ := by
  sorry''',label='(7.29)',missing='需展开两个含O和H的嵌套交换子在共同核上的相消短桥；保留未证。')

add('TripleCommutatorPrinted','7.9.1',299,
r'''\[[\mathcal L_A^\dagger,\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho_\beta=(2\beta p^T(\nabla^2U)\nabla U-\nabla^3U:p\otimes p\otimes p)\rho_\beta,\]
\[[\mathcal L_B^\dagger,\mathcal L_B^\dagger,\mathcal L_A^\dagger]\rho_\beta=-(2\beta p^T(\nabla^2U)\nabla U)\rho_\beta.\]''',
'''def hessianU (U : V n → ℝ) (q : V n) (i j : Fin n) : ℝ := coordDerivative (fun y ↦ gradient U y j) q i
def thirdU (U : V n → ℝ) (q : V n) (i j k : Fin n) : ℝ := coordDerivative (fun y ↦ hessianU U y j k) q i
def hessianGrad (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, ∑ j, x.2 i*hessianU U x.1 i j*gradient U x.1 j
def cubicThird (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, ∑ j, ∑ k, thirdU U x.1 i j k*x.2 i*x.2 j*x.2 k
def tripleCommutatorPrinted (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  (2*β*hessianGrad U x-cubicThird U x)*gibbsWeight (fun _ ↦ 1) U β x
def tripleCommutatorPrinted_corrected (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β*(2*hessianGrad U x-cubicThird U x)*gibbsWeight (fun _ ↦ 1) U β x
theorem tripleCommutator_corrected (U : V n → ℝ) (β : ℝ) (hβ : 0 < β) (hU : ContDiff ℝ ⊤ U) :
    let m : V n := fun _ ↦ 1
    let ρ := gibbsWeight m U β
    phaseComm (aForward m) (phaseComm (aForward m) (bForward U)) ρ = tripleCommutatorPrinted_corrected U β ∧
    phaseComm (bForward U) (phaseComm (bForward U) (aForward m)) ρ =
      (fun x ↦ -2*β*hessianGrad U x*ρ x) := by
  sorry
theorem tripleCommutator_factor_counterexample : (2*(2 : ℝ)*0-1) ≠ 2*(2*0-1) := by norm_num''',
issues=['已目视核对PDF320／印刷299：首条三重交换子的三阶导数项未带β；后面的PDE却把β乘整个括号，且直接微分给出共同β。原文版与补β修正版独立保留。'],
extra=['M=I；Hessian、三阶张量及张量缩并均为实际坐标导数；原文版仅定义，不证明。反例先给系数代数区别，完整势函数测度反例未构造。'],
missing='需要多维三阶Gibbs微分与交换子展开；不建设通用算符理论。',verdict='NEEDS_HUMAN')

add('SymmetricRHS','7.9.1',299,
r'''\[\mathcal L_{LD}^\dagger(\rho_\beta f_{2,[OABAO]})=\frac\beta{24}(6p^T(\nabla^2U)\nabla U-\nabla^3U:p\otimes p\otimes p)\rho_\beta,\]
\[\mathcal L_{LD}^\dagger(\rho_\beta f_{2,[OBABO]})=\frac\beta{24}(2\nabla^3U:p\otimes p\otimes p-6p^T(\nabla^2U)\nabla U)\rho_\beta.\]
We can see immediately that the Fredholm alternative holds in both cases, as both equations have right-hand sides that are of odd order in $p$, and hence will average to 0.''',
'''def symmetricRHS (flip : Bool) (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β/24*(if flip then 2*cubicThird U x-6*hessianGrad U x else 6*hessianGrad U x-cubicThird U x)
theorem symmetricRHS_odd (flip : Bool) (U : V n → ℝ) (β : ℝ) (x : Phase n) :
    symmetricRHS flip U β (x.1,-x.2) = -symmetricRHS flip U β x := by
  have hG : hessianGrad U (x.1,-x.2) = -hessianGrad U x := by
    simp [hessianGrad,Finset.sum_neg_distrib]
  have hT : cubicThird U (x.1,-x.2) = -cubicThird U x := by
    simp [cubicThird,Finset.sum_neg_distrib]
  cases flip <;> simp [symmetricRHS,hG,hT] <;> ring
theorem symmetricRHS_zeroMean (flip : Bool) (U : V n → ℝ) (β : ℝ)
    (hint : Integrable (symmetricRHS flip U β) (productGibbs (fun _ ↦ 1) U β)) :
    (∫ x, symmetricRHS flip U β x ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry''',
extra=['右端去掉共同正Gibbs权，改用真实乘积Gibbs测度积分；奇性与零均值不等于完整Fredholm充分可解性。PDE左端与L2识别另需三重交换子桥。'],
missing='需Gaussian乘积测度在p↦-p下不变与可积奇函数积分为零的短桥；不建设Fredholm理论。')

add('Lemma71','7.9.1','299–300',
r'''Lemma 7.1 Consider two numerical schemes with associated operators governing the evolution of measure $ST$ and $TS$, with unique associated invariant distributions $\widehat\rho_{ST}$ and $\widehat\rho_{TS}$ respectively, such that
\[ST\widehat\rho_{ST}=\widehat\rho_{ST},\qquad TS\widehat\rho_{TS}=\widehat\rho_{TS}.\]
Under suitable ergodicity assumptions (such that in the long-time limit, all distributions converge to the invariant distribution), we have
\[\widehat\rho_{ST}=S\widehat\rho_{TS},\qquad\widehat\rho_{TS}=T\widehat\rho_{ST}.\]''',
'''theorem lemma71 (S T : Kernel Ω Ω) [IsMarkovKernel S] [IsMarkovKernel T]
    (ρST ρTS : Measure Ω)
    (hST : MolecularDynamics.textbookUniqueInvariantProbability (S ∘ₖ T) ρST)
    (hTS : MolecularDynamics.textbookUniqueInvariantProbability (T ∘ₖ S) ρTS) :
    ρST = S ∘ₘ ρTS ∧ ρTS = T ∘ₘ ρST :=
  MolecularDynamics.textbookInvariantDistributionSwap S T hST hTS''',kind='lemma',label='Lemma 7.1',
proof=r'''If we assume that $\lim_{n\to\infty}(ST)^n\rho=\widehat\rho_{ST}$, for any initial distribution $\rho$, then we have
$\widehat\rho_{ST}=\lim_{n\to\infty}(ST)^n\widehat\rho_{ST}=\lim_{n\to\infty}S(TS)^{n-1}T\widehat\rho_{ST}=S\widehat\rho_{TS}$.
A similar statement holds for $\widehat\rho_{ST}$.''',
extra=['真实Markov核、真实概率与不变概率的唯一性完整；借助不变性和唯一性即足够，不要求额外极限交换。保留原书证明文本，Lean采用已证更弱假设路线。'],
prior=['MolecularDynamics.textbookUniqueInvariantProbability','MolecularDynamics.textbookInvariantDistributionSwap'])

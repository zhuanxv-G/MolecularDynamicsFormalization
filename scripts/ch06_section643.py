"""Inactive draft: original weighted Brownian identities and existing closed realizations."""
import re
from ch06_data import add,copied
DIR='MolecularDynamics/Chapter06/BrownianDirichlet.lean'
PARAMS='''{Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)'''
def brownian_copy(file,name,newname):
    code=copied('MolecularDynamics/Chapter06/'+file+'.lean',name,newname)
    return code.replace('theorem '+newname,'theorem '+newname+' '+PARAMS,1)
add('BrownianGenerator','6.4.3',249,[87],r'''For example, let us return to Brownian dynamics (or overdamped Langevin dynamics) and set $M=I$ and $\gamma=1$ in (6.36), giving an equation of motion
\[dq=-\nabla U(q)dt+\sqrt{2k_BT}dW.\tag{6.46}\]
Writing $\beta^{-1}=k_BT$ as usual, the generator of the stochastic process may be written as
\[\mathcal L f=-\nabla U^T\nabla f+\beta^{-1}\Delta f.\]''',copied(DIR,'textbookBrownianGenerator','brownianGenerator'),kind='definition',label='(6.46)',extra=['[EXTRA]实际任意对角质量版本，取m≡1即此处公式；不声称原6.46本身含一般质量。'])
add('BrownianWeightedInner','6.4.3',249,[88],r'''Let $\bar\rho_\beta=\exp(-\beta U)$, and define the space of functions $C_0^2(\bar\rho_\beta)$ consisting of functions in $C_0^2$ on the configuration space $\mathcal Q\subset\mathbb R^{N_c}$ together with the inner product
\[\langle f,g\rangle_\beta\stackrel{\rm def}=\int_{\mathcal Q}f(q)g(q)\bar\rho_\beta(d\omega_q)=\int_{\mathcal Q}f(q)g(q)\bar\rho_\beta(q)d\omega_q;\]
where $d\omega_q=dq_1dq_2\cdots dq_{N_c}$.''','''def brownianWeightedInner {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β : ℝ)
    (f g : (Fin n → ℝ) → ℝ) : ℝ :=
  ∫ q in textbookConfigurationCube n, f q*g q*Real.exp (-β*U q)''',kind='definition',extra=['[EXTRA]本章后续周期Q的单位基本域；保留原未归一权重，不偷加Z⁻¹。C₀²域与闭算子域另行区别。'])
proof=r'''\[\langle f,\mathcal Lg\rangle_\beta=\int_{\mathcal Q}f[-\nabla U^T\nabla g+\beta^{-1}\Delta g]\bar\rho_\beta d\omega_q.\]
Integrating by parts in the second term we have
\[\beta^{-1}\int_{\mathcal Q}f\Delta g\bar\rho_\beta d\omega_q=-\beta^{-1}\int_{\mathcal Q}\nabla g^T\nabla(f\bar\rho_\beta)d\omega_q
=-\beta^{-1}\int_{\mathcal Q}\nabla g^T\nabla f\bar\rho_\beta d\omega_q+\int_{\mathcal Q}f(\nabla g^T\nabla U)\bar\rho_\beta d\omega_q.\]
Combining this with the first part of the inner product, we see that
\[\langle f,\mathcal Lg\rangle_\beta=-\beta^{-1}\int_{\mathcal Q}\nabla g^T\nabla f\bar\rho_\beta d\omega_q.\]'''
add('BrownianDirichlet','6.4.3','249–250',[89],r'''Combining this with the first part of the inner product, we see that
\[\langle f,\mathcal Lg\rangle_\beta=-\beta^{-1}\int_{\mathcal Q}\nabla g^T\nabla f\bar\rho_\beta d\omega_q.\]''',copied(DIR,'textbookBrownianGenerator_integral_dirichlet','brownianDirichlet'),proof=proof,extra=['[EXTRA]真实C∞周期资格保证边界通量消去；实际全质量逆M梯度积，m≡1还原原式；β≠0。'],prior=['MolecularDynamics.textbookBrownianGenerator_integral_dirichlet'])
sym=copied(DIR,'textbookBrownianGenerator_inner_symmetric','brownianSymmetry').replace('textbookConfigurationInner','brownianWeightedInner')
sym=sym[:sym.index(' := by')]+''' := by
  have hs := textbookBrownianGenerator_inner_symmetric m U β hβ f g hU hf hg hPU hPf hPg
  unfold textbookConfigurationInner at hs
  have hz := (textbookConfigurationPartition_pos U hU β).ne'
  have hc := mul_left_cancel₀ (inv_ne_zero hz) hs
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc'''
add('BrownianSymmetry','6.4.3',250,[89],r'''In this form we see that $f$ and $g$ appear symmetrically, so we may write
\[\langle f,\mathcal Lg\rangle_\beta=\langle\mathcal Lf,g\rangle_\beta;\]
hence, with respect to the weighted inner product, $\mathcal L=\mathcal L^*$. (Note that the adjoint indicated here is quite different than the $L^2$ adjoint mentioned previously in connection with the Fokker-Planck operator.)''',sym,extra=['[EXTRA]完整未归一配对等式，由现成归一配对消去正Z⁻¹；C∞周期核心上的形式对称，不宣称C₀²核心本身已闭自伴。'],prior=['MolecularDynamics.textbookBrownianGenerator_inner_symmetric'])
nonpos=copied(DIR,'textbookBrownianGenerator_inner_nonpos','brownianNonpositive').replace('textbookConfigurationInner','brownianWeightedInner')
nonpos=nonpos[:nonpos.index(' := by')]+''' := by
  have hn := textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf
  unfold textbookConfigurationInner at hn
  have hc := nonpos_of_mul_nonpos_right hn (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc'''
add('BrownianNonpositive','6.4.3',250,[90],r'''Moreover, from the calculation above,
\[\langle f,\mathcal Lf\rangle=-\beta^{-1}\int_{\mathcal Q}\|\nabla f\|^2\bar\rho_\beta d\omega_q;\]
so that $\langle f,\mathcal Lf\rangle\le0$ so the operator is negative definite and can only have non-positive eigenvalues.''',nonpos,extra=['[EXTRA]正质量与β>0，未归一配对；本条结论精确保留≤0，原negative definite术语错误另记录。'],issues=['常数属于核，≤0只证明半负定，不能升级严格负定。'],prior=['MolecularDynamics.textbookBrownianGenerator_inner_nonpos'])
add('BrownianRealEigenvalue','6.4.3',250,[90],r'''so that $\langle f,\mathcal Lf\rangle\le0$ so the operator is negative definite and can only have non-positive eigenvalues.''',copied(DIR,'textbookBrownianGenerator_real_eigenvalue_nonpos','brownianRealEigenvalue'),extra=['[EXTRA]真正非零L²特征函数、C∞周期、正质量与β>0；不以特征值符号作假设。'],prior=['MolecularDynamics.textbookBrownianGenerator_real_eigenvalue_nonpos'])
from ch06_data import RECORDS
next(r for r in RECORDS if r['source_id'].endswith('-BrownianRealEigenvalue'))['code']=next(r for r in RECORDS if r['source_id'].endswith('-BrownianRealEigenvalue'))['code'].replace('apply MolecularDynamics.textbookBrownianGenerator_real_eigenvalue_nonpos <;> assumption','exact MolecularDynamics.textbookBrownianGenerator_real_eigenvalue_nonpos m hm U β hβ f hU hf hPU hPf hne ℓ heig')
add('BrownianClosedSelfAdjoint','6.4.3','249–250',[91],r'''Then $\mathcal L$ is self-adjoint with respect to this inner product.''',brownian_copy('BrownianGibbsComplexOperator','textbookBrownianGibbsComplexOperator_isSelfAdjoint','brownianClosedSelfAdjoint'),extra=['[EXTRA]使用现成实际Gibbs复L²闭实现及完整adjoint域；原C₀²核心对称不等于闭自伴。权重归一不改变自伴关系。'],prior=['MolecularDynamics.textbookBrownianGibbsComplexOperator_isSelfAdjoint'])
add('BrownianCompactResolvent','6.4.3',250,[92],r'''In particular, it has a compact resolvent [360]; this can be shown to imply that the spectrum consists only of a countable collection of eigenvalues, i.e. that the operator has a discrete spectrum.''',brownian_copy('BrownianGibbsComplexResolvent','textbookBrownianGibbsComplexResolvent_isCompact','brownianCompactResolvent'),extra=['[EXTRA]实际Gibbs复L²闭实现的(1−L)⁻¹；全部离散谱子结论另条保留，未从本条自动声称原C₀²域自伴。'],prior=['MolecularDynamics.textbookBrownianGibbsComplexResolvent_isCompact'])

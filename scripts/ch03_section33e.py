"""Last eight entries of §3.3: PDF132–135, original rendered pages."""
from ch03_data import add,copied,proposition,D
add('Yoshida4Structure','3.3.3',110,[59],r'''Yoshida fourth-order scheme (velocity Verlet)''',
proposition('yoshida4Structure_statement',proof='exact MolecularDynamics.Chapter03Review.yoshida4Structure_proved'),
context=[r'同页九阶段(3.8)全文见Yoshida4；p.109/PDF131的对称三次辛复合；本条只列辛性和反步对称，不假冒已证4阶。'],
extra=['U全域C²；真实kick/drift及三次回文复合。'],prior=['MolecularDynamics.Chapter03Review.yoshida4Structure_proved'])
add('GeneralSplitting','3.3.3',111,[60],r'''We can view the Suzuki-Yoshida methods as one type of general composition scheme [260, 277, 326]:
\[\mathcal F_h=\exp(\alpha_1h\mathcal L_T)\circ\exp(\beta_1h\mathcal L_U)\circ\exp(\alpha_2h\mathcal L_T)\circ\exp(\beta_2h\mathcal L_U)\circ\cdots\circ\exp(\alpha_kh\mathcal L_T)\circ\exp(\beta_kh\mathcal L_U).\]''',
copied(D,'generalSplitting'),kind='definition',context=[r'有限有序列表(αᵢ,βᵢ)，foldr保持展示的复合次序；T,U参数为给定实际部分流，不由exp记号宣称存在。'])
add('TakahashiPotential','3.3.4',112,[61],r'''Recall the Takahashi-Imada method introduced in the last chapter.
\[\widehat P:=p-(h/2)\nabla\widetilde U(q),\qquad Q:=q+hM^{-1}\widehat P,\qquad P:=\widehat P-(h/2)\nabla\widetilde U(Q),\]
with modified potential energy function
\[\widetilde U(q)=U(q)-\frac{h^2}{24}\nabla U(q)^TM^{-1}\nabla U(q).\]''',
'''def takahashiImada {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  coordinateVerlet m (textbookPotentialForce (takahashiPotential m U h)) h''',kind='definition',
context=[r'实际takahashiPotential体为U−h²/24 ∑ᵢ(grad U)ᵢ²/mᵢ，实际kick-drift-kick梯度取整个修正势。'],
extra=['M为固定对角质量矩阵，原第1章机械模型。'])
add('PotentialDoubleBracket','3.3.4',112,[62],r'''One might recognize the modification as being proportional to one part of the commutator expansion in the Verlet method, in fact
\[\nabla U(q)^TM^{-1}\nabla U(q)=\{U,\{U,T\}\}.\]''',
proposition('potentialDoubleBracket_statement'),context=[r'$T=½p^TM^{-1}p$；U只依赖q；固定规范Poisson约定。'],
extra=['正对角质量、U全域C²，显式化真实二次Poisson括号的微分资格。'],
missing='需实际机械Hamiltonian的坐标Poisson双括号/梯度接口桥接；当前不存在现成桥接，有限微分路线待处理。')
add('TakahashiShadow','3.3.4',112,[63],r'''This is certainly not a coincidence. If we replace the potential $U$ by $\widetilde U$ in the Verlet expansion, we have
\[\begin{aligned}\widetilde H_h&=T+\widetilde U+\frac{h^2}{12}\left(\{T,\{T,\widetilde U\}\}-\frac12\{\widetilde U,\{\widetilde U,T\}\}\right)+O(h^4)\\
&=T+U-\frac{h^2}{24}\{U,\{U,T\}\}+\frac{h^2}{12}\left(\{T,\{T,\widetilde U\}\}-\frac12\{\widetilde U,\{\widetilde U,T\}\}\right)+O(h^4)\\
&=H+\frac{h^2}{12}\left(\{T,\{T,\widetilde U\}\}-\{\widetilde U,\{\widetilde U,T\}\}\right)+O(h^4)\\
&=H+\frac{h^2}{12}\left(p^TM^{-1}U''M^{-1}p-\nabla U^TM^{-1}\nabla U\right)+O(h^4).\end{aligned}\]''',
copied(D,'takahashiShadow2'),kind='definition',context=[r'本条存最后展示式到h²的有限函数；Poisson→梯度推导属前条待证明，不把定义称为已证实际匹配。'],
proof_note='原书同段推导完整存于statement_latex；有限函数定义不证明该推导或实际余项。')
add('TakahashiProcessor','3.3.4',113,[64],r'''Introducing coordinate transformations
\[\widetilde q=q-\frac{h^2}{12}M^{-1}\nabla U(q),\qquad\widetilde p=p+\frac{h^2}{12}U''(q)M^{-1}p,\tag{3.9}\]''',
copied(D,'takahashiProcessor'),kind='definition',label='(3.9)',context=[r'前句“Introducing coordinate transformations”位于p.112/PDF134末尾；不由此定义假设该变换全局可逆。'])
add('ProcessorEnergyPrinted','3.3.4',113,[65],r'''and inserting these into $H$ yields, after expanding in a Taylor series:
\[\begin{aligned}H(\widetilde q,\widetilde p)&=T+\frac{h^2}{12}\left(p^TM^{-1}U''M^{-1}p-\nabla U^TM^{-1}\nabla U\right)+O(h^4)\\
&=\widetilde H_h(q,p)+O(h^4).\end{aligned}\]''',
'''theorem processorEnergyPrinted :
    ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (Z n)),
      positiveMass m → ContDiff ℝ 4 U → IsCompact B →
      ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
        (|mechanicalEnergy m U (takahashiProcessor m U h z) -
          (quadraticKinetic m z.2+h^2/12*((shadowTerms m U z).1-(shadowTerms m U z).2.1))|
          ≤ C*h^4) ∧
        (|mechanicalEnergy m U (takahashiProcessor m U h z)-takahashiShadow2 m U h z|
          ≤ C*h^4) := by
  sorry''',context=[r'T仅为动能，不等于H=T+U；同页第二行的H̃及p.112/PDF134定义包含U。'],
extra=['正对角质量、U全域C⁴、紧初值集B；展示O(h⁴)按小h统一实际余项解释。'],
verdict='FAIL',explanation='p.113/PDF135第一行漏写U，h=0时已要求H=T；与下一行及上一页H̃矛盾。两行完整字面结论均保留sorry，不静默补U。',
issues=[dict(code='ERRATUM?',detail='第一行“T + h²/12(...)”似应为“H + h²/12(...)”；原文逐字保留，未改变正式库。')],
missing='印刷漏项待裁定；非PASS不证明。')
add('TakahashiEffectiveOrder','3.3.4',113,[66],r'''Since $\widetilde H_h$ is assumed to be constant along the numerical solution, the coordinate transformations have the result of giving an effective order of four for the energy. It turns out that the Takahashi-Imada method is, more generally, an effective 4th order scheme, i.e. for arbitrary quantities, not just the energy [166].''',
'''theorem takahashiEffectiveOrder :
    ∀ n (m : Fin n → ℝ) (U : Q n → ℝ), positiveMass m → ContDiff ℝ ⊤ U →
      ∃ χ : ℝ → Z n ≃ₜ Z n, ∀ (γ : ℝ → Z n) τ, 0 < τ →
        solution (mechanicalField m (fun q => -grad U q)) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
        ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
          oneStepMaxError (fun h => textbookProcessedMethod χ
            (fun k => verlet m (fun q => -grad (takahashiPotential m U k) q) k) h)
            (τ/ν) γ ν ≤ C*(τ/ν)^4 := by
  sorry''',context=[r'与第2章同方法的有效阶陈述对应；处理方法为χ⁻¹∘G∘χ，实际轨迹误差保留，不只证明能量。'],
extra=['正对角质量、U全域C∞、实际有限时间解连续；处理器χ要求全局homeomorphism，强于原文局部坐标展开。'],
verdict='NEEDS_HUMAN',explanation='全局可逆处理器与原书局部近恒等坐标变换的关系待审；完整实际轨迹四阶结论保留，不把能量阶误当任意观测量阶。',
issues=[dict(code='NEEDS_HUMAN',detail='全局χ是否过强，以及可选局部处理器和其作用方向，需导师判断。')],
missing='缺处理器逆、局部展开与实际四阶余项/稳定性的完整理论；本地非PASS不证明。')

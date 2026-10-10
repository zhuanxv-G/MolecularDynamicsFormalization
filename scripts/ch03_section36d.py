"""Final §3.6 entries, original PDF154."""
from ch03_data import add,proposition,EXCLUDED
add('MechanicalReversalCorrect','3.6.1',128,[],r'''Therefore the molecular dynamics Hamiltonian system is time-reversible.''',proposition('mechanicalReversal_statement','mechanicalReversalCorrect',proof='exact MolecularDynamics.Chapter03Review.mechanicalReversal_proved'),
extra=['[EXTRA]独立正确机械R反转结论；原书错误展示等式仍由MechanicalReversalPrinted保留，不静默更改它。'],context=['F=−grad U代入任意位置力版本；泛化不改变机械坐标反转对象。'],prior=['MolecularDynamics.Chapter03Review.mechanicalReversal_proved'])
add('ConjugateOrderPrinted','3.6.3',132,[],r'''and, if they are numerical methods, they will have similar stability properties and performance (e.g. the same effective order).''',
'''theorem conjugateOrderPrinted :
    ∀ (n r : ℕ) (χ : Q n ≃ₜ Q n) (G Φ : ℝ → Q n → Q n) (B : Set (Q n)),
      0 < r → IsCompact B → MolecularDynamics.Chapter03Review.localOrder G Φ B r →
      MolecularDynamics.Chapter03Review.localOrder
        (fun h z => χ (G h (χ.symm z))) (fun h z => χ (Φ h (χ.symm z))) (χ '' B) r := by
  sorry''',
extra=['将“same effective order”按同一局部误差幂阶和真实共轭参考流解释；χ至少homeomorphism、紧初值域、r>0。'],
verdict='NEEDS_HUMAN',explanation='仅拓扑共轭不保持数值误差幂阶；通常需要定量局部Lipschitz或光滑处理器及步长资格。原泛称性能也未精确定义。',issues=[dict(code='NEEDS_HUMAN',detail='homeomorphism可用平方根改变误差阶；原文缺定量正则性，不能由迭代共轭冒充已证同有效阶。')],missing='原文阶数/稳定性性能的精确意义及处理器正则性待审；本地非PASS不证明。')
add('ReversibleVolumeFailure','3.6.3',132,[124],r'''Of particular importance for molecular dynamics are the following properties: a symplectic map will preserve volume, whereas a time-reversible map need not do so, and a symplectic integrator will approximately conserve energy due to the existence of the perturbed Hamiltonian, whereas a time-reversible integrator may give rise to a drift in energy [166].''',proposition('reversibleVolumeFailure_statement'),
context=['本条保留真实可逆光滑非保体积反例；辛体积与BEA能量性质已在前章及§3.4保留；可逆方法能量漂移按may定性。'],missing='缺非线性可逆光滑equivalence和Jacobian绝对det≠1的反例桥接；线性可逆矩阵不足以给本例。')
EXCLUDED += [dict(printed_page='127–132',pdf_page='149–154',reason='设计原则选择、维数泛型、文献及KAM类比为定性评述；原文共轭effective-order附加数学断言已单列疑点，不排除。')]

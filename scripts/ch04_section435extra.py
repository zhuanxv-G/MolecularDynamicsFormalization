"""Prepared extra claims for subsection 4.3.5."""
from ch04_data import add,copied,proposition,D,NS
add('SHAKEElimination','4.3.5',161,[],r'''It is possible to demonstrate (see exercises) that this method reduces to (4.25)–(4.26) by eliminating the momenta.''',proposition('shakeElimination_statement'),extra=['[EXTRA]实际相空间SHAKE消元给质量一致M⁻¹(F−Gᵀλ)；原(4.25)缺M⁻¹的字面版单列待审；只转录正文结论，不进入习题。'],missing='待相邻两步真实关系逐坐标有限代数消元短证明。')
add('SHAKEPositionOrder','4.3.5',161,[],r'''There are several constraint-preserving, second-order alternatives which generalize the Störmer-Verlet scheme. One of these is the SHAKE method [322]. The symmetry suggests that this will be second order.''',proposition('shakePositionOrder_statement'),extra=['[EXTRA]正质量、C⁴势/约束/实际轨道、沿解非奇异Gram、相容两步初值；精确给真实有限区间位置误差O(h²)及分支存在，不把误差界作假设。'],missing='缺实际约束多步方法一致误差与离散分支存在理论；不建设大型收敛理论。')
from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,['SHAKEElimination'])

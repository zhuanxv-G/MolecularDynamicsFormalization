"""Dynamic correction and the corrected norm divergence, without numerical claims."""
from ch05_data import add,proposition,NS,EXCLUDED
add('DynamicalCorrection','5.6',209,[86],r'''The interpretation of a dynamical average (e.g. an autocorrelation function) as a stationary average means that we can apply the perturbation result to such computations as well.''',proposition('dynamicalCorrection_statement'),extra=['[EXTRA]固定lag的真实光滑pullback观测量及统一紧正则能量带；H参数改变时flow本身改变所导致的额外误差未自动忽略。本条完整平均校正关系不以结论为前提。'],missing='依赖未建立的完整曲面扰动/coarea平均误差定理；不建设大型理论。')
add('ForwardNormDivergence','5.6',207,[76],r'''the eigenvalues of the propagation matrix are outside the unit disk. Thus both solution components tend to infinity unless $(q_0,p_0)=(0,0)$.''',f'''theorem forwardNormDivergence : ∀ h : ℝ,h ≠ 0 → ∀ z : {NS}E 2,z ≠ 0 →
  Tendsto (fun k : ℕ => ‖({NS}forwardEuler h)^[k] z‖) atTop atTop := by
  sorry''',extra=['[EXTRA]独立修正为实际范数发散，不覆盖原两分量字面版；h≠0及非原点。'],missing='待已建立有限步能量增长、Euclidean范数平方及幂发散短桥。')
EXCLUDED.append(dict(section='5.6',printed_page='207–208',pdf_page='228–229',kind='excluded_qualitative',reason='Example5.7关于trimer轨道、100000步、两个步长的填色与边界overspill是数值观察；不提升为已证明混沌/遍历或精确modified方程。'))

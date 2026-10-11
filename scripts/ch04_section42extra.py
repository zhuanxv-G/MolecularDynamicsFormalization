"""Keep the linear rate in addition to divergence; original PDF169."""
from ch04_data import add,NS
add('ResonanceLinearRate','4.2.1',147,[27],r'''and the norm of the solution will oscillate and grow linearly with $n$ as $n\to\infty$. This is the simplest type of linear resonance present in multiple timestepping.''',f'''theorem resonanceLinearRate : ∀ Ω : ℝ, 0 < Ω → ∀ z : Fin 2 → ℝ, z 0 ≠ 0 →
  Tendsto (fun k : ℕ => ‖({NS}impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖/(k : ℝ))
    atTop (𝓝 (|(Real.pi/Ω)*z 0|)) := by
  sorry''',extra=['[EXTRA]选实际Pi最大范数给出精确正线性率；q0≠0，否则此增长结论不成立。'],context=['前条保持所有矩阵幂精确式，divergence另条；本条不把线性增长弱化为仅趋无穷。'],missing='待共振幂公式、Pi最大范数及归一化向量极限的短桥接。')
from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,['ResonanceLinearRate','ResonanceGrowth'])
# The divergence proof refers to the established positive linear rate.
growth=next(r for r in RECORDS if r['source_id'].endswith('-ResonanceGrowth'))
RECORDS.remove(growth);RECORDS.append(growth)

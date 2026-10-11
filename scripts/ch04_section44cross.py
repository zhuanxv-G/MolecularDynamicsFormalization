"""The full printed three-way cross-product identity, PDF191."""
from ch04_data import add,NS,RECORDS
add('CrossIdentityFull','4.4',169,[84],r'''$\operatorname{skew}(\omega)\delta_i=\omega\times\delta_i=-\operatorname{skew}(\delta_i)\omega$.''',f'''theorem crossIdentityFull : ∀ u v : {NS}V,
    {NS}skewMatrix u *ᵥ v={NS}cross3 u v ∧
    {NS}cross3 u v= -({NS}skewMatrix v *ᵥ u) := by
  sorry''',context=['保留三个表达式及两个等式；首等式的已证子引理另条，不以子引理冒充全部原式。'],missing='待真实Fin3矩阵/叉积完整双重等式短证明。')
from blueprint_source import apply_saved_routes
apply_saved_routes(4,RECORDS,['CrossIdentityFull'])

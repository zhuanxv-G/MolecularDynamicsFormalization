"""The exact planar rotation claim, with the actual Euler-sign convention."""
from ch04_data import add,NS
add('ExactPlanarRotation','4.4.1',173,[95],r'''Each of these is, it turns out, easily integrated as a planar rotation (see Exercise 7).''',f'''theorem exactPlanarRotation : ∀ (I π : {NS}V) (i : Fin 3), 0 < I i →
  let γ := fun t : ℝ => {NS}axisRotation i (-t*π i/I i) *ᵥ π
  γ 0=π ∧ (∀ t,γ t i=π i) ∧
    ∀ t,HasDerivAt γ ({NS}cross3 (γ t) (Pi.single i (γ t i/I i))) t := by
  sorry''',extra=['[EXTRA]第二/第三子场按完整π₂/π₃解释，与PrincipalAxisField一致；显式负角主动旋转给出(4.41)的π×ω符号，不将原表正角错误候选当作该精确子流。'],missing='待三轴实际sin/cos链式导数及Fin3展开短证明；正角原表另条待审。')
from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,['ExactPlanarRotation'])

"""Clause-completeness refinements, imported only after the current section check."""
from ch02_data import RECORDS

# A single matrix symbol belongs to the ODE's context, not a separate claim.
j=next(r for r in RECORDS if r['source_id']=='MD-2-CanonicalJ')
h=next(r for r in RECORDS if r['source_id']=='MD-2-HamiltonianODE')
h['old_ids']+=j['old_ids'];h['context_notation']+=[j['statement_latex']]+j['context_notation']
h['context_notation']=[x.replace('$J$及$H$见同页下两条','J在本条上下文、H见同页mechanicalHamiltonian条目') for x in h['context_notation']]
RECORDS.remove(j)
for r in RECORDS:
    if r['source_id']=='MD-2.2.1-Parts':
        r['code']='''theorem firstVariationParts : ∀ n (L : Q n → Q n → ℝ)
    (q η : ℝ → Q n) a b, a < b → ContDiff ℝ 2 (Function.uncurry L) →
    ContDiff ℝ 2 q → ContDiff ℝ ∞ η → η a=0 → η b=0 →
    stationarySmoothAction L a b q →
    (∫ t in a..b, (fderiv ℝ (fun x => L x (deriv q t)) (q t)) (η t)+
      (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)) =
    (∫ t in a..b, ((fderiv ℝ (fun x => L x (deriv q t)) (q t))-
      deriv (fun s => fderiv ℝ (L (q s)) (deriv q s)) t) (η t)) ∧
    (∫ t in a..b, ((fderiv ℝ (fun x => L x (deriv q t)) (q t))-
      deriv (fun s => fderiv ℝ (L (q s)) (deriv q s)) t) (η t))=0 := by
  sorry'''
        r.update(local_explanation='完整一阶变分I、分部积分后EL积分、驻值下I=0三个子句；前提是真实作用量驻值定义，不以目标积分零作假设。',missing='实际作用量求导、连续线性泛函值积分分部与变分正则性理论。')
        r['extra_assumptions']=['α<β，实际L和q C²；η按原文C∞、零端点；真实作用量驻值。']
        r['context_notation']=['I在上一段由实际作用量驻值得到，不能仅保留分部积分中的一个项。']
    if r['source_id']=='MD-2.2.1-FirstVariation':
        # The exact action difference precedes the O(epsilon^2) expansion.
        r['code']=r['code'].replace('    HasDerivAt (fun ε =>', '''    (∀ ε : ℝ, action L a b (variation q η ε)-action L a b q =
      ∫ t in a..b, L (q t+ε • η t) (deriv q t+ε • deriv η t)-L (q t) (deriv q t)) ∧
    HasDerivAt (fun ε =>''')
        r['local_explanation']='实际作用量差的精确积分恒等式、一阶导数及O(ε²)余项全部保留。'
    if r['source_id']=='MD-2.3.4-MatrixCancellation':
        r['proof_latex']=r['statement_latex']
        r['statement_latex']='''Hence
\\[\\frac{\\mathrm d}{\\mathrm dt}W^TJW=W^TJ\\dot W+\\dot W^TJW=0.\\]'''
        r['proof_note']='两个中间矩阵等式属于原文证明计算，逐字保留于proof_latex；实际时间乘积导数及常值由FormConstant承担。'
        r['local_explanation']='两个矩阵求和的零式完整；原文中间两等式保留为逐字证明，实际导数结论在FormConstant真实ODE常值条目。'
    if r['source_id']=='MD-2.4.4-FrozenNewton':
        r['code']=r['code'].replace('0 ≤ ρ →','0 < ρ →')
    if r['source_id']=='MD-2.4.5-EulerConjugacy':
        # Effective order is a separate conclusion, not hidden in a note.
        r['statement_latex']='As an illustration, the Symplectic Euler method turns out to be conjugate to the Verlet method (see Exercise 12).'

# Stable page/section order, including the new Gauss-two order and effective order.
RECORDS.sort(key=lambda r: (tuple(int(x) for x in r['section'].split('.')),
    int(r['printed_page'].split('–')[0])))

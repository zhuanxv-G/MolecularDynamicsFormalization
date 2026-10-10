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
    if r['source_id']=='MD-2.4.1-PotentialFlow':
        r['code']='''def bp_potentialFlow {Nc : ℕ} (U : Q Nc → ℝ)
    (h : ℝ) : SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookMomentumKick (textbookPotentialForce U) h'''
        r['local_explanation']='闭式势能子流采用原文实际负梯度，未把任意独立F偷换为给定U的力。'
    if r['source_id']=='MD-2.4.4-ImplicitLocal':
        r['code']='''theorem implicitLocal : ∀ n (g : ℝ → Q n → Q n) x
    (A : Q n ≃L[ℝ] Q n), ContDiff ℝ ∞ (Function.uncurry g) →
    HasFDerivAt (g 0) A.toContinuousLinearMap x →
    ∃ δ > 0, ∀ h : ℝ, |h| < δ → ∃ U V : Set (Q n),
      IsOpen U ∧ IsOpen V ∧ x ∈ U ∧ g h x ∈ V ∧
      ∃ inv : Q n → Q n, ContDiffOn ℝ ∞ inv V ∧
        (∃ K ≥ 0, ∀ y ∈ V, ‖inv y‖ ≤ K) ∧
        (∀ y ∈ V, inv y ∈ U ∧ g h (inv y)=y) ∧
        (∀ y ∈ U, inv (g h y)=y) := by
  sorry'''
        r['extra_assumptions']=['[EXTRA]g依赖真实步长h；联合C∞，零步实际导数为连续线性同构。',
            '[EXTRA]结论为充分小步长的局部逆；缩小有界邻域，不宣称全域有界逆。']
        r.update(local_explanation='步长量词、局部唯一双逆、连续/光滑和有界四类结论保留；没有把足够小步长的可逆性本身作假设。',
            missing='参数化光滑逆函数定理、连续可逆导数邻域及局部有界光滑逆理论。')
    if r['source_id']=='MD-2.5.1-GaussFamily':
        r['code']=r['code'].replace('methodLocalOrder G F (2*s)',
            '(∃ r : ℕ, 0 < r ∧ Even r ∧ methodLocalOrder G F r)')
        r['missing']='大型Gauss配点构造、正交多项式根/对称性及偶数阶逆步理论；当前库无完整理论。'
        r['local_explanation']='原句中的对称与偶数阶全部保留；没有额外声称原句未陈述的一般2s阶。2阶段四阶在GaussTwoOrder单列。'
    if r['source_id']=='MD-2.4.5-EulerConjugacy':
        # Effective order is a separate conclusion, not hidden in a note.
        r['statement_latex']='As an illustration, the Symplectic Euler method turns out to be conjugate to the Verlet method (see Exercise 12).'

# Stable page/section order, including the new Gauss-two order and effective order.
RECORDS.sort(key=lambda r: (tuple(int(x) for x in r['section'].split('.')),
    int(r['printed_page'].split('–')[0])))

"""Bounded routes on current PASS entries; save exact input and compiler output."""
import sys,json,subprocess,hashlib,importlib
from ch03_data import ROOT,BASE,RECORDS
key,route=sys.argv[1],int(sys.argv[2]);assert 1<=route<=3
sections={'EqualComponentIntegral':'35','LinearContinuousIntegral':'35b','ReversedTrajectory':'36','ElasticEnergy':'37','VerletOscillatorEnergy':'35'}
importlib.import_module('ch03_section'+sections[key])
r=next(x for x in RECORDS if x['source_id'].endswith('-'+key));assert r['local_verdict']=='PASS'
folder=BASE/'validation/short_search';folder.mkdir(exist_ok=True)
state=folder/(key+'.json');results=json.loads(state.read_text(encoding='utf-8')) if state.exists() else []
if any(x['exit_code']==0 or x['route']==route for x in results):raise SystemExit('Reuse existing route; no repeat.')
proofs={
'VerletOscillatorEnergy':'''intro Ω ρ hΩ hρ hρ2 z
  let A : ℝ := 1-ρ^2/4
  have hA : 0 < A := by dsimp [A]; nlinarith
  let E0 : ℝ := (z.2 0)^2+Ω^2*(z.1 0)^2
  refine ⟨Ω^2*E0/(4*A), by dsimp [E0]; positivity, ?_⟩
  intro h hh ν
  have hh2 : h^2*Ω^2 ≤ ρ^2 := by
    have hp := abs_le.mp hh
    nlinarith
  have hcoeff : A ≤ 1-h^2*Ω^2/4 := by dsimp [A]; linarith
  let K : Z 1 → ℝ := fun w => (w.2 0)^2+Ω^2*(1-h^2*Ω^2/4)*(w.1 0)^2
  have hstep : ∀ w, K (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0) h w) = K w := by
    intro w
    simp only [K, verlet, invMass, Pi.add_apply, Pi.smul_apply, smul_eq_mul, inv_one, one_mul]
    ring
  have hi : K (oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν) = K z := by
    induction ν with
    | zero => rfl
    | succ ν ih => rw [oneStepIterate_succ, hstep, ih]
  have hupper : K z ≤ E0 := by
    dsimp [K, E0]
    nlinarith [mul_nonneg (sq_nonneg h) (mul_nonneg (sq_nonneg Ω)
      (mul_nonneg (sq_nonneg Ω) (sq_nonneg (z.1 0))))]
  have hlower : ∀ w, Ω^2*A*(w.1 0)^2 ≤ K w := by
    intro w
    dsimp [K]
    nlinarith [sq_nonneg (w.2 0), mul_nonneg (sq_nonneg Ω)
      (mul_nonneg (sub_nonneg.mpr hcoeff) (sq_nonneg (w.1 0)))]
  let w := oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν
  have hden : 0 < Ω^2*A := mul_pos (sq_pos_of_pos hΩ) hA
  have hw : (w.1 0)^2 ≤ E0/(Ω^2*A) := by
    apply (le_div_iff₀ hden).mpr
    have hlow := hlower w
    change K w=K z at hi
    nlinarith
  have hz : (z.1 0)^2 ≤ E0/(Ω^2*A) := by
    apply (le_div_iff₀ hden).mpr
    have hlow := hlower z
    nlinarith
  have habs : |(w.1 0)^2-(z.1 0)^2| ≤ 2*E0/(Ω^2*A) := by
    apply abs_le.mpr
    constructor <;> nlinarith [sq_nonneg (w.1 0), sq_nonneg (z.1 0)]
  have heq : mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) w-
      mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z =
      (h^2*Ω^4/8)*((w.1 0)^2-(z.1 0)^2) := by
    norm_num [mechanicalEnergy, quadraticKinetic, Fin.sum_univ_one]
    change K w=K z at hi
    dsimp [K] at hi
    nlinarith
  change |mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) w-
    mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z| ≤ _
  rw [heq, abs_mul, abs_of_nonneg (show 0 ≤ h^2*Ω^4/8 by positivity)]
  calc
    _ ≤ (h^2*Ω^4/8)*(2*E0/(Ω^2*A)) := mul_le_mul_of_nonneg_left habs (by positivity)
    _ = Ω^2*E0/(4*A)*h^2 := by
      have hg : Ω ≠ 0 := ne_of_gt hΩ
      have ha : A ≠ 0 := ne_of_gt hA
      field_simp
      ring''',
'EqualComponentIntegral':'''refine ⟨(fun z => z.1-z.2), (fun _ => rfl), ?_⟩
  intro f u v hu hv t
  have hd : ∀ s, HasDerivAt (fun t => u t-v t) 0 s := by
    intro s
    simpa using (hu s).sub (hv s)
  exact is_const_of_deriv_eq_zero (fun s => (hd s).differentiableAt)
    (fun s => (hd s).deriv) t 0''',
'LinearContinuousIntegral':'''intro n b f γ hbf hγ t
  have hd : ∀ s, HasDerivAt (fun t => ∑ i, b i*γ t i) 0 s := by
    intro s
    simpa only [hbf] using HasDerivAt.fun_sum
      (u := Finset.univ) (fun i _ => ((hasDerivAt_pi.mp (hγ s)) i).const_mul (b i))
  exact is_const_of_deriv_eq_zero (fun s => (hd s).differentiableAt)
    (fun s => (hd s).deriv) t 0''',
'ReversedTrajectory':'''intro n R f γ hR hrev hγ t
  simpa only [Function.comp_apply, neg_one_smul, map_neg, hrev, neg_neg] using
    R.hasFDerivAt.comp_hasDerivAt t ((hγ (-t)).comp t (hasDerivAt_neg t))''',
'ElasticEnergy':'''intro n m u p hm hu
  have hex : ∃ i, u i ≠ 0 := by
    by_contra! h
    apply hu
    ext i
    exact h i
  let S : ℝ := ∑ i, u i^2/m i
  let T : ℝ := ∑ i, u i*p i/m i
  have hS : 0 < S := by
    apply Finset.sum_pos'
    · intro i _; exact div_nonneg (sq_nonneg _) (le_of_lt (hm i))
    · obtain ⟨i, hi⟩ := hex
      exact ⟨i, Finset.mem_univ i, div_pos (sq_pos_of_ne_zero hi) (hm i)⟩
  let a := -2*T/S
  have hid : ∀ i, (p i+a*u i)^2/m i =
      p i^2/m i+2*a*(u i*p i/m i)+a^2*(u i^2/m i) := by
    intro i; ring
  have hnormal : ∀ i, u i*(p i+a*u i)/m i =
      u i*p i/m i+a*(u i^2/m i) := by
    intro i; ring
  constructor
  · change (∑ i, (p i+a*u i)^2/m i)/2 = (∑ i, p i^2/m i)/2
    simp_rw [hid, Finset.sum_add_distrib, ← Finset.mul_sum]
    change ((∑ i, p i^2/m i)+2*a*T+a^2*S)/2 = _
    dsimp [a]
    field_simp
    ring
  · change (∑ i, u i*(p i+a*u i)/m i) = -T
    simp_rw [hnormal, Finset.sum_add_distrib, ← Finset.mul_sum]
    change T+a*S = -T
    dsimp [a]
    field_simp
    ring'''}
candidate=proofs[key]
if route==2:candidate=candidate.replace('simpa only [hbf]','simpa [hbf]')
if route>=2:
    candidate=candidate.replace('(hu s).sub (hv s)', '(hu s).fun_sub (hv s)')
    candidate=candidate.replace('(hγ (-t)).comp t (hasDerivAt_neg t)', '(hγ (-t)).comp_hasDerivAt t (hasDerivAt_neg t)')
if route>=2 and key=='VerletOscillatorEnergy':
    candidate=candidate.replace('field_simp','field_simp [ne_of_gt hΩ, ne_of_gt hA]')
    candidate=candidate.replace('simp only [K, verlet, invMass,', 'simp [K, verlet, invMass,')
if route==3 and key=='VerletOscillatorEnergy':
    candidate=candidate.replace('simp [K, verlet, invMass, Pi.add_apply, Pi.smul_apply, smul_eq_mul, inv_one, one_mul]',
        'dsimp [K, verlet, invMass]; simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul, inv_one, one_mul]')
if route==2 and key=='VerletOscillatorEnergy':
    candidate=proofs[key].replace('''  have habs : |(w.1 0)^2-(z.1 0)^2| ≤ 2*E0/(Ω^2*A) := by
    apply abs_le.mpr''','''  have habs : |(w.1 0)^2-(z.1 0)^2| ≤ 2*E0/(Ω^2*A) := by
    rw [mul_div_assoc]
    apply abs_le.mpr''')
if route==3:candidate=candidate.replace('change T+a*S = -T','change T+(-2*T/S)*S = -T').replace('simpa only [hbf]','simpa [hbf]')
if route>=2 and key=='ElasticEnergy':candidate=candidate.replace('field_simp','field_simp [ne_of_gt hS]')
if route==3 and key=='ReversedTrajectory':
    candidate=candidate.replace('(hγ (-t)).comp_hasDerivAt t (hasDerivAt_neg t)',
        '(hγ (-t)).scomp t (hasDerivAt_neg t)')
source=folder/f'{key}-route{route}.lean';log=source.with_suffix('.log')
source.write_text('''import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology ContDiff
noncomputable section
namespace MD.Ch03ShortMore
set_option maxHeartbeats 400000
'''+r['code'].replace('by\n  sorry','by\n  '+candidate)+'\nend MD.Ch03ShortMore\n',encoding='utf-8')
out=subprocess.run(['lake','env','lean',str(source.relative_to(ROOT))],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
log.write_bytes(out.stdout);sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
results.append(dict(route=route,exit_code=out.returncode,proof=candidate if out.returncode==0 else None,
    source=source.relative_to(ROOT).as_posix(),log=log.relative_to(ROOT).as_posix(),source_sha256=sha(source),log_sha256=sha(log)))
state.write_text(json.dumps(results,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(key,'route',route,'exit',out.returncode)
if out.returncode:print(out.stdout.decode('utf-8',errors='replace').encode(sys.stdout.encoding,errors='replace').decode(sys.stdout.encoding)[-3500:])

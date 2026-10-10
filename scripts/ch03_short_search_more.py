"""Bounded routes on current PASS entries; save exact input and compiler output."""
import sys,json,subprocess,hashlib,importlib
from ch03_data import ROOT,BASE,RECORDS
key,route=sys.argv[1],int(sys.argv[2]);assert 1<=route<=3
sections={'EqualComponentIntegral':'35','LinearContinuousIntegral':'35b','ReversedTrajectory':'36','ElasticEnergy':'37'}
importlib.import_module('ch03_section'+sections[key])
r=next(x for x in RECORDS if x['source_id'].endswith('-'+key));assert r['local_verdict']=='PASS'
folder=BASE/'validation/short_search';folder.mkdir(exist_ok=True)
state=folder/(key+'.json');results=json.loads(state.read_text(encoding='utf-8')) if state.exists() else []
if any(x['exit_code']==0 or x['route']==route for x in results):raise SystemExit('Reuse existing route; no repeat.')
proofs={
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
if route==2:candidate=candidate.replace('field_simp','field_simp [ne_of_gt hS]').replace('R.hasFDerivAt','R.hasFDerivAt').replace('simpa only [hbf]','simpa [hbf]')
if route>=2:
    candidate=candidate.replace('(hu s).sub (hv s)', '(hu s).fun_sub (hv s)')
    candidate=candidate.replace('(hγ (-t)).comp t (hasDerivAt_neg t)', '(hγ (-t)).comp_hasDerivAt t (hasDerivAt_neg t)')
if route==3:candidate=candidate.replace('field_simp','field_simp [ne_of_gt hS]').replace('change T+a*S = -T','change T+(-2*T/S)*S = -T').replace('simpa only [hbf]','simpa [hbf]')
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

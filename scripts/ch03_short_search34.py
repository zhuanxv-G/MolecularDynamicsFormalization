"""At most three recorded routes for §3.4 local PASS statements."""
import sys,json,subprocess,hashlib
from ch03_data import ROOT,BASE,RECORDS
import ch03_section34b,ch03_section34c
key,route=sys.argv[1],int(sys.argv[2]);assert 1<=route<=3
r=next(x for x in RECORDS if x['source_id']=='MD-3.4-'+key)
assert r['local_verdict']=='PASS'
folder=BASE/'validation/short_search';folder.mkdir(exist_ok=True)
state=folder/(key+'.json');results=json.loads(state.read_text(encoding='utf-8')) if state.exists() else []
if any(x['exit_code']==0 or x['route']==route for x in results):raise SystemExit('Reuse existing route; no repeat.')
proofs={
'ExponentialFlat':'''intro γ hγ k
  have ht : Tendsto (fun h : ℝ => γ / h) (𝓝[>] 0) atTop := by
    simpa only [div_eq_mul_inv] using tendsto_inv_nhdsGT_zero.const_mul_atTop hγ
  have hp := ((Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero k).comp ht).div_const (γ^k)
  convert hp using 1
  · ext h
    by_cases hh : h = 0
    · subst h; cases k <;> simp
    · have hg : γ ≠ 0 := ne_of_gt hγ
      simp only [Function.comp_apply, div_pow, neg_div]
      field_simp
  · simp''',
'CommutingEnergySymmetry':'''intro n H K D Φ η hK hD hflow hzero
  have hskew : ∀ z ∈ D, textbookPoissonBracket K H z = 0 := by
    intro z hz
    rw [textbookPoissonBracket_skew, hzero z hz, neg_zero]
  refine ⟨hskew, ?_⟩
  intro z hz t ht
  have hη := hflow.1
  have htraj := hflow.2 z hz
  have hd : ∀ s ∈ Ioo (-η) η, HasDerivAt (fun u => K (Φ u z)) 0 s := by
    intro s hs
    have hks : DifferentiableAt ℝ K (Φ s z) :=
      (hK.differentiableOn (by norm_num)).differentiableAt (hD.mem_nhds (htraj.2 s hs).1)
    simpa only [textbookLieDerivative_hamiltonian_eq_poisson,
      hskew _ (htraj.2 s hs).1] using
      hasDerivAt_textbookLieDerivative (textbookHamiltonianVectorField H) K
        (fun u => Φ u z) s hks (htraj.2 s hs).2
  have heq := isOpen_Ioo.is_const_of_deriv_eq_zero (convex_Ioo (-η) η).isPreconnected
    (fun s hs => (hd s hs).differentiableAt.differentiableWithinAt)
    (fun s hs => (hd s hs).deriv) ht (show (0:ℝ) ∈ Ioo (-η) η by constructor <;> linarith)
  simpa only [htraj.1] using heq'''}
candidate=proofs[key]
if route==2:
    candidate=candidate.replace('hasDerivAt_textbookLieDerivative','MolecularDynamics.hasDerivAt_textbookLieDerivative')
    candidate=candidate.replace('field_simp','field_simp [hh, hg]')
if route==3:
    candidate=candidate.replace('hasDerivAt_textbookLieDerivative','MolecularDynamics.hasDerivAt_textbookLieDerivative')
    candidate=candidate.replace('field_simp','field_simp [hh, hg]; ring')
source=folder/f'{key}-route{route}.lean';log=source.with_suffix('.log')
body=r['code'].replace('by\n  sorry','by\n  '+candidate)
source.write_text('''import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology ContDiff
noncomputable section
namespace MD.Ch03Short34
set_option maxHeartbeats 400000
'''+body+'\nend MD.Ch03Short34\n',encoding='utf-8')
out=subprocess.run(['lake','env','lean',str(source.relative_to(ROOT))],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
log.write_bytes(out.stdout)
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
results.append(dict(route=route,exit_code=out.returncode,proof=candidate if out.returncode==0 else None,
    source=source.relative_to(ROOT).as_posix(),log=log.relative_to(ROOT).as_posix(),source_sha256=sha(source),log_sha256=sha(log)))
state.write_text(json.dumps(results,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(key,'route',route,'exit',out.returncode)
if out.returncode:print(out.stdout.decode('utf-8',errors='replace')[-4000:])

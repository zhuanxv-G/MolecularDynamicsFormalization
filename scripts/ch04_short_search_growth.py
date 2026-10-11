"""Bounded real norm limits, using the checked resonance-power identity."""
import sys,json,hashlib,subprocess
from ch04_data import ROOT,BASE,RECORDS
import ch04_section42extra
key=sys.argv[1]; assert key in ['ResonanceGrowth','ResonanceLinearRate']
folder=BASE/'validation/short_search';state=folder/f'{key}.json'
routes=json.loads(state.read_text(encoding='utf-8')) if state.exists() else []
if any(x['exit_code']==0 for x in routes) or len(routes)>=3: print(key,'saved evidence reused');sys.exit()
route=len(routes)+1
r=next(x for x in RECORDS if x['source_id'].endswith('-'+key));assert r['local_verdict']=='PASS'
linear='''intro Ω hΩ z hz
  let c : ℝ := (Real.pi/Ω)*z 0
  let w : ℕ → Fin 2 → ℝ := fun k => ![z 0/(k : ℝ),z 1/(k : ℝ)-c]
  have ht : Tendsto w atTop (𝓝 (![0,-c] : Fin 2 → ℝ)) := by
    apply tendsto_pi_nhds.mpr
    intro i
    fin_cases i
    · simpa [w] using tendsto_const_div_atTop_nhds_zero_nat (z 0 : ℝ)
    · simpa [w] using (tendsto_const_div_atTop_nhds_zero_nat (z 1 : ℝ)).sub_const c
  have hn : ‖(![0,-c] : Fin 2 → ℝ)‖=|c| := by
    apply le_antisymm
    · apply (pi_norm_le_iff_of_nonneg (abs_nonneg c)).mpr
      intro i
      fin_cases i <;> simp
    · simpa using (norm_le_pi_norm (![0,-c] : Fin 2 → ℝ) 1)
  have he : (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖/(k : ℝ))
      =ᶠ[atTop] fun k => ‖w k‖ := by
    filter_upwards [eventually_gt_atTop (0 : ℕ)] with k hk
    have hk0 : (k : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hk)
    have hp := resonancePower Ω hΩ k
    have hv : (!![1,0; -(k : ℝ)*(Real.pi/Ω),1] : Matrix (Fin 2) (Fin 2) ℝ) *ᵥ z
        = (k : ℝ) • w k := by
      ext i
      fin_cases i <;> simp [Matrix.mulVec,Fin.sum_univ_two,w,c] <;> field_simp <;> ring
    rw [hp,Matrix.smul_mulVec,hv,norm_smul,norm_smul]
    simp [Real.norm_eq_abs,abs_pow,abs_of_nonneg (Nat.cast_nonneg k),hk0]
  exact (ht.norm.congr' he.symm).trans (by simpa [hn,c] using tendsto_id)
'''
growth='''intro Ω hΩ z hz
  have hc : 0 < |(Real.pi/Ω)*z 0| := abs_pos.mpr (mul_ne_zero (div_ne_zero Real.pi_ne_zero (ne_of_gt hΩ)) hz)
  have hr := resonanceLinearRate Ω hΩ z hz
  have ht := hr.pos_mul_atTop hc (tendsto_natCast_atTop_atTop (R := ℝ))
  apply ht.congr'
  filter_upwards [eventually_gt_atTop (0 : ℕ)] with k hk
  have hk0 : (k : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hk)
  exact div_mul_cancel₀ _ hk0
'''
candidate=linear if key=='ResonanceLinearRate' else growth
if route==2:
    candidate=candidate.replace('exact (ht.norm.congr\' he.symm).trans (by simpa [hn,c] using tendsto_id)',
        "simpa only [hn,c] using (ht.norm.congr' he.symm)")
    candidate=candidate.replace('field_simp <;> ring','field_simp [hk0] <;> ring')
    candidate=candidate.replace('Matrix.mulVec,Fin.sum_univ_two,w,c','Matrix.mulVec,Matrix.dotProduct,Fin.sum_univ_two,Pi.smul_apply,smul_eq_mul,w,c')
    candidate=candidate.replace('Nat.cast_nonneg k','(Nat.cast_nonneg k : (0 : ℝ) ≤ (k : ℝ))')
if route==3:
    candidate=candidate.replace('exact (ht.norm.congr\' he.symm).trans (by simpa [hn,c] using tendsto_id)',
        "simpa only [hn,c] using (ht.norm.congr' he.symm)")
    candidate=candidate.replace('field_simp <;> ring','field_simp [hk0] <;> ring')
    candidate=candidate.replace('Matrix.mulVec,Fin.sum_univ_two,w,c','Matrix.mulVec,dotProduct,Fin.sum_univ_two,Pi.smul_apply,smul_eq_mul,w,c')
    candidate=candidate.replace('Nat.cast_nonneg k','(Nat.cast_nonneg k : (0 : ℝ) ≤ (k : ℝ))')
power=json.loads((folder/'ResonancePower.json').read_text(encoding='utf-8'))
pr=next(x for x in power if x['exit_code']==0)
ps=(ROOT/pr['source']).read_text(encoding='utf-8');helper=ps[ps.index('theorem resonancePower'):ps.index('\nend MD.Ch04Resonance')]
if key=='ResonanceGrowth':
    successful=json.loads((folder/'ResonanceLinearRate.json').read_text(encoding='utf-8'))
    lr=next(x for x in successful if x['exit_code']==0)
    ls=(ROOT/lr['source']).read_text(encoding='utf-8')
    helper+='\n'+ls[ls.index('theorem resonanceLinearRate'):ls.index('\nend MD.Ch04Growth')]
src=folder/f'{key}-route{route}.lean';log=src.with_suffix('.log')
src.write_text('''import MolecularDynamics.Chapter04.Statements
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter04Review
open scoped BigOperators Topology Matrix.Norms.Elementwise
noncomputable section
namespace MD.Ch04Growth
set_option maxHeartbeats 400000
'''+helper+'\n'+r['code'].replace('by\n  sorry','by\n  '+candidate)+'\nend MD.Ch04Growth\n',encoding='utf-8')
out=subprocess.run(['lake','env','lean',str(src.relative_to(ROOT))],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT);log.write_bytes(out.stdout)
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
routes.append(dict(route=route,exit_code=out.returncode,proof=candidate if out.returncode==0 else None,source=src.relative_to(ROOT).as_posix(),log=log.relative_to(ROOT).as_posix(),source_sha256=sha(src),log_sha256=sha(log)))
state.write_text(json.dumps(routes,ensure_ascii=False,indent=2)+'\n',encoding='utf-8');print(key,route,out.returncode)
if out.returncode:print(out.stdout.decode('utf-8',errors='replace')[-4000:])

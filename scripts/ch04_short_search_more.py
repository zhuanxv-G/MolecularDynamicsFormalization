"""Bounded independent short routes; immutable source/log evidence, at most 3 per item."""
import sys,json,hashlib,subprocess
from ch04_data import ROOT,BASE,RECORDS
import ch04_section41,ch04_section43,ch04_section43a,ch04_section44b,ch04_section441b
key=sys.argv[1]
record=next(r for r in RECORDS if r['source_id'].endswith('-'+key))
assert record['local_verdict']=='PASS'
folder=BASE/'validation/short_search';folder.mkdir(parents=True,exist_ok=True)
state=folder/f'{key}.json';routes=json.loads(state.read_text(encoding='utf-8')) if state.exists() else []
if any(r['exit_code']==0 for r in routes) or len(routes)>=3:print(key,'saved evidence reused');sys.exit()
ns='MolecularDynamics.Chapter04Review.'
proofs={
'ModifiedFrequencyLimit':'''intro Ω
  have hd : HasDerivAt (fun h : ℝ => 2*Real.arctan (h*Ω/2)) Ω 0 := by
    convert (((hasDerivAt_id (0 : ℝ)).mul_const Ω).div_const 2).arctan.const_mul 2 using 1 <;> norm_num
  simpa [MolecularDynamics.Chapter04Review.modifiedFrequency,smul_eq_mul,div_eq_mul_inv,mul_comm] using hd.tendsto_slope_zero''',
'ConstraintDegrees':'''intro n l g q hg hs
  have hh := LinearMap.finrank_ker_add_finrank_range (fderiv ℝ g q).toLinearMap
  rw [LinearMap.range_eq_top.mpr hs] at hh
  simpa using hh''',
'TimeConstraintDerivative':'''intro n l g q t v hg hq hz
  have hd := hg.hasFDerivAt.comp_hasDerivAt t (hq.prodMk (hasDerivAt_id t))
  have hzero : HasDerivAt (fun s => g (q s) s) (0 : Fin l → ℝ) t :=
    (hasDerivAt_const t (0 : Fin l → ℝ)).congr_of_eventuallyEq hz.symm
  exact hd.unique hzero''',
'CrossMatrix':f'''intro u v
  ext i
  fin_cases i <;> simp [{ns}skewMatrix,{ns}cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring''',
'PoissonDegeneracy':f'''intro π
  ext i
  fin_cases i <;> simp [{ns}rigidPoissonMatrix,{ns}skewMatrix,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring'''
}
candidate=proofs[key]
route=len(routes)+1
if route>1:
    if key=='ConstraintDegrees':candidate='''intro n l g q hg hs
  have hh := LinearMap.finrank_range_add_finrank_ker (fderiv ℝ g q).toLinearMap
  rw [LinearMap.range_eq_top.mpr hs] at hh
  simpa [add_comm] using hh'''
    if key=='TimeConstraintDerivative':candidate='''intro n l g q t v hg hq hz
  have hp : HasDerivAt (fun s => (q s,s)) (v,1) t := hq.prodMk (hasDerivAt_id t)
  have hd : HasDerivAt (fun s => g (q s) s)
      ((fderiv ℝ (Function.uncurry g) (q t,t)) (v,1)) t :=
    hg.hasFDerivAt.comp_hasDerivAt t hp
  have hzero : HasDerivAt (fun s => g (q s) s) (0 : Fin l → ℝ) t :=
    (hasDerivAt_const t (0 : Fin l → ℝ)).congr_of_eventuallyEq hz.symm
  exact hd.unique hzero'''
    if key=='ModifiedFrequencyLimit':candidate='''intro Ω
  have hd : HasDerivAt (fun h : ℝ => 2*Real.arctan (h*Ω/2)) Ω 0 := by
    convert (((hasDerivAt_id (0 : ℝ)).mul_const Ω).div_const 2).arctan.const_mul 2 using 1 <;> norm_num <;> ring
  convert hd.tendsto_slope_zero using 1
  funext t
  simp [MolecularDynamics.Chapter04Review.modifiedFrequency,smul_eq_mul,div_eq_mul_inv]
  ring'''
src=folder/f'{key}-route{route}.lean';log=src.with_suffix('.log')
src.write_text('''import MolecularDynamics.Chapter04.Statements
import Mathlib.Analysis.Calculus.Deriv.Slope
import Mathlib.Analysis.SpecialFunctions.Trigonometric.ArctanDeriv
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter04Review
open scoped BigOperators Topology ContDiff Matrix.Norms.Elementwise
noncomputable section
namespace MD.Ch04More
set_option maxHeartbeats 400000
'''+record['code'].replace('by\n  sorry','by\n  '+candidate)+'\nend MD.Ch04More\n',encoding='utf-8')
out=subprocess.run(['lake','env','lean',str(src.relative_to(ROOT))],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
log.write_bytes(out.stdout);sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
routes.append(dict(route=route,exit_code=out.returncode,proof=candidate if out.returncode==0 else None,source=src.relative_to(ROOT).as_posix(),log=log.relative_to(ROOT).as_posix(),source_sha256=sha(src),log_sha256=sha(log)))
state.write_text(json.dumps(routes,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(key,route,out.returncode)
if out.returncode:print(out.stdout.decode('utf-8',errors='replace').encode(sys.stdout.encoding,errors='replace').decode(sys.stdout.encoding)[-2400:])

"""Bounded new algebra route for the repaired general oscillator statement."""
import json,re,sys
from integrate_website_returns import ROOT,sha,read,dump
from eaudit_review_tasks import declarations,build
from prepare_ch03_eaudit01 import SIDS,CODES
from local_compile import compile_recorded
BASE=ROOT/'blueprint/ch03';FOLDER=BASE/'validation/EAUDIT01/short_energy';FOLDER.mkdir(parents=True,exist_ok=True)
routes_path=FOLDER/'ROUTES.json';routes=read(routes_path) if routes_path.exists() else []
if any(r['exit_code']==0 for r in routes) or len(routes)>=3:print('Saved energy routes reused.');raise SystemExit()
proof='''intro Ω h hΩ hh
  have hh2 : 0 < h^2 := sq_pos_of_ne_zero hh
  have hΩ2 : 0 < Ω^2 := sq_pos_of_ne_zero hΩ.ne'
  have hc : h^2*Ω^2/2 ≠ 0 := (div_pos (mul_pos hh2 hΩ2) (by norm_num : (0 : ℝ)<2)).ne'
  have hdelta : ∀ z : ℝ × ℝ,
      oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z)-oscillatorEnergy Ω z =
        (h^2*Ω^2/2)*(Ω^2*(z.1+h*z.2)^2-z.2^2) := by
    intro z
    simp only [oscillatorEnergy,oscillatorAdjointEuler]
    ring
  refine ⟨hdelta,?_,?_⟩
  · intro z
    rw [← sub_eq_zero,hdelta z,mul_eq_zero]
    simp only [hc,false_or]
    have he : Ω^2*(z.1+h*z.2)^2=(Ω*(z.1+h*z.2))^2 := by ring
    rw [he,sub_eq_zero]
    exact sq_eq_sq_iff_eq_or_eq_neg
  · refine ⟨(1,0),?_⟩
    intro heq
    have hd := hdelta (1,0)
    rw [heq,sub_self] at hd
    norm_num at hd
    have hp : 0 < h^2*Ω^2/2*Ω^2 := mul_pos (div_pos (mul_pos hh2 hΩ2) (by norm_num)) hΩ2
    linarith'''
if routes:
 revised=FOLDER/'NEXT_PROOF.txt';assert revised.exists();proof=revised.read_text(encoding='utf-8')
number=len(routes)+1;code=CODES[SIDS[1]].replace('by\n  sorry','by\n  '+proof)
source=FOLDER/f'route{number}.lean';source.write_text('''import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter MolecularDynamics MolecularDynamics.Chapter03Review
open scoped Topology
namespace MD.Ch03EAUDIT
'''+code+'\nend MD.Ch03EAUDIT\n',encoding='utf-8')
log=FOLDER/f'route{number}.log';receipt=FOLDER/f'route{number}-COMPILE.json'
r,output,reused=compile_recorded(['lake','env','lean',str(source.relative_to(ROOT))],ROOT,source,log,receipt,reuse_failure=True)
routes.append(dict(route=number,exit_code=r['exit_code'],proof=proof if r['exit_code']==0 else None,
 source=source.relative_to(ROOT).as_posix(),source_sha256=sha(source),log=log.relative_to(ROOT).as_posix(),log_sha256=sha(log)))
dump(routes_path,routes)
if r['exit_code']:
 print(output.decode('utf-8',errors='replace'));raise SystemExit(r['exit_code'])
lean=ROOT/'Blueprint/Ch03.lean';ds=declarations(3);text=lean.read_text(encoding='utf-8-sig')
assert text.count(ds[SIDS[1]]['block'])==1;text=text.replace(ds[SIDS[1]]['block'],code,1);lean.write_text(text,encoding='utf-8')
overrides=read(BASE/'website_signature_overrides.json');overrides[SIDS[1]]['code']=code;dump(BASE/'website_signature_overrides.json',overrides)
prep_path=BASE/'mathcopilot_results/EAUDIT01_PREPARATION.json';prep=read(prep_path)
history=BASE/'validation/EAUDIT01/PREPARATION_DRAFT_BEFORE_ENERGY_PROOF.json'
if not history.exists():dump(history,prep)
tasks=build(3,'EAUDIT01','3–3.1',SIDS)
prep.update(lean_sha256=sha(lean),compact_bytes=[s['total_bytes'] for s in tasks['subtasks']],energy_proof_receipt=routes_path.relative_to(ROOT).as_posix())
dump(prep_path,prep);web=read(BASE/'website_audit.json')
for w in web:
 if w['source_id'] in SIDS:w['repair']['input_sha256']=tasks['input_sha256']
dump(BASE/'website_audit.json',web)
print('General energy difference, exceptional lines and nonconservation witness PASS; current packages rebound to the final local proof snapshot.')

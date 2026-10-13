"""Second routes based on the saved section 5.6 compiler diagnostics."""
from pathlib import Path
from ch05_short_candidates import proofs
folder=Path(__file__).resolve().parents[1]/'blueprint/ch05/validation/short_search'
ns='MolecularDynamics.Chapter05Review.'
for key in ['ModifiedLiouvillian','SymplecticEulerEllipse','SymplecticEulerDensity','EulerLogCorrespondence']:
    proof=proofs[key]
    if key=='ModifiedLiouvillian':
        needle='    rw [((hf z).hasFDerivAt.add'
        proof=proof.replace(needle,'    change LinearMap.trace ℝ ('+ns+'E n)\n      (fderiv ℝ (f+(h^r) • fr) z).toLinearMap=_\n'+needle)
    elif key=='SymplecticEulerEllipse':
        proof=proof.replace('    have hle : ‖z‖^2','    change '+ns+'shadowOscillator h z ≤ c at hz\n    have hle : ‖z‖^2')
    elif key=='SymplecticEulerDensity':
        proof=proof.replace('Matrix.mulVec,Fin.sum_univ_two,','Matrix.mulVec,Matrix.vecHead,Matrix.vecTail,Fin.sum_univ_two,')
    else:
        proof=proof.replace('by field_simp [hn];ring','by field_simp [hn] <;> ring')
        proof=proof.replace('all_goals field_simp <;> nlinarith [Real.sq_sqrt hp.le]',
            'all_goals field_simp [hs] <;> simp only [Real.sq_sqrt hp.le] <;> ring')
        proof=proof.replace('convert hq using 1 <;> simp [mul_comm] <;> ring',
            'convert hq using 1 <;> first | (funext s; simp; ring) | (simp; ring)')
        proof=proof.replace('convert hp using 1 <;> simp [mul_comm] <;> ring',
            'convert hp using 1 <;> first | (funext s; simp; ring) | (simp; ring)')
    (folder/(key+'-next-proof.txt')).write_text(proof,encoding='utf-8')
    print('Prepared second route:',key)

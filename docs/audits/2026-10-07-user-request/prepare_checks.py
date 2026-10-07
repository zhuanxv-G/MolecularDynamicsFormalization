from pathlib import Path
import json,re,random,unicodedata,hashlib
OUT=Path(__file__).resolve().parent
ROOT=OUT.parents[2]
data=json.loads((OUT/'declarations.json').read_text(encoding='utf-8'))
targets={
1:['strictPotentialMin_futureStableEuclidean_of_smooth','mechanical_energy_const_on_Ioo','exists_globalMechanicalIVP_of_energy_barrier'],
2:['theorem_2_1_euler','oneStepMaxError_order_bound','textbookSymplecticEulerEquiv_isSymplectic'],
3:['textbookPoissonBracket_jacobi','exists_uniform_textbookTruncatedHamiltonian_remainder','textbook_energy_drift_rate_of_flow_defect'],
4:['lemma_4_1','textbookCotangentProjection_hiddenConstraint','textbookConstrainedFlow_pullback_constant_of_mass_and_independence'],
6:['proposition_6_1','textbookWienerQuadraticSum_meanSquare_tendsto','textbookWienerDeterministicIto_proposition63'],
7:['textbookInvariantDistributionSwap','textbookSymmetricModifiedGenerator_logarithm','textbookSymmetricModifiedGenerator_odd_coeff_zero'],
8:['textbookThermostats_additive_proposition81','textbookThermostatFamily_linearIndependent','textbookNHL_hormander_physicalNoise']}
lookup={d['name']:d for d in data}
names=[n for ns in targets.values() for n in ns]
missing=[n for n in names if n not in lookup]
if missing: raise ValueError(missing)
(OUT/'SelectedAxioms.lean').write_text('import MolecularDynamicsFormalization\n\n'+'\n'.join('#print axioms MolecularDynamics.'+n for n in names)+'\n',encoding='utf-8')
(OUT/'selected-theorems.json').write_text(json.dumps([{**lookup[n],'qualified_name':'MolecularDynamics.'+n} for n in names],ensure_ascii=False,indent=2),encoding='utf-8')
completed=[
('Theorem 1.1','strictPotentialMin_futureStableEuclidean_of_smooth',55,32),
('Theorem 2.1','theorem_2_1_euler',78,56),
('Lemma 4.1','lemma_4_1',181,159),
('Proposition 6.1','proposition_6_1',243,222),
('Proposition 6.2','textbookWienerQuadraticSum_meanSquare_tendsto',250,229),
('Proposition 6.3','textbookWienerDeterministicIto_proposition63',252,231),
('Lemma 6.1','textbookLangevinPeriodicGlobalRandomSolution_physicalNoise_exists_open_pos',276,255),
('Lemma 7.1','textbookInvariantDistributionSwap',320,299),
('Proposition 8.1','textbookThermostats_additive_proposition81',359,338),
('Proposition 8.2','textbookThermostatPhysical_hormander',365,344),
('Theorem 8.1','textbookNHL_hormander_physicalNoise',367,346),
('Lemma 8.1','textbookThermostat_C_D_mem_lieSpan',368,347),
('Proposition 8.3','textbookThermostatFamily_linearIndependent',368,347)]
sample=random.Random(20261007).sample(completed,5)
pages=json.loads((OUT/'pdf-pages.json').read_text(encoding='utf-8'))
out=[]
for label,n,pdf,printed in sample:
    d=lookup[n]; src=(OUT/'snapshot'/d['file']).read_text(encoding='utf-8')
    start=re.search(r'^theorem\s+'+re.escape(n)+r'\b',src,re.M).start()
    end=src.find(':= by',start)
    statement=src[start:end].strip()
    out.append({**d,'label':label,'pdf_page':pdf,'printed_page':printed,'lean_statement':statement,'page_text':pages[pdf-1]['text']})
(OUT/'random-five.json').write_text(json.dumps({'seed':20261007,'population':[x[0] for x in completed],'sample':out},ensure_ascii=False,indent=2),encoding='utf-8')
norm=[]
for x in pages:
    t=unicodedata.normalize('NFKC',x['text'])
    for m in re.finditer(r'(?m)^\s*(Definition|Theorem|Lemma|Proposition|Corollary)\s+(\d+)\.(\d+)\b',t):
        norm.append({'kind':m[1],'chapter':int(m[2]),'number':int(m[3]),'pdf_page':x['pdf_page'],'context':t[m.start():m.start()+650]})
(OUT/'pdf-numbered-normalized.json').write_text(json.dumps(norm,ensure_ascii=False,indent=2),encoding='utf-8')
u={}
for x in norm:u.setdefault((x['kind'],x['chapter'],x['number']),[]).append(x['pdf_page'])
(OUT/'pdf-numbered-unique-normalized.json').write_text(json.dumps([{'kind':k[0],'chapter':k[1],'number':k[2],'pages':v} for k,v in sorted(u.items(),key=lambda x:(x[0][1],x[0][0],x[0][2]))],ensure_ascii=False,indent=2),encoding='utf-8')
print('AXIOM_TARGETS',len(names));print('SAMPLE',[(x['label'],x['name'],x['pdf_page']) for x in out]);print('NUMBERED',len(u))

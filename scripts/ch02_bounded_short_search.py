"""Three bounded local routes for still-open, short algebra/calculus obligations.

This produces isolated candidates importing only the unchanged formal library.
It cannot 'prove' a goal by using a Blueprint declaration containing sorry.
Successful candidates are eligible for integration only after semantic review.
"""
import sys,re,json
from ch02_data import ROOT,BASE,RECORDS
import ch02_section24,ch02_section25
round_no=int(sys.argv[1])
target_keys=['DiscreteDerivative','DiscreteVerlet','VerletStability','KickDifferential',
    'AsymmetricJacobian','AsymmetricArea','CompositionOrder','FrozenNewton',
    'PartitionedReduction','NewmarkDamping']
selected=[r for r in RECORDS if r['source_id'].split('-')[-1] in target_keys]
selected=[r for r in selected if r['local_verdict']=='PASS' and re.search(r'\bsorry\b',r['code'])]
header=(ROOT/'Blueprint/Ch02.lean').read_text(encoding='utf-8').split('/-- source_id:')[0]
header=header.replace('namespace MD.Ch02','namespace MD.Ch02.ShortSearch')
code=[header];lines={}
for r in selected:
    signature=r['code'].split(' := by')[0]
    # Signature qualification uses only genuine existing definitions.
    route={1:'  intros\n  exact?',2:'  intros\n  aesop',3:'  intros\n  simp_all [verlet, invMass, mass, partialQ, partialP, discreteStationary,\n    stormerRelation, newtonStep, generalSymplecticEulerRelation, partitionedVerletRelation,\n    textbookCoordinateJacobian, Matrix.det_fin_two] <;> try ring_nf <;> try aesop'}[round_no]
    start=''.join(code).count('\n')+1
    block='set_option maxHeartbeats 2000 in\n'+signature+' := by\n'+route+'\n\n'
    code.append(block);lines[r['source_id']]=dict(start=start,end=start+block.count('\n')-1)
code.append('end MD.Ch02.ShortSearch\n')
path=BASE/'validation'/f'ShortSearch{round_no}.lean'
path.write_text(''.join(code),encoding='utf-8')
(BASE/'validation'/f'short-search{round_no}-mapping.json').write_text(json.dumps(lines,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(path.relative_to(ROOT))

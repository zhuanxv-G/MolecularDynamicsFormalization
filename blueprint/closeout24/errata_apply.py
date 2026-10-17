from common import *
from errata_corrections import correction
from local_compile import compile_recorded

def candidates(ch):
 cs=load(OUT/f'ch{ch:02}/ERRATA_CANDIDATES.json')
 # These NH verdicts concern omitted cross-reference excerpts, not textbook errata.
 local_excerpt_only={'MD-4.2.1-FastVerlet','MD-4.3.5.1-ConstrainedComposition',
   'MD-5.2.2-DivergenceCoordinates','MD-5.2.2-LiouvilleProduct'}
 cs=[c for c in cs if c['source_id'] not in local_excerpt_only]
 # The A transcription review can flag a book problem even when C approves the qualified Lean signature.
 a_book={2:['MD-2.3.7-Adjoint'],
  3:['MD-3.3.2-ModifiedEven','MD-3.4-TruncatedConservation','MD-3.4-EnergyTelescoping',
   'MD-3.4-UniformTruncatedLipschitz','MD-3.4-PhysicalEnergyDrift',
   'MD-3.6.1-ReversedTrajectoryPrinted','MD-3.6.1-ReversedTrajectory',
   'MD-3.6.2-AffineInvariant','MD-3.6.2-SymmetricAffineReversible'],
  4:['MD-4-VerletStability','MD-4-SymplecticEulerUnitRoots','MD-4-SymplecticEulerStability',
   'MD-4.1-PrintedImplicitRelation','MD-4.1-ImplicitModulus','MD-4.2.1-ResonanceTaylor','MD-4.4.2-DLMPrinted'],
  5:['MD-5.2.1-L2Norm','MD-5.2.2-OutwardNormal','MD-5.2.2-GeneralFluxBalance',
   'MD-5.3.2-ShellWeakLimitCorrected','MD-5.4.1-ErgodicTimeEquivalence',
   'MD-5.4.1-TwoOscillatorEnergyDecomposition','MD-5.5-Correlation','MD-5.5-CorrelationTimeAE']}
 for sid in a_book.get(ch,[]):
  if not any(c['source_id']==sid for c in cs):cs.append(dict(source_id=sid,old=False,new=True,a_book_issue=True))
 extras={3:['MD-3.4-ScalarVerletShadow4'],4:['MD-4.3.2-ProjectionScale','MD-4.3.3-ComponentSweep'],5:['MD-5.3.3-LowerDimensionNull']}
 repairs=load(OUT/f'ch{ch:02}/REPAIRS.json') if (OUT/f'ch{ch:02}/REPAIRS.json').exists() else []
 for sid in extras.get(ch,[]):
  if sid in groups(ch) and any(r['source_id']==sid and r['exit_code']==0 for r in repairs) and not any(c['source_id']==sid for c in cs):
   cs.append(dict(source_id=sid,old=False,new=True,fail_book_issue=True))
 return cs

def prepare_batch(ch,limit=8):
 dest=OUT/f'ch{ch:02}';manifest=dest/'CORRECTIONS.json'
 done=load(manifest) if manifest.exists() else []
 todo=[c for c in candidates(ch) if c['source_id'] not in {d['source_id'] for d in done}][:limit]
 # Some extra book issues are already handled by the associated FAIL repair.
 for c in todo:
  sid=c['source_id'];text=lean(ch).read_text(encoding='utf-8-sig');g=groups(ch,text)[sid]
  if sid.endswith('-LowerDimensionNull'):
   row=dict(source_id=sid,original_names=[n for n in g['names'] if 'corrected' not in n],corrected_names=[n for n in g['names'] if 'corrected' in n],
     note='本条网站意见已由FAIL修复处理，完整引文保留并独立登记覆盖问题；一般环境零测结论不作无条件能级维数定理。',
     proof_routes=['对应FAIL修复及其逐声明公理日志'],added=False)
  elif sid.endswith('-ScalarVerletShadow4'):
   assert 'scalarVerletShadow4_corrected' in g['names'],'apply its FAIL repair first'
   row=dict(source_id=sid,original_names=[n for n in g['names'] if 'corrected' not in n],
    corrected_names=[n for n in g['names'] if 'corrected' in n],added=False,
    note='保留原印系数及原印匹配声明，独立列修正系数和匹配声明；精确代数核对见SHADOW4_ALGEBRA.json，实际流误差定理未证明。',
    proof_routes=['独立SymPy有限jet代数核对通过','实际流统一余项需缺失Taylor/ODE桥接，未建立大型理论'])
  else:
   code,newname,note,custom,cross=correction(ch,sid)
   # Three short proof routes. A failure falls through to an explicitly recorded placeholder.
   routes=['先检索同签名现成已证桥接；仅可用无占位原声明','直接反身性rfl','现有假设assumption','仅基础化简simp only；未解决则时间盒止']
   code=code.replace(':= by\n  sorry',':= by\n  first\n  | rfl\n  | assumption\n  | solve | simp only\n  | sorry')
   names=re.findall(r'(?m)^(?:@\[[^\]\n]+\]\s*)*(?:(?:noncomputable|private|protected)\s+)*(?:theorem|lemma|def|abbrev)\s+(\w+)',code)
   assert newname in names,(sid,newname,names)
   assert all(n not in {x for v in groups(ch,text).values() for x in v['names']} for n in names),(sid,names)
   insert='\n\n/-- 修正版，对应原文 '+sid+'。改动：'+note+' -/\n'+code+'\n\n'
   text=text[:g['end']]+insert+text[g['end']:]
   text=add_doc(text,sid,'【原书疑误/资格待导师】原文版保留，不证明其有疑的字面断言。独立修正版：'+note)
   lean(ch).write_text(text,encoding='utf-8')
   row=dict(source_id=sid,original_names=g['names'],corrected_names=names,note=note,added=True,proof_routes=routes)
  done.append(row);dump(manifest,done)
  src=load(base(ch)/f'ch{ch:02}_source.json');s=next(s for s in src if s['source_id']==sid)
  s['closeout24_erratum']=row
  s.setdefault('extra_assumptions',[]).append('[ERRATUM?] '+row['note'])
  dump(base(ch)/f'ch{ch:02}_source.json',src)
 if todo:
  refresh_prints(ch)
  print(f'CH{ch:02}: prepared {len(todo)} independent errata records',flush=True)
 return len(todo)

def refresh_prints(ch):
 text=lean(ch).read_text(encoding='utf-8-sig')
 text=re.sub(r'(?m)^#print axioms[^\n]+\n?','',text).rstrip()+'\n'
 names=[n for g in groups(ch,text).values() for n in g['names']]
 text+='\n'+'\n'.join(f'#print axioms MD.Ch{ch:02}.'+n for n in names)+'\n'
 lean(ch).write_text(text,encoding='utf-8')

def finish(ch):
 dest=OUT/f'ch{ch:02}';i=1
 while prepare_batch(ch):
  while (dest/f'errata-{i:02}.json').exists():i+=1
  r,o,_=compile_recorded(['lake','env','lean',f'Blueprint/Ch{ch:02}.lean'],ROOT,lean(ch),dest/f'errata-{i:02}.log',dest/f'errata-{i:02}.json')
  if r['exit_code']:
   print(o.decode('utf-8',errors='replace')[-12000:],flush=True);raise SystemExit(r['exit_code'])
  print(f'CH{ch:02} errata batch {i} compiled with all declaration axiom checks',flush=True)
  i+=1
if __name__=='__main__':finish(int(sys.argv[1]))

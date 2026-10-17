from common import *
def prepare(ch):
 dest=OUT/f'ch{ch:02}'
 if ch==4:
  sid2='MD-4.3.5.1-ConstrainedComposition'
  sid='MD-4.2.1-FastVerlet';text=lean(4).read_text(encoding='utf-8-sig');g=groups(4,text)[sid]
  if 'fastVerlet_kick_drift_kick' not in g['names']:
   code='''

/-- 本地核对网站缺摘录项：动量半kick、位置整drift、动量半kick。 -/
theorem fastVerlet_kick_drift_kick {n : ℕ} (m : Fin n → ℝ)
    (UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) :
    fastVerlet m UF h z =
      let F := fun q => -MolecularDynamics.Chapter04Review.grad UF q
      let pHalf := z.2+(h/2) • F z.1
      let qNew := z.1+h • Chapter02Review.invMass m pHalf
      (qNew,pHalf+(h/2) • F qNew) := by
  let F := fun q => -MolecularDynamics.Chapter04Review.grad UF q
  have hq : z.1+h • Chapter02Review.invMass m z.2+
      (h^2/2) • Chapter02Review.invMass m (F z.1) =
      z.1+h • Chapter02Review.invMass m (z.2+(h/2) • F z.1) := by
    ext i
    simp [Chapter02Review.invMass]
    <;> ring
  dsimp only [fastVerlet, Chapter02Review.verlet]
  change (z.1+h • Chapter02Review.invMass m z.2+(h^2/2) • Chapter02Review.invMass m (F z.1),
    z.2+(h/2) • (F z.1+F (z.1+h • Chapter02Review.invMass m z.2+(h^2/2) • Chapter02Review.invMass m (F z.1)))) = _
  rw [hq]
  apply Prod.ext
  · rfl
  · ext i
    simp [F]
    <;> ring
'''
   text=text[:g['end']]+code+'\n'+text[g['end']:]
   text=add_doc(text,sid,'本地展开Chapter02Review.verlet及invMass，并逐坐标核对为kick(h/2)→drift(h)→kick(h/2)，有独立等式证明；网站仅因摘录缺失未判，不属于原书疑误。')
   # Correct the overstatement in the old explanatory note without adding a branch theorem.
   sid2='MD-4.3.5.1-ConstrainedComposition'
   text=add_doc(text,sid2,'本地已核对constrainedCompositionOrder的完整C³解族、真实受限关系及局部O(h³)声明。circleExample仅为固定步长、存在乘子的非等价位置实例，不主张单值近分支唯一性。该二阶声明尚未证明。')
   lean(4).write_text(text,encoding='utf-8')
  checks={sid:dict(status='local_definition_and_algebra_verified',
    definitions=['MolecularDynamics.Chapter02Review.verlet','MolecularDynamics.Chapter02Review.invMass'],
    definition_file='MolecularDynamics/Chapter02/ReviewDefinitions.lean',definition_sha256=sha(ROOT/'MolecularDynamics/Chapter02/ReviewDefinitions.lean'),
    proof='MD.Ch04.fastVerlet_kick_drift_kick',book_erratum=False,
    conclusion='本地核验通过（网站因摘录缺失未判）；须与本章最终逐声明公理结果共同读取'),
   sid2:dict(status='local_cross_reference_verified',book_erratum=False,
    referenced_source_id='MD-4.3.5.1-ConstrainedCompositionOrder',
    referenced_declaration='MD.Ch04.constrainedCompositionOrder',
    conclusion='完整局部误差阶声明已核对，C³与真实关系/小步长资格齐；声明尚未证明；circleExample不含唯一性。')}
 elif ch==5:
  refs=dict(source_id='MD-5.2.2-LiouvilleProductCoordinates',
   declarations=['MD.Ch05.liouvilleProductCoordinates','MD.Ch05.liouvilleProductCoordinates_evolution'],
   checked_components=['实时间HasDerivAt','ρ·∂ᵢfᵢ','fᵢ·∂ᵢρ','真实流、域不变、概率密度及测度输运前提'],
   conclusion='坐标静态乘积公式已有证明；完整时间PDE声明存在但尚未证明，不把静态辅助引理冒充时间PDE。')
  checks={sid:dict(status='local_cross_reference_verified',book_erratum=False,**refs)
   for sid in ['MD-5.2.2-DivergenceCoordinates','MD-5.2.2-LiouvilleProduct']}
 else:return
 for sid in checks:
  checks[sid]['current_group']=groups(ch)[sid]['code']
 dump(dest/'LOCAL_EXCERPT_CHECKS.json',checks)
 src=load(base(ch)/f'ch{ch:02}_source.json')
 for s in src:
  if s['source_id'] in checks:
   s['closeout24_local_excerpt']=checks[s['source_id']]
   s.setdefault('extra_assumptions',[]).append('[EXTRA] '+checks[s['source_id']]['conclusion'])
   if s['source_id'].endswith('-ConstrainedComposition'):
    s['extra_assumptions']=[v.replace('具体单值近分支实例','固定步长、存在乘子的非等价位置实例') for v in s['extra_assumptions']]
 dump(base(ch)/f'ch{ch:02}_source.json',src)
if __name__=='__main__':prepare(int(sys.argv[1]))

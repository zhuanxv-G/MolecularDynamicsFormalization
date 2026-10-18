from common25 import *
from repair25 import check,replace_group
from collections import Counter
import difflib

def main():
 if not (OUT/'SUPPLEMENT_PREPARED.json').exists():
  before=LEAN.read_text(encoding='utf-8');text=before;notes=[]
  from ch06_errata import SPECS
  for row in load(OUT/'REPAIRS.json'):
   sid=row['source_id'];key=sid.split('-')[-1]
   m=re.search(r'/-- source_id:\s*'+re.escape(sid)+r'(?=\s|·)[\s\S]*?-/',text)
   head=m[0].splitlines()[0].replace('-/','').rstrip()
   if key=='WeightedH1Norm':head=re.sub(r'印刷p\.[^/]+/ PDFp\.\S+', '印刷p.256–257 / PDFp.277–278',head)
   flag='\n[ERRATUM?] 原书疑误、原文版与独立修正版见CH06_ERRATA。' if key in set(SPECS)-{'WeakItoAlias','OULawPrinted','FPDiffusionPrinted'} else ''
   text=text[:m.start()]+head+flag+'\n[EXTRA] 25号：'+row['note']+' -/'+text[m.end():]
  notes.append(dict(source_id=None,note='25条FAIL旧覆盖/资格docstring以当前限定范围替换；旧内容逐字保存在before与各项diff，不保留互相冲突的现行范围声称。'))
  for key in ['OULawPrinted','FPDiffusionPrinted']:
   sid=next(s for s in groups(text) if s.endswith('-'+key));m=re.search(r'/-- source_id:\s*'+re.escape(sid)+r'(?=\s|·)[\s\S]*?-/',text)
   doc=m[0];head=doc.splitlines()[0].replace('-/','').rstrip();note=next(r['note'] for r in load(OUT/'REPAIRS.json') if r['source_id']==sid)
   text=text[:m.start()]+head+'\n[EXTRA] 25号：'+note+' -/'+text[m.end():]
   notes.append(dict(source_id=sid,note='撤销旧docstring对原书错误的归因，历史before/diff保留。'))
  sid=next(s for s in groups(text) if s.endswith('-TimeItoFormula'));code=groups(text)[sid]['code']
  new=code.replace('strictScalarSDE P W X a b x0 → ContDiff ℝ 2 φ →', '''strictScalarSDE P W X a b x0 →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ a w.1 w.2) →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ b w.1 w.2) → ContDiff ℝ 2 φ →''')
  text=replace_group(text,sid,new);notes.append(dict(source_id=sid,note='Time主版和corrected另补C¹系数以保证自然适应连续被积过程的标准局部Itô联系，仍未证明。'))
  # Where a source is a proof/domain error rather than a false formula, preserve its
  # already-correct restricted assertion as an explicitly named independent version.
  keys=['Proposition61','RiemannTags','SelfStratonovichIntegral','BrownianSymmetry','BrownianRealEigenvalue','BrownianClosedSelfAdjoint','BrownianCompactResolvent','ComplexInitialDensity']
  for key in keys:
   sid=next(s for s in groups(text) if s.endswith('-'+key));g=groups(text)[sid];code=g['code'];name=g['names'][0]
   if name+'_corrected' in {n for gg in groups(text).values() for n in gg['names']}:continue
   corrected=re.sub(r'\b(theorem|lemma|def|abbrev)\s+'+re.escape(name)+r'\b',lambda m:m[1]+' '+name+'_corrected',code,count=1)
   corrected='/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/\n'+corrected
   text=replace_group(text,sid,code+'\n\n'+corrected)
   notes.append(dict(source_id=sid,note='补独立'+name+'_corrected；原有正确限定数学子句不撤回，原书证明或无条件说法的疑误另列。'))
  sid=next(s for s in groups(text) if s.endswith('-CylinderForwardPrinted'));code=groups(text)[sid]['code']
  code+='''

/-- 修正版：真正环面×动量圆柱空间的前向表达式，使用周期lift方向导数。
原Euclidean坐标辅助cylinderForwardPrinted_corrected另保留；本定义不声称密度存在。 -/
def cylinderForwardPeriodic_corrected {n r : ℕ}
    (a : textbookLangevinPeriodicPhase n → (Fin n ⊕ Fin n → ℝ))
    (B : Matrix (Fin n ⊕ Fin n) (Fin r) ℝ)
    (ρ : textbookLangevinPeriodicPhase n → ℝ) (x : textbookLangevinPeriodicPhase n) : ℝ :=
  -(∑ i : Fin n ⊕ Fin n, textbookLangevinPeriodicDirectionalDerivative
      (fun y ↦ a y i*ρ y) (textbookLangevinCanonicalCoordinateDirection i) x) +
    (∑ j : Fin r, ∑ i : Fin n ⊕ Fin n, ∑ k : Fin n ⊕ Fin n,
      B i j*B k j*textbookLangevinPeriodicDirectionalDerivative
        (textbookLangevinPeriodicDirectionalDerivative ρ (textbookLangevinCanonicalCoordinateDirection k))
        (textbookLangevinCanonicalCoordinateDirection i) x)/2
'''
  text=replace_group(text,sid,code);notes.append(dict(source_id=sid,note='新增圆柱空间周期lift版本，Printed保留原φ及1/2；Euclidean corrected仅作坐标辅助。'))
  LEAN.write_text(text,encoding='utf-8');dump(OUT/'SUPPLEMENT_PREPARED.json',notes)
  (OUT/'SUPPLEMENT.diff').write_text(''.join(difflib.unified_diff(before.splitlines(True),text.splitlines(True),fromfile='before',tofile='after')),encoding='utf-8')
 else:notes=load(OUT/'SUPPLEMENT_PREPARED.json')
 receipt=check('SUPPLEMENT-final');dump(OUT/'SUPPLEMENT_REPAIRS.json',dict(items=notes,receipt=receipt))
if __name__=='__main__':main()

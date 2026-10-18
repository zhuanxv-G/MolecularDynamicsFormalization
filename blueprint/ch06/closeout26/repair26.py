from common26 import *
import difflib,time
from lsp26 import compile_text

def replace_group(text,sid,new):
 g=groups(text)[sid];raw=text[g['body_start']:g['end']]
 assert g['code'] in raw
 return text[:g['body_start']]+raw.replace(g['code'],new,1)+text[g['end']:]

def check(label):
 folder=OUT/'compiled';folder.mkdir(exist_ok=True)
 while True:
  text=LEAN.read_text(encoding='utf-8');digest=sha(LEAN)
  names=re.findall(r'(?m)^(?:@\[[^\]\n]+\]\s*)*(?:(?:noncomputable|private|protected)\s+)*(?:theorem|lemma|def|abbrev)\s+(\w+)',text)
  probe=folder/(label+'.lean');probe.write_text(text+'\n'+'\n'.join('#print axioms MD.Ch06.'+n for n in names)+'\n',encoding='utf-8')
  saved=folder/(label+'.json');log=folder/(label+'.log')
  receipt=load(saved) if saved.exists() and log.exists() else {}
  if not (receipt.get('exit_code')==0 and receipt.get('input_sha256')==sha(probe) and receipt.get('log_sha256')==sha(log)):
   receipt=compile_text(probe.read_text(encoding='utf-8'),label,probe)
  if receipt['exit_code']==0:break
  dump(OUT/'REPAIR_WAITING.json',dict(label=label,canonical_sha256=digest,status='awaiting local correction',receipt=receipt))
  print('WAITING for source correction',label,flush=True)
  while sha(LEAN)==digest:time.sleep(2)
  # Preserve the failed compiler run before checking the corrected text.
  for p in folder.glob(label+'*'):
   if p.is_file():
    dst=folder/'failures'/str(receipt['version'])/p.name;dst.parent.mkdir(parents=True,exist_ok=True);dst.write_bytes(p.read_bytes())
 dump(folder/(label+'-binding.json'),dict(receipt,canonical_sha256=sha(LEAN),declarations=names))
 dump(OUT/'REPAIR_WAITING.json',dict(label=label,status='passed'))
 print(label,'single-file +',len(names),'axioms PASS',flush=True)
 return receipt

def repair(item,text):
 sid=item['source_id'];key=sid.split('-')[-1];code=groups(text)[sid]['code'];new=code;gaps=[]
 if key=='FPEquation':
  new=code.replace('ContDiff ℝ ∞ (Function.uncurry ρ) →','ContDiffOn ℝ ∞ (Function.uncurry ρ) {z : ℝ × ℝ | 0 < z.1} →')
  note='密度联合光滑性只要求在(0,∞)×ℝ，保留确定初态及正时刻密度；不再要求密度跨t=0光滑。严格网格积分解到通常适应Itô解的桥接仍未证明，PDE结论不当作前提。'
  gaps=['严格网格积分关系到通常适应Itô解、以及一般Fokker–Planck推导尚缺证明；不将单文件编译当作这些桥接已完成。']
 elif key=='Theorem61':
  new=code.replace('theorem theorem61Printed :','theorem theorem61ClosedRealizationExcerpt :')
  new=new.replace('【原书疑误】Theorem6.1三款并列，保留严格负定及(5.6)轨道时间平均；闭算子实现与质量Laplacian歧义另列，不证明此版。','【限定摘录，非原域字面版】保留严格负定及(5.6)轨道时间平均的疑误，但算子为闭Gibbs复L²实现；不把另列质量表达式当成本声明的算子，不证明此版。')
  new=new.replace('按p.244既定ΔM=Σmi∂ii逐字代入Theorem6.1的形式表达；不宣称它是Brownian过程生成元。','在ΔM=Σmi∂ii这一记号解释下的条件性代数表达；原页记号尚待核定，不宣称它是整个原定理或Brownian过程生成元。')
  note='主版与_corrected保持网站已通过的闭实现/分布平均签名。旧theorem61Printed改名theorem61ClosedRealizationExcerpt，明确只是闭实现限定摘录，不能冒称C₀²原域及原ΔM生成元的整条字面实现。分布平均与轨道时间平均冲突、negative definite措辞保留为原书疑误。'
  gaps=['原C₀²域及原ΔM生成元对应的整条字面形式化未提供；独立质量表达式不补足此联系。','ΔM既定含义仍需核原页；闭实现限定摘录不作为该原域解释的签核。','严格负定与几乎处处轨道时间平均的固定指数界不作为成立结论。']
 elif key=='Theorem62':
  original,printed=code.split('theorem theorem62Printed :',1)
  anchor='''        Integrable (MolecularDynamics.Chapter06Review.kernelGenerator K f) μ →'''
  guards='''        (∀ x, HasDerivWithinAt
          (fun t : ℝ ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x)
          (MolecularDynamics.Chapter06Review.kernelGenerator K f x) (Ici 0) 0) →
        (∃ ε : ℝ, 0 < ε ∧ ∃ bound : D → ℝ, Integrable bound μ ∧
          ∀ t ∈ Ioo (0 : ℝ) ε, ∀ x,
            |(MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x-f x)/t| ≤ bound x) →
'''
  assert printed.count(anchor)==1
  new=original+'theorem theorem62Printed :'+printed.replace(anchor,guards+anchor)
  note='原文两处k按网站逐页核对改回κ（转录纠正）。Printed的弱平稳测试补主版同样的真实右导数及局部可积差商支配，排除derivWithin默认值；保留原[0,∞)连续密度端点疑误，阈值统一性和全部结论量词不变。'
  gaps=['原Assumption 1(ii)在t=0要求连续密度的疑误保留；Printed含明确的实际生成元测试资格，并非无技术前提的整条字面翻译。']
 elif key=='Lemma61Printed':
  new=code.replace('(γ σ : ℝ) (T : ℝ≥0) (hT : (0 : ℝ) < T)\n    (hσ : σ ≠ 0)', '(γ θ : ℝ) (hγ : 0 < γ) (hθ : 0 < θ)\n    (T : ℝ≥0) (hT : (0 : ℝ) < T)')
  new=new.replace('hF γ σ T x C','hF γ (Real.sqrt (2*γ*θ)) T x C')
  note='kind恢复编号lemma；Printed收回原(6.47)正摩擦γ>0及物理噪声σ=√(2γθ)、θ=kBT>0的参数域，保留所有开集（包括空集）的原断言。任意实γ/非零σ的推广只留在非空修正版；漏C.Nonempty是原书疑误，不证明Printed。'
  gaps=['原书漏非空目标；Printed忠实保留空集漏洞。']
 elif key=='WeightedH1Norm':
  new+='''

/-- 原文第一式：实标量L²范数平方等于平方积分。 -/
theorem weightedL2NormScalar26 {D : Type*} [MeasurableSpace D]
    (μ : Measure D) (f : Lp ℝ 2 μ) :
    ‖f‖ ^ 2 = ∫ x, (f x) ^ 2 ∂μ := by
  sorry

/-- 原文第二式：任意欧氏向量值L²函数的分量均属L²，范数平方为分量平方和。 -/
theorem weightedL2NormVector26 {D : Type*} [MeasurableSpace D] {Nc : ℕ}
    (μ : Measure D) (w : D → EuclideanSpace ℝ (Fin Nc)) (hw : MemLp w 2 μ) :
    ∃ hc : ∀ i : Fin Nc, MemLp (fun x ↦ w x i) 2 μ,
      ‖hw.toLp w‖ ^ 2 = ∑ i : Fin Nc, ‖(hc i).toLp (fun x ↦ w x i)‖ ^ 2 := by
  sorry
'''
  note='保留已证H¹ jet范数分解为辅助；新增原文实标量L²平方积分式及任意欧氏向量值L²函数的分量范数平方和两条独立短陈述。新增陈述的证明状态单列，不用辅助等式代替原文两式。'
 elif key=='KernelEvolution':
  note='本source_id仅登记两个核作用于测度的辅助定义；hK要求真实Markov半群，但不因此提供特定Langevin前向密度或指数算子识别。明确原式尚未由本条形式化，缺口继续保留。'
  gaps=['特定Langevin核与前向密度半群的识别、ρt dω=Kt∘ₘ(ρ0 dω)及e^{tL†}解释未由本条给出。']
 elif key=='KernelAverage':
  new+='''

/-- 原句的两种平均相等：明确初始/演化分布及可积资格。 -/
theorem kernelAverage_distributionIdentity26 {D : Type*} [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ0 μt : Measure D) (t : ℝ≥0) (f : D → ℝ)
    (hμ0 : IsProbabilityMeasure μ0) (hK : IsMarkovKernel (K t))
    (hμt : μt = K t ∘ₘ μ0) (hf : Measurable f) (hi : Integrable f μt) :
    (∫ x, f x ∂μt) = ∫ x, kernelAverage K f t x ∂μ0 := by
  subst μt
  letI : IsProbabilityMeasure μ0 := hμ0
  letI : IsMarkovKernel (K t) := hK
  unfold kernelAverage
  rw [Measure.comp_eq_comp_const_apply]
  apply Kernel.integral_comp
  simpa only [← Measure.comp_eq_comp_const_apply] using hi
'''
  note='保留kernelAverage总化辅助记号；新增实际分布平均恒等式，显式量化μ0、μt、μt=Kt∘ₘμ0、概率/Markov资格以及f可测可积，不再仅引用未随本条送审的KernelDuality名称。'
 elif key=='SmoothTestL2Printed':
  note='恢复原文完整末句。Printed仅保留光滑蕴含平直L²的原书疑误子主张；_corrected仅是网站已PASS的C∞∩L²合格域定义。限定当前覆盖，不把该定义计作平均公式或积分有界定理。'
  gaps=['平均恒等式、ρ^(1)的L²资格及与测试函数配对的有界性没有在本条两声明中表达；未将这些内容标为已经形式化。']
 else:raise ValueError(key)
 if new!=code:text=replace_group(text,sid,new)
 m=re.search(r'/-- source_id:\s*'+re.escape(sid)+r'(?=\s|·)[\s\S]*?-/',text);assert m
 text=text[:m.end()-2]+'[EXTRA] 26号：'+note+'\n'+text[m.end()-2:]
 return text,note,gaps

def run():
 queue=load(OUT/'FAIL_QUEUE.json');done=load(OUT/'REPAIRS.json') if (OUT/'REPAIRS.json').exists() else []
 for item in queue:
  sid=item['source_id'];key=sid.split('-')[-1]
  if any(r['source_id']==sid and r['exit_code']==0 for r in done):continue
  pending=OUT/(key+'-PREPARED.json')
  if pending.exists():state=load(pending);note=state['note'];gaps=state['gaps']
  else:
   before=LEAN.read_text(encoding='utf-8-sig');src=load(BASE/'ch06_source.json');s=next(s for s in src if s['source_id']==sid);old=json.loads(json.dumps(s))
   text,note,gaps=repair(item,before);LEAN.write_text(text,encoding='utf-8')
   corrected=item['json_review'].get('corrected_json')
   if corrected:
    for f in ['kind','label','statement_latex','proof_note','proof_latex','proof_discussion_latex','printed_page','pdf_page']:
     if f in corrected:s[f]=corrected[f]
   s.setdefault('superseded_extra_assumptions26',s.get('extra_assumptions',[]))
   # Keep current scope concise; historical claims remain in superseded metadata.
   s['extra_assumptions']=['[EXTRA] 26号：'+note]
   if key in ['Theorem61','Lemma61Printed','SmoothTestL2Printed','Theorem62']:s['extra_assumptions'].append('[ERRATUM?] 原书数学疑误与本次形式化修复分别记录，见CH06_ERRATA。')
   s['statement_scope']='本条当前覆盖范围：'+note;s['coverage_gaps']=gaps
   s.setdefault('repair_log',[]).append(dict(stage='CLOSEOUT26',note=note,suggested_fix=item['audit']['suggested_fix']))
   dump(BASE/'ch06_source.json',src)
   diff=''.join(difflib.unified_diff(before.splitlines(True),text.splitlines(True),fromfile='Blueprint/Ch06.lean before',tofile='Blueprint/Ch06.lean after'))
   diff+='\n'+''.join(difflib.unified_diff(json.dumps(old,ensure_ascii=False,indent=2).splitlines(True),json.dumps(s,ensure_ascii=False,indent=2).splitlines(True),fromfile='source entry before',tofile='source entry after'))
   (OUT/(key+'.diff')).write_text(diff,encoding='utf-8')
   dump(pending,dict(source_id=sid,note=note,gaps=gaps,lean_sha256=sha(LEAN)))
  receipt=check(key)
  row=dict(source_id=sid,note=note,gaps=gaps,suggested_fix=item['audit']['suggested_fix'],diff_file=(OUT/(key+'.diff')).relative_to(ROOT).as_posix(),**receipt)
  done.append(row);dump(OUT/'REPAIRS.json',done)
  web=load(BASE/'website_audit.json');w=next(w for w in web if w['source_id']==sid)
  w.update(effective_status='按网站审校意见修复，本地核验通过（未再送网站）',local_repair26=row);dump(BASE/'website_audit.json',web)
  summary=load(BASE/'WEBSITE_SUMMARY.json');summary.update(local_repairs= len(done),repairing=8-len(done));dump(BASE/'WEBSITE_SUMMARY.json',summary)
 print('ALL EIGHT REPAIRS PASS',flush=True)
if __name__=='__main__':run()

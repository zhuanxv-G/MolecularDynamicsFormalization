from common25 import *
from local_compile import compile_recorded
import difflib

HELPERS='''
/-- 25号：只在非负时间使用的真实自然历史，包含全部过去。 -/
def naturalHistory25 {Ω V : Type*} [MeasurableSpace Ω] [MeasurableSpace V]
    (X : ℝ → Ω → V) (s : ℝ) : MeasurableSpace Ω :=
  ⨆ r : {r : ℝ // 0 ≤ r ∧ r ≤ s}, MeasurableSpace.comap (X r) inferInstance

/-- 25号：严格网格积分的充分资格；切片L²、有限和L²及局部均方Hölder控制。
不把积分公式或其所求极限作为假设。 -/
def gridItoQualification25 {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ Measurable (Function.uncurry g) ∧
  (∀ t : ℝ, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (g t)) ∧
  ∀ T : ℝ, 0 ≤ T →
    (∀ t ∈ Icc 0 T, MemLp (g t) 2 P) ∧
    (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
    ∃ C : ℝ, 0 ≤ C ∧ ∀ s ∈ Icc 0 T, ∀ t ∈ Icc 0 T,
      (∫ sample, (g s sample-g t sample)^2 ∂P) ≤ C*|s-t|

/-- 25号：共同向量自然过滤上的适应性与均方时间正则；不要求仅对单坐标历史适应。 -/
def vectorGridItoQualification25 {Ω : Type*} [MeasurableSpace Ω] {r : ℕ}
    (P : Measure Ω) (W : ℝ → Ω → (Fin r → ℝ)) (g : Fin r → ℝ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ (∀ j, Measurable (Function.uncurry (g j))) ∧
  (∀ j t, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (g j t)) ∧
  ∀ j T, 0 ≤ T → (∀ t ∈ Icc 0 T, MemLp (g j t) 2 P) ∧
    (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum
      (fun s sample ↦ W s sample j) (g j) T K) 2 P) ∧
    ∃ C : ℝ, 0 ≤ C ∧ ∀ s ∈ Icc 0 T, ∀ t ∈ Icc 0 T,
      (∫ sample, (g j s sample-g j t sample)^2 ∂P) ≤ C*|s-t|

/-- 25号：Markov半群及紧支光滑测试的真实右生成元资格。
它是给定核与Langevin微分表达式的识别条件，不是任意核存在性定理。 -/
def langevinKernelQualification25 {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β γ : ℝ)
    (K : ℝ≥0 → Kernel (textbookLangevinPeriodicPhase n) (textbookLangevinPeriodicPhase n)) : Prop :=
  0 < β ∧ 0 < γ ∧ ContDiff ℝ ∞ U ∧ textbookUnitPeriodicPotential U ∧
  MolecularDynamics.Chapter06Review.markovSemigroup K ∧
  ∀ f : textbookLangevinPeriodicPhase n → ℝ,
    ContDiff ℝ ∞ (f ∘ textbookLangevinPeriodicProjection) → HasCompactSupport f →
    ∀ x, HasDerivWithinAt
      (fun t : ℝ ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x)
      (textbookLangevinPeriodicDifferentialOperator U γ (Real.sqrt (2*γ*β⁻¹)) f x) (Ici 0) 0

'''

def replace_group(text,sid,new):
 g=groups(text)[sid];raw=text[g['body_start']:g['end']]
 assert g['code'] in raw
 return text[:g['body_start']]+raw.replace(g['code'],new,1)+text[g['end']:]

def check(label):
 folder=OUT/'compiled';folder.mkdir(exist_ok=True)
 import time
 while True:
  text=LEAN.read_text(encoding='utf-8');digest=sha(LEAN);names=re.findall(r'(?m)^(?:@\[[^\]\n]+\]\s*)*(?:(?:noncomputable|private|protected)\s+)*(?:theorem|lemma|def|abbrev)\s+(\w+)',text)
  probe=folder/(label+'.lean');probe.write_text(text+'\n'+'\n'.join('#print axioms MD.Ch06.'+n for n in names)+'\n',encoding='utf-8')
  saved=folder/(label+'.json');log=folder/(label+'.log')
  receipt=load(saved) if saved.exists() and log.exists() else {}
  if not (receipt.get('exit_code')==0 and receipt.get('input_sha256')==sha(probe) and receipt.get('log_sha256')==sha(log)):
   from lsp25 import compile_text
   receipt=compile_text(probe.read_text(encoding='utf-8'),label,probe)
  dump(folder/(label+'-binding.json'),dict(receipt,canonical_sha256=sha(LEAN),declarations=names))
  if not receipt['exit_code']:break
  dump(OUT/'REPAIR_WAITING.json',dict(label=label,canonical_sha256=digest,status='awaiting local source correction',receipt=receipt))
  print('WAITING for source correction',label,flush=True)
  while sha(LEAN)==digest:time.sleep(2)
 dump(OUT/'REPAIR_WAITING.json',dict(label=label,status='passed'))
 print(label,'compile + all',len(names),'axioms PASS',flush=True)
 return receipt

def repair(item,text):
 sid=item['source_id'];key=sid.split('-')[-1];code=groups(text)[sid]['code'];new=code;gaps=[]
 notes={
 'WalkIncrement':'仅覆盖一步差分定义；dx·J、扩散缩放等式及独立增量尚未在本条声明。',
 'OUVarianceIntegral':'仅覆盖确定性指数积分求值；随机积分的Gaussian法则、均值及方差由其他条目承接，本条不声称覆盖。',
 'ZeroNoise':'仅覆盖生成元和前向算子的零扩散代数简化；SDE解到ODE积分方程及经典导数桥接未覆盖。',
 'WeightedH1Norm':'仅覆盖真实加权H¹的jet范数分解；原文标量L²积分及任意向量w的平方和等式未由本条覆盖。',
 'KernelAverage':'仅为检验函数核传播的总化辅助记号；原句两种平均相等由MD-6.4.5-KernelDuality对应，可积资格须见该条。',
 }
 if key in notes:
  note=notes[key];gaps=[note]
 elif key=='StateMarkovMeaning':
  # Both meanings require the actual natural history, ambient measurability and probability.
  new=code.replace('  ∀ s t : ℝ≥0,', '''  IsProbabilityMeasure P ∧ (∀ t, Measurable (X t)) ∧
  (∀ s, history s = ⨆ r : {r : ℝ≥0 // r ≤ s}, MeasurableSpace.comap (X r) inferInstance) ∧
  ∀ s t : ℝ≥0,''')
  note='原版及coarseMarkovPrinted_corrected同时要求概率空间、X各时可测和history严格等于全部过去生成的自然过滤；排除任意history伪Markov。'
 elif key=='WeakItoAlias':
  new=code.replace('  MemLp Y 2 P ∧','  (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧\n  MemLp Y 2 P ∧')
  note='采用既有strictItoIntegral的全部有限和L²资格；极限及平方误差的可积性不再被Bochner默认零掩盖。正式库旧辅助保持冻结。'
 elif key=='DeterministicStrobePrinted':
  new=code.replace('(Real.sqrt (∫ s in (0 : ℝ)..times (k+1), g s^2)).toNNReal','((Real.sqrt (∫ s in (0 : ℝ)..times k, g s^2))^2).toNNReal')
  note='Printed忠实保留原书N(0,σ(t_n))累计尺度，将标准差平方后传给gaussianReal方差参数；该印刷增量说法有疑。独立修正版保留相邻区间∫g²及整族独立性，以Y(times 0)为初始观测，不假设times 0=0。'
 elif key in ['VectorSDE','MomentumOU']:
  anchor='  (∀ᵐ sample' if key=='VectorSDE' else '  (∀ i, 0 < m i)'
  new=code.replace(anchor,'  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧\n'+anchor,1)
  note='补真实标准向量Wiener资格；该结构给联合Gaussian、全部跨时协方差及连续路径，并有整坐标路径独立定理，不仅是同一时刻独立。其余方程关系保持。'
 elif key in ['ScalarItoFormula','TimeItoFormula']:
  expr='(fun t sample ↦ deriv φ (X t sample)*b (X t sample) t)' if key=='ScalarItoFormula' else '(fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s)'
  anchor='  ∀ T : ℝ, 0 ≤ T → strictItoIntegral'
  qualification=f'''  Measurable (Function.uncurry X) →
  (∀ t, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (X t)) →
  gridItoQualification25 P W {expr} →
'''
  new=code.replace(anchor,qualification+anchor)
  note='补X联合可测及自然过滤适应、被积过程全部网格和L²与局部均方时间Hölder资格。仅时间积分平方可积的旧签名前提不足且有网站反例；新签名不假设所求积分公式/极限，仍缺一般Itô理论，不证明。Time版与_corrected同步，漏dt原文形式单列保留。'
 elif key=='OULawPrinted':
  new=code.replace('((σ*Real.sqrt ((2*γ)⁻¹)*(1-Real.exp (-2*γ*T)))^2).toNNReal','(σ^2*(1-Real.exp (-2*γ*T))/(2*γ)).toNNReal')
  note='PDF256/印刷235已目视核对：根号覆盖完整(2γ)⁻¹(1−e^(−2γt))。Printed方差改σ²(1−e^(−2γT))/(2γ)，此前根号范围是转录错误，撤销原书疑误归因。'
 elif key=='FPDiffusionPrinted':
  new=code.replace('    -(∫ x, φ x*deriv','    (∫ x, φ x*deriv',1)
  # The identical positive-sign theorem is already proved independently below.
  original,rest=new.split('/-- 修正版',1)
  proof=rest.split(' := by\n',1)[1]
  original=original.replace(' := by\n  sorry',' := by\n'+proof.rstrip())
  new=original+'\n/-- 原页忠实版的同义独立证明；旧_corrected名称仅作兼容，原页本为正号。'+rest.split('-/',1)[1]
  # Restore a well-formed doc comment, without the historical false attribution.
  new=original+'\n\n/-- 原页本为正号；此同义_corrected名称为兼容保留，不是原书勘误。 -/'+rest.split('-/',1)[1]
  note='PDF263/印刷242已目视核对：两次分部积分右端是正号并含(x,t)。删除错误外负号，Printed使用已有独立分部积分证明；撤销虚假原书疑误，旧_corrected名字仅兼容保留。'
 elif key=='VectorIto':
  old='''  (∀ j, MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P (fun t sample ↦ W t sample j)
    (fun t sample ↦ fderiv ℝ φ (X t sample) (fun i ↦ B i j))) →'''
  new=code.replace(old,'''  Measurable (Function.uncurry X) →
  (∀ t, 0 ≤ t → @Measurable Ω (Fin n → ℝ) (naturalHistory25 W t) inferInstance (X t)) →
  vectorGridItoQualification25 P W
    (fun j t sample ↦ fderiv ℝ φ (X t sample) (fun i ↦ B i j)) →''');assert new!=code
  note='改为共同向量自然过滤上的适应性，补X联合可测、各被积过程全部左和L²及局部均方时间资格；strictVectorSDE已含整族Wiener资格。原文相隔公式按网站corrected_json恢复连接文本。仍缺一般多维Itô理论。'
 elif key=='CylinderForwardPrinted':
  new=code.replace('MolecularDynamics.Chapter06Review.vectorDiffusion B φ x','MolecularDynamics.Chapter06Review.vectorDiffusion B φ x / 2')
  note='Printed补原页1/2，保留印刷φ而不静默改ρ；独立corrected采用实际周期lift的前向密度表达式，与VectorForward相同。'
  # Its existing corrected declaration is in VectorForward's source group.
 elif key=='StationaryDensity':
  raw=code.replace('def stationaryDensity','def stationaryWeightRaw25',1)
  new=raw+'\n\n'+code.replace('  ∀ x,','  Measurable ρ ∧ (∀ x, 0 ≤ ρ x) ∧ Integrable ρ volume ∧\n  (∫ x, ρ x)=1 ∧ ∀ x,',1)
  note='保留总化平稳权重stationaryWeightRaw25作辅助；stationaryDensity补可测、非负、可积及体积积分1后才要求前向算子为零。'
 elif key=='BrownianDiscreteSpectrum':
  # Keep the proved countability/isolation result, add the requested missing spectral clause.
  new+='''

/-- 25号补全：每个谱点均为闭实现的特征值；尚缺完整谱理论桥接。 -/
theorem brownianDiscreteSpectrum_eigenvalue {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
      ∃ v : Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β), v ≠ 0 ∧
        (v,z • v) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ).graph := by
  sorry
'''
  note='保留已证可数/实谱/孤立子句，新增“每谱点为特征值”的完整短陈述，尚未证明；有限重数与无有限聚点未冒称覆盖。'
  gaps=['有限重数和无有限聚点的标准离散谱强化尚未单列。']
 elif key=='Theorem61':
  anchor='  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ).Countable ∧'
  extra='''
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    ∃ v : Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β), v ≠ 0 ∧
      (v,z • v) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ).graph) ∧'''
  new=code.replace(anchor,anchor+extra)
  note='Theorem6.1主版、corrected和Printed同时补全部谱点特征值子句；仍保留闭域/半负定/L²相对初始密度的分布平均与原印刷严格负定/轨道平均两套版本，原文疑误不证。'
 elif key=='MinorizationCorrectedImplication':
  new=code.replace('(C : Set D), MolecularDynamics.Chapter06Review.assumption1','''(C : Set D),
    MolecularDynamics.Chapter06Review.markovSemigroup K →
    (∀ A : Set D, IsOpen A → A.Nonempty → 0 < ν A) →
    MolecularDynamics.Chapter06Review.assumption1''')
  note='主版与minorizationPrinted_corrected同时补Chapman–Kolmogorov/Markov半群及参考测度全支撑。两步核局部共同下界仍需大型小集理论，未证明、未宣称数学结论已核定；交网站复审。'
 elif key=='HamiltonianPowerMomentumLaplacian':
  note='保留已证精确Laplacian等式；原错误上界Printed与修正系数分别由MD-6.4.4-LaplacianBoundPrinted/LaplacianBoundCorrect保存，不能把等式视为已覆盖原印刷不等式。'
  gaps=['原印刷上界不属于本条；见LaplacianBoundPrinted（原书疑误）及LaplacianBoundCorrect。']
 elif key=='ForwardKernelGibbs':
  new='''theorem forwardKernelGibbs : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β γ : ℝ) (hβ : 0 < β),
  0 < γ →
  let A := (textbookLangevinCanonicalHilbertClosedOperator U β γ (Real.sqrt (2*γ*β⁻¹)) hβ).adjoint
  ∀ w : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (textbookLangevinCanonicalWeakH1Value U hU hp β hβ w,0) ∈ A.graph →
    ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
      textbookLangevinCanonicalWeakH1Value U hU hp β hβ w x=c := by
  sorry'''
  note='改用相对Gibbs密度的Hilbert adjoint闭域，核结论为常数；旧flat紧支弱测试允许非Gibbs恒通量零模，网站反例保留。改后核定理尚缺大型理论，不证明；原印刷flat措辞由Proposition64Printed留存。'
 elif key=='KernelEvolution':
  raw=code.replace('def kernelEvolution','def kernelEvolutionRaw25',1)
  new=raw+'\n\n'+code.replace('(μ : Measure D) (t : ℝ≥0)', '(μ : Measure D) (_hK : MolecularDynamics.Chapter06Review.markovSemigroup K) (t : ℝ≥0)')
  note='保留任意核作用的kernelEvolutionRaw25辅助；主入口加真正Markov半群资格。仅覆盖概率测度推进，实际Langevin生成元和密度关系须见DensityEvolutionMeaning，不把本条称作完整指数传播识别。'
  gaps=['仅核推进，不覆盖Langevin密度存在、前向生成元或指数算子识别。']
 elif key=='DensityEvolutionMeaning':
  new=code.replace('def densityEvolutionMeaning {n : ℕ} (K','def densityEvolutionMeaning {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β γ : ℝ) (K')
  new=new.replace('  (∀ x, 0 ≤ ρ0 x)', '  langevinKernelQualification25 U β γ K ∧\n  (∀ x, 0 ≤ ρ0 x)',1)
  new=new.replace('  ∀ t, (∀ x, 0 ≤ ρ t x)', '  (∀ x, ρ 0 x = ρ0 x) ∧\n  ∀ t, (∫ x, ρ t x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1 ∧\n    (∀ x, 0 ≤ ρ t x)',1)
  # Exact weak equality is explicitly part of this meaning predicate, with genuine integrability.
  new+=''' ∧
    ∀ f : textbookLangevinPeriodicPhase n → ℝ,
      Integrable (fun x ↦ f x*ρ t x) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) →
      Integrable f (K t ∘ₘ ((MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity
        (fun x ↦ ENNReal.ofReal (ρ0 x)))) →
      (∫ x, f x*ρ t x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n) =
        ∫ x, f x ∂K t ∘ₘ ((MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity
          (fun x ↦ ENNReal.ofReal (ρ0 x)))'''
  note='补Markov/初值/半群及真实右生成元识别资格，补各时刻概率质量和初值；逐点非负为所选代表，显式列可积测试的变分等式。此为语义资格定义，未声称密度存在或任意核满足它。'
 elif key=='LangevinForwardSemigroupMeaning':
  new=code.replace('def langevinForwardSemigroupMeaning {n : ℕ}','def langevinForwardSemigroupMeaning {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β γ : ℝ)')
  new=new.replace('  ∀ v : Lp', '''  langevinKernelQualification25 U β γ K ∧
  S 0 = ContinuousLinearMap.id ℂ _ ∧
  (∀ s t, S (s+t) = (S s).comp (S t)) ∧
  (∀ v, Continuous (fun t ↦ S t v)) ∧
  ∀ v : Lp''',1)
  new=new.replace('    ∀ t, MolecularDynamics.Chapter06Review.kernelEvolution K', '''    ∀ t, (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n,
      (S t v x).im=0 ∧ 0 ≤ (S t v x).re) ∧
      Integrable (fun x ↦ (S t v x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
      MolecularDynamics.Chapter06Review.kernelEvolution K''',1)
  note='补C₀半群（初值/组合/强连续）、Markov核及实际Langevin右生成元联系；每个合格输入的输出AE实且非负并可积，排除(1+i)id和ofReal裁剪伪识别。此为资格定义，未证明存在。'
 else:raise ValueError(key)
 if new!=code:text=replace_group(text,sid,new)
 m=re.search(r'/-- source_id:\s*'+re.escape(sid)+r'(?=\s|·)[\s\S]*?-/',text);assert m
 text=text[:m.end()-2]+'[EXTRA] 25号：'+note+'\n'+text[m.end()-2:]
 return text,note,gaps

def run():
 queue=load(OUT/'FAIL_QUEUE.json');done=load(OUT/'REPAIRS.json') if (OUT/'REPAIRS.json').exists() else []
 for item in queue:
  sid=item['source_id'];key=sid.split('-')[-1]
  if any(d['source_id']==sid and d['exit_code']==0 for d in done):continue
  pending=OUT/(key+'-PREPARED.json')
  if pending.exists():state=load(pending);note=state['note'];gaps=state['gaps']
  else:
   before=LEAN.read_text(encoding='utf-8-sig');text=before
   if 'def naturalHistory25' not in text:text=text.replace('/-- source_id:',HELPERS+'/-- source_id:',1)
   text,note,gaps=repair(item,text);LEAN.write_text(text,encoding='utf-8')
   (OUT/(key+'.diff')).write_text(''.join(difflib.unified_diff(before.splitlines(True),text.splitlines(True),fromfile='before',tofile='after')),encoding='utf-8')
   dump(pending,dict(source_id=sid,note=note,gaps=gaps,lean_sha256=sha(LEAN)))
   src=load(BASE/'ch06_source.json');s=next(s for s in src if s['source_id']==sid)
   s.setdefault('extra_assumptions',[]).append('[EXTRA] 25号：'+note)
   s['statement_scope']='本条Lean覆盖范围：'+note
   s.setdefault('coverage_gaps',[]).extend(gaps)
   s.setdefault('repair_log',[]).append(dict(stage='CLOSEOUT25',note=note,suggested_fix=item['audit']['suggested_fix']))
   dump(BASE/'ch06_source.json',src)
  receipt=check(key)
  row=dict(source_id=sid,note=note,gaps=gaps,suggested_fix=item['audit']['suggested_fix'],diff_file=(OUT/(key+'.diff')).relative_to(ROOT).as_posix(),**receipt)
  done.append(row);dump(OUT/'REPAIRS.json',done)
  web=load(BASE/'website_audit.json');w=next(w for w in web if w['source_id']==sid)
  w.update(effective_status='按网站意见修复、本地编译通过；待复审',local_repair25=row);dump(BASE/'website_audit.json',web)
 print('25 FAIL REPAIRS COMPLETE',flush=True)
if __name__=='__main__':run()

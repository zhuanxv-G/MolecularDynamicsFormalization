from common import *
from local_compile import compile_recorded
import difflib

def repair(ch,sid,text):
 g=groups(ch,text)[sid];code=g['code'];new=code;extra='';gaps=[];scope=None
 key=sid.split('-')[-1]
 if ch==2:
  if key=='Splitting':
   extra='本条只定义组合构造；Hamilton子流资格及O(h²)近似由MD-2.4.1-SplittingLocal / MD.Ch02.splittingLocal共同覆盖。新增rfl桥接核对与该条所用F₁ h (F₂ h u)及splittingMap一致，不从任意函数族推断Hamilton流。'
   scope='组合构造定义；与MD-2.4.1-SplittingLocal跨条共同覆盖带真实Hamilton子流前提的近似结论。'
   new+='''

theorem bp_splittingMap_eq (F₁ F₂ : ℝ → E → E) (h : ℝ) :
    bp_splittingMap F₁ F₂ h = splittingMap F₁ F₂ h := rfl

theorem bp_splittingMap_apply (F₁ F₂ : ℝ → E → E) (h : ℝ) (u : E) :
    bp_splittingMap F₁ F₂ h u = F₁ h (F₂ h u) := rfl
'''
  elif key=='KineticFlow':
   extra='保留总化代数公式和kick导数辅助；新增正质量下动能Hamiltonian、初值及真实Hamilton方程声明。kick导数不作为kinetic流证明；Hamilton识别尚未证明。'
   new+='''

def kineticHamiltonian {Nc : ℕ} (m : Fin Nc → ℝ) (z : SymplecticCoordinates Nc) : ℝ :=
  ∑ i, (z (Sum.inr i))^2/(2*m i)

theorem bp_kineticFlow_initial {Nc : ℕ} (m : Fin Nc → ℝ) (z : SymplecticCoordinates Nc) :
    bp_kineticFlow m 0 z = z := by
  funext i
  cases i <;> simp [bp_kineticFlow]

theorem bp_kineticFlow_hamiltonian {Nc : ℕ} (m : Fin Nc → ℝ)
    (_hm : ∀ i, 0 < m i) (z : SymplecticCoordinates Nc) (t : ℝ) :
    HasDerivAt (fun s => bp_kineticFlow m s z)
      (textbookHamiltonianVectorField (kineticHamiltonian m) (bp_kineticFlow m t z)) t := by
  sorry
'''
  elif key=='PotentialFlow':
   extra='原总化公式仅作候选辅助；新增H₂=U∘位置投影、初值及C¹势下候选轨道的真实Hamilton方程声明；Hamilton识别尚未证明，不将不可微点的fderiv总化值称为经典梯度。'
   new+='''

def potentialHamiltonian {Nc : ℕ} (U : Q Nc → ℝ) (z : SymplecticCoordinates Nc) : ℝ :=
  U (textbookPositionProjection Nc z)

theorem bp_potentialFlow_initial {Nc : ℕ} (U : Q Nc → ℝ) (z : SymplecticCoordinates Nc) :
    bp_potentialFlow U 0 z = z := by
  funext i
  cases i <;> simp [bp_potentialFlow, textbookMomentumKick]

theorem bp_potentialFlow_hamiltonian {Nc : ℕ} (U : Q Nc → ℝ)
    (_hU : ContDiff ℝ 1 U) (z : SymplecticCoordinates Nc) (t : ℝ) :
    HasDerivAt (fun s => bp_potentialFlow U s z)
      (textbookHamiltonianVectorField (potentialHamiltonian U) (bp_potentialFlow U t z)) t := by
  sorry
'''
  elif key=='RK4':
   extra='算法定义与MD-2.5.1-RK4Order / MD.Ch02.rk4Order共同覆盖原句；新增定义相等桥接bp_rk4_eq_rk4，使四阶声明所用rk4与本条公式明确对应。四阶定理原证明状态独立保留。'
   scope='四阶段公式定义；四阶结论由MD-2.5.1-RK4Order跨条共同覆盖，bp_rk4_eq_rk4给出同一算法映射。'
   new+='''

theorem bp_rk4_eq_rk4 {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) :
    bp_rk4 f h z = MolecularDynamics.Chapter02Review.rk4 f h z := rfl
'''
  else:raise ValueError(sid)
 elif ch==3:
  if key=='ModifiedConstruction':
   lib=(ROOT/'MolecularDynamics/Chapter03/Statements.lean').read_text(encoding='utf-8-sig')
   smooth=lib[lib.index('def smoothSymplecticData'):lib.index('def finiteMatching')].strip().replace('ContDiffOn ℝ ⊤','ContDiffOn ℝ ∞')
   stmt=lib[lib.index('def modifiedConstruction_statement'):lib.index('def theorem31_statement')].strip().replace('modifiedConstruction_statement','modifiedConstruction_statement24').replace('ContDiffOn ℝ ⊤','ContDiffOn ℝ ∞')
   new=smooth+'\n\n'+stmt+'\n\n'+code.replace('MolecularDynamics.Chapter03Review.modifiedConstruction_statement','modifiedConstruction_statement24')
   extra='正式库冻结；在本Blueprint同名局部定义中把H、联合G的正则性改为scoped ∞，构造结论Hj也使用∞。主定理改接该本地完整命题，保留Hamilton流辛性合取及∃Hj后∀k量词。未改冻结库，未把解析充分条件当作C∞证明。'
  elif key in ['FiniteMatchingConstruction','ArbitraryFiniteTruncation']:
   extra='本声明的smoothSymplecticData现解析到MD.Ch03本地C∞定义（在MD-3-ModifiedConstruction同组完整列出）；H、联合G及Hj统一scoped ∞，其它资格和∃Hj后∀k顺序不变。'
  elif key=='DifferenceCommutator':
   extra='保留零至二次结论；补一般非交换代数三次系数及Hamilton算子实例。原JSON恢复印刷p.104/PDF126的三次项和O(h⁴)展示式，已视觉复核原页。一般三次系数尝试有限代数展开证明；Hamilton算子实例尚未证明，最终逐声明状态以本地核验日志为准。'
   new+='''

theorem differenceCommutator_coeff3 (A B : R) :
    PowerSeries.coeff 3 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) =
      (1/6 : ℝ) • ((2 : ℝ) • (A*B^2)+(2 : ℝ) • (A^2*B)-
        B*A^2-B*A*B-B^2*A-A*B*A) := by
  rw [map_sub, textbookFormalOperatorProduct_coeff_three,
    textbookFormalOperatorExponential_coeff]
  norm_num
  have hp : (A+B)^3 = A^3+A^2*B+A*B*A+A*B^2+
      B*A^2+B*A*B+B^2*A+B^3 := by noncomm_ring
  rw [hp]
  module

theorem differenceCommutator_hamiltonian_coeff3 (n : ℕ)
    (A B φ : SymplecticCoordinates n → ℝ)
    (_hA : ContDiff ℝ ∞ A) (_hB : ContDiff ℝ ∞ B) (_hφ : ContDiff ℝ ∞ φ)
    (z : SymplecticCoordinates n) :
    let LA := textbookLieDerivative (textbookHamiltonianVectorField A)
    let LB := textbookLieDerivative (textbookHamiltonianVectorField B)
    PowerSeries.coeff 3 (hamiltonianSplittingObservable A B φ z-
      hamiltonianExactObservable A B φ z) = (1/6 : ℝ)*
      (2*LA (LB (LB φ)) z+2*LA (LA (LB φ)) z-
        LB (LA (LA φ)) z-LB (LA (LB φ)) z-LB (LB (LA φ)) z-LA (LB (LA φ)) z) := by
  sorry
'''
  elif key=='Strang':
   extra='formalStrang保留构造；补常项为1、log常项为0及零常项形式指数重建的全阶等式。Z_t明确为log级数去掉一因子X后的移位级数；重建声明尚未证明，不声称真实ODE收敛。'
   new+='''

def formalStrang_Zt {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  PowerSeries.mk (fun j => PowerSeries.coeff (j+1) (formalLog (formalStrang A B)))

theorem formalStrang_constant {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) :
    PowerSeries.coeff 0 (formalStrang A B) = 1 := by
  simp [formalStrang, PowerSeries.coeff_mul, textbookFormalOperatorExponential]

theorem formalStrang_log_constant {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) :
    PowerSeries.constantCoeff (formalLog (formalStrang A B)) = 0 := by
  rw [← PowerSeries.coeff_zero_eq_constantCoeff_apply]
  simp [formalLog]

theorem formalStrang_log_reconstruction {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) :
    PowerSeries.coeff 0 (formalLog (formalStrang A B)) = 0 ∧
    PowerSeries.X * formalStrang_Zt A B = formalLog (formalStrang A B) ∧
    textbookFormalZeroConstantExponential ⟨formalLog (formalStrang A B), formalStrang_log_constant A B⟩ = formalStrang A B := by
  sorry
'''
  elif key=='ScalarVerletShadow4':
   assert (OUT/'SHADOW4_ALGEBRA.json').exists(),'independent coefficient check required'
   extra='【原书疑误】保留印刷有限式及原匹配断言（另名Printed，不证明）；独立精确有理数jet核对kick-drift-kick后，修正版h⁴四项系数为−1/720,+1/120,+1/60,−1/240，分别乘p⁴U⁗、p²U′U‴、p²(U″)²、(U′)²U″。SymPy验到h⁶；统一实际流O(h⁷)估计仍未证明，交导师核查。'
   new=code.replace('theorem scalarVerletShadow4_matching','theorem scalarVerletShadow4_matching_Printed')
   new+='''

/-- 修正版；对应MD-3.4-ScalarVerletShadow4，原印式独立保留。 -/
def scalarVerletShadow4_corrected (U : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ :=
  let p := z.2; let q := z.1
  p^2/2+U q+h^2/24*(2*p^2*deriv (deriv U) q-(deriv U q)^2)+h^4*(
    -p^4*iteratedDeriv 4 U q/720+p^2*deriv U q*iteratedDeriv 3 U q/120+
    p^2*(iteratedDeriv 2 U q)^2/60-(deriv U q)^2*iteratedDeriv 2 U q/240)
'''
   matching=code[code.index('theorem scalarVerletShadow4_matching'):].replace('scalarVerletShadow4_matching','scalarVerletShadow4_matching_corrected').replace('scalarVerletShadow4 U','scalarVerletShadow4_corrected U')
   new+='\n'+matching
  elif key=='HardCoreDomain':
   extra='hardCoreDomain保留任意实半径的代数集合辅助；新增非负半径物理包装、接触面（至少一对取等号）及H=K+U的明确对象。域不自动保证动力学存在。'
   new+='''

def hardCoreDomainPhysical {N d : ℕ} (σ : Fin N → ℝ) (_hσ : ∀ i, 0 ≤ σ i) :
    Set (Fin N → Position d) := hardCoreDomain σ

def hardCoreContactSurface {N d : ℕ} (σ : Fin N → ℝ) : Set (Fin N → Position d) :=
  {q ∈ hardCoreDomain σ | ∃ i j, i ≠ j ∧ ‖q i-q j‖ = σ i+σ j}

def hardCoreMechanicalHamiltonian {N d : ℕ} (m : Fin N → ℝ) (_hm : ∀ i, 0 < m i)
    (U : (Fin N → Position d) → ℝ) (q p : Fin N → Position d) : ℝ :=
  (∑ i, ‖p i‖^2/(2*m i))+U q
'''
  elif key=='CollisionComposition':
   new=code.replace('G t ∘ Rc ∘ collisionComposition G Rc (u::ts)','collisionComposition G Rc (u::ts) ∘ Rc ∘ G t')
   new+='''

theorem collisionComposition_two {E : Type*} (G : ℝ → E → E) (Rc : E → E)
    (t₀ t₁ : ℝ) : collisionComposition G Rc [t₀,t₁] = G t₁ ∘ Rc ∘ G t₀ := by
  simp [collisionComposition]
'''
   extra='列表现在按自然时间顺序[Δτ₀,…,Δτᵣ]存储，递归先执行首段、再碰撞、再余段；二段桥接展开递归核对为G t₁∘Rc∘G t₀。此为形式组合器，非负时长、总时长及G/Rc来自实际Hamilton碰撞的资格不由任意函数定义推出。'
   scope='自然时间顺序的形式组合公式；不在本条声称任意G、Rc就是实际Hamilton碰撞流。';gaps=['实际事件存在性、非负时长和总时长的动力学资格由具体碰撞模型另行承担']
  elif key=='CollisionRegularity':
   new=code.replace('ContDiffAt ℝ ⊤','ContDiffAt ℝ ∞');assert new!=code
   extra='仅将各内段结论ContDiffAt ℝ ⊤改为scoped ∞，与C∞力前提一致；全部有限事件、横截、拼接及左右极限条件不变。'
  elif key=='ModifiedCollisionProjection':
   scope='[EXTRA] 通用有限截断Hamiltonian等值辅助关系；不覆盖原段Verlet专属修正系数、投影存在唯一、变步长共同修正能量或统计精度。'
   gaps=['Hj为Verlet修正系数的资格绑定','四阶/六阶截断专属选择','投影存在唯一性','整个变步长轨道共同修正能量及BEA/统计精度']
   extra=scope+' 未覆盖内容已列coverage_gaps；原引文保留。'
  else:raise ValueError(sid)
 elif ch==4:
  if key=='RESPA':
   new=code.replace('def respa ','def respaTotalized ')
   new+='''

def respa {n : ℕ} (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (r : ℕ) (_hr : 0 < r) (h : ℝ) (z : MolecularDynamics.Chapter04Review.Z n) :
    MolecularDynamics.Chapter04Review.Z n := respaTotalized m US UF r h z
'''
   extra='总化辅助respaTotalized保留；主接口respa增加0<r。当前Blueprint没有主接口下游调用需调整；正式库旧辅助不改。已展开同版本Chapter02Review.verlet核对为kick(h/2)→drift(h)→kick(h/2)，桥接见FastVerlet本地核验记录。原文网站漏句按corrected_json补回。'
  elif key=='ReactionMultiplier':
   scope='[EXTRA] 逆Gram候选公式定义（含奇异点的总化）；原句在det≠0时解平衡方程及唯一性由MD-4.3-ReactionBalance和MD-4.3-GramInvertible共同覆盖。'
   extra=scope+' 不将无条件总化定义报告成唯一求解结论。'
  elif key=='ProjectionScale':
   new=code.replace('z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2+h^2 •','z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2-h^2 •');assert new!=code
   extra='F按原印F_n解释，预测位置+h²M⁻¹F改为−h²M⁻¹F；保留根分支、初态余切相容及Gram可逆资格，原句不改。原书O(h²)的初态范围另列勘误待导师，不把两种根方程混为一谈。'
  elif key=='ComponentSweep':
   new=code.replace('Gsup1 j| < tol','Gsup1 j| ≤ tol');assert new!=code
   new=new.replace('(tol : ℝ) (_hl : 0 < l) : Prop :=','''(tol : ℝ) (_hl : 0 < l)
    (_hvalid : ∀ k < (round+1)*l,
      let j : Fin l := ⟨k%l,Nat.mod_lt k _hl⟩
      let Q := componentPrintedTrajectory m g q Q₀ Gsup1 k
      DifferentiableAt ℝ (g j) q ∧ DifferentiableAt ℝ (g j) Q ∧
        MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Q)
          (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j)) ≠ 0) : Prop :=''')
   extra='停止判据恢复原印非严格≤tol，并要求含测试轮全部步骤的可微/分母非零资格；原G_j^1索引疑误保留待导师。没有更改逐分量更新次序。'
  elif key=='DipolarPotentialSum':
   new=code.replace('def dipolarPotentialSum ','def dipolarPotentialSumTotalized ')
   new+='''

def dipolarPotentialSum {N : ℕ} (lj : ℝ → ℝ)
    (q μ : Fin N → MolecularDynamics.Chapter04Review.V)
    (_hq : ∀ i j, i ≠ j → q i ≠ q j)
    (_hμ : ∀ i, MolecularDynamics.Chapter04Review.dot (μ i) (μ i) = 1) : ℝ :=
  dipolarPotentialSumTotalized lj q μ
'''
   extra='原任意输入有限和另名Totalized作代数辅助；物理主接口补不同粒子位置非碰撞及每个μ单位方向。总逆在零距离的值不解释为物理势。'
  elif key=='AngularInertia':
   new+='''

theorem vectorTripleProduct (a b c : MolecularDynamics.Chapter04Review.V) :
    MolecularDynamics.Chapter04Review.cross3 a (MolecularDynamics.Chapter04Review.cross3 b c) =
      MolecularDynamics.Chapter04Review.dot a c • b-MolecularDynamics.Chapter04Review.dot a b • c := by
  ext i
  fin_cases i <;> simp [MolecularDynamics.Chapter04Review.cross3,
    MolecularDynamics.Chapter04Review.dot, Fin.sum_univ_three, Pi.smul_apply, smul_eq_mul] <;> ring

theorem spatialAngularInertia (N : ℕ) (m : Fin N → ℝ)
    (δ : Fin N → MolecularDynamics.Chapter04Review.V) (omegaVec : MolecularDynamics.Chapter04Review.V) :
    MolecularDynamics.Chapter04Review.angularMomentum m δ
      (fun i => MolecularDynamics.Chapter04Review.cross3 omegaVec (δ i)) =
      MolecularDynamics.Chapter04Review.inertiaTensor m δ *ᵥ omegaVec := by
  simpa [MolecularDynamics.Chapter04Review.bodyMomentum] using
    (angularInertia N m δ (1 : MolecularDynamics.Chapter04Review.Mat3) omegaVec (by simp) (by simp))
'''
   extra='原体坐标等式与证明完整保留；另列一般三重积（逐坐标ring证明）及空间角动量矩阵中间等式（体坐标已证式取Θ=1），覆盖引文遗漏。'
  elif key=='AxisRotation':
   scope='三个标准右手轴旋转矩阵的公式定义；第一句平面子流可积性是背景，移出本条承诺，由MD-4.4.1-ExactPlanarRotation的带负角修正版单独给出。'
   gaps=['原印正角是否等于π×ω场的时间h子流，见AxisFlowFormal/ExactPlanarRotation勘误']
   extra=scope+' 不以矩阵名字推断ODE解。'
  else:raise ValueError(sid)
 elif ch==5:
  if key=='HamiltonianSkewExpression':
   scope='零散度可微向量场的条件乘积恒等式；原段从Hamilton场推散度零的桥接另为覆盖义务，不在本条预先假设后再声称证明。'
   gaps=['C² Hamiltonian的真实Hamilton场散度零桥接与本条实例化；正式库HamiltonianVolume的维数/坐标转换尚未在本条展开核对']
   extra=scope
  elif key=='TestSpace':
   new+='''

/-- 原文第二选项，独立保留Schwartz空间。 -/
def testSpaceSchwartz (n : ℕ) := SchwartzMap (MolecularDynamics.Chapter05Review.E n) ℝ
'''
   extra='紧支持C∞选项保留，并在同一source_id新增实际SchwartzMap选项testSpaceSchwartz；二者各自独立，不用其它条目的名称替代第二选项。'
  elif key=='LowerDimensionNull':
   new+='''

theorem lowerDimensionNull_ambient_corrected (n d : ℕ)
    (g : ℕ → MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E n)
    (K : ℕ → Set (MolecularDynamics.Chapter05Review.E d)) (_hd : d < n)
    (_hblocks : ∀ k, ContDiff ℝ 1 (g k) ∧ IsCompact (K k)) :
    volume (⋃ k, g k '' K k) = 0 := by
  sorry
'''
   extra='保留既有三个正则能级声明，另加不依赖H、c或能级包含关系的一般d<n环境Lebesgue零测声明，覆盖平面曲线和三维曲面；新增声明尚未证明。原书无条件能级维数句保留疑误。'
  elif key=='Mixing':
   new=code.replace('(IsProbabilityMeasure μ ∧ (∀ z,Φ 0 z=z) ∧','(IsProbabilityMeasure μ ∧ (∀ t, MeasurePreserving (Φ t) μ μ) ∧ (∀ z,Φ 0 z=z) ∧');assert new!=code
   extra='补全部实时间的MeasurePreserving，μ明确为不变概率参考分布。weakMixing为兼容保留的名称，含义是密度在有界连续测试下的弱收敛，不用作标准术语“弱混合”。'
  elif key=='WeakAttractor':
   new=code.replace('  ∃ m : ℕ,','  IsProbabilityMeasure μ ∧ ∃ m : ℕ,');assert new!=code
   extra='目标测度资格直接加入定义体IsProbabilityMeasure μ∧…，排除μ=0下空概率邻域的真空成立；其余有限测试族、共同ε和概率ν收敛量词不变。'
  elif key=='EulerLogCorrespondence':
   scope='Euler两个离散更新与连续对数向量场的精确单步插值，以及全时间线性ODE；仅这两个子句由当前Lean覆盖。'
   gaps=['原文密度Liouville演化','密度侧伴随算子及生成元线性分解']
   extra=scope+' 原引文完整保留，密度及伴随分解另列覆盖缺口，不宣称这些结论已证明。'
  else:raise ValueError(sid)
 else:raise ValueError((ch,sid))
 if new!=code:text=text[:g['body_start']]+text[g['body_start']:g['end']].replace(code,new)+text[g['end']:]
 text=add_doc(text,sid,extra)
 return text,extra,scope,gaps

def run(ch):
 b=base(ch);dest=OUT/f'ch{ch:02}';queue=[x for x in load(OUT/'FAIL_QUEUE.json') if x['chapter']==ch]
 done=load(dest/'REPAIRS.json') if (dest/'REPAIRS.json').exists() else []
 for item in queue:
  sid=item['source_id'];key=sid.split('-')[-1]
  if any(x['source_id']==sid and x['exit_code']==0 for x in done):continue
  pending=dest/(key+'-PREPARED.json')
  if pending.exists():
   state=load(pending);assert sha(lean(ch))==state['lean_sha256'],'prepared source changed; repair manually before resuming'
   note=state['diff_summary']
  else:
   if ch != 2:
    from errata_apply import prepare_batch
    prepare_batch(ch)
   prepare(ch,item,pending)
   state=load(pending);note=state['diff_summary']
  receipt,output,_=compile_recorded(['lake','env','lean',f'Blueprint/Ch{ch:02}.lean'],ROOT,lean(ch),dest/(key+'.log'),dest/(key+'.json'))
  row=dict(source_id=sid,diff_summary=note,suggested_fix=item['audit']['suggested_fix'],original_fail=item['audit'],diff_file=(dest/(key+'.diff')).relative_to(ROOT).as_posix(),**receipt)
  done=[d for d in done if d['source_id']!=sid]+[row];dump(dest/'REPAIRS.json',done)
  if receipt['exit_code']:
   print(output.decode('utf-8',errors='replace')[-5000:],flush=True);raise SystemExit(receipt['exit_code'])
  web=load(b/'website_audit.json');w=next(w for w in web if w['source_id']==sid)
  w['effective_status']='按网站审校意见修复，本地核验通过（未再送网站）';w['local_repair24']=row;dump(b/'website_audit.json',web)
  print(sid+': single-file compile and declaration axioms PASS',flush=True)
 print('CHAPTER',ch,'FAIL REPAIRS COMPLETE; full check pending',flush=True)

def prepare(ch,item,pending):
  b=base(ch);dest=OUT/f'ch{ch:02}';sid=item['source_id'];key=sid.split('-')[-1]
  before=lean(ch).read_text(encoding='utf-8-sig');after,note,scope,gaps=repair(ch,sid,before)
  after=re.sub(r'(?m)^#print axioms[^\n]+\n?','',after).rstrip()+'\n'
  # Print every named declaration, including private helpers, in its source module.
  names=[]
  for g in groups(ch,after).values():names+=g['names']
  after+='\n'+'\n'.join(f'#print axioms MD.Ch{ch:02}.'+n for n in names)+'\n';lean(ch).write_text(after,encoding='utf-8')
  sources=load(b/f'ch{ch:02}_source.json');s=next(s for s in sources if s['source_id']==sid)
  s.setdefault('extra_assumptions',[]).append('[EXTRA] '+note)
  if scope:s['statement_scope']=scope
  if gaps:s.setdefault('coverage_gaps',[]).extend(gaps)
  s.setdefault('repair_log',[]).append(dict(stage='CLOSEOUT24',reason=note,suggested_fix=item['audit']['suggested_fix'],original_statement_preserved=True))
  dump(b/f'ch{ch:02}_source.json',sources)
  diff=''.join(difflib.unified_diff(before.splitlines(True),after.splitlines(True),fromfile='before',tofile='after'))
  (dest/(key+'.diff')).write_text(diff,encoding='utf-8')
  dump(pending,dict(source_id=sid,diff_summary=note,lean_sha256=sha(lean(ch))))
if __name__=='__main__':run(int(sys.argv[1]))

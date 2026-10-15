"""Remaining chapter 2 audit repairs, with literal errata left to the mentor."""
from website_repair_batch import prepare,verify,commit_section
from eaudit_review_tasks import declarations
from integrate_website_returns import ROOT,read

def run(section):
    ds=declarations(2);edits={};human={}
    def current(key):return ds['MD-'+section+'-'+key]['block']
    def change(key,code,category,note,**kw):edits['MD-'+section+'-'+key]=dict(code=code,category=category,note=note,**kw)
    if section=='2.5.1':
        human['MD-2.5.1-RKSymplectic']='任意可约Butcher表的系数必要性有反例；选项：批准只保留充分方向／指定不可约等资格后保留必要性。当前iff及原文不擅改。'
        human['MD-2.5.1-GaussFamily']='原文even order需区分确切有限阶与偶数阶下界，原全步长唯一分支资格也过强；选项：批准局部唯一分支上的至少2s阶／定义最高有限阶后证明确切阶偶性。需先确定数学范围，当前声明保持。'
        change('MidpointProperties','''theorem midpointProperties
    (n : ℕ) (H : SymplecticCoordinates n → ℝ)
    (G F : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (U : Set (SymplecticCoordinates n)) (δ : ℝ) (_hδ : 0 < δ)
    (_hU : IsOpen U) (_hH : ContDiff ℝ 4 H)
    (_hG : ContDiffOn ℝ 3 (Function.uncurry G) (Ioo (-δ) δ ×ˢ U))
    (_hzero : ∀ z ∈ U, G 0 z = z)
    (_hstep : ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ U,
      G h z = z+h • textbookHamiltonianVectorField H ((1/2 : ℝ) • (z+G h z)))
    (_hflow : ∀ z ∈ U, F 0 z = z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun u ↦ F u z) (textbookHamiltonianVectorField H (F t z)) t) :
    (∀ h ∈ Ioo (-δ) δ, ∀ z ∈ U,
      IsTextbookSymplectic (textbookJacobian (G h) z)) ∧
    (∀ z ∈ U, ∃ C > 0, ∃ d > 0, d ≤ δ ∧ ∀ h : ℝ, |h| < d →
      ‖G h z-F h z‖ ≤ C*|h|^3) := by
  sorry

theorem midpointProperties_generalODE (n : ℕ) (f : Q n → Q n)
    (G F : ℝ → Q n → Q n) (U : Set (Q n)) (δ : ℝ)
    (_hδ : 0 < δ) (_hU : IsOpen U) (_hf : ContDiff ℝ 3 f)
    (_hG : ContDiffOn ℝ 3 (Function.uncurry G) (Ioo (-δ) δ ×ˢ U))
    (_hzero : ∀ z ∈ U, G 0 z = z)
    (_hstep : ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ U, G h z = z+h • f ((1/2 : ℝ) • (z+G h z)))
    (_hflow : ∀ z ∈ U, F 0 z = z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun u ↦ F u z) (f (F t z)) t) :
    ∀ z ∈ U, ∃ C > 0, ∃ d > 0, d ≤ δ ∧ ∀ h : ℝ, |h| < d →
      ‖G h z-F h z‖ ≤ C*|h|^3 := by
  sorry''','B','补一般ODE局部二阶与Hamilton情形局部保辛；显式G0=id及实际方程、开状态域/小步长分支和真实流，移除全步长全初值解要求。C³分支及全域光滑场为充分[EXTRA]；二阶指至少二阶，非每个方程恰二阶。')
        change('GaussTwoOrder','''theorem gaussTwoOrder (n : ℕ) (f : Q n → Q n) (G : ℝ → Q n → Q n)
    (γ : ℝ → Q n) (τ : ℝ) (_htrajectory : compactTrajectory f γ τ)
    (U : Set (Q n)) (δ : ℝ) (_hδ : 0 < δ) (_hU : IsOpen U)
    (_hcover : γ '' Icc 0 τ ⊆ U)
    (_hG : ContDiffOn ℝ 6 (Function.uncurry G) (Ioo (-δ) δ ×ˢ U))
    (_hzero : ∀ z ∈ U, G 0 z = z)
    (stages : ℝ → Q n → Fin 2 → Q n)
    (_hregular : ∀ i, ContDiffOn ℝ 6 (fun x : ℝ × Q n ↦ stages x.1 x.2 i)
      (Ioo (-δ) δ ×ˢ U))
    (_hstagezero : ∀ z ∈ U, ∀ i, stages 0 z i = f z)
    (_hstage : ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ U,
      rungeKuttaRelation f gaussTwoCoefficients (fun _ => 1/2) h z (G h z) (stages h z)) :
    globalOrder G γ τ 4 ∧
    (∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀, ∀ k ≤ ν,
      oneStepIterate G (τ/ν) (γ 0) k ∈ U) := by
  sorry''','A','改为紧轨迹开邻域U、δ小步长内的真实光滑阶段分支，显式G0=id；补充分细迭代留U，保留全网格四阶。C⁶分支为充分[EXTRA]，未无条件声称任意步长可解。')
        eaudit='EAUDIT20';pages=[111,112]
    elif section=='2.5.2':
        change('GeneralSymplectic',current('GeneralSymplectic'),'B',
          '本条承担基本隐式辛Euler的辛性；同一原句的伴随半步复合、三步关系与对称性由MD-2.5.2-GeneralVerletSymplectic补全，原文不删。',
          scope='基本隐式辛Euler的辛性子结论；所引原句的半步伴随复合、三步对应及对称辛性归MD-2.5.2-GeneralVerletSymplectic。')
        change('GeneralVerletSymplectic','''theorem generalVerletSymplectic
    (n : ℕ) (H : Z n → ℝ) (G : ℝ → Equiv.Perm (SymplecticCoordinates n))
    (δ : ℝ) (_hδ : 0 < δ) (_hH : ContDiff ℝ 2 H)
    (_hG : ∀ h ∈ Ioo (-δ) δ, ContDiff ℝ 1 (G h))
    (_hInv : ∀ h ∈ Ioo (-δ) δ, ContDiff ℝ 1 (G h).symm)
    (_hstep : ∀ h ∈ Ioo (-δ) δ, ∀ z,
      generalSymplecticEulerRelation H h (unpack z) (unpack (G h z))) :
    let K : ℝ → Equiv.Perm (SymplecticCoordinates n) :=
      fun h ↦ (textbookAdjointMethod G (h/2)).trans (Equiv.refl _)
        |>.symm.symm
    let V : ℝ → Equiv.Perm (SymplecticCoordinates n) :=
      fun h ↦ (G (h/2)).trans (textbookAdjointMethod G (h/2))
    (∀ h, (V h : SymplecticCoordinates n → SymplecticCoordinates n) =
      textbookAdjointMethod G (h/2) ∘ G (h/2)) ∧
    textbookAdjointMethod V = V ∧
    (∀ h ∈ Ioo (-δ) δ, IsTextbookSymplecticMap (V h) ∧
      ∀ z, partitionedVerletRelation H h (unpack z) (unpack (V h z))
        (unpack (G (h/2) z)).2) := by
  sorry''','B','以真实可逆且C¹的基本求解族构造伴随半步复合V，补三步关系、V自伴随及辛性；仅δ小步长要求真实Euler关系，全球可逆族明确为条件性[EXTRA]，不宣称一般隐式方程必有全球解。')
        # Keep the construction direct: Equiv.trans has the desired composition order.
        edits['MD-2.5.2-GeneralVerletSymplectic']['code']=edits['MD-2.5.2-GeneralVerletSymplectic']['code'].replace('''    let K : ℝ → Equiv.Perm (SymplecticCoordinates n) :=
      fun h ↦ (textbookAdjointMethod G (h/2)).trans (Equiv.refl _)
        |>.symm.symm
''','')
        eaudit='EAUDIT21';pages=[112,113]
    elif section=='2.5.3':
        human['MD-2.5.3-NewmarkReduction']='原印一般质量公式不能推出Verlet，正质量仍有反例；选项：导师批准m≡1限制／另立质量因子修正版newmarkMassCorrected，保留原印与反例。'
        human['MD-2.5.3-NewmarkNotSymplectic']='非辛反例未覆盖插值位置处力构造的相关辛方法族，原页只给定性构造并引用395；选项：核对395后指定插值参数及更新关系／导师批准另列独立构造条目。现有反例签名保持，不凭空选择方法族。'
        eaudit='EAUDIT22';pages=[114]
    elif section=='2.5.4':
        human['MD-2.5.4-TIForce']='负号改势的真实负梯度为加号修正，印刷力式为减号；选项：批准改力为加号／改势为加号并同步方法。现有字面式保持。'
        human['MD-2.5.4-TIOrder']='有效四阶需先确定改势/力符号，再指定轨迹邻域上光滑近恒等局部处理器及五阶局部缺陷；选项：沿负号改势路线／沿印刷减号力路线。不得直接以力式冲突断言负号改势四阶必假；当前声明保持。'
        eaudit='EAUDIT23';pages=[114,115]
    elif section=='2.5.5':
        human['MD-2.5.5-BeemanOrder']='原文three在当前全相空间全网格全局三阶解释下有谐振子二阶反例；选项：批准另立全局二阶修订／先确定原书其他阶概念再形式化。原three、公式、当前待纠错签名均保留。'
        eaudit='EAUDIT24';pages=[116]
    else:raise ValueError(section)
    sources=read(ROOT/'blueprint/ch02/ch02_source.json');web={w['source_id']:w for w in read(ROOT/'blueprint/ch02/website_audit.json')}
    source_only=[s['source_id'] for s in sources if s['section']==section and s['source_id'] not in edits and s['source_id'] not in human and web[s['source_id']]['json_review']['status']=='CORRECTED']
    prepare(2,eaudit,section,edits,pages=pages,source_only=source_only,human=human)
    verify(2,eaudit);commit_section(2,section,[eaudit])

if __name__=='__main__':
    import sys
    run(sys.argv[1])

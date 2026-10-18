from ch08_data import add

add('DPDVelocityVerlet','8.9.2','389–391',r'''p½=p+hFᶜ(q)/2+hFᴰ(q,p)/2+√h Fᴿ(q,Rold)/2; q'=q+hM⁻¹p½; p'=p½+hFᶜ(q')/2+hFᴰ(q',p½)/2+√h Fᴿ(q',Rnew)/2. Reuse Rnew next step. (8.91)–(8.93).''',
'''def dpdRandomForce {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (σ : ℝ)
    (wR : ℝ → ℝ) (q : ParticleConfig N d) (R : Vec K) : ParticleConfig N d :=
  ∑ k, R k • (dpdNoise pairs σ wR q k).2

def dpdVerlet {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ h : ℝ) (wD wR : ℝ → ℝ)
    (state : ParticlePhase N d × Vec K) (Rnew : Vec K) : ParticlePhase N d × Vec K :=
  let q := state.1.1
  let p := state.1.2
  let ph := p+(h/2) • dpdConservative α rc q+(h/2) • dpdDissipative m γ wD q p+
    (Real.sqrt h/2) • dpdRandomForce pairs σ wR q state.2
  let qn := fun i ↦ q i+(h/m i) • ph i
  let pn := ph+(h/2) • dpdConservative α rc qn+(h/2) • dpdDissipative m γ wD qn ph+
    (Real.sqrt h/2) • dpdRandomForce pairs σ wR qn Rnew
  ((qn,pn),Rnew)

theorem dpdVerlet_reuse {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ h : ℝ) (wD wR : ℝ → ℝ) (z : ParticlePhase N d × Vec K) (R : Vec K) :
    (dpdVerlet pairs m α rc γ σ h wD wR z R).2=R := rfl''',kind='algorithm',equations=['8.91','8.92','8.93'],extra=['物理用法要求mᵢ>0、h≥0、无序对枚举、每步Rnew独立标准正态并与历史独立；本条确定性给定输入的扩展状态映射。','尚未证明书中预期的一阶弱收敛；未把随机输入映射称为对称确定性流。'],scope='三条更新式和新噪声在下一步复用的状态机制。')

add('DPDSplitGenerator','8.9.2',391,r'''The DPD system splits into A: free transport, B: conservative force, O: dissipative plus pair noise. L_DPD=L_A+L_B+L_O. (8.94)–(8.98).''',
'''def dpdA {N d : ℕ} (m : Fin N → ℝ) (z : ParticlePhase N d) : ParticlePhase N d :=
  ((fun i ↦ (m i)⁻¹ • z.2 i),0)
def dpdB {N d : ℕ} (α rc : ℝ) (z : ParticlePhase N d) : ParticlePhase N d :=
  (0,dpdConservative α rc z.1)
def dpdO {N d : ℕ} (m : Fin N → ℝ) (γ : ℝ) (wD : ℝ → ℝ)
    (z : ParticlePhase N d) : ParticlePhase N d := (0,dpdDissipative m γ wD z.1 z.2)
def firstOrder8 {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → E) (f : E → ℝ) (z : E) : ℝ := fderiv ℝ f z (F z)
def dpdLO {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (γ σ : ℝ) (wD wR : ℝ → ℝ) (f : ParticlePhase N d → ℝ) (z : ParticlePhase N d) : ℝ :=
  firstOrder8 (dpdO m γ wD) f z+
    (∑ k, fderiv ℝ (fun x ↦ fderiv ℝ f x) z (dpdNoise pairs σ wR z.1 k)
      (dpdNoise pairs σ wR z.1 k))/2
def dpdGenerator {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ : ℝ) (wD wR : ℝ → ℝ) (f : ParticlePhase N d → ℝ) (z : ParticlePhase N d) : ℝ :=
  firstOrder8 (dpdA m) f z+firstOrder8 (dpdB α rc) f z+dpdLO pairs m γ σ wD wR f z
theorem dpdDrift_split {N d : ℕ} (m : Fin N → ℝ) (α rc γ : ℝ) (wD : ℝ → ℝ)
    (z : ParticlePhase N d) : dpdDrift m α rc γ wD z=dpdA m z+dpdB α rc z+dpdO m γ wD z := by
  ext <;> simp [dpdDrift,dpdA,dpdB,dpdO]''',equations=['8.94','8.95','8.96','8.97','8.98'],extra=['采用独立无序对的Itô二阶导数形式，实现(8.97)有序双和的合并表达；未证明有序/无序表达等价。','光滑测试函数上的形式生成元定义不等同于已建立Markov半群，Fₜ=eᵗᴸ及其定义域列缺口。'],scope='实际三个漂移、无序对扩散生成元和漂移分解恒等式。')

add('DPDPairGeneratorPrinted','8.9.2',392,r'''(8.100) prints L_Oij=[−γωᴰu+(σ²/2)(ωᴿ)² e·(∂pi−∂pj)] e·∂pi for each unordered pair i<j.''',
'''def pairDerivative {N d : ℕ} (i j : Fin N) (e : Vec d)
    (f : ParticleConfig N d → ℝ) (p : ParticleConfig N d) : ℝ :=
  fderiv ℝ f p (pairImpulseVector i j e)
def dpdPairGeneratorPrinted {N d : ℕ} (i j : Fin N) (e : Vec d) (m : Fin N → ℝ)
    (γ σ wd wr : ℝ) (f : ParticleConfig N d → ℝ) (p : ParticleConfig N d) : ℝ :=
  -γ*wd*dot e (relativeVelocity m p i j)*fderiv ℝ f p (Pi.single i e)+
    σ^2*wr^2/2*pairDerivative i j e (fun x ↦ fderiv ℝ f x (Pi.single i e)) p
def dpdPairGenerator_corrected {N d : ℕ} (i j : Fin N) (e : Vec d) (m : Fin N → ℝ)
    (γ σ wd wr : ℝ) (f : ParticleConfig N d → ℝ) (p : ParticleConfig N d) : ℝ :=
  -γ*wd*dot e (relativeVelocity m p i j)*pairDerivative i j e f p+
    σ^2*wr^2/2*pairDerivative i j e (pairDerivative i j e f) p''',kind='definition',equations=['8.100'],verdict='NEEDS_HUMAN',issues=['已目视核对原页PDF413：单个无序对算子的最外层只对pᵢ求导，会对总动量产生非零漂移；对两粒子成对守恒更新应将最外层改为e·(∂pᵢ−∂pⱼ)。完整有序双和(8.97)另含反方向项，不能直接同样判错。'],extra=['本条只分别定义原印和成对修正版；不声称已证明驻定概率或原书单对不变性。'],scope='冻结配置下单对动量生成元的原式和守恒方向修正版。')

add('DPDSplittingCompositions','8.9.2','392–393',r'''Shardlow: O(h) B(h/2) A(h) B(h/2); S=B+O and Trotter: S(h/2) A(h) S(h/2). Pair products use the printed fixed unordered-pair order. (8.99),(8.101),(8.102).''',
'''def dpdShardlowComposition {E : Type*} (A B O : ℝ → E → E) (h : ℝ) : E → E :=
  O h ∘ B (h/2) ∘ A h ∘ B (h/2)
def dpdTrotterComposition {E : Type*} (A S : ℝ → E → E) (h : ℝ) : E → E :=
  S (h/2) ∘ A h ∘ S (h/2)
def sequentialPairComposition {E : Type*} (steps : List (E → E)) : E → E :=
  fun x ↦ steps.foldl (fun y F ↦ F y) x
def dpdSGenerator {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ : ℝ) (wD wR : ℝ → ℝ) (f : ParticlePhase N d → ℝ) (z : ParticlePhase N d) : ℝ :=
  firstOrder8 (dpdB α rc) f z+dpdLO pairs m γ σ wD wR f z''',kind='algorithm',equations=['8.99','8.101','8.102'],extra=['A/B/O/S为调用者指定的映射；只保留所印组合顺序。尚未实现BBK成对近似或其误差、全O/S流及生成元指数关系。','两次S同顺序的非交换成对乘积不能仅凭外层回文判为对称；不作该声称。'],scope='两种外层组合、固定顺序逐对执行及S形式生成元；实际OU单对步骤见后条。')

add('DPDPairOUUpdate','8.9.2',393,r'''mred=mi mj/(mi+mj); mred du=Fdt−γωᴰu dt+σωᴿdW. a=γωᴰ/mred. u(t)=F/(a mred)+exp(−at)(u0−F/(a mred))+√[θ(1−exp(−2at))/mred]R. Δu=u(t)−u0; pi+=mred Δu e, pj−=mred Δu e. (8.103)–(8.107).''',
'''def reducedMass8 (mi mj : ℝ) : ℝ := mi*mj/(mi+mj)
theorem reducedMass8_pos (mi mj : ℝ) (hi : 0 < mi) (hj : 0 < mj) : 0 < reducedMass8 mi mj :=
  div_pos (mul_pos hi hj) (add_pos hi hj)
def dpdPairOUPrinted (mr a F θ t u R : ℝ) : ℝ :=
  F/(a*mr)+Real.exp (-a*t)*(u-F/(a*mr))+Real.sqrt (θ*(1-Real.exp (-2*a*t))/mr)*R
def dpdPairOU_corrected (mr a F θ t u R : ℝ) : ℝ :=
  Real.exp (-a*t)*u+(F/mr)*(if a=0 then t else (1-Real.exp (-a*t))/a)+
    Real.sqrt (θ*(1-Real.exp (-2*a*t))/mr)*R
theorem dpdPairOU_zeroRate (mr F θ t u R : ℝ) :
    dpdPairOU_corrected mr 0 F θ t u R=u+(F/mr)*t := by simp [dpdPairOU_corrected]
def dpdPairMomentumStep {N d : ℕ} (i j : Fin N) (e : Vec d) (mr du : ℝ)
    (p : ParticleConfig N d) : ParticleConfig N d := p+pairImpulseVector i j ((mr*du) • e)
theorem dpdPairMomentumStep_conserves {N d : ℕ} (i j : Fin N) (e : Vec d) (mr du : ℝ)
    (p : ParticleConfig N d) : totalMomentum (dpdPairMomentumStep i j e mr du p)=totalMomentum p := by
  simp [dpdPairMomentumStep,pairImpulseVector,totalMomentum,Finset.sum_add_distrib,Finset.sum_sub_distrib]''',equations=['8.103','8.104','8.105','8.106','8.107'],verdict='NEEDS_HUMAN',issues=['已目视核对原页PDF414：原印F/(amred)须a>0；γ=0或截断外ωᴰ=0时需用积分系数连续延拓。修正版显式定义a=0为自由加速，噪声退化为零。'],extra=['原印转移律要求mr>0、a>0、θ>0、t≥0及R独立标准正态；F为冻结配置的成对保守力标量，FDT用于方差。','单对精确分布律及其随机积分推导未证明；已证明质量正性、零率值与逐对总动量代数守恒。'],scope='原印/零率延拓的OU转移公式、速度增量所用动量更新及总动量守恒。')

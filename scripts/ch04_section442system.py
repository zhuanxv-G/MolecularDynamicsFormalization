"""Eight faithful N-body DLM records, including coupled force/torque slices."""
from ch04_data import add,NS,RECORDS
SPIN_TEXT=next(r['statement_latex'] for r in RECORDS if r['source_id'].endswith('-PrintedSpinStep'))
KICK_TEXT=r'''“Kick”: update the momenta and angular momentum vectors with known forces and torques for a half step:
\[p^k:=p^k+\tfrac h2 F_k;\quad\pi^k:=\pi^k+\tfrac h2\tau_k.\]'''
TABLE_TEXT=r'''DLM Rigid Body Molecular Dynamics Step
1. '''+KICK_TEXT+r'''
2. “Drift”: step forward a whole step in positions
\[q^k:=q^k+hp^k.\]
3. '''+SPIN_TEXT+r'''
4. “Kick”: update the momenta and angular momentum vectors (as in Step 1) with a half step using new forces $F_k$ and torques $\tau_k$ evaluated at the current $q,\Theta$.'''
add('RigidSystemState','4.4.2',173,[],r'''Procedures given below for rigid body $k$ are meant to be performed for all rigid bodies in the system.''',f'''@[reducible] def rigidSystemState (N : ℕ) := Fin N → {NS}RBState''',kind='definition',extra=['[EXTRA]完整N体状态的透明类型别名：每体(q,p,π,Θ)；下列势U可耦合全部刚体，不限于单体或独立势。'])
add('RigidSystemForce','4.4.2',173,[96],r'''The relevant expressions are $F_k=-\partial U/\partial q^k$.''',f'''def rigidSystemForce {{N : ℕ}}
    (U : (Fin N → {NS}V) → (Fin N → {NS}Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : {NS}V :=
  -{NS}grad (fun x => U (Function.update (fun j => (z j).1.1) k x) (fun j => (z j).2.2)) (z k).1.1''',kind='definition',context=['真实耦合势的第k个位置切片Fréchet梯度；其余坐标保持在当前完整状态。'])
add('RigidSystemTorque','4.4.2',173,[96],r'''$\tau_k=-\operatorname{rot}(\Theta^{kT}\partial U/\partial\Theta^k)$.''',f'''def rigidSystemTorque {{N : ℕ}}
    (U : (Fin N → {NS}V) → (Fin N → {NS}Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : {NS}V :=
  -{NS}matrixRot ((z k).2.2ᵀ * {NS}matrixGrad
    (fun A => U (fun j => (z j).1.1) (Function.update (fun j => (z j).2.2) k A)) (z k).2.2)''',kind='definition',context=['真实矩阵元素Fréchet偏导；rot(A)=skew⁻¹(A−Aᵀ)，没有额外1/2。'])
add('RigidSystemKick','4.4.2',174,[97],KICK_TEXT,f'''def rigidSystemKick {{N : ℕ}}
    (U : (Fin N → {NS}V) → (Fin N → {NS}Mat3) → ℝ) (h : ℝ)
    (z : rigidSystemState N) : rigidSystemState N :=
  fun k => (((z k).1.1,(z k).1.2+h • rigidSystemForce U z k),
    ((z k).2.1+h • rigidSystemTorque U z k,(z k).2.2))''',kind='definition',context=['参数h表示本次kick长度；整体算法以h/2调用，全部力/力矩从同一当前状态同时计算。'])
add('RigidSystemDriftPrinted','4.4.2',174,[97],r'''“Drift”: step forward a whole step in positions
\[q^k:=q^k+hp^k.\]''',f'''def rigidSystemDriftPrinted {{N : ℕ}} (h : ℝ) (z : rigidSystemState N) : rigidSystemState N :=
  fun k => (((z k).1.1+h • (z k).1.2,(z k).1.2),(z k).2)''',kind='definition',issues=[dict(code='ERRATUM?',detail='原字面缺1/Mk；完整N体版本保留原式，不静默补质量。')])
add('RigidSystemSpinPrinted','4.4.2',174,[97],SPIN_TEXT,f'''def rigidSystemSpinPrinted {{N : ℕ}} (I : Fin N → {NS}V) (h : ℝ)
    (z : rigidSystemState N) : rigidSystemState N :=
  fun k => ((z k).1,printedSpinStep (I k) h (z k).2)''',kind='definition',context=['原表为列动量Rπ与方向ΘRᵀ，与正式库一致；每个子轴角使用当前已更新动量。'],issues=[dict(code='ERRATUM?',detail='正角Rπ与π×ω的子流符号疑点保留，不冒充已证精确刚体子流。')])
add('DLMPrintedSystem','4.4.2',174,[97],TABLE_TEXT,f'''def dlmPrintedSystem {{N : ℕ}} (I : Fin N → {NS}V)
    (U : (Fin N → {NS}V) → (Fin N → {NS}Mat3) → ℝ) (h : ℝ) :
    rigidSystemState N → rigidSystemState N :=
  rigidSystemKick U (h/2) ∘ rigidSystemSpinPrinted I h ∘
    rigidSystemDriftPrinted h ∘ rigidSystemKick U (h/2)''',kind='definition',context=['完整任意N及耦合势；末kick由更新后的全部位置和方向重新求力/力矩，不把它们冻结在旧状态。'],issues=[dict(code='ERRATUM?',detail='完整原表的缺质量drift与正角spin疑点保持；编译定义不代表正确辛性。')])
add('SystemDriftSpinCommute','4.4.2',174,[98],r'''as the updates Drift/Spin are decoupled, the order they are performed is not important.''',f'''theorem systemDriftSpinCommute : ∀ N (I : Fin N → {NS}V) h (z : rigidSystemState N),
    rigidSystemDriftPrinted h (rigidSystemSpinPrinted I h z)=
      rigidSystemSpinPrinted I h (rigidSystemDriftPrinted h z) := by
  intro N I h z
  rfl''',context=['任意N的真实全状态两个函数复合相等；只有drift/spin互换，不交换依赖耦合势的kick。'])

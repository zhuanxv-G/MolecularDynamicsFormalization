"""Include every source-marked erratum, including contextual and dimensional ambiguities."""
import sys,re
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];sys.path.insert(0,str(ROOT/'scripts'))
from integrate_website_returns import read,dump
from eaudit_review_tasks import declarations
BASE=ROOT/'blueprint/ch01';OUT=BASE/'validation/CLOSEOUT19'

def apply():
 p=ROOT/'Blueprint/Ch01.lean';text=p.read_text(encoding='utf-8-sig');ds=declarations(1);rows=read(OUT/'ERRATA_RECORDS.json')
 def add(suffix,code,change,problem,example,options,default,missing='',literal_name=None):
  nonlocal text
  sid=next(s for s in ds if s.endswith('-'+suffix));old=ds[sid]['block']
  text=text.replace(old,old+'\n\n/-- 修正版，对应原文 '+sid+'，改动：'+change+' -/\n'+code.strip(),1)
  text=re.sub(r'(/-- source_id: '+re.escape(sid)+r'[^\n]*)',r'\1 【原书疑误】',text,count=1)
  rows.append(dict(source_id=sid,original_name=literal_name or ds[sid]['name'],original_signature_sha256=ds[sid]['signature_sha256'],change=change,problem=problem,mathematical_counterexample=example,mentor_options=options,default_option=default,missing=missing,corrected_names=re.findall(r'(?m)^(?:noncomputable )?(?:theorem|def)\s+(\w+_corrected(?:_[ab])?)\b',code),counterexample_names=[]))
 add('Yukawa','''def yukawaScreened_corrected_a (C : {x : ℝ // 0 < x}) (Qᵢ Qⱼ : ℝ)
    (dielectric κ r : {x : ℝ // 0 < x}) : ℝ :=
  C.val*Qᵢ*Qⱼ/(dielectric.val*r.val)*Real.exp (-κ.val*r.val)

/-- 修正版，对应原文 MD-1.1.2-Yukawa，改动：若参数称Debye长度，指数应为−r/ℓ。 -/
def yukawaScreened_corrected_b (C : {x : ℝ // 0 < x}) (Qᵢ Qⱼ : ℝ)
    (dielectric ℓ r : {x : ℝ // 0 < x}) : ℝ :=
  C.val*Qᵢ*Qⱼ/(dielectric.val*r.val)*Real.exp (-r.val/ℓ.val)''',
 'a保留−κr但把κ解释为逆屏蔽长度；b若保留Debye length称谓则用−r/ℓ。正参数为物理域补充。',
 '原文称κ为长度，但无量纲指数−κr通常要求κ为逆长度。Lean实数类型不携带量纲，此疑点必须文字核查。',
 '长度单位L乘长度单位L得到L²，不能作为无量纲指数；κ=1/ℓ时两个修正版逐点一致。',
 ['保留指数并改称逆长度','保留长度称谓并改指数'],'保留指数并改称逆长度')
 old=ds['MD-1.4-LegendreHamiltonian']['block']
 literal=old.replace('hamiltonian_legendre_transform','hamiltonian_legendre_transform_literal',1).replace('\n    (hPositive : (M q).PosDef)','')
 corrected=old.replace('hamiltonian_legendre_transform','hamiltonian_legendre_transform_corrected',1)
 add('LegendreHamiltonian',literal+'\n\n/-- 修正版，对应原文 MD-1.4-LegendreHamiltonian，改动：显式继承对称正定机械质量背景。 -/\n'+corrected,
 '新增仅可逆的原文字面版；修正版继承正定质量背景并保留上界、精确上确界、唯一达到点、动量梯度与能量全部结论。',
 '任意可逆矩阵不足以保证凹二次目标有最大值；需继承机械质量的对称正定背景。',
 '一维M=−1、p=U=0时待取sup的目标为v²/2，无上界。',
 ['继承机械质量正定背景','只保留字面疑误'],'继承机械质量正定背景',
 '缺一般配置相关正定矩阵Legendre上确界及梯度桥接；不恢复大型理论。','MD.Ch01.hamiltonian_legendre_transform_literal')
 add('PhaseSpace','''def finiteEnergyPhaseDomain_corrected {n : ℕ} (H : PhaseSpace n → EReal) : Set (PhaseSpace n) :=
  {z | H z ≠ ⊤ ∧ H z ≠ ⊥}

theorem finiteEnergyPhaseDomain_corrected_dimension (N : ℕ) :
    Module.finrank ℝ (PhaseSpace (3*N)) = 6*N := by
  simp [PhaseSpace,Position,Momentum]
  omega''',
 '有限能量位置×动量定义保留；把后句coordinates and positions按前句解释为位置与动量，并显式核验6N维。',
 '后句重复位置，疑为positions/momenta文字笔误；前句定义及R^{6N}支持位置×动量解释。',
 'N粒子各有3N位置与3N动量坐标，合计6N；两个位置词不能说明第二半坐标的物理含义。',
 ['依前句读作位置与动量','保留原词待核'],'依前句读作位置与动量')
 add('IsoscelesCoordinates','''def isoscelesCoordinates_corrected (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]

theorem isoscelesCoordinates_corrected_center (x y : ℝ) :
    (∑ i : Fin 3, isoscelesCoordinates_corrected x y i) = 0 := by
  ext k
  fin_cases k <;> simp [isoscelesCoordinates_corrected,Fin.sum_univ_three] <;> ring''',
 '把三坐标公式作为主动选取的对称子模型，证明其质心为零；不把零总动量/角动量推出等腰。',
 '零平动、零角动量不强迫任意三角形等腰；必须额外选择对称初态及证明对称性保持。',
 '取一个不等边三角形，平移使质心为零，并令全部初速度为零。总动量和角动量均为零，但三角形仍不等边。',
 ['明确选择等腰对称子模型','另审一般约化资格'],'明确选择等腰对称子模型')
 p.write_text(text,encoding='utf-8')
 for r in rows:
  if r['source_id'].endswith('-ConvexLegendre'):r['original_name']='MD.Ch01.legendreTransform_literal'
  if r['source_id'].endswith('-TorusDense'):r['original_name']='MD.Ch01.torusdense_literal'
  if r['source_id'].endswith('-LocalActionAngleReduction'):r['original_name']='MD.Ch01.local_action_angle_reduction_literal'
 dump(OUT/'ERRATA_RECORDS.json',rows);print('Context errata total',len(rows))

if __name__=='__main__':apply()

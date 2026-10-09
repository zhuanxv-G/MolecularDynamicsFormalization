"""Finalize evidence and correspondence without changing any formal-library file.

Run after all section writers; this script does not manufacture website approval.
"""
from pathlib import Path
import json,re,hashlib,shutil
from ch01_full_data import ROOT,BASE,RECORDS
from ch01_full_tools import declarations,sync
from ch01_full_proofs import PROOFS,FAILED_PROOFS
from render_blueprint import render

def save(path,data):
    path.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')

# These are distinct edited proof attempts. Re-running an unchanged failing body
# is not another attempt. Success is finally certified by the full axiom check.
ATTEMPTS={
 'MD-1.1.1-MorseMinimum':(3,3,['proof-final-1','proof-final-2','proof-final-3']),
 'MD-1.1.1-LJRepulsion':(3,2,['proof-final-1','proof-final-2','proof-final-3']),
 'MD-1.2-LJTimeScaling':(3,2,['proof-ljtime-1','proof-ljtime-2','proof-ljtime-3']),
 'MD-1.2-MomentumConservation':(2,1,['proof-last-short-1','proof-last-short-3']),
 'MD-1.4-HamiltonFixedMass':(2,1,['proof-final-1','proof-final-2']),
 'MD-1.5-Nonconfining':(1,0,['proof-sec17-1']),
 'MD-1.5.1-FlowEnergy':(3,2,['proof-sec17-1','proof-sec17-2','proof-sec17-3']),
 'MD-1.5.2-KeplerMomentum':(1,0,['proof-sec17-1']),
 'MD-1.5.3-HamiltonEquilibrium':(1,0,['proof-final-2']),
 'MD-1.5.3-PositiveHessianQuadratic':(3,2,['proof-sec17-1','proof-sec17-2','proof-sec17-3']),
 'MD-1.6-UnorderedPairCount':(2,1,['proof-sec16-1','proof-sec16-2']),
 'MD-1.6-HexagonalLattice':(3,2,['proof-sec16more-1','proof-sec16more-2','proof-sec16more-3']),
 'MD-1.6-PeriodicTranslationMomentum':(3,3,['proof-sec16more-2','proof-sec16more-3','proof-periodic-3']),
 'MD-1.6.1-ForceLinearization':(3,2,['proof-sec16-1','proof-sec16-2','proof-sec16-3']),
 'MD-1.6.1-ComplexNormalMode':(3,3,['proof-complex-1','proof-sec16more-1','proof-sec16more-2']),
 'MD-1.7-CentralPairGradient':(2,1,['proof-sec17-1','proof-sec17-2']),
 'MD-1.7-CentralAngularMomentum':(1,0,['proof-angular-1']),
 'MD-1.7-CenterOfMassMotion':(2,1,['proof-last-short-1','proof-last-short-3']),
 'MD-1.7-IsoscelesEnergyReduction':(2,1,['proof-last-short-2','proof-energy-2']),
 'MD-1.7-EquilateralTrimerMinimum':(3,3,['proof-trimer-1','proof-trimer-2','proof-trimer-3']),
 'MD-1.7.2-PositiveLyapunovGrowth':(2,1,['proof-sec17-1','proof-sec17-2']),
}
TIMEBOX={
 'MD-1.1.1-MorseMinimum':'三次失败已止：无穷远指数极限的Tendsto目标与局部Morse定义归一化；非负/极小部分已有尝试，完整井深极限尚未通过。',
 'MD-1.6.1-ComplexNormalMode':'三次失败已止：Pi复空间的连续线性作用与实时间导数/复标量作用接口不统一；数学共轭模式论证与现有实模式证明不能冒充此签名。',
 'MD-1.6-PeriodicTranslationMomentum':'三次失败已止：Pi空间拓扑与实际HasDerivAt链式法则实例不能统一；平移不变已有正式证明，完整方向导数及动量桥接未通过。',
 'MD-1.7-EquilateralTrimerMinimum':'三次失败已止：LJ单距离唯一极小值、rpow根及三边势和计算已在尝试中补出；最后有限指标反向距离等式归一化未闭合，完整定理保持占位。',
}
LARGE={
 'MD-1.5.2-KeplerConservedEnergy':'整句两守恒量已分别桥接；可积性完整极坐标提升和全存在区间quadrature重建尚缺大型理论，未删掉therefore integrable结论。',
 'MD-1.2-ScalarQuadrature':'缺大型理论：带(x,ξ,η)参数的C∞隐函数定理及积分逆C∞依赖、真实解局部唯一性组合；现有固定初值C1图表不足以推出全部签名。',
 'MD-1.4-HamiltonLagrangeEquivalence':'缺大型理论：配置相关矩阵逆的C2微分、一般二次型的配置/速度梯度和Euler–Lagrange全等价；固定质量偏梯度已证明但范围不足。',
 'MD-1.5-EnergyBounds':'缺一般SPD矩阵二次型在紧单位球上的严格正下界与coercivity桥接；旧正式对角质量证明不能直接支持一般质量矩阵。',
 'MD-1.5-UniformLevelsCompact':'依赖尚缺的一般SPD动量统一界及连续能量层闭、有界、紧组合；不假设结论或改成对角特例。',
 'MD-1.5-CompactContinuation':'缺双向紧集留域延拓与反向系统拼接；旧正式库只供未来延拓，未尝试用其冒充全时间结论。',
 'MD-1.5.2-KeplerFullSolution':'缺全局Kepler极坐标提升、碰撞边界控制及跨转向点的quadrature图拼接；已有固定初值局部重建不足。',
 'MD-1.5.3-HyperbolicStabilityTransfer':'缺一般Hartman–Grobman局部拓扑共轭和稳定/不稳定转移；不调用仍含sorry的smooth字面条目。',
 'MD-1.5.3-PositiveHessianMinimum':'缺实对称Hessian谱正定转换和C2二阶Taylor严格局部极小判别；已证明的纯二次型极小不等于非线性势结论。',
 'MD-1.6.1-ImaginarySpectrum':'缺一般SPD M,K的Hamilton块谱相似变换及共轭特征对、非零频率理论；实部零、平方正和±配对须同时证明。',
 'MD-1.7-CentralAngularMomentum':'缺三维叉积的连续双线性真实导数、逐对力矩反对称及有限N体和桥接；二维Kepler角动量不能覆盖全部签名。',
 'MD-1.7-TrimerSaddle':'缺共线LJ驻点全局唯一根及二维严格鞍点的两方向二阶导数符号/局部比较；不只证明一维极小就宣称鞍点。',
 'MD-1.7.2-SingularEllipsoid':'缺一般实矩阵SVD、正交坐标变换与逆矩阵球面像的完整几何证明；奇异值定义本身不是椭球结论证明。',
}

# Additional rows make the easily missed components explicit. The complete
# expanded Lean signature is also included, so no clause is hidden by a name.
COMPONENTS={
 'MD-1.5.2-KeplerConservedEnergy':[
  ('energy and angular momentum','平面真实解的kepler_energy_const_on_Ioo与kepler_planarAngularMomentum_const_on_Ioo完整签名','一致；两结论已桥接'),
  ('mean that … is an integrable system','整个非碰撞存在区间的径向quadrature、角积分与初值重建合取','一致；未以只证明能量守恒代替全部结论')],
 'MD-1.1-Schrodinger':[
  ('13粒子的3分量二阶偏导与质量权重','Fin 39; μ ⟨i.val / 3, …⟩; secondPartial (Φ t) q i / (2 * μᵢ)','一致'),
  ('时间导数与势项','Complex.I * h * deriv (fun s => Φ s q) t; (U q : ℂ) * Φ t q','一致')],
 'MD-1.1.1-MorseMinimum':[
  ('rₑ处极小、井深D','∀ r>0, 0≤morsePotential…; morsePotential…rₑ=0; Tendsto … atTop (𝓝 D)','一致'),
  ('a controls curvature','定性形状参数合并context_notation；原书未给二阶导数公式','一致（定性背景）')],
 'MD-1.1.1-LJRepulsion':[
  ('r→0时趋正无穷','Tendsto (lennardJonesPotential ε σ) (𝓝[>] 0) atTop','一致'),
  ('长模拟中通常保持分离','context_notation；严格有限能量无碰撞旧CH01-198排除','一致（定性经验）')],
 'MD-1.1.2-GayBerne':[
  ('εGB=ε₁ε₂','gayBerneEpsilonOne … * gayBerneEpsilonTwo …，没有平方ε₂','一致；旧正式定义平方与原页不同，未桥接'),
  ('ρ、χ、χ′及各向异性参数','gayBerneModel的r/χ/χ′/Δ定义及原始定义文件','一致')],
 'MD-1.1.2-Yukawa':[
  ('exp(-κr)','Real.exp (-κ * r)','一致；κ称屏蔽长度的量纲疑点见原文issues')],
 'MD-1.2-MomentumConservation':[
  ('两体力反向，净力相消','F t i j = -F t j i → (∑ i, ∑ j, F t i j)=0','一致；净力为零是结论'),
  ('全向量/每坐标动量守恒','真实HasDerivAt (∑ i,m i • v s i) 0及任意a,b∈I的值相等','一致')],
 'MD-1.2-ScalarQuadrature':[
  ('V(x,ξ,η)光滑且能量式局部唯一确定速度','联合ContDiffOn ℝ ∞ V及隐式能量唯一性','一致'),
  ('积分逆重建及初值参数光滑依赖','联合ContDiffOn ℝ ∞ X、实际ODE、X 0=ξ、积分=时间','一致；现有固定初值桥接不足')],
 'MD-1.2-LJCoordinateScaling':[
  ('一阶、二阶及所有距离缩放','两个HasDerivAt结论及∀r s, ‖σ•r-σ•s‖=σ*‖r-s‖','一致')],
 'MD-1.2-LJTimeScaling':[
  ('时间缩放得到无参数单位质量系统','真实C2非碰撞Q的原Newton系统 ↔ ∀τ i,Q″=ljForce 1 1','一致'),
  ('单位时间','α⁻¹=σ*Real.sqrt (m/ε)','一致')],
 'MD-1.4-HamiltonFixedMass':[
  ('一般固定矩阵M的两Hamilton偏梯度','M.PosDef；动量梯度matrixAction M⁻¹ p，位置梯度gradient U q','一致；保留一般SPD矩阵')],
 'MD-1.5.1-FlowEnergy':[
  ('一般Hamilton流保能量，所有初值与时间','∀ξ t,H(F t ξ)=H ξ；hF为实际symplecticGradient H的ODE','一致；守恒未作前提')],
 'MD-1.5.2-ScalarFirstIntegral':[
  ('energy as a first integral','scalarPotentialEnergy_isFirstIntegral的完整签名','一致'),
  ('therefore integrable','scalarPotential_nonturning_quadrature的实际局部积分逆重建','一致；非转向资格显式')],
 'MD-1.5.3-PositiveHessianMinimum':[
  ('distinct positive eigenvalues','Function.Injective freq；∀i,0<freq i；实特征基完整heig','一致'),
  ('势的严格局部极小','IsStrictPotentialMin U q','一致；未替换为纯二次型')],
 'MD-1.6-PeriodicTranslationMomentum':[
  ('平移不变及方向导数为零','∀q c,U(q+c)=U q；fderiv U q (fun _=>1)=0','一致'),
  ('真实Newton系统总动量守恒','有限和HasDerivAt 0及∀a b∈I动量相等','一致')],
 'MD-1.6.1-ForceLinearization':[
  ('一般质量Hamilton向量场的块导数','(M⁻¹∘snd).prod ((-D∇U)∘fst)的HasFDerivAt','一致'),
  ('梯度线性化误差','∇U(q)-D∇U(q*)(q-q*) =o[𝓝 q*] (q-q*)','一致')],
 'MD-1.6.1-ImaginarySpectrum':[
  ('全部特征值±iΩ与Ω²>0','任意非零实虚特征对推出a=0、0<b²及A x=-b•y、A(-y)=-b•x','一致；全部三个结论保留')],
 'MD-1.7-CentralAngularMomentum':[
  ('逐对力矩相消','∀t i j,cross3(qᵢ,Fᵢⱼ)=-cross3(qⱼ,Fⱼᵢ)','一致'),
  ('角动量守恒','HasDerivAt (∑i,cross3(qᵢ,mᵢ•vᵢ)) 0','一致')],
 'MD-1.7-EquilateralTrimerMinimum':[
  ('全局极小值-3','-3≤uniformLJEnergy 1 1 q','一致'),
  ('达到极小当且仅当三边等于2^(1/6)','能量=-3 ↔ ∀i≠j,pairDistance…=Real.rpow 2 (1/6)','一致')],
 'MD-1.7.2-FlowJacobianLiteral':[
  ('W的取值点为z(t,ξ)=Ftξ','fderiv ℝ (F t) (F t ξ)','[ERRATUM?] 字面保留，未换为ξ')],
 'MD-1.7.2-LyapunovExponents':[
  ('limsup与有序奇异值','Filter.limsup ((Real.log (σ t)/t : ℝ) : EReal) atTop；σ为singularValues关系的第i分量','一致')],
 'MD-1.7.2-PositiveLyapunovGrowth':[
  ('正limsup蕴涵指数放大','∃c>0,∀T,∃t>T,Real.exp(c*t)<σ t','一致；任意晚子列，不增强为全部晚时刻')],
}

def finalize():
    ss=json.loads((BASE/'ch01_source.json').read_text(encoding='utf-8-sig'))
    audit=json.loads((BASE/'local_audit.json').read_text(encoding='utf-8'))
    ds=declarations();rr={r['source_id']:r for r in RECORDS}
    dest=BASE/'validation/proof-attempts';dest.mkdir(parents=True,exist_ok=True)
    attempts=[]
    for sid,(n,f,logs) in ATTEMPTS.items():
        copied=[]
        for log in logs:
            src=ROOT/'tmp/ch01_full'/f'{log}.log';target=dest/src.name
            if src.exists():shutil.copyfile(src,target)
            assert target.exists(),target
            copied.append({'file':target.relative_to(ROOT).as_posix(),
                'sha256':hashlib.sha256(target.read_bytes()).hexdigest()})
        attempts.append({'source_id':sid,'distinct_attempts':n,'failed_attempts':f,
            'timebox_exhausted':sid in FAILED_PROOFS,'logs':copied})
    save(BASE/'proof_attempts.json',attempts)
    for s in ss:
        sid=s['source_id'];a=audit['items'].get(sid);d=ds[sid]
        assert a is not None,sid
        if sid in rr:
            r=rr[sid]
            a.update(verdict=r['local_verdict'],explanation=r['local_explanation'],
                documented_priors=r['priors'],missing=r['missing'])
        placeholder=bool(re.search(r'\bsorry\b',d['block']))
        a['direct_placeholder']=placeholder
        local_ids=set(PROOFS)|{'MD-1.2-ConstraintDimension','MD-1.2-PairCancellation','MD-1.2-LJCoordinateScaling'}
        a['proof_status']=('placeholder' if placeholder else 'definition' if d['statement'].startswith('def ') else
            'local_proof' if sid in local_ids else 'existing_bridge')
        if not placeholder:a['missing']=None;a['suggested_fix']=None
        elif a['verdict']=='PASS':
            a['missing']=TIMEBOX.get(sid,LARGE.get(sid,a.get('missing')))
            a['suggested_fix']=a['missing']
            a['proof_stop_reason']='three_failed_attempts' if sid in TIMEBOX else 'missing_large_theory'
        if not placeholder:
            a['explanation']=a['explanation'].replace('语义本地通过，证明尚未完成。','语义本地通过，完整Lean检查另行登记。')
        if sid in ATTEMPTS:
            a['proof_attempts'],a['proof_failures'],_=ATTEMPTS[sid]
            a['attempt_evidence']='blueprint/ch01/proof_attempts.json'
        # Formula-level source quotations plus the expanded signature expose all
        # clauses even for imported predicates. Website C will recheck definitions.
        formulae=re.findall(r'\\\[[\s\S]*?\\\]',s['statement_latex'])
        rows=[dict(source='原文对象、量词、前提与完整定义/结论（见第2段逐字引用）',
            lean=d['statement'],note='一致' if a['verdict']=='PASS' else a['verdict'])]
        if formulae:rows.append(dict(source='；'.join(formulae),lean=d['name']+'，完整展开陈述见上一行及第4段',note='一致' if a['verdict']=='PASS' else a['verdict']))
        rows.extend(dict(source=x,lean=y,note=z) for x,y,z in COMPONENTS.get(sid,[]))
        rows.extend(dict(source='原文未显式量化的技术资格',lean=x,note='[EXTRA]') for x in s.get('extra_assumptions',[]))
        a['correspondence']=rows
        human=[i for i in s.get('issues',[]) if i.get('status')=='NEEDS_HUMAN']
        if human:
            a['source_questions']=[i['detail'] for i in human]
            if a['verdict']!='PASS':a['counterexample']='；'.join(i['detail'] for i in human)
        if sid=='MD-1.7-ConstantRotationLiteral':
            a['counterexample']='r(t)=sqrt(1+t²)、θ(t)=arctan t、ℓ=1；r²θ′≡1但θ′(0)=1、θ′(1)=1/2。解析反例，未作为Lean证明提交。'
        s['review_status']='DRAFT'
        s['source_page_verification']='VERIFIED_RENDERED; source_page_checks.json'
    save(BASE/'ch01_source.json',ss);save(BASE/'local_audit.json',audit)
    pdf=next(ROOT.parent.glob('Leimkuhler2015b*.pdf'))
    pages=[]
    for printed in range(1,46):
        number=printed+23;stem=f'pdf{number:03}'
        png=ROOT/'tmp/ch01_full'/f'{stem}.png';txt=png.with_suffix('.txt')
        assert png.exists() and txt.exists(),printed
        pages.append({'printed_page':printed,'pdf_page':number,'visual_check':'VERIFIED_RENDERED',
            'render_scale':1.3,'png':png.relative_to(ROOT).as_posix(),
            'render_sha256':hashlib.sha256(png.read_bytes()).hexdigest(),
            'extracted_text_sha256':hashlib.sha256(txt.read_bytes()).hexdigest(),
            'note':'已查看渲染原页并用于逐字数学转录；提取文本仅辅助，不替代视觉核对。'})
    save(BASE/'source_page_checks.json',{'source_pdf':pdf.name,
        'sha256':hashlib.sha256(pdf.read_bytes()).hexdigest(),'pages':pages,
        'render_artifacts':'PNG/TXT留在本地tmp，不作为交付依赖；可从同一PDF重渲染核对。',
        'detail_check':'Gay–Berne印刷p.16/PDF39放大核实εGB=ε₁ε₂，原页无ε₂平方。'})
    exclusions=[
      ('1–4','介绍、历史、应用、规模与图示，没有独立数学定义或有原文论证的数学结论。'),
      ('10–11','LJ长模拟中分离的经验说明并入极限条目背景；不虚构全局无碰撞定理。'),
      ('14–16','Stillinger–Weber/EAM/Bond Order/United atom的模型分类与经验用途无具体原文公式，旧CH01-031–034按定性描述排除。'),
      ('17–18','经验参数拟合、细粒/粗粒势、模型准确性与模拟可靠性讨论，无固定数学命题。'),
      ('20','跨转向点拼接仅是方法提示，没有全局假设与定理；局部quadrature完整保留。'),
      ('22','最小作用量的历史介绍明确指向第2章，正文无独立变分命题，不进入第2章。'),
      ('38–39','三体运动模拟选择与可视化说明；零动量到等腰规约的疑点记IsoscelesCoordinates，不冒充一般规约定理。'),
      ('42–43','ε≠0模型的仅有能量积分、混沌与轨道图示为数值/定性观察，无解析论证；能量函数与混沌定义已完整登记。'),
      ('45','数值Lyapunov指数约0.28为特定实验估计，没有可验证误差论证；定义及正指数的增长结论已登记。'),
    ]
    save(BASE/'excluded_passages.json',[{'classification':'excluded_qualitative','printed_page':p,
        'pdf_page':'–'.join(str(int(x)+23) for x in re.findall(r'\d+',p)),'reason':why} for p,why in exclusions])
    old=BASE/'mathcopilot_tasks/PILOT_ALL.md'
    if old.exists():
        target=old.parent/'archive/PILOT_ALL.md'
        assert not target.exists(),'Refuse to overwrite archived task'
        old.rename(target)
    sync()
    (ROOT/'docs/review/CH01_BLUEPRINT.zh-CN.md').write_text(
        render(BASE/'ch01_source.json',ROOT/'Blueprint/Ch01.lean',BASE/'local_audit.json'),encoding='utf-8')
    print('Final evidence, literal-error questions and correspondence regenerated.')

if __name__=='__main__':finalize()

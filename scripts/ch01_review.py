"""Refresh stable claim IDs, extract statement-only code, and build review artifacts."""
from pathlib import Path
import csv,re,json,collections
root=Path(__file__).resolve().parents[1]
review=root/'docs/review'
csvpath=review/'CH01_CLAIMS.csv'
rows=list(csv.DictReader(csvpath.open(encoding='utf-8-sig')))
newfiles=[root/'MolecularDynamics/Chapter01'/f for f in ['ReviewDefinitions.lean','Statements.lean','ReviewProofs.lean']]
pat=re.compile(r'(?m)^(?:noncomputable )?(def|abbrev|theorem|structure) (\w+)')
newdecl={}
for p in newfiles:
    s=p.read_text(encoding='utf-8-sig')
    for m in pat.finditer(s):
        newdecl[m[2]]=(p.relative_to(root).as_posix(),s[:m.start()].count('\n')+1,m[1])
aliases={
'CH01-047':['Chapter01Review.forceGradient_statement'],
'CH01-080':['legendre_objective_eq_massHamiltonian_iff','Chapter01Review.legendreMaximizer_statement'],
'CH01-081':['hasGradientAt_massLagrangian_velocity','Chapter01Review.generalizedMomentum_statement'],
'CH01-082':['Chapter01Review.quadraticH'],
'CH01-083':['massHamiltonian_eq_legendre_sup','Chapter01Review.generalizedLegendreSup_statement'],
'CH01-084':['Chapter01Review.symplecticGradient'],
'CH01-087':['Chapter01Review.finiteEnergyPhaseSpace'],
'CH01-094':['isCompact_phaseEnergySublevel','Chapter01Review.uniformLevelsCompact_statement'],
'CH01-107':['Chapter01Review.matrixExponentialSeries_hasSum'],
'CH01-113':['keplerPotential','momentumKineticEnergy','massHamiltonian'],
'CH01-124':['keplerRadial_nonturning_quadrature','Chapter01Review.keplerQuadratureGlobal_statement'],
'CH01-126':['exists_kepler_localIVP_radialReconstruction','Chapter01Review.keplerFullReconstruction_statement'],
'CH01-127':['harmonicActionPosition','harmonicActionVelocity'],
'CH01-131':['HarmonicTorus','harmonicTorusPhase','harmonicTorusPhase_rotation_isMechanical'],
'CH01-133':['harmonicTorusRotation_two_dense','Chapter01Review.torusDense_statement'],
'CH01-143':['Chapter01Review.mechanicalEquilibrium_iff'],
'CH01-155':['boxPeriodicNearestNeighborPotentialEnergy_translate','Chapter01Review.periodicMomentum_statement'],
'CH01-167':['gradientLinearization_expansion','gradientLinearizationRemainder_isLittleO'],
'CH01-192':['linearExponentialFlow_isConstantVariationalSolution','Chapter01Review.variationalEquationLiteral_statement','Chapter01Review.variationalEquation_statement'],
}
proved_keys=['kineticEnergyBound','positionEnergyBound','minimumGradientZero','isoscelesEnergyBound','trimerLowerBound']
for r in rows:
    ident=r['id']
    if '待补' in r['文件:行号']:
        key=r['Lean声明名'].split('.')[-1].removesuffix('_statement')
        if key in newdecl:
            r['Lean声明名']='MolecularDynamics.Chapter01Review.'+key
            file,line,kind=newdecl[key]
            r['文件:行号']=f'{file}:{line}'
            r['状态']='proved'
            r['备注']=r['备注'].replace('；清单阶段：待补忠实陈述，未计为证明','')+'；定义/notation已实现，此状态不表示解存在或经验模型已验证'
        else:
            assert key+'_statement' in newdecl, (ident,key)
            file,line,kind=newdecl[key+'_statement']
            r['文件:行号']=f'{file}:{line}'
            r['备注']=r['备注'].replace('；清单阶段：待补忠实陈述，未计为证明','')+'；Prop陈述未证明'
        if key in proved_keys:
            aliases[ident]=['Chapter01Review.'+key+'_statement','Chapter01Review.'+key+'_proved']
            r['状态']='proved'
            r['备注']=r['备注'].replace('；Prop陈述未证明','')+'；完整证明见ReviewProofs'
    if ident in aliases:
        names=['MolecularDynamics.'+x for x in aliases[ident]]
        loc=[]
        for name in names:
            if '.Chapter01Review.' in name:
                f,l,_=newdecl[name.split('.')[-1]]
            else:
                existingfile=r['文件:行号'].split(';')[0].split(':')[0]
                # Look up source independently; no historical hash re-computation.
                matches=[]
                for p in [root/'MolecularDynamics/Notation.lean',*sorted((root/'MolecularDynamics/Chapter01').glob('*.lean'))]:
                    text=p.read_text(encoding='utf-8-sig')
                    pattern=r'(?m)^(?:@\[[^\n]*\]\s*)?(?:noncomputable )?(?:def|abbrev|theorem|structure) '+re.escape(name.split('.')[-1])+r'\b'
                    m=re.search(pattern,text)
                    if m: matches.append((p.relative_to(root).as_posix(),text[:m.start()].count('\n')+1))
                assert matches, name
                f,l=matches[0]
            loc.append(f'{f}:{l}')
        r['Lean声明名']=';'.join(names)
        r['文件:行号']=';'.join(loc)
    if ident in ['CH01-047','CH01-082','CH01-084','CH01-087','CH01-107','CH01-143']:
        r['状态']='proved'
    if ident=='CH01-143':r['备注']='固定正质量；实际向量场平衡等价p=0与梯度U=0，已完整证明'
    if ident=='CH01-107':r['备注']='所有有限实方阵；HasSum明确断言整个指数级数收敛，新增完整证明复用Mathlib'
    if ident=='CH01-167':r['备注']='真实C2势、平衡梯度零；恒等式与小o余项两条一起映射'
    if ident=='CH01-134':
        r['状态']='not_formalizable_now'
        r['备注']='已给局部辛action-angle及全环面运动的忠实Prop；补充紧、连通、满秩正则层等标准条件。固定Mathlib缺完整Liouville-Arnold、辛流形与action-angle坐标证明基础，本阶段不搭建'
    if ident=='CH01-192':r['备注']='已有常系数完整证明；补齐打印W取值点字面Prop及在初值xi取导数的修正版Prop；一般非线性均未证明，不能用常系数冒充'
    if ident=='CH01-179':
        r['原文陈述(英文原句或忠实转述)']='Conservation of angular momentum is said to imply rotation at a constant rate in time.'
        r['备注']='字面推论一般不成立：r变化时theta_dot=l/r^2。Prop保留该断言供审阅，未证明'
    if ident=='CH01-207':r['备注']='针对前文质心固定、等腰、零角动量的正能量模型；字面一般逃逸断言未证明，待人工判断'
    if ident=='CH01-031':
        r['状态']='weakened';r['备注']='仅形式化二体/三体分解；原文偏好四面体结构的定性模型性质无具体公式或条件，未证明'
    if ident=='CH01-032':
        r['状态']='weakened';r['备注']='用任意嵌入函数和邻居密度参数化标准模型形式；原文无公式，具体物理模型与逼真性未经证明'
    if ident=='CH01-033':
        r['状态']='weakened';r['备注']='用依赖局部配置的bond-order系数实现模型模板；原文无指定函数，不声称结构稳定性证明'
    if ident=='CH01-034':
        r['状态']='weakened';r['备注']='已实现原子到pseudoatom的满射分组；有效势的物理近似/平均效应没有数学定义，未证明'
with csvpath.open('w',encoding='utf-8-sig',newline='') as f:
    w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)

def code_for(name,loc):
    path,lineno=loc.rsplit(':',1)
    s=(root/path).read_text(encoding='utf-8-sig')
    start=sum(len(line)+1 for line in s.splitlines()[:int(lineno)-1])
    # Offset based on normalized read_text newlines.
    tail=s[start:]
    # Stop at next declaration or namespace/section end, including doc comments.
    boundary=re.search(r'\n(?:/[-*]|(?:@\[[^\n]*\]\s*)?(?:noncomputable )?(?:def|abbrev|theorem|structure) |end\b|section\b|variable\b|omit\b)',tail)
    text=tail[:boundary.start() if boundary else len(tail)].rstrip()
    text=re.sub(r'^@\[[^\n]*\]\s*','',text)
    if re.match(r'(?:noncomputable )?theorem ',text):
        if ':=' in text:text=text.split(':=',1)[0].rstrip()
        else:raise RuntimeError((name,'missing proof delimiter'))
    # Do not paste implementation proof terms in a statement.
    text=re.sub(r'\(by exact \([^\n]*','(proof argument omitted)',text) if False else text
    context=[]
    prefix=s[:start]
    if '{E' in text or ' E' in text:
        context.append('variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]')
    return '\n'.join(context+[text])

counts=collections.Counter(r['状态'] for r in rows)
nonproved=[r for r in rows if r['状态']!='proved']
questions=[
'印刷32的Hartman–Grobman是否应将smooth invertible map改为局部homeomorphism？本交付保留字面未证明Prop。',
'印刷37的“极小点Hessian正定”是否应改为半正定并另加非退化条件？x^4的严格极小已提示该问题。',
'印刷44的W应在初值xi处取流导数，而非z(t,xi)处吗？字面与修正版均给出，现有证明仅常系数。',
'印刷34任意均匀势的正则晶格极小、印刷39定角速度、印刷40正能量必逃逸，哪些需要补假设或降为经验说明？',
'定性势模型模板、有限27副本PBC及高维无共振/紧正则层假设是否忠实体现本章希望交付的范围？拓扑传递与遍历性还需指定不变测度。'
]
intro='''# 第1章人工审阅材料

正文：印刷1–46 / PDF24–69；Exercises从印刷46中途开始，全部排除。清单是唯一进度来源。
`proved`含已实现的定义和完整证明的结论，不能把两者都称为定理证明数量；`statement_only`与`not_formalizable_now`仅有Prop陈述，编译通过不等于命题成立。
旧成果复用固定版本正式库；新增结果的机器验证见 `CH01_VALIDATION.json`。负责人原文语义审阅尚未进行，本文件就是待审材料。
类型别名和定义需要展示定义体；定理只展示陈述，不展示证明。代码块需在工程导入、命名空间及各节的隐式参数环境中阅读，不能逐块独立编译。
新增配置相关质量采用正定性；旧成果多为固定正对角质量。物理奇异公式限制到备注中的正距离等域。

| 状态 | 条数 |
| --- | ---: |
'''
intro+=''.join(f'| {status} | {counts[status]} |\n' for status in ['proved','statement_only','weakened','not_formalizable_now'])
verified_definitions=sum(r['状态']=='proved' and r['类型'] in ['notation','定义'] for r in rows)
verified_conclusions=counts['proved']-verified_definitions
intro+=f'| 合计 | {len(rows)} |\n\n需要人工判断的问题：\n\n'+'\n'.join(f'{i}. {q}' for i,q in enumerate(questions,1))+'\n\n全部待证或有差异的条目：\n\n'
intro=intro.replace('需要人工判断的问题：',f'proved中有{verified_definitions}条notation/定义、{verified_conclusions}条数学结论；完整章节交付包含未证明的忠实陈述。\n\n需要人工判断的问题：',1)
intro+='\n'.join(f'- {r["id"]}（§{r["节号"]}，p.{r["印刷页"]}，{r["状态"]}）：{r["原文陈述(英文原句或忠实转述)"]}' for r in nonproved)+'\n'
def entry(r):
    codes='\n\n'.join(code_for(n,l) for n,l in zip(r['Lean声明名'].split(';'),r['文件:行号'].split(';')))
    return f'\n### {r["id"]} · {r["类型"]} · 印刷p.{r["印刷页"]} / PDF{r["PDF页"]}\n\n原文（忠实转述）：{r["原文陈述(英文原句或忠实转述)"]}\n\n```lean\n{codes}\n```\n\n差异及额外假设：{r["备注"]}。\n\n状态：**{r["状态"]}**。位置：`{r["文件:行号"]}`。\n'
text=intro
for sec in dict.fromkeys(r['节号'] for r in rows):
    text+=f'\n## §{sec}\n'
    text+=''.join(entry(r) for r in rows if r['节号']==sec)
(review/'CH01_REVIEW.zh-CN.md').write_text(text,encoding='utf-8')
selected=['CH01-054','CH01-056','CH01-073','CH01-083','CH01-095','CH01-105','CH01-109','CH01-126','CH01-133','CH01-134','CH01-140','CH01-145','CH01-169','CH01-192','CH01-196']
short='# 第1章导师快速审阅（15条）\n\n'+intro.split('| 状态')[1].split('全部待证或有差异')[0]
short=short.replace('\n |','\n|')
short='# 第1章导师快速审阅（15条）\n\n详表与全部差异见 CH01_REVIEW.zh-CN.md；这里挑出基础守恒、Theorem 1.1及最重要的覆盖边界。\n\n| 状态'+intro.split('| 状态',1)[1].split('全部待证或有差异')[0]+''.join(entry(next(r for r in rows if r['id']==ident)) for ident in selected)
(review/'CH01_REVIEW_SHORT.zh-CN.md').write_text(short,encoding='utf-8')
allnames=sorted(set(n for r in rows for n in r['Lean声明名'].split(';')))
audit=['import MolecularDynamicsFormalization']+[f'#check {n}' for n in allnames]+[f'#print axioms {n}' for n in allnames]
(root/'scripts/CheckChapter01Review.lean').write_text('\n'.join(audit)+'\n',encoding='utf-8')
print(json.dumps({'rows':len(rows),'counts':dict(counts),'unique_mapped_declarations':len(allnames),'pending_locations':sum('待补' in r['文件:行号'] for r in rows)},ensure_ascii=False))

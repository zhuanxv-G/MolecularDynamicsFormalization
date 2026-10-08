"""Resolve maintained CSVs and render proof-free review material plus audits."""
from pathlib import Path
import csv, re, json, collections, sys
root=Path(__file__).resolve().parents[1]; ch=int(sys.argv[1]); tag=f'CH{ch:02}'
review=root/'docs/review'; path=review/f'{tag}_CLAIMS.csv'
rows=list(csv.DictReader(path.open(encoding='utf-8-sig')))
index={}
for p in sorted((root/'MolecularDynamics').rglob('*.lean')):
    s=p.read_text(encoding='utf-8-sig'); namespaces=[]
    for line in s.splitlines():
        if line.startswith('namespace '): namespaces.append(line[10:].strip())
        if line.startswith('end ') and namespaces and line[4:].strip()==namespaces[-1]: namespaces.pop()
        m=re.match(r'(?:@\[[^\n]*\]\s*)?(?:noncomputable )?(def|abbrev|theorem|structure)\s+([\w.]+)',line)
        if m:
            name='.'.join(namespaces+[m[2]])
            # Declaration line itself, independently verified from source.
            pattern=re.compile(r'(?m)^(?:@\[[^\n]*\]\s*)?(?:noncomputable )?'+m[1]+r'\s+'+re.escape(m[2])+r'\b')
            hit=pattern.search(s); start=hit.start(); tail=s[start:]
            boundary=re.search(r'\n(?:/[-*]|(?:@\[[^\n]*\]\s*)?(?:private |protected )?(?:noncomputable )?(?:def|abbrev|theorem|structure) |end\b|section\b|variable\b|omit\b)',tail)
            code=tail[:boundary.start() if boundary else len(tail)].strip()
            if m[1]=='theorem': code=code.split(':=',1)[0].rstrip()
            else:
                proof_fields=re.search(r'(?m)^  (?:map_\w+\x27|one_mem\x27|mul_mem\x27|inv_mem\x27)',code)
                if proof_fields:code=code[:proof_fields.start()].rstrip()+'\n  -- 结构证明字段省略；完整定义见源码'
            index[name]={'loc':f'{p.relative_to(root).as_posix()}:{s[:start].count(chr(10))+1}',
                         'code':code,'kind':m[1]}
ns=f'MolecularDynamics.Chapter{ch:02}Review.'
if ch==2:
    upgrades={'wedgeSelf_statement':'wedgeSelf_proved','errorDifference_statement':'errorDifference_proved',
      'verletSymplectic_statement':'verletSymplectic_proved','velocityVerletStormer_statement':'velocityVerletStormer_proved',
      'newmarkReduction_statement':'newmarkReduction_proved','explicitRKNotSymplectic_statement':'explicitRKNotSymplectic_proved',
      'eulerVolumeCounterexample_statement':'eulerVolumeCounterexample_proved',
      'verletComposition_statement':'verletComposition_proved',
      'symplecticEulerConjugacy_statement':'symplecticEulerConjugacy_proved',
      'kineticPotentialComposition_statement':'kineticPotentialComposition_proved'}
    faithful={'CH02-063':'liouville_statement','CH02-065':'hamiltonianVolume_statement',
      'CH02-067':'flowVariational_statement','CH02-070':'flowDet_statement',
      'CH02-092':'hamiltonianDet_statement','CH02-095':'hamiltonianVariational_statement',
      'CH02-098':'hamiltonianSymplectic_statement'}
    extra={'verletDefectExpansion_statement':['verletDefectPrinted_statement'],
      'integralError_statement':['integralErrorPrinted_statement'],
      'generalSymplectic_statement':['generalizedVerletSymplectic_statement'],
      'newmarkReduction_statement':['newmarkPrintedReduction_statement'],
      'takahashiForce_statement':['takahashiForceCorrected_statement']}
    extra['explicitRKNotSymplectic_statement']=['explicitRKUniversal_statement']
    for r in rows:
        if r['id']=='CH02-120':
            r['Lean声明名']=ns+'kineticPotentialComposition_statement';r['状态']='statement_only'
        if r['id']=='CH02-115': r['Lean声明名']=ns+'splittingMap'
        names=r['Lean声明名'].split(';'); new=[]
        if ns+'firstIntegralPreserved_statement' in names:
            new.append('MolecularDynamics.firstIntegral_const_on_Ioo');r['状态']='proved'
            r['备注']+='；复用第1章开放时间区间完整守恒证明；所附较强闭区间Prop仍未证明'
        if 'MolecularDynamics.textbookSymplecticDiffeomorphismGroup' in names:
            new.append('MolecularDynamics.textbookSymplecticDiffeomorphismGroup_mem_iff')
        for name in names:
            leaf=name.removeprefix(ns)
            proof=ns+upgrades.get(leaf,'')
            if proof in index:
                new.append(proof);r['状态']='proved'
                r['备注']+='；新增完整证明，经单文件构建'
                new.append(name)
            else:new.append(name)
            new.extend(ns+x for x in extra.get(leaf,[]) if ns+x not in new)
        if r['id'] in faithful:
            new.append(ns+faithful[r['id']])
            new.append(ns+('localLiouville_statement' if r['id'] in ['CH02-063','CH02-067','CH02-070'] else 'localHamiltonianStructures_statement'))
        r['Lean声明名']=';'.join(dict.fromkeys(new))
        if 'explicitRKUniversal_statement' in r['Lean声明名']:
            r['状态']='weakened';r['备注']+='；已证严格下三角A不能满足辛系数条件；原文普适不辛结论的必要性/实际RK反例仍仅Prop'
        if 'gaussRK_statement' in r['Lean声明名']:
            r['状态']='not_formalizable_now';r['备注']+='；缺一般Gauss配点阶条件与对称性理论；给实际Legendre节点/积分系数及唯一阶段条件的完整Prop，未证'
else:
    for r in rows:
        name=r['Lean声明名'];leaf=name.removeprefix(ns)
        proof=ns+leaf.replace('_statement','_proved')
        if leaf.endswith('_statement') and proof in index:
            r['Lean声明名']=proof+';'+name;r['状态']='proved';r['备注']+='；新增完整证明，经单文件构建'
        extras={'theorem31_statement':['analyticBEA_statement'],
          'verletModifiedH_statement':['verletModifiedHPrinted_statement']}
        for key,more in extras.items():
            if key in name:r['Lean声明名']+=';'+ ';'.join(ns+x for x in more)
for r in rows:
    names=r['Lean声明名'].split(';')
    names=[ns+n.removeprefix('MolecularDynamics.') if n not in index and ns+n.removeprefix('MolecularDynamics.') in index else n for n in names]
    r['Lean声明名']=';'.join(names)
    missing=[n for n in names if n not in index]
    if missing:raise RuntimeError((r['id'],missing))
    r['文件:行号']=';'.join(index[n]['loc'] for n in names)
    r['备注']=r['备注'].replace('；计划声明，补齐阶段核实','')
    r['备注']='；'.join(dict.fromkeys(r['备注'].split('；')))
    if r['状态']=='defined': assert r['类型'] in ['notation','定义'],r['id']
with path.open('w',encoding='utf-8-sig',newline='') as f:
    w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)
counts=collections.Counter(r['状态'] for r in rows)
questions={2:[
 '印刷63的L中+U与实际展开-U不一致，端点q_nu又被列为可变节点；是否统一采用固定两端、仅内部驻值的版本？',
 '印刷68位置局部误差符号、印刷71常数1/2、印刷93修正力符号是否是笔误？字面Prop和修正版均保留，字面版没有证明。',
 '印刷79能否将“辛映射形成群”明确限于辛微分同胚？非零Jacobian只提供局部逆；流Jacobian应在初值处取导。',
 '印刷92 Newmark位置公式缺逆质量，是否采用质量一致版本？一般隐式方法均应明确局部解和非奇异条件。',
 'Liouville/流辛性现有jointC2假设是否接受为较强实现条件？一般C1流、变分原理、Gauss配点等完整Prop均未证明。'],3:[
 'Theorem3.1的C^infinity、每个固定k的代数长时间界，是否应与额外解析性下的指数小匹配/指数长时间界严格区分？',
 '形式级数、有限截断和实际收敛级数是否清楚区分？全阶构造与匹配仅陈述，有限系数和有条件能量界已有证明。',
 'Verlet修正Hamiltonian系数、Takahashi–Imada势修正符号及正文中辛性/能量“不可能同时保持”的限定条件，是否需勘误？',
 '时间可逆需要固定反演R和唯一局部流，不能从自伴随直接推出；投影修正需E-U≥0和非零动能，是否接受这些补假设？',
 '硬球碰撞需二元非擦碰、正质量和排除同时多重碰撞；这些局部模型是否足够忠实，长期误差阶是否需进一步条件？']}[ch]
scope={2:'印刷53–93 / PDF75–115；习题从印刷94开始，数值实验及数值图表排除。',
       3:'印刷97–136 / PDF119–158，止于印刷136的Exercises标题；数值实验、图表及纯实现伪代码排除。'}[ch]
intro=f'# 第{ch}章人工审阅材料\n\n{scope}\n清单为唯一进度来源；定义不计为证明。Prop定义编译通过不表示命题成立。\n'
intro+='忠实转述来自用户提供的教材PDF；问题公式以原页图像复核。代码块保留陈述和必要定义体，不贴证明；须在工程导入与对应命名空间/节参数环境中阅读。\n'
intro+='原文语义尚待导师审阅；机器验收证据见本章VALIDATION.json及check-full目录。\n\n| 状态 | 条数 |\n| --- | ---: |\n'
intro+=''.join(f'| {status} | {counts[status]} |\n' for status in ['defined','proved','statement_only','weakened','not_formalizable_now'])
intro+=f'| 合计 | {len(rows)} |\n\n已证明结论数：{sum(r["状态"]=="proved" and r["类型"] in ["定理","未编号结论"] for r in rows)}（按清单行统计，重复映射同一证明不是独立定理）。\n\n需要人工判断的问题：\n\n'
intro+='\n'.join(f'{i}. {q}' for i,q in enumerate(questions,1))+'\n'
def entry(r):
    blocks=[]
    for name in r['Lean声明名'].split(';'):
        d=index[name];blocks.append('-- '+name+'\n'+d['code'])
    return f'\n### {r["id"]} · §{r["节号"]} · {r["类型"]} · 印刷p.{r["印刷页"]} / PDF{r["PDF页"]}\n\n原文（忠实转述）：{r["原文陈述(英文原句或忠实转述)"]}\n\n```lean\n'+ '\n\n'.join(blocks)+f'\n```\n\n差异及额外假设：{r["备注"]}。\n\n状态：**{r["状态"]}**。位置：`{r["文件:行号"]}`。\n'
full=intro+''.join(entry(r) for r in rows)
(review/f'{tag}_REVIEW.zh-CN.md').write_text(full,encoding='utf-8')
selected={2:['CH02-012','CH02-027','CH02-033','CH02-041','CH02-050','CH02-063','CH02-064','CH02-095','CH02-099','CH02-121','CH02-122','CH02-136','CH02-143','CH02-148','CH02-158'],
          3:[]}[ch]
if not selected: selected=[r['id'] for r in rows if r['类型']=='定理']+ [r['id'] for r in rows if r['状态']=='proved'][:6]+[r['id'] for r in rows if r['状态']=='statement_only'][:8]
selected=list(dict.fromkeys(selected))[:15]
while len(selected)<15:
    selected.append(next(r['id'] for r in rows if r['id'] not in selected))
(review/f'{tag}_REVIEW_SHORT.zh-CN.md').write_text(intro.replace('人工审阅材料','导师快速审阅（15条）')+
  ''.join(entry(next(r for r in rows if r['id']==i)) for i in selected),encoding='utf-8')
names=sorted(set(n for r in rows for n in r['Lean声明名'].split(';')))
(root/f'scripts/CheckChapter{ch:02}Review.lean').write_text('import MolecularDynamicsFormalization\n'+
  '\n'.join(f'#check {n}\n#print axioms {n}' for n in names)+'\n',encoding='utf-8')
print(json.dumps({'rows':len(rows),'counts':dict(counts),'mapped_declarations':len(names)},ensure_ascii=False))

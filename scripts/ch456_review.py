"""Resolve chapter 4-6 CSV mappings and produce proof-free review artifacts."""
from pathlib import Path
import csv,re,json,collections,sys
root=Path(__file__).resolve().parents[1];ch=int(sys.argv[1]);tag=f'CH{ch:02}'
review=root/'docs/review';path=review/f'{tag}_CLAIMS.csv'
rows=list(csv.DictReader(path.open(encoding='utf-8-sig')))
index={}
decl=re.compile(r'^(?:@\[[^\n]*\]\s*)?(?:noncomputable )?(def|abbrev|theorem|lemma|structure)\s+([\w.]+)')
for p in sorted((root/'MolecularDynamics').rglob('*.lean')):
    lines=p.read_text(encoding='utf-8-sig').splitlines();ns=[]
    for i,line in enumerate(lines):
        if line.startswith('namespace '):ns.append(line[10:].strip())
        if line.startswith('end ') and ns and line[4:].strip()==ns[-1]:ns.pop()
        m=decl.match(line)
        if not m:continue
        name='.'.join(ns+[m[2]])
        j=i+1
        while j<len(lines) and not (decl.match(lines[j]) or re.match(r'^(?:/[-*]|end\b|namespace\b|section\b|variable\b|omit\b|private\b|protected\b)',lines[j])):j+=1
        code='\n'.join(lines[i:j]).strip()
        if m[1] in ['theorem','lemma']:code=code.split(':=',1)[0].rstrip()
        index[name]={'loc':f'{p.relative_to(root).as_posix()}:{i+1}','code':code,'kind':m[1]}
for r in rows:
    names=list(dict.fromkeys(r['Lean声明名'].split(';')))
    missing=[n for n in names if n not in index]
    if missing:raise RuntimeError((r['id'],missing))
    r['文件:行号']=';'.join(index[n]['loc'] for n in names)
    if r['状态']=='defined':assert r['类型'] in ['notation','定义'] and all(index[n]['kind'] not in ['theorem','lemma'] for n in names),r
    if r['状态']=='proved':assert any(index[n]['kind'] in ['theorem','lemma'] for n in names),r
    if r['状态'] in ['statement_only','not_formalizable_now']:
        assert any(n.endswith('_statement') and '/Statements.lean:' in index[n]['loc'] for n in names),r
with path.open('w',encoding='utf-8-sig',newline='') as f:
    w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)
scope={
4:'扫描用户指定PDF159–197；实际第4章标题在印刷139/PDF161，正文止于印刷174/PDF196。PDF159–160是第3章习题；印刷175/PDF197从Exercises开始，均不纳入。§4.3.7是数值实验，逐页核对后排除。介绍模型、图表、实现成本与经验性能不作为独立数学交付。',
5:'扫描用户指定PDF199–231；实际页码及章节标题边界以本章PAGE_SCAN.json为准。数值实验、介绍性模型和Exercises不纳入。微正则、Liouville、遍历和KAM一般理论只登记明确缺口，不搭建。',
6:'扫描PDF233–285至Exercises标题前；逐页边界见PAGE_SCAN.json。全部proved/weakened为既有正式库成果映射，本次没有新证明。CanonicalKernelConstant等封存文件不导入、不恢复。Theorem6.1、Theorem6.2、Proposition6.4保持statement_only。'}[ch]
questions={
4:['印刷142把trapezoidal写为Implicit Midpoint；144却使用真正midpoint。是否接受字面和实际算法分列？',
   '印刷140显式辛PRK最大阈值2/Omega是否隐含阶段数或单位计算成本？分步组合可以改变阈值，书中文字面普适陈述未证明。147特征值sqrt项系数是否有误？',
   '位置投影/受约束Euler和RATTLE现有证明只接受给定光滑分支；隐式解存在、唯一选根及算法阶是否允许继续保持仅陈述？SHAKE/RATTLE乘子缩放需如何统一？',
   '公式(4.25)约束反力的M^-1、(4.40)的1/2、DLM drift的1/M和spin符号是否需勘误？字面版与质量一致版均保留；旋转惯性矩阵需非奇异。',
   'C2/C3约束、正质量与梯度独立的明确假设是否忠实表达原文局部正则框架？joint C2流证明是否应标为较强实现条件？'],
5:['微正则测度是否采用能量面Hausdorff/Riemannian测度乘1/abs(grad H)的规范？该几何构造尚无一般证明。',
   'Theorem5.1公式使用div(g u)，其几何平均校正本身不假设ergodic；数值轨道解释另需ergodicity。实现补统一紧能量带/非零分母/正有限raw mass，是否接受这些较强技术条件？',
   '遍历定义的量词是每个可积观测量分别几乎处处，还是共同满测集？Birkhoff条件平均与空间平均不可无条件等同。',
   '原文KAM需非退化、Diophantine条件及有限光滑/解析正则性；是否接受显式列出这些条件，正文定性结论仅陈述？',
   '印刷页与PDF页偏移发生变化；本章标题/Exercises/下章标题边界是否接受本次原页核对？'],
6:['Prop6.1–6.3的已验收内容与原文一般质量/域/正则性是否一致？单位质量、单位周期实现的范围差异已逐行列明。',
   'Theorem6.1已有谱和Brownian依赖，但完整指数收敛仍缺 semigroup/谱展开及实际过程桥接；是否接受保持statement_only？',
   'Theorem6.2已有真实过程、kernel、Markov/Chapman–Kolmogorov依赖；唯一不变测度和完整遍历结论仍不能由这些依赖直接记为proved。',
   'Proposition6.4的Poisson方程完整存在/唯一模核仍缺Fredholm、紧预解和核识别；封存CanonicalKernelConstant不计正式验收，是否明确？',
   'Lemma6.1可达性已证单位质量/单位周期模型，但原文更一般域/质量和适应性语义签核仍需人工判断；相关行是否应保留weakened？']}[ch]
counts=collections.Counter(r['状态'] for r in rows)
intro=f'# 第{ch}章人工审阅材料\n\n{scope}\n\n清单是进度来源；defined与proved分开统计。Prop定义编译通过只确认陈述类型正确，不表示结论成立。\n'
intro+='原文为用户提供的教材PDF逐页忠实转述；机器验收见VALIDATION.json和check-full目录。导师语义审阅待完成。\n'
intro+='代码块展示陈述及定义体，省略证明；节参数、类型实例及命名空间环境以链接源码为准。\n\n| 状态 | 条数 |\n| --- | ---: |\n'
intro+=''.join(f'| {s} | {counts[s]} |\n' for s in ['defined','proved','statement_only','weakened','not_formalizable_now'])
intro+=f'| 合计 | {len(rows)} |\n\nproved为清单行数；重复映射同一证明不等于独立定理数量。\n\n需人工判断的问题：\n\n'
intro+='\n'.join(f'{i}. {q}' for i,q in enumerate(questions,1))+'\n'
def entry(r):
    names=r['Lean声明名'].split(';');blocks=['-- '+n+'\n'+index[n]['code'] for n in names]
    return f'\n### {r["id"]} · §{r["节号"]} · {r["类型"]} · 印刷p.{r["印刷页"]} / PDF{r["PDF页"]}\n\n原文（忠实转述）：{r["原文陈述(英文原句或忠实转述)"]}\n\n```lean\n'+ '\n\n'.join(blocks)+f'\n```\n\n差异、假设及缺口：{r["备注"]}。\n\n状态：**{r["状态"]}**；位置：`{r["文件:行号"]}`。\n'
(review/f'{tag}_REVIEW.zh-CN.md').write_text(intro+''.join(entry(r) for r in rows),encoding='utf-8')
if ch==4:
    leaves=['symplecticEulerStability_statement','printedImplicitRelation','respa','resonanceInstability_statement',
      'textbookConstrainedODE_cotangent_invariant_of_mass_and_independence','textbookConstrainedFlow_pullback_constant_of_mass_and_independence',
      'lemma_4_1','textbookGramProjectedEulerChart_hiddenConstraint_and_pullback','rattleRelation','shakeRattlePositions_statement',
      'newtonQuadratic_statement','inertiaTracePrinted_statement','rigidInvariants_statement','dlmPrinted','dlmStructure_statement']
else:
    leaves=['theorem51_statement','smoothDenominatorBound_proved','zeroPerturbation_proved',
      'liouvilleEquation_statement','liouvillianAdjoint_statement','microRaw','shellWeakLimit_statement',
      'surfaceAreaFormula_statement','microInvariant_statement','microErgodic','ergodicTimeAverage_statement',
      'kam_statement','mixingCorrelation_statement','symplecticEulerShadow_proved','backwardEulerLimit_statement'] if ch==5 else ['theorem61_statement','theorem62_statement','proposition64_statement','lemma61_statement']
chosen=[]
for leaf in leaves:
    hit=next((r for r in rows if any(n.split('.')[-1]==leaf for n in r['Lean声明名'].split(';'))),None)
    if hit and hit not in chosen:chosen.append(hit)
for status in ['weakened','not_formalizable_now','proved','statement_only','defined']:
    for r in rows:
        if r['状态']==status and r not in chosen and len(chosen)<15:chosen.append(r)
(review/f'{tag}_REVIEW_SHORT.zh-CN.md').write_text(intro.replace('人工审阅材料','导师快速审阅（15条）')+''.join(entry(r) for r in chosen),encoding='utf-8')
names=sorted(set(n for r in rows for n in r['Lean声明名'].split(';')))
(root/f'scripts/CheckChapter{ch:02}Review.lean').write_text('import MolecularDynamicsFormalization\n'+
    '\n'.join(f'#check {n}\n#print axioms {n}' for n in names)+'\n',encoding='utf-8')
print(json.dumps({'rows':len(rows),'counts':dict(counts),'mapped_declarations':len(names)},ensure_ascii=False))

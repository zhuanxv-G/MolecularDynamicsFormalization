"""Generate mentor-facing book reports from book_stats outputs; no Lean writes."""
from __future__ import annotations

import collections
import csv
import json
import re
from pathlib import Path

from book_stats import ROOT, OUT, load, read, dump, declarations, THEORIES

REPO = 'https://github.com/zhuanxv-G/MolecularDynamicsFormalization'
TAG = 'book-ch01-08-summary'


def gh(path, line=None):
    return f'{REPO}/blob/{TAG}/{path}' + (f'#L{line}' if line else '')


def write(name, lines):
    (OUT/name).write_text('\n'.join(lines)+'\n', encoding='utf-8')


def cell(s):
    return str(s).replace('|', '∣').replace('\n', ' ')


def errlink(e):
    # GitHub heading anchors remove punctuation but preserve Unicode letters.
    anchor = re.sub(r'[^\w\- ]', '', f'{e["section"]}. {e["heading"]}'.lower()).replace(' ', '-')
    return gh(e['path']) + '#' + anchor


# Mathematical editorial summaries, each bound to an existing numbered errata section.
# These are review choices, not statistical overrides.
SELECTED = [
    (1, 2, '径向Lennard–Jones力与势梯度的符号相反', '采用力为负梯度的版本'),
    (1, 6, '一般双曲系统不保证光滑线性化', '以拓扑共轭表述Hartman–Grobman定理'),
    (1, 10, '严格极小点的Hessian未必正定', '改为半正定；正定需另加非退化条件'),
    (1, 13, '拓扑传递不能与测度遍历直接等同', '明确拓扑及不变测度，分列两性质'),
    (1, 15, '变分矩阵使用了演化后再次复合的取值点', '使用初值处的真实流导数'),
    (2, 2, '变分导数展开漏去泛函基值', '对F(q+εη)−F(q)展开'),
    (2, 11, 'Hamilton流的变分方程沿用错误取值点', '在初值处求空间导数并沿轨道取系数'),
    (2, 22, '一般质量下Newmark关系与Verlet的对应缺质量因子', '采用保留质量逆矩阵的版本'),
    (3, 8, '处理后的能量估计漏去势能，常势即给反例', '首界将动能T改为总能量H=T+U'),
    (3, 10, '长时间能量估计依赖统一正则性与轨道域条件', '明确有限截断、共同常数及时间尺度'),
    (4, 2, '稳定边界的单位模特征值可伴随Jordan增长', '有界稳定要求排除非平凡Jordan块'),
    (5, 1, 'L²函数作为逐点函数时范数和完备性存在商空间问题', '采用几乎处处等价类并写清函数空间'),
    (6, 4, '规范平均原印式出现重复归一因子', '按概率密度或未归一权重择一归一'),
    (6, 23, '分布平均收敛不能直接替代轨道时间平均', '分列两结论并明确各自遍历条件'),
    (6, 26, '空小集和无密度情形使小集推论不足', '补非空内部及相应转移密度资格'),
    (6, 29, '把确定性漂移单独放入生成族不足以推出随机平滑', '采用与噪声及其交换子相容的条件'),
    (7, 11, '离散谱不意味着特征值均为单重', '改为离散谱及有限重数，另审单重性'),
    (7, 13, '三重交换子展示式的共同β因子疑漏', '采用补齐β因子的独立版本'),
    (7, 23, '普通λdt不能一般抵消约束法向随机噪声', '采用可含随机部分的约束反作用冲量'),
    (8, 1, 's′=ξ与含log s的Nosé–Hoover第一积分不相容', '取s′=sξ，或同步修改第一积分'),
    (8, 3, '同名Nosé能量的自由度系数前后不同', '明确选择n版能量及匹配初始常量'),
    (8, 4, '正号耦合与所列Gaussian驻定密度不相容', '采用负号耦合并保留原印式供比对'),
    (8, 8, '质量归一的坐标、动量缩放方向颠倒', '取q̃=M¹ᐟ²q、p̃=M⁻¹ᐟ²p并同步变换势'),
    (8, 29, '不等质量下DPD涨落耗散式的矩阵乘法次序不当', '将质量逆矩阵置于噪声协方差右侧'),
]


def redundancy():
    formal = []
    for p in sorted((ROOT/'MolecularDynamics').rglob('*.lean')):
        path = p.relative_to(ROOT).as_posix()
        for d in declarations(p.read_text(encoding='utf-8-sig')):
            if d['kind'] in ['def', 'abbrev', 'structure', 'inductive']:
                formal.append(dict(d, path=path))
    blue = []
    for ch in range(1, 9):
        for d in declarations(read(f'Blueprint/Ch{ch:02}.lean')):
            if d['kind'] in ['def', 'abbrev', 'structure', 'inductive']:
                blue.append(dict(d, path=f'Blueprint/Ch{ch:02}.lean', chapter=ch))

    def key(d): return d['name'].removeprefix('bp_').lower()
    def formula(d):
        code = re.split(r'\n\s*(?:end\b|namespace\b|section\b|variable\b|attribute\b|open\b|#)', d['code'])[0]
        code = re.sub(r'^\s*(?:(?:noncomputable|private|protected)\s+)*(?:def|abbrev|structure|inductive)\s+[^\s]+', '', code)
        return re.sub(r'\s+', '', code)

    names = collections.defaultdict(list)
    bodies = collections.defaultdict(list)
    for d in formal: names[key(d)].append(d); bodies[formula(d)].append(d)
    same_name, same_formula, aliases = [], [], []
    for d in blue:
        for f in names[key(d)]: same_name.append((d, f))
        for f in bodies[formula(d)]: same_formula.append((d, f))
        body = d['code'].split(':=', 1)[-1].strip()
        m = re.fullmatch(r'([\w.]+)', body)
        if m:
            candidates = names.get(m[1].split('.')[-1].lower(), [])
            for f in candidates: aliases.append((d, f))
    # Join cross-chapter candidates by either short name or complete parameter/body syntax.
    # This also catches E/Q/V/Vec aliases that intentionally use different names.
    parents = list(range(len(blue)))
    def find(i):
        while parents[i] != i:
            parents[i] = parents[parents[i]]; i = parents[i]
        return i
    features = collections.defaultdict(list)
    for i, d in enumerate(blue):
        features[('name', key(d))].append(i)
        features[('syntax', formula(d))].append(i)
    for ids in features.values():
        if len({blue[i]['chapter'] for i in ids}) > 1:
            for i in ids[1:]: parents[find(i)] = find(ids[0])
    cross_groups = collections.defaultdict(list)
    for i, d in enumerate(blue): cross_groups[find(i)].append(d)
    cross = {' / '.join(sorted({d['name'] for d in ds})): ds for ds in cross_groups.values()
             if len({d['chapter'] for d in ds}) > 1}
    summary = dict(blueprint_definitions=len(blue), formal_definitions=len(formal),
                   blueprint_formal_same_short_name_pairs=len(same_name),
                   blueprint_formal_same_short_name_blueprint_definitions=len({(d['path'], d['name']) for d, _ in same_name}),
                   blueprint_formal_same_syntax_pairs=len(same_formula),
                   direct_alias_pairs=len(aliases), cross_chapter_near_name_groups=len(cross),
                   cross_chapter_near_name_definitions=sum(map(len, cross.values())))
    dump('docs/review/book/BOOK_REDUNDANCY_COUNTS.json', summary)
    lines = ['# 定义复用与重复候选清单', '',
             '只报告，不改代码。以下“同名”指去掉bp_前缀后不区分大小写的短名；完整命名空间不同，不是Lean命名冲突。',
             '“同式”仅指去注释、空白和声明名后，参数及定义体的字面表达式相同；未证明任意改名、类型别名、命名空间解释或表示变换下的语义等价。“近似重复”按跨章同短名或同式关系归组，需人工比较量词、参数域和度量约定。', '',
             f'共扫描逐章数学陈述中的{len(blue)}项定义类声明和正式证明材料中的{len(formal)}项定义类声明。',
             f'同短名候选{len(same_name)}对，涉及{summary["blueprint_formal_same_short_name_blueprint_definitions"]}项逐章定义；字面同式{len(same_formula)}对；直接别名候选{len(aliases)}对。',
             f'跨章同短名或同式关系合并为{len(cross)}组，涉及{summary["cross_chapter_near_name_definitions"]}项定义；每组的成员不重复进入另一组。与正式材料比对的各数互有交叠，不能相加作为去重收益。', '',
             '## 逐章定义与正式材料同短名', '', '|逐章定义|正式材料定义|核查范围|', '|---|---|---|']
    for d, f in same_name:
        lines.append(f'|[{d["name"]}]({gh(d["path"], d["line"])})|[{f["name"]}]({gh(f["path"], f["line"])})|短名候选；需比较参数与定义域|')
    for title, pairs in [('逐章定义与正式材料字面同式', same_formula), ('直接别名候选', aliases)]:
        lines += ['', '## '+title, '', '|逐章定义|正式材料定义|', '|---|---|']
        for d, f in pairs: lines.append(f'|[{d["name"]}]({gh(d["path"], d["line"])})|[{f["name"]}]({gh(f["path"], f["line"])})|')
    lines += ['', '## 跨章近似重复候选', '', '|同短名或同式相连的名称组|涉及定义及章节|', '|---|---|']
    for k, ds in sorted(cross.items()):
        links = '；'.join(f'[第{d["chapter"]}章 {d["name"]}]({gh(d["path"], d["line"])})' for d in ds)
        lines.append(f'|{k}|{links}|')
    lines += ['', '代表例子包括向量空间、梯度、Poisson括号、Gibbs权重和规范平均。相同数学概念可能因坐标表示、质量参数或函数域不同而保留多个定义；定义本身不是已证定理。建议先判等价与依赖，再决定是否统一。']
    write('BOOK_REDUNDANCY.zh-CN.md', lines)
    return summary


def reports():
    stats = load('docs/review/book/BOOK_STATS.json'); rows = stats['chapters']; total = stats['total']
    decls = load('docs/review/book/BOOK_DECLARATIONS.json'); errs = load('docs/review/book/BOOK_ERRATA_RECORDS.json')
    red = redundancy()
    lookup = {(e['chapter'], e['section']): e for e in errs}
    unproved = [d for d in decls if d['status'] == 'unproved']
    theory_counts = collections.Counter(d['theory'] for d in unproved if d['theory'])
    groups = {title: [d for d in unproved if d['theory'] == title] for title, _ in THEORIES}
    reasons = total['unproved_reasons']

    # Include all numbered records and separately enumerate retracted transcription mistakes.
    lines = ['# 全书原书疑误与核查索引', '',
             f'原章勘误单共有{total["errata_sections"]}个编号节；其中{total["potential_book_issue_sections"]}项为原书表述、论证或资格疑问，另{total["context_or_proof_review_sections"]}项明确为解释、范围或原证明核查。均未等同于导师确认的排印错误。',
             '同一矛盾涉及不同条目时仍按原节保留；合并计数及跨条影响须由核查人判断。下表按章及节号排列，类型为便于筛选的建议分类，复合问题只归一个主要类型。', '',
             '|章|ERRATA节|印刷页 / PDF页|类型|一句话问题或核查方向|状态|', '|---|---:|---|---|---|---|']
    for e in errs:
        # The correction field often states the mathematical issue more directly than old review prose.
        problem = e['issue']
        if (e['chapter'], e['section']) in {(c, s) for c, s, _, _ in SELECTED}:
            problem = next(p for c, s, p, _ in SELECTED if (c, s) == (e['chapter'], e['section']))
        elif e['chapter'] in [2, 3, 4, 5]:
            correction = e['suggestion'].split('；`', 1)[0]
            if correction: problem = correction
        problem = re.sub(r'\[[A-Z_? /]+\]', '', problem)
        problem = re.sub(r'`[^`]+`', '对应声明', problem)
        problem = re.sub(r'已目视核对(?:原页)?PDF[^：]*：', '', problem)
        problem = re.split(r'；|。| 网站', problem)[0][:180]
        lines.append('|'+ '|'.join(map(cell, [e['chapter'], f'[{e["section"]}]({errlink(e)})', e['printed_page']+' / '+e['pdf_page'], e['type'], problem, e['status']]))+'|')
    transcription = [
        (6, 'OU解/方差公式', '原有转录漏根号，原页公式正确', 'CH06_SUMMARY_FOR_MENTOR.zh-CN.md'),
        (6, '分部积分', '原有转录误记正负号，已按原页纠正', 'CH06_SUMMARY_FOR_MENTOR.zh-CN.md'),
        (6, '定理6.2', 'κ的转录已纠正，不计原书疑误', 'CH06_SUMMARY_FOR_MENTOR.zh-CN.md'),
        (7, '分裂串', '原页九字母OABOAOBAO，遗漏字母已纠正', 'CH07_SUMMARY_FOR_MENTOR.zh-CN.md'),
        (7, '一阶修正函数表', '原页s=4符号正确，原转录错误已纠正', 'CH07_SUMMARY_FOR_MENTOR.zh-CN.md'),
    ]
    lines += ['', '## 转录错误已更正（不计入原书疑误）', '', '|章|位置|更正说明|依据|', '|---|---|---|---|']
    for c, pos, desc, path in transcription: lines.append(f'|{c}|{pos}|{desc}|[章节摘要]({gh("docs/review/"+path)})|')
    lines += ['', '以上列出章末摘要明确撤销原书疑误归因的5类转录纠正；不宣称穷尽历史上的一切抄录修改。详细原句、反例、页码证据与并列版本以链接勘误单为准。']
    write('BOOK_ERRATA_INDEX.zh-CN.md', lines)
    with (OUT/'BOOK_ERRATA_INDEX.csv').open('w', encoding='utf-8-sig', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=['chapter', 'section', 'printed_page', 'pdf_page', 'type', 'record_class', 'issue', 'status', 'path'], extrasaction='ignore')
        writer.writeheader(); writer.writerows(errs)

    lines = ['# 全书未证声明与理论缺口', '',
             f'未证共{total["unproved"]}项，含直接占位与依赖未证结果的声明。原文疑误版和修正版分开；原文版不作为有效定理依赖。',
             '原因继承已有逐声明证明记录，理论分组按声明名及已记录缺项筛选，仅供优先级规划；“缺大理论”也包括局部衔接，并不意味着数学库完全没有该领域。每个未证声明只在一个原因/主理论组出现。', '',
             '|原因|项数|', '|---|---:|']
    for cause, count in reasons.items(): lines.append(f'|{cause}|{count}|')
    lines += ['', '## 缺大理论的主理论分组', '', '|理论|声明项数|章节|', '|---|---:|---|']
    for title, _ in THEORIES:
        ds = groups[title]
        if ds: lines.append(f'|{title}|{len(ds)}|'+ '、'.join(map(str, sorted({d['chapter'] for d in ds})))+'|')
    for title, ds in [*[(k, v) for k, v in groups.items() if v], *[(cause, [d for d in unproved if d['reason'] == cause]) for cause in ['原书疑误原文版不证', '尝试次数用尽']]]:
        lines += ['', '## '+title, '', '|声明名|章|原因|对应原文条目|', '|---|---:|---|---|']
        for d in ds:
            target = gh('Blueprint/Ch%02d.lean' % d['chapter'], d['line'])
            lines.append(f'|[{d["name"]}]({target})|{d["chapter"]}|{d["reason"]}|{d["source_id"] or "共同辅助定义"}|')
    write('BOOK_GAPS.zh-CN.md', lines)

    # The mentor text intentionally avoids all internal workflow terminology.
    lines = ['# 第1–8章正文数学形式化成果汇报', '',
             '## 1. 结论与范围', '',
             f'已整理Leimkuhler–Matthews《Molecular Dynamics》（2015）第1–8章正文的原文、数学陈述、对照说明、独立语义审校意见与证明状态，不含习题及附录。共{total["entries"]}个正文条目、{total["named_declarations"]}个命名声明，其中{total["definitions"]}项定义、{total["proved"]}项已证陈述、{total["unproved"]}项未证陈述。网站按当前整条内容通过{total["website_pass"]}条，另{total["local_repairs"]}条按审校意见修复并经本地核验，{total["needs_human"]}条需人工判断，{total["local_excerpt_verified"]}条仅补充摘录后完成本地核对。仍未处理的失败项为0。正式证明材料没有未完成证明，也没有新增公理；逐章待证材料与正式证明明确分列。', '',
             '## 2. 方法与可信度', '',
             '例如，原书“严格极小点的Hessian正定”不能照字面作为正确结论：U(x)=x⁴在0严格极小，但二阶导数为0。材料保留原句，另列半正定修正版及反例，核查人可直接比较结论与前提。相同方法用于其他正文条目：原文 → Lean数学陈述 → 成分对照表 → 独立语义审校 → 定义或证明状态。',
             '编译检查确认陈述有正确类型，现有证明确实证明了所写结论；逐声明依赖检查区分完成证明与尚依赖未证结论的材料。编译本身不能判断陈述是否忠实于教材，也不能将未写证明的命题变成已证定理。语义审校比较对象、量词、假设、结论、符号和原页，能够指出转录、范围或原文问题；它仍可能遗漏细节，不能代替严格证明或导师逐条裁定。',
             '使用Lean 4.34.0和固定Mathlib版本。正式材料中无证明占位、无新增公理，并不表示完全不使用通常的逻辑基础；逐章待证材料不冒充正式定理。此处复核既有成功检查与当前相同的数学文件，未重新开展证明。',
             '定义确有一定重复。为了让每章能按原文独立阅读，常把坐标、梯度、概率权重及算法写成局部定义；这有助于对照，但定义数量不能当作定理成果。是否统一，应先比较对象及参数约定。',
             '[EXTRA]表示为严格数学解释补充或明确的前提。例如规范平均须有可积性及非零归一因子；除法、平方根或经典导数还需相应有效域。它说明“在这些条件下讨论”，并不宣称这些条件已从原书推出。人工阅读时先看原句和并列修正版，再逐项核对[EXTRA]、适用域、反例及证明状态；修正版获认可不能替原书疑误作最终裁定。', '',
             '## 3. 分章总表与主要内容', '',
             '|章|印刷页 / PDF页|条目|整条通过|本地修复|需人工|定义|已证|未证|疑误单节数|', '|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|']
    for r in rows:
        lines.append('|'+ '|'.join(map(str, [r['chapter'], r['printed_pages']+' / '+r['pdf_pages'], r['entries'], r['website_pass'], r['local_repairs'], r['needs_human'], r['definitions'], r['proved'], r['unproved'], r['errata_sections']]))+'|')
    lines.append('|合计|正文，不含习题|'+ '|'.join(str(total[k]) for k in ['entries', 'website_pass', 'local_repairs', 'needs_human', 'definitions', 'proved', 'unproved', 'errata_sections'])+'|')
    lines += ['',
              '第4、5章各另有2条摘录本地核对，所以每章“整条通过＋本地修复＋需人工＋摘录核对＝条目数”。通过数不含只对修正版给出的部分认可；疑误单节数是合并问题记录数，与需人工条目数不一一对应。页码给章正文所在物理范围；末页兼有习题时只取习题前正文，数学条目实际页界另见统计文件。', '',
              '**第1章：经典力学与动力系统。** 整理势能、Newton与Hamilton方程、流、平衡与线性化；已有能量守恒、谐振子能量和同初值唯一性等证明。一般拓扑线性化、作用角及稠密性、散射与部分变分结果仍待补充。', '',
              '**第2章：数值积分与几何结构。** 整理Verlet、变分构造、辛性、组合及Runge–Kutta类方法；包含可直接复用的导数、积分保持和算法关系结果。统一误差界、一般阶数与辛条件的完整证明仍有缺口。', '',
              '**第3章：几何积分的误差分析。** 整理Lie导数、Poisson括号、修正Hamiltonian、时间对称与碰撞方法；已有部分代数恒等式和具体算法结果。形式展开与真实流的衔接、长时间和指数小误差结论尚未全部证明。', '',
              '**第4章：稳定性、约束与刚体。** 整理振子稳定阈值、多时间步、SHAKE/RATTLE及刚体坐标；已有部分线性代数与具体模型结果。一般约束流、全局算法资格与刚体几何结果仍需理论支持。', '',
              '**第5章：相空间分布与微正则平均。** 整理概率演化、Liouville方程、微正则测度和遍历平均；已有若干测度、代数与有限范围的推论。曲面测度识别、算子域及一般遍历结论仍未完成。', '',
              '**第6章：正则分布与随机微分方程。** 整理Gaussian、OU过程、Itô及Fokker–Planck、Brownian与Langevin遍历性；已有部分概率恒等式和明确条件下的局部结果。一般随机积分、解的存在唯一性、闭算子和全局遍历性是主要缺口。', '',
              '**第7章：随机数值方法与采样误差。** 整理强弱误差、分裂、谐振子矩、修正密度和受约束Langevin；已证明受约束组合输出的可测性与概率律等有限结果。一般阶数、长期误差和随机初值下条件解仍待证明。', '',
              '**第8章：扩展变量恒温器。** 整理Nosé–Hoover、NHL、等动能、广义Langevin、活塞及DPD；已有部分局部恒等式、修正关系与不等质量反例。一般驻定测度、全局遍历性及若干交换子计算仍未完成。', '',
              '## 4. 原书疑误与优先裁定项', '',
              f'全书勘误单共{total["errata_sections"]}个编号节，按本次区分有{total["potential_book_issue_sections"]}项原书表述、论证或资格疑问，另{total["context_or_proof_review_sections"]}项解释、范围或原证明核查。相同数学矛盾可能影响多条，数量不代表独立排印错误数，也不代表导师已认可的错误数。按主要问题分为以下类型；混合问题仅归一类以便核对。', '',
              '|主要类型|项数|', '|---|---:|']
    types = collections.Counter(e['type'] for e in errs if e['record_class'] == 'potential_book_issue')
    for typ, count in sorted(types.items()): lines.append(f'|{typ}|{count}|')
    lines += ['', '以下24项优先请导师裁定；建议版本均供选择，详细原句、理由及证据见各章勘误单。', '', '|章|印刷页|问题|建议版本|', '|---|---|---|---|']
    for ch, sec, problem, fix in SELECTED:
        e = lookup[ch, sec]
        lines.append(f'|{ch}|[{e["printed_page"]}]({errlink(e)})|{problem}|{fix}|')
    lines += ['',
              '已更正的转录错误单列，不计入上述原书疑误：第6章OU方差根号、分部积分符号、定理6.2的κ，以及第7章九字母分裂串和一阶修正表符号。不能把先前抄错归责于教材。完整索引还保留只需解释而未确认有错的记录。', '',
              '## 5. 未证明部分与下一阶段优先级', '',
              f'未证共{total["unproved"]}项：缺少理论或必要衔接{reasons["缺大理论"]}项，原书疑误原文版暂不证明{reasons["原书疑误原文版不证"]}项，短证明尝试次数用尽{reasons["尝试次数用尽"]}项。最后一类只说明当前路线未解决，不意味着命题错误；第一类也含已有理论与当前表示之间的衔接工作。', '',
              '|缺失理论主组|涉及声明数|章节|', '|---|---:|---|']
    for title, _ in THEORIES:
        ds = groups[title]
        if ds: lines.append(f'|{title}|{len(ds)}|'+ '、'.join(map(str, sorted({d['chapter'] for d in ds})))+'|')
    lines += ['',
              '表中每项只进入一个主组，未重复相加；一个定理实际可能依赖多个领域。一般SDE存在唯一性等还可能只列在覆盖说明中，尚未单列为待证定理，不能把上表随机过程项数当成存在唯一性定理数。建议先评估随机分析基础，再决定遍历性、随机平滑及长期采样误差的优先次序；几何积分一侧可独立推进反向误差与辛结构证明。逐声明清单见[未证与理论缺口](BOOK_GAPS.zh-CN.md)。', '',
              '## 6. 已知局限', '',
              f'定义复用扫描得到：逐章材料与正式材料同短名候选{red["blueprint_formal_same_short_name_pairs"]}对，涉及{red["blueprint_formal_same_short_name_blueprint_definitions"]}项逐章定义；参数及定义体字面同式{red["blueprint_formal_same_syntax_pairs"]}对；跨章近似重复候选{red["cross_chapter_near_name_groups"]}组，涉及{red["cross_chapter_near_name_definitions"]}项定义。这些集合重叠，不能相加。梯度、相空间坐标、Gibbs权重及规范平均是代表例子；同短名并不自动等价，具体清单见[定义复用与重复候选](BOOK_REDUNDANCY.zh-CN.md)。',
              '本次只整理第1–8章正文，不做习题；图示经验现象、引用文献中的完整理论和未形式化的结论范围仍需按原文说明理解。独立语义审校是工具辅助，不是导师或第三方数学家逐条人工签认。对局部散度、生成元或有限维模型的结论，不自动提升为全局流不变性、概率平稳性或遍历性。', '',
              '## 7. 请导师决定的事项', '',
              '1. 疑误按“保留原印＋并列工作修正”裁定，还是逐项联系其他核查人；先审哪些高影响问题。',
              '2. 下一阶段是否补完整证明；随机分析基础、遍历与混合、几何积分误差理论如何排序。',
              '3. 是否统一重复定义，以及允许统一到何种坐标、质量和函数空间约定。',
              '4. 正文对照材料的粒度、汇报篇幅和交付格式是否需要调整。', '',
              '## 8. 文件导航', '',
              f'主入口为[仓库全书审阅导航]({gh("docs/review/book/README.zh-CN.md")})。数学内容基于[第1–8章收口版本]({REPO}/tree/book-ch01-08-closeout)，本汇报及导航固定于版本{TAG}；均可在[仓库]({REPO})访问。',
              '各章短摘要、勘误、完整逐条对照和Lean数学文件用途如下；数学文件仅链接，离线包不复制。', '',
              '|章节|短摘要|疑误与选项|完整对照|数学文件|', '|---|---|---|---|---|']
    for ch in range(1, 9):
        links = [f'[{label}]({gh(f"docs/review/CH{ch:02}_{kind}.zh-CN.md")})' for label, kind in [('SUMMARY', 'SUMMARY_FOR_MENTOR'), ('ERRATA', 'ERRATA'), ('BLUEPRINT', 'BLUEPRINT')]]
        lines.append(f'|{ch}|'+ '|'.join(links)+ f'|[Lean]({gh(f"Blueprint/Ch{ch:02}.lean")})|')
    lines += ['', '全书[统计](BOOK_STATS.csv)、[统计口径差异](BOOK_STATS_DIFF.md)、[疑误索引](BOOK_ERRATA_INDEX.zh-CN.md)、[未证清单](BOOK_GAPS.zh-CN.md)可进一步定位。各章既有短摘要保留原状，数字差异以本次统一统计及其解释为准。']
    write('BOOK_SUMMARY_FOR_MENTOR.zh-CN.md', lines)

    nav = ['# 全书审阅入口：第1–8章正文', '',
           f'主要入口：[本固定版本的全书审阅导航]({gh("docs/review/book/README.zh-CN.md")})。版本：{TAG}。数学内容承接[第1–8章收口版本]({REPO}/tree/book-ch01-08-closeout)。', '',
           '## 建议阅读顺序', '',
           '1. 先读[全书成果汇报](BOOK_SUMMARY_FOR_MENTOR.zh-CN.md)，了解结论、数量、可信度与待决定事项。',
           '2. 再看[全书疑误索引](BOOK_ERRATA_INDEX.zh-CN.md)，选择优先裁定问题。',
           '3. 按需查看各章SUMMARY、ERRATA及BLUEPRINT，逐项比对原句、假设、修正版和证明状态。',
           '4. 规划下一阶段时看[未证与理论缺口](BOOK_GAPS.zh-CN.md)及[定义复用候选](BOOK_REDUNDANCY.zh-CN.md)。', '',
           '## 全书文件（固定版本链接）', '', '|文件|用途|', '|---|---|']
    for name, purpose in [('BOOK_SUMMARY_FOR_MENTOR.zh-CN.md', '导师汇报正文，先读'), ('BOOK_ERRATA_INDEX.zh-CN.md', '全书疑误及转录纠正索引'), ('BOOK_GAPS.zh-CN.md', '未证声明及理论归组'), ('BOOK_REDUNDANCY.zh-CN.md', '同名、同式及跨章重复候选'), ('BOOK_STATS.json', '统一统计及来源凭据'), ('BOOK_STATS.csv', '可排序的分章统计表'), ('BOOK_STATS_DIFF.md', '与既有章节摘要的差异'), ('BOOK_DECLARATIONS.json', '逐声明状态及原因'), ('BOOK_ITEMS.json', '逐条审校分类'), ('BOOK_ERRATA_RECORDS.json', '疑误结构化索引'), ('BOOK_PAGE_RANGES.json', '正文与习题页界'), ('BOOK_REDUNDANCY_COUNTS.json', '定义复用计数'), ('BOOK_SUPPLEMENTAL_DECLARATIONS.json', '补入漏计的枚举定义'), ('BOOK_VALIDATION.json', '交付自检结果')]:
        nav.append(f'|[{name}]({gh("docs/review/book/"+name)})|{purpose}|')
    nav += [f'|[BOOK_ERRATA_INDEX.csv]({gh("docs/review/book/BOOK_ERRATA_INDEX.csv")})|可按章节、页码、类型和状态排序的疑误索引|',
            '', '## 各章材料', '', '|章|SUMMARY：简要结论|ERRATA：问题、理由、版本、选项|BLUEPRINT：逐条原文及对照|Lean：陈述与证明|', '|---|---|---|---|---|']
    for ch in range(1, 9):
        links = [f'[{kind}]({gh(f"docs/review/CH{ch:02}_{kind}.zh-CN.md")})' for kind in ['SUMMARY_FOR_MENTOR', 'ERRATA', 'BLUEPRINT']]
        nav.append(f'|{ch}|'+ '|'.join(links)+f'|[Ch{ch:02}.lean]({gh(f"Blueprint/Ch{ch:02}.lean")})|')
    nav += ['', '各章原摘要保持原样；网站通过数等差异请以全书统计与差异说明为准。数学陈述不等于已完成证明；含未证依赖者列在未证清单。', '',
            '## 轻量离线材料', '',
            '离线文件为book-ch01-08-docs.zip：book/下全书汇总文件，以及8章SUMMARY_FOR_MENTOR和ERRATA；不含完整BLUEPRINT和Lean文件。后两类请使用上表固定版本链接。',
            '离线包内各章摘要及勘误保持原文；其中旧相对链接若指向未打包的完整对照材料，请改从本导航的GitHub链接访问。', '',
            '## 统计复算与检查', '',
            f'[统计脚本]({gh("scripts/book_stats.py")})、[汇报生成脚本]({gh("scripts/book_report.py")})和[交付检查脚本]({gh("scripts/book_delivery.py")})可供复核。',
            'BOOK_VALIDATION保存统计、链接、文件冻结与离线包内容检查结果。未完成数学证明和导师尚未裁定的事项均保留，不以文件生成或语义认可代替。']
    write('README.zh-CN.md', nav)
    print(json.dumps(dict(summary_chars=len((OUT/'BOOK_SUMMARY_FOR_MENTOR.zh-CN.md').read_text(encoding='utf-8')), redundancy=red, theory_counts=theory_counts), ensure_ascii=False, indent=2))


if __name__ == '__main__':
    reports()

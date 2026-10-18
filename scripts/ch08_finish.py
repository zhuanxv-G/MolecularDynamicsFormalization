"""Validate chapter-8 closeout, write mentor documents and the stopping checkpoint."""
from ch08_pipeline import *
from ch08_packages import closure
from ch08_dependency_index import index_project,strip_comments
from collections import Counter

def main():
    frozen=verify_frozen()
    full=BASE/'closeout/full'
    report=json.loads((full/'CHECK_REPORT.json').read_text(encoding='utf-8-sig'))
    assert report['machine_check_status']=='passed'
    for f in report['inputs']:assert sha(ROOT/f['relative_path'])==f['sha256']
    for c in report['checks']:assert c['exit_code']==0 and sha(full/c['raw_log'])==c['raw_log_sha256']
    canonical=ROOT/'Blueprint/Ch08.lean'
    bindings=[]
    for p in (BASE/'validation/batches').glob('*-binding.json'):
        b=json.loads(p.read_text(encoding='utf-8'))
        if b['canonical_sha256']==sha(canonical) and b['audit_sha256']==sha(BASE/'CheckAxioms.lean'):
            receipt=p.with_name(p.name.replace('-binding',''))
            assert sha(receipt)==b['receipt_sha256']
            assert json.loads(receipt.read_text(encoding='utf-8'))['exit_code']==0
            bindings.append((p,b))
    assert bindings,'No successful current whole-chapter native check'
    binding,b=max(bindings,key=lambda x:x[0].stat().st_mtime)
    audit=json.loads((BASE/'local_audit.json').read_text(encoding='utf-8'))['items']
    assert len(audit)==len(RECORDS) and all(a['checked'] for a in audit.values())
    assert {r['section'].split('.')[1] for r in RECORDS}=={str(x) for x in range(1,14)}
    checks=json.loads((BASE/'source_page_checks.json').read_text(encoding='utf-8'))['visually_checked_pdf_pages']
    assert all(str(p) in checks for p in range(282,348))
    # Scan every formal source separately from the deliberately incomplete blueprint.
    formal=list((ROOT/'MolecularDynamics').rglob('*.lean'))
    for p in formal:
        assert not re.search(r'\b(sorry|admit|axiom|unsafe)\b',strip_comments(p.read_text(encoding='utf-8-sig'))),p
    assert not re.search(r'\b(admit|axiom|unsafe|True)\b',strip_comments(canonical.read_text(encoding='utf-8')))
    packages=json.loads((BASE/'PACKAGE_VALIDATION.json').read_text(encoding='utf-8'))
    assert packages['covered_entries']==packages['subtasks']==len(RECORDS) and not packages['website_submitted']
    index,contexts,allitems=index_project()
    manifest=json.loads((BASE/'mathcopilot_tasks/MANIFEST.json').read_text(encoding='utf-8'))
    seen=[]
    for batch in manifest:
        for sub in batch['subtasks']:
            folder=ROOT/sub['path'];mf=json.loads((folder/'MANIFEST.json').read_text(encoding='utf-8'))
            assert sha(folder/'MANIFEST.json')==sub['manifest_sha256']
            assert mf['input_sha256']['Blueprint/Ch08.lean']==sha(canonical)
            assert mf['input_sha256']['blueprint/ch08/ch08_source.json']==sha(BASE/'ch08_source.json')
            for name,v in mf['files'].items():assert sha(folder/name)==v['sha256']
            assert mf['total_task_bytes']==sum(p.stat().st_size for p in folder.iterdir() if p.is_file())
            sid=mf['source_ids'][0];r=next(r for r in RECORDS if r['source_id']==sid)
            excerpt=closure(r['code'],index)
            assert {d['full_name'] for d in excerpt}=={d['full_name'] for d in mf['definition_excerpts']}
            paste=(folder/'PASTE.txt').read_text(encoding='utf-8')
            assert paste.startswith('以附件/PASTE 为准，忽略 /workspace 旧文件；Mathlib 定义按标准含义采信')
            assert all(d['code'] in paste for d in excerpt)
            seen.append(sid)
    assert len(seen)==len(set(seen))==len(RECORDS)
    counts=Counter();decls=[]
    for r in RECORDS:
        a=audit[r['source_id']]
        for kind,name in re.findall(r'(?m)^(?:noncomputable )?(def|abbrev|theorem|lemma|structure)\s+(\w+)',r['code']):
            name='MD.Ch08.'+name;assert name in a['declaration_axioms']
            unproved='sorryAx' in a['declaration_axioms'][name]
            status='未证' if kind in ['theorem','lemma'] and unproved else '已证' if kind in ['theorem','lemma'] else '定义或记号'
            counts[status]+=1
            decls.append(dict(source_id=r['source_id'],name=name,kind=kind,status=status))
    gaps=[dict(source_id=r['source_id'],statement_scope=r['statement_scope'],extra=r['extra_assumptions'],missing=r['missing'])
          for r in RECORDS if r['local_verdict']=='NEEDS_HUMAN' or r['missing'] or r['extra_assumptions']]
    dump(BASE/'closeout/COVERAGE_AND_GAPS.json',dict(body_sections='7.1–7.13',body_pdf_pages=[282,347],
        excluded='Exercises及参考文献；实验图表和经验数值结果见excluded_qualitative.json',
        all_source_items_registered=True,all_mathematical_claims_fully_proved=False,
        formula_numbers=list(range(1,50)),declarations=decls,scope_and_gaps=gaps))
    completion=dict(machine_check_status='passed',body_all_items_on_disk=True,final_full_check_passed=True,
        entries=len(RECORDS),declarations=len(decls),declaration_status=dict(counts),
        canonical_sha256=sha(canonical),source_json_sha256=sha(BASE/'ch08_source.json'),
        native_binding=binding.relative_to(ROOT).as_posix(),native_binding_sha256=sha(binding),
        full_report='blueprint/ch08/closeout/full/CHECK_REPORT.json',full_report_sha256=sha(full/'CHECK_REPORT.json'),
        frozen_files=frozen,formal_source_files=len(formal),formal_sorry=0,formal_axiom_declarations=0,
        batches=packages['batches'],subtasks=len(seen),covered_entries=len(seen),website_submitted=False,
        scope='全部正文条目已登记；限定陈述与未证部分逐条区分；没有进入第8章。')
    dump(BASE/'closeout/COMPLETION.json',completion)
    render()
    issues=[r for r in RECORDS if r['issues'] or r['local_verdict']=='NEEDS_HUMAN']
    err=['# 第8章原书疑误与双版本审阅单','',
      '教材：Leimkuhler–Matthews《Molecular Dynamics》（2015）。正文为印刷261–326页、PDF282–347页，末页取Exercises之前。',
      '每项公式疑点均已目视核对原页。以下是待导师裁定的工作版本；条件不足、符号歧义与已确认的代数不符分别说明，不能一概称为原书错误。网站尚未审阅。',
      '定义只记录对象或待证目标；已证与未证分开列出。原文疑误版本不作为修正版的证明依据。','']
    for k,r in enumerate(issues,1):
        ds=[d for d in decls if d['source_id']==r['source_id']]
        err += [f'## {k}. {r["source_id"]}','',f'- 页码：印刷{r["printed_page"]} / PDF{r["pdf_page"]}。',
          '- 原文引句与公式：','',r['statement_latex'],'',
          '- 问题、理由或反例：'+('；'.join(r['issues']) if r['issues'] else '原文省略技术条件或本条覆盖范围尚有限定；详见下列说明。'),
          '- 限定与覆盖缺口：'+'；'.join(r['extra_assumptions']),
          '- 原文版、工作修正版及相关证明：']
        err += ['  - `'+d['name']+'`：'+d['status']+'。' for d in ds]
        err += ['- 待人工核查点：'+r['statement_scope'],
          '- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。',
          '- 网站结论：未送审。','']
    (ROOT/'docs/review/CH07_ERRATA.zh-CN.md').write_text('\n'.join(err).rstrip()+'\n',encoding='utf-8')
    summary=['# 第8章：导师审阅摘要','',
      f'已整理第8章§7.1–§7.13正文{len(RECORDS)}条。原页核对后确定正文为印刷261–326页（PDF282–347，末页在Exercises处截止）；PDF348–349属于习题，未纳入。数值实验的曲线、表格与经验比较另列，不作待证结论。','',
      f'数学材料共{len(decls)}个命名声明：{counts["定义或记号"]}项定义或记号、{counts["已证"]}项已证定理、{counts["未证"]}项未证陈述。全部条目已登记，不表示整章理论已经证明；有些条目仅覆盖明确列出的局部结论，其余在逐条材料的[EXTRA]及覆盖范围中说明。','',
      '已完成的证明包括强误差控制Lipschitz观测误差、配分函数修正后的归一化、线性更新的乘积恒等式、共轭迭代、不变概率交换引理、对称格式的奇次形式系数消失、若干高摩擦系数关系及过阻尼位置消元。未证部分主要需要随机积分与Gaussian转移律、Gibbs积分分部、平稳矩输运、微分算符展开、弱误差余项及谱理论；本轮没有另建这些大型理论。','',
      f'共有{len(issues)}项原文疑点或条件、覆盖范围问题需导师判断。请重点检查配分常数倒数、OABAOBAO字串的OU总时长、SPV力的求值位置、BBK相关项、离散谱与单重谱的区别、(7.25c)符号、三重交换子的β因子、共轭传播子的二阶项、OU核与条件动量平均、h与τ的阶数记号、欠阻尼幅相公式以及摩擦阈值下界。γh<4仅保留为原文限制；补充的OU模态稳定性不构成对整套约束算法的反例。','',
      '随机过程定义明确Wiener过程、独立坐标、适应性及积分方程；概率分布的非负与归一资格另列。形式幂级数的系数恒等式与实际不变概率的渐近误差有区别，不能据前者直接宣称后者已证。约束流的求解存在性、约束遍历性、临界阻尼情形和一般误差展开仍有明确缺口。','',
      f'已验证：固定Lean 4.34.0及对应Mathlib的完整工程检查通过；第8章当前全文的Lean检查与所有命名声明的证明依赖检查通过。正式库没有未完成证明或新增公理；第1–7章及正式库的冻结文件保持原样。','',
      f'MathCopilot任务包已生成{packages["batches"]}批、{len(seen)}个子包，覆盖{len(seen)}条，均附原页和所需项目定义。依用户指令没有提交网站。','',
      f'尚未验证或裁定：{counts["未证"]}项未证陈述、列明的完整陈述与理论缺口、网站语义审阅以及导师对原书疑点的裁定。',
      '详细条目见[逐条材料](CH07_BLUEPRINT.zh-CN.md)，疑点及双版本见[审阅单](CH07_ERRATA.zh-CN.md)。第8章本地流程结束，等待用户新指令，不做附加章节。']
    (ROOT/'docs/review/CH07_SUMMARY_FOR_MENTOR.zh-CN.md').write_text('\n'.join(summary)+'\n',encoding='utf-8')
    for name in ['CH07_BLUEPRINT.zh-CN.md','CH07_ERRATA.zh-CN.md','CH07_SUMMARY_FOR_MENTOR.zh-CN.md']:
        text=(ROOT/'docs/review'/name).read_text(encoding='utf-8')
        for forbidden in ['sorryAx','checked+documented priors','字节预算','历史绑定哈希']:assert forbidden not in text,(name,forbidden)
    msg=f'第8章本地流程完成，等待用户新指令。正文{len(RECORDS)}条，章末完整check通过；正式库0 sorry、0 axiom声明，{frozen}个冻结文件一致；任务包{packages["batches"]}批、{len(seen)}子包。'
    for name in ['AGENTS.md','docs/handoff/CURRENT_STATE.zh-CN.md']:
        p=ROOT/name;s=p.read_text(encoding='utf-8');a=s.index('## 28号运行检查点');b=s.index('## 历史规则与状态',a)
        s=s[:a]+'## 28号运行检查点\n\n'+msg+'\n不做附加章节。未证陈述、覆盖缺口和待导师裁定问题见CH07三份文档；网站未提交。\n\n'+s[b:]
        if name.endswith('CURRENT_STATE.zh-CN.md'):s='第8章本地流程完成，等待用户新指令\n\n'+s
        p.write_text(s,encoding='utf-8')
    (ROOT/'docs/handoff/RESUME_PROMPT.zh-CN.md').write_text('# 第28号已完成\n\n'+msg+'\n停止，不做附加章节；等待用户新指令。\n如heartbeat接续，先读PROGRESS.md与closeout/COMPLETION.json，满足停止条件时不再开展工作。\n',encoding='utf-8')
    with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
        f.write('\n## 2026-10-18 第28号第8章章末收口\n\n'+msg+'\n原书正文实际截止PDF347的Exercises之前；末尾完整检查及逐项状态见blueprint/ch08/closeout/COMPLETION.json。\n未证与范围缺口保留，网站未送审；已结束第8章，不做附加章节。\n')
    (BASE/'LOCAL_PIPELINE.md').write_text('# 第8章本地五步流程\n\n'+msg+'\n原文JSON及原页 → Lean陈述 → 本地原页核对 → 编译与公理检查 → 三份导师文档。\n网站未提交；停止于第8章。\n',encoding='utf-8')
    print(json.dumps(completion,ensure_ascii=False,indent=2))

if __name__=='__main__':main()

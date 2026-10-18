"""Validate chapter-8 closeout, write mentor documents and the stopping checkpoint."""
from ch08_pipeline import *
from ch08_packages import closure
from ch08_dependency_index import index_project,strip_comments
from collections import Counter

def main():
    frozen=verify_frozen(full=True)
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
    assert {r['section'].split('.')[1] for r in RECORDS}=={str(x) for x in range(1,11)}
    checks=json.loads((BASE/'source_page_checks.json').read_text(encoding='utf-8'))['visually_checked_pdf_pages']
    assert all(str(p) in checks for p in range(350,421))
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
    counts=Counter();decls=[];unproved_categories=Counter()
    attempts=json.loads((BASE/'proof_attempts.json').read_text(encoding='utf-8'))
    for r in RECORDS:
        a=audit[r['source_id']]
        assert '本条列出的数学对象与结论全部' not in r['statement_scope']
        for kind,name in re.findall(r'(?m)^(?:noncomputable )?(def|abbrev|theorem|lemma|structure|inductive)\s+(\w+)',r['code']):
            full_name='MD.Ch08.'+name;axs=a['declaration_axioms'][full_name]
            unproved='sorryAx' in axs
            if kind not in ('theorem','lemma'):assert not unproved,('Incomplete definition',full_name)
            status='未证' if unproved else '已证' if kind in ('theorem','lemma') else '定义或记号'
            category=None
            if unproved:
                category='原书疑误不证' if 'Printed' in name or name=='diffusionPrinted' else attempts[r['source_id']]['category']
                if category=='原书疑误不证' and ('corrected' in name or 'Printed' not in name and name!='diffusionPrinted'):
                    category='缺大型理论'
                unproved_categories[category]+=1
            counts[status]+=1
            decls.append(dict(source_id=r['source_id'],name=full_name,kind=kind,status=status,unproved_category=category,axioms=axs))
    equations={f'8.{i}':[r['source_id'] for r in RECORDS if f'8.{i}' in r['numbered_equations']] for i in range(1,115)}
    assert all(equations.values()),('Unaccounted numbered formula',[k for k,v in equations.items() if not v])
    labels={r['label']:r['source_id'] for r in RECORDS if r['label']}
    for label in ['Lemma 8.1','Proposition 8.1','Proposition 8.2','Proposition 8.3','Theorem 8.1']:assert label in labels,label
    coverage=dict(body_sections='8.1–8.10',body_pdf_pages=[350,420],
        boundary='PDF420的Exercises之前；PDF423–436为附录，均不纳入正文。',
        all_numbered_equations_accounted=True,formula_numbers=equations,numbered_objects=labels,
        all_source_items_registered=True,all_mathematical_claims_fully_proved=False,
        declarations=decls,scope_selfcheck=[dict(source_id=r['source_id'],statement_scope=r['statement_scope'],
          declared_names=r['lean_declarations'],code_sha256=hashlib.sha256(r['code'].encode()).hexdigest(),
          extra=r['extra_assumptions'],missing=r['missing'],review='已对照本条实际定义、签名、原页及限定范围；未用辅助恒等式冒充完整原句。') for r in RECORDS],
        excluded=EXCLUDED)
    dump(BASE/'closeout/COVERAGE_AND_GAPS.json',coverage)
    completion=dict(machine_check_status='passed',body_all_items_on_disk=True,final_full_check_passed=True,
        entries=len(RECORDS),declarations=len(decls),declaration_status=dict(counts),unproved_categories=dict(unproved_categories),
        canonical_sha256=sha(canonical),source_json_sha256=sha(BASE/'ch08_source.json'),
        native_binding=binding.relative_to(ROOT).as_posix(),native_binding_sha256=sha(binding),
        full_report='blueprint/ch08/closeout/full/CHECK_REPORT.json',full_report_sha256=sha(full/'CHECK_REPORT.json'),
        frozen_files=frozen,formal_source_files=len(formal),formal_sorry=0,formal_axiom_declarations=0,
        batches=packages['batches'],subtasks=len(seen),covered_entries=len(seen),missing_project_definitions=0,
        website_submitted=False,scope='第8章全部正文条目已登记；证明与覆盖缺口逐条保留；停止，不做附加章节。')
    dump(BASE/'closeout/COMPLETION.json',completion)
    render()
    issues=[r for r in RECORDS if r['issues'] or r['local_verdict']=='NEEDS_HUMAN']
    err=['# 第8章原书疑误与双版本审阅单','',
      '教材：Leimkuhler–Matthews《Molecular Dynamics》（2015）。正文印刷329–399页、PDF350–420页，末页仅取Exercises之前。',
      '所有公式疑点均已目视核对原页。以下为待导师裁定的工作版本；书中省略条件、符号歧义、明确代数矛盾分别说明。网站尚未审阅。',
      '原页引文保留文字层字符；公式的分式、上下标和特殊字形以附原页排版为准。原文版不作为修正版的证明依据。','']
    for k,r in enumerate(issues,1):
        ds=[d for d in decls if d['source_id']==r['source_id']]
        raw='\n\n'.join(f'PDF{p["pdf_page"]}（印刷{p["printed_page"]}）：\n'+p['text'] for p in r['original_page_text'])
        err += [f'## {k}. {r["source_id"]}','',f'- source_id：{r["source_id"]}；印刷{r["printed_page"]} / PDF{r["pdf_page"]}。',
          '- 原页核对：已目视核对原页。','- 原文引文（对应原页文字层逐字保留）：','',
          '\n'.join('> '+line for line in raw.splitlines()),'',
          '- 本条公式定位：'+r['statement_latex'],
          '- 问题所在、反例或理由：'+('；'.join(r['issues']) or '技术条件或覆盖范围需核查。'),
          '- 工作修正及限定：'+'；'.join(r['extra_assumptions']),
          '- 原文版及修正版Lean名称与证明状态：']
        err += ['  - `'+d['name']+'`：'+d['status']+'。' for d in ds]
        err += ['- 待人工核查点：'+r['statement_scope'],
          '- 导师选项：接受所列工作修正或限定 / 保留原文并补足适用条件 / 指定新的修正。',
          '- 网站结论：尚未送审；原文忠实性、原书疑误与修正版应分别审阅。','']
    (ROOT/'docs/review/CH08_ERRATA.zh-CN.md').write_text('\n'.join(err).rstrip()+'\n',encoding='utf-8')
    summary=['# 第8章：导师审阅摘要','',
      f'已整理§8.1–§8.10正文{len(RECORDS)}条。正文为印刷329–399页（PDF350–420），末页在Exercises标题前截止；其后习题和附录不纳入。本章114条编号公式以及Lemma 8.1、Proposition 8.1–8.3、Theorem 8.1均有对应条目。数值图表与经验比较另列。','',
      f'共有{len(decls)}个命名声明：{counts["定义或记号"]}项定义或记号、{counts["已证"]}项已证定理、{counts["未证"]}项未证陈述。全部条目已登记，仍有完整理论与局部覆盖的区别；各条明确列出适用条件和未覆盖内容。','',
      '已完成的证明包括Hamiltonian Gibbs权的局部驻定、扩展密度边缘积分、热浴的相加命题、线性热浴场的Lie括号归属、模态域内的线性无关、补充非零噪声后的Hörmander条件，以及零模态沿轨道保持。另有投影、约束瞬时平衡、Gaussian权归一、体积正性、成对动量守恒和动量缩放等代数结论。','',
      '未证部分主要涉及高维散度与积分分部、随机积分和Gaussian转移律、非线性约束括号、一般ODE投影与积分因子、记忆核过程极限，以及不变测度与遍历性。给出形式生成元或局部驻定式，不表示已经证明全局概率不变性、唯一性或采样收敛。','',
      f'共有{len(issues)}项原文疑点或条件问题待导师裁定。重点包括Nosé时间变量的导数和对数项、非零噪声条件、OU矩阵协方差与扩散系数、Lyapunov衰减系数、等动能散度符号、SIN括号/子流符号及热浴质量、一般矩阵记忆核协方差、NPT边缘权的归一常数、活塞热浴权的动能系数，以及DPD质量矩阵次序与单对生成元。每项保留原文和工作修正，证明状态单独列出。','',
      '随机过程明确标准Wiener及独立坐标、适应性和实际积分方程。密度的非负、可积与归一条件独立写明；热浴、活塞质量和正体积等有效域单列。固定总动量的分布以动量叶参考测度表述，没有将Dirac记号当作普通Lebesgue密度。','',
      '已验证：第8章当前全文的Lean检查、所有命名声明的证明依赖核查，以及固定Lean 4.34.0与对应Mathlib的完整工程检查均通过。正式库没有未完成证明或新增公理；本轮冻结的第1–7章及正式库文件逐字一致。','',
      f'首轮审阅材料已整理为{packages["batches"]}批、{len(seen)}个子包，覆盖{len(seen)}条，附对应原页及所需项目定义。尚未提交网站。','',
      f'尚未验证或裁定：{counts["未证"]}项未证陈述、逐条列出的完整理论缺口、网站语义审阅和导师对原书疑点的裁定。',
      '详细条目见[逐条材料](CH08_BLUEPRINT.zh-CN.md)，原书疑点见[审阅单](CH08_ERRATA.zh-CN.md)。第8章本地流程结束，等待用户新指令。']
    (ROOT/'docs/review/CH08_SUMMARY_FOR_MENTOR.zh-CN.md').write_text('\n'.join(summary)+'\n',encoding='utf-8')
    for name in ['CH08_BLUEPRINT.zh-CN.md','CH08_ERRATA.zh-CN.md','CH08_SUMMARY_FOR_MENTOR.zh-CN.md']:
        text=(ROOT/'docs/review'/name).read_text(encoding='utf-8')
        for forbidden in ['sorryAx','checked+documented priors','字节预算','历史绑定哈希']:assert forbidden not in text,(name,forbidden)
    msg=f'第8章本地流程完成，等待用户新指令。正文{len(RECORDS)}条，章末完整check通过；正式库0 sorry、0 axiom声明，{frozen}个冻结文件一致；任务包{packages["batches"]}批、{len(seen)}子包，缺失定义0。'
    for name in ['AGENTS.md','docs/handoff/CURRENT_STATE.zh-CN.md']:
        p=ROOT/name;s=p.read_text(encoding='utf-8');a=s.index('## 28号运行检查点');b=s.index('## 历史规则与状态',a)
        s=s[:a]+'## 28号运行检查点\n\n'+msg+'\n未证陈述、覆盖缺口和待导师裁定问题见CH08三份文档；网站未提交。停止，不做附加章节。\n\n'+s[b:]
        s=s.replace('继续28号第8章，从50条检查点的§8.6剩余内容接续。','28号第8章已完成本地流程，现已停止，等待用户新指令。')
        if name.endswith('CURRENT_STATE.zh-CN.md'):s='第8章本地流程完成，等待用户新指令\n\n'+s
        p.write_text(s,encoding='utf-8')
    (ROOT/'docs/handoff/RESUME_PROMPT.zh-CN.md').write_text('# 第29号及续接28号已完成\n\n'+msg+'\n第7章首轮结果已整合，12个EAUDIT包覆盖35条，待用户提交；Ch07继续冻结。\n如heartbeat接续，先读PROGRESS与COMPLETION；满足停止条件时不再开展工作。不做附加章节。\n',encoding='utf-8')
    with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
        f.write('\n## 2026-10-18 第29号续接28号第8章章末收口\n\n'+msg+'\n正文截止PDF420的Exercises之前，114编号公式全部登记；未证与范围缺口详见COVERAGE_AND_GAPS。\n第7章交付提交bf0f8b8a后持续冻结；第8章网站未送审，已停止，等待用户新指令。\n')
    (BASE/'LOCAL_PIPELINE.md').write_text('# 第8章本地五步流程\n\n'+msg+'\n原文JSON及原页 → Lean陈述 → 原页核对 → 编译与公理检查 → 导师材料。\n完整数学理论的未证部分明确保留；网站未提交，停止于第8章。\n',encoding='utf-8')
    print(json.dumps(completion,ensure_ascii=False,indent=2))

if __name__=='__main__':main()

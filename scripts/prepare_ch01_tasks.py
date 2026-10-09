"""Prepare one-goal, version-bound MathCopilot tasks. No website interaction."""
from __future__ import annotations

import argparse
import json
import re
import subprocess
from pathlib import Path

from render_blueprint import ROOT, declarations, entry_hash, sha256

PILOT = ROOT / 'blueprint/ch01'

DEFINITIONS = {
 'MD-1.5.3-Thm1.1': ['MolecularDynamics/Notation.lean', 'MolecularDynamics/Chapter01/PotentialBarriers.lean',
    'MolecularDynamics/Chapter01/Equilibrium.lean', 'MolecularDynamics/Chapter01/EuclideanStability.lean',
    'MolecularDynamics/Chapter01/PhaseMetric.lean', 'MolecularDynamics/Chapter01/LocalTrajectories.lean'],
 'MD-1.2-EnergyConservation': ['MolecularDynamics/Notation.lean', 'MolecularDynamics/Chapter01/NBody.lean',
    'MolecularDynamics/Chapter01/ParticleCoordinates.lean', 'MolecularDynamics/Chapter01/LocalTrajectories.lean',
    'MolecularDynamics/Chapter01/EnergyConservation.lean', 'MolecularDynamics/Chapter01/Hamiltonian.lean'],
 'MD-1.3-NewtonEulerLagrange': ['MolecularDynamics/Notation.lean', 'MolecularDynamics/Chapter01/NBody.lean',
    'MolecularDynamics/Chapter01/LocalTrajectories.lean', 'MolecularDynamics/Chapter01/Lagrangian.lean'],
 'MD-1.4-LegendreHamiltonian': ['MolecularDynamics/Notation.lean', 'MolecularDynamics/Chapter01/LegendreTransform.lean',
    'MolecularDynamics/Chapter01/Lagrangian.lean'],
 'MD-1.5.1-FlowInverse': ['MolecularDynamics/Notation.lean', 'MolecularDynamics/Chapter01/LocalTrajectories.lean',
    'MolecularDynamics/Chapter01/GlobalFlow.lean', 'MolecularDynamics/Chapter01/LocalExistence.lean'],
}

CONTEXT_PAGES = {
 'MD-1.5.3-Thm1.1': 'PDF 41、48、54–55（印刷18、25、31–32）',
 'MD-1.2-EnergyConservation': 'PDF 41–42（印刷18–19）',
 'MD-1.3-NewtonEulerLagrange': 'PDF 41、45–46（印刷18、22–23）',
 'MD-1.4-LegendreHamiltonian': 'PDF 45–47（印刷22–24）',
 'MD-1.5.1-FlowInverse': 'PDF 48–49（印刷25–26）',
}


def dependency_inventory(lean_text: str) -> list:
    queue = re.findall(r'^import\s+(MolecularDynamics(?:\.[\w]+)+)\s*$', lean_text, re.M)
    seen = set()
    result = []
    while queue:
        module = queue.pop()
        if module in seen:
            continue
        seen.add(module)
        relative = module.replace('.', '/') + '.lean'
        text = (ROOT/relative).read_text(encoding='utf-8-sig')
        imports = re.findall(r'^import\s+(\S+)\s*$', text, re.M)
        result.append(dict(module=module, file=relative, sha256=sha256(text), imports=imports))
        queue.extend(m for m in imports if m.startswith('MolecularDynamics.'))
    return sorted(result, key=lambda r: r['module'])


def fingerprint(entry: dict, lean_text: str) -> dict:
    d = declarations(lean_text)[entry['source_id']]
    prelude = lean_text[:lean_text.index('/-- source_id:')]
    inventory = dependency_inventory(lean_text)
    return dict(source_entry_sha256=entry_hash(entry), signature_sha256=d['signature_sha256'],
                prelude_sha256=sha256(prelude),
                project_dependency_inventory_sha256=sha256(json.dumps(inventory, sort_keys=True)))


def generate(revision='', source_id=None):
    sources = json.loads((PILOT/'ch01_source.json').read_text(encoding='utf-8-sig'))
    lean_text = (ROOT/'Blueprint/Ch01.lean').read_text(encoding='utf-8-sig')
    decls = declarations(lean_text)
    registry_path = PILOT/'tasks.json'
    registry = json.loads(registry_path.read_text(encoding='utf-8')) if registry_path.exists() else {}
    base = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    template = ROOT.parent/'claude-notes/03_MathCopilot任务模板.md'
    template_text = template.read_text(encoding='utf-8-sig')
    bodies = re.findall(r'```\s*\n([\s\S]*?)\n```', template_text)
    if len(bodies) < 3:
        raise ValueError('Templates A/B/C not found')
    inventory = dependency_inventory(lean_text)
    (PILOT/'dependency_inventory.json').write_text(json.dumps(inventory, ensure_ascii=False, indent=2)+'\n',encoding='utf-8')
    for s in sources:
        sid = s['source_id']
        if source_id and sid != source_id:
            continue
        fp = fingerprint(s, lean_text)
        for idx, stage in enumerate(('json_review', 'blueprint', 'audit')):
            name = f'T_{stage}_{sid}' + ('_' + revision if revision else '')
            path = PILOT/'mathcopilot_tasks'/f'{name}.md'
            if path.exists() and registry.get(name, {}).get('input_fingerprint') != fp:
                raise ValueError(f'Use a new --revision to preserve previous task: {name}')
            body = bodies[idx].replace('<source_id 列表>', sid).replace('<声明名>', s['lean_decl'])
            upload = [f'- 教材完整PDF：`{ROOT.parent.name}/Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`。',
                      f"- 原文条目：印刷 p.{s['printed_page']} / PDF p.{s['pdf_page']}；上下文页：{CONTEXT_PAGES[sid]}。PDF页号从1起算。",
                      '- `blueprint/ch01/ch01_source.json`（下面也内嵌本条）。']
            if idx > 0:
                upload += ['- `Blueprint/Ch01.lean`，目标声明 `' + s['lean_decl'] + '`（下面内嵌片段）。']
            if idx == 2:
                upload += ['- 以下相关定义文件（可以合并上传，必须点开检查，不能仅凭定义名推断）：']
                upload += ['  - `' + p + '`' for p in DEFINITIONS[sid]]
                upload += ['- `blueprint/ch01/dependency_inventory.json`：正式库传递导入文件和哈希；若不能读取依赖，明确标未验证。']
            guard = ('本条当前JSON尚未approved，先完成模板A。若A有修复，Codex整合后用新任务版本重生成B/C；'
                     '只读审计C必须使用approved JSON和当前哈希，不审旧稿。')
            text = f'# {name}\n\n单目标：{sid}。模板{chr(65+idx)}，来自`claude-notes/03_MathCopilot任务模板.md`。\n\n'
            text += '## 上传 / @引用\n\n' + '\n'.join(upload) + '\n\n'
            text += f'正式库基线commit：`{base}`。草稿以以下内容哈希锁定；网站不负责推送/改仓库。\n\n'
            text += '```json\n' + json.dumps(fp, indent=2) + '\n```\n\n' + guard + '\n\n'
            text += '## 任务正文\n\n' + body + '\n\n'
            if idx == 1:
                text += '独立给出完整签名；将候选放在输出里，不覆盖现有源码。不要拿本地版本作为忠实性的依据。\n\n'
            if idx == 2:
                text += '注意：审计包含本条全部结论子句和[EXTRA]/[ERRATUM?]。缺上下文或无法检查Lean时明确记未验证；不得假报fresh Check。\n\n'
            text += '## 返回件约定\n\n用户保存到`blueprint/ch01/mathcopilot_results/' + name + '.json`或`.md`。\n'
            text += '在模板规定的JSON字段之外，原样添加下列任务名和input_fingerprint；不输出未经检查的PASS。\n\n'
            text += '```json\n' + json.dumps(dict(task_name=name, input_fingerprint=fp),ensure_ascii=False,indent=2) + '\n```\n\n'
            if idx == 1:
                text += '模板B返回JSON需包含`source_id`、`lean_decl`、`lean_statement`（完整Lean陈述字符串）、`extra_assumptions`、`risks`、`fresh_check`（命令/版本/实际结果或not_run）。\n\n'
            text += '## 本条JSON输入\n\n```json\n' + json.dumps(s,ensure_ascii=False,indent=2) + '\n```\n'
            if idx > 0:
                text += '\n## 当前Blueprint片段\n\n```lean\n' + lean_text[:lean_text.index('/-- source_id:')] + '\n' + decls[sid]['block'] + '\nend MD.Ch01\n```\n'
            path.parent.mkdir(parents=True,exist_ok=True)
            path.write_text(text,encoding='utf-8')
            registry[name] = dict(source_id=sid, stage=('json_review','blueprint_translation','semantic_review')[idx],
                                  input_fingerprint=fp, task_file=str(path.relative_to(ROOT)).replace('\\','/'),
                                  base_commit=base, task_sha256=sha256(text))
    registry_path.write_text(json.dumps(registry,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(f'Prepared version-bound tasks: {len(registry)} registered')


if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('--revision', default='')
    p.add_argument('--source-id')
    args = p.parse_args()
    generate(args.revision, args.source_id)

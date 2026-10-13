"""Second website batch; only page-checked source correction and two full signature repairs."""
import copy,json,re,hashlib
from datetime import datetime
from pathlib import Path
import fitz
from pypdf import PdfReader,PdfWriter
from integrate_website_returns import ROOT,sha,read,dump,display
from render_blueprint import entry_hash
from ch01_full_tools import declarations
from build_mathcopilot_compact import definitions,referenced
BASE=ROOT/'blueprint/ch01';TASK=BASE/'mathcopilot_tasks/EAUDIT03'
SIDS=['MD-1.1.1-Multibody','MD-1.1.1-MorseMinimum','MD-1.1.1-LengthBond','MD-1.1.1-HeterogeneousLJ']
MENTOR='MD-1.1.1-LJRepulsion'

def prepare():
 receipt=BASE/'mathcopilot_results/EAUDIT03_PREPARATION.json'
 if receipt.exists():
  saved=read(receipt);assert sha(ROOT/'Blueprint/Ch01.lean')==saved['lean_sha256']
  assert sha(BASE/'ch01_source.json')==saved['source_sha256'];print('EAUDIT03 existing preparation reused.');return
 lean=ROOT/'Blueprint/Ch01.lean';old_ds=declarations();text=lean.read_text(encoding='utf-8-sig')
 old='morsePotential D a rₑ rₑ = 0 ∧ Tendsto (morsePotential D a rₑ) atTop (𝓝 D) := by'
 if old not in text:
  assert 'deriv (deriv (morsePotential D a rₑ)) rₑ = 2*D*a^2' in text
  original_audit=read(BASE/'local_audit.json')['items']
  for sid in SIDS:old_ds[sid]['signature_sha256']=original_audit[sid]['signature_sha256']
 text=text.replace(old,'''morsePotential D a rₑ rₑ = 0 ∧ Tendsto (morsePotential D a rₑ) atTop (𝓝 D) ∧
    deriv (deriv (morsePotential D a rₑ)) rₑ = 2*D*a^2 ∧
    (∀ a₁ a₂ : ℝ, 0 < a₁ → a₁ < a₂ →
      deriv (deriv (morsePotential D a₁ rₑ)) rₑ < deriv (deriv (morsePotential D a₂ rₑ)) rₑ) := by''',1)
 old='def lengthBond (k r₀ r : ℝ) := k / 2 * (r-r₀)^2'
 assert old in text or 'def lengthBond (k r₀ : ℝ) (qᵢ qⱼ : V3)' in text
 text=text.replace(old,'def lengthBond (k r₀ : ℝ) (qᵢ qⱼ : V3) := k / 2 * (‖qᵢ-qⱼ‖-r₀)^2',1)
 if 'def lengthBondRadial' not in text:
  first=text.index('/-- source_id:')
  text=text[:first]+'-- EAUDIT03: original radial profile retained as an auxiliary.\ndef lengthBondRadial (k r₀ r : ℝ) := k / 2 * (r-r₀)^2\n\n'+text[first:]
 lean.write_text(text,encoding='utf-8')
 ds=declarations();sources=read(BASE/'ch01_source.json');unchanged=copy.deepcopy(sources)
 indexed={s['source_id']:s for s in sources};web=read(BASE/'website_audit.json');ws={w['source_id']:w for w in web}
 pdf=next(ROOT.parent.glob('Leimkuhler2015b*.pdf'));book=fitz.open(pdf)
 expected=read(BASE/'mathcopilot_tasks/MANIFEST.json')[0]['source_pdf_sha256'];assert sha(pdf)==expected
 visual=BASE/'validation/EAUDIT03/source_pages';visual.mkdir(parents=True,exist_ok=True)
 pages=[]
 for p in (31,32,33,34):
  cached=ROOT/f'tmp/ch01_full/pdf{p:03}.png';fresh=book[p-1].get_pixmap(matrix=fitz.Matrix(1.3,1.3))
  assert fresh.samples==fitz.Pixmap(cached).samples
  path=visual/f'pdf{p:03}.png';fresh.save(path)
  pages.append(dict(pdf_page=p,printed_page=p-23,png=path.relative_to(ROOT).as_posix(),png_sha256=sha(path),verification='VIEW_IMAGE original pages31–34 checked; exact pixel identity with source PDF verified'))
 extra={
  SIDS[0]:'[EXTRA] EAUDIT03补真实V3=Position 3=EuclideanSpace ℝ(Fin 3)及求和依赖，仅补材料，不改多体定义。',
  SIDS[1]:'[EXTRA] EAUDIT03补原曲率子句的实际展开φ″(rₑ)=2Da²，并表达固定D>0时正a增大曲率严格增大；公式为形式化展开，不回填成教材原句。',
  SIDS[2]:'[EXTRA] EAUDIT03保留原径向剖面为lengthBondRadial；主定义以真实三维粒子位置为参数，rᵢⱼ=‖qᵢ−qⱼ‖代入原弹簧能。',
  SIDS[3]:'[EXTRA] EAUDIT03补真实V3和pairDistance=‖qᵢ−qⱼ‖；总函数公式对应域为pairDistance>0，零距离的总化取值不解释为物理势。'}
 changed_fields={}
 for sid in [*SIDS,MENTOR]:
  s=indexed[sid];before=entry_hash(s);changes=[]
  existing=next((r for r in s['repair_log'] if r.get('stage')=='EAUDIT03_LOCAL_PAGE_RECHECK'),None)
  if existing:
   assert existing['after_sha256']==entry_hash(s)
   changed_fields[sid]=existing['changed_fields'];continue
  if sid==SIDS[2]:
   proposed=ws[sid]['json_review']['corrected_json']['statement_latex']
   assert s['statement_latex'].replace('compared to the other','compared to other')==proposed
   s['statement_latex']=proposed;changes.append('statement_latex');s['review_status']='CORRECTED'
  if sid in extra:s['extra_assumptions'].append(extra[sid])
  if sid==MENTOR:
   s['context_notation'].append('EAUDIT03：精确LJ单侧极限保留；“long simulations/well separated/rarely”尚无算法、时间段和概率频率语义，经验叙述覆盖未完成，供导师裁定，不能推为无条件全局无碰撞。')
  s['source_page_verification']='VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json'
  s['repair_log'].append(dict(stage='EAUDIT03_LOCAL_PAGE_RECHECK',timestamp=datetime.now().isoformat(),before_sha256=before,after_sha256=entry_hash(s),
    changed_fields=changes,raw_return=ws[sid]['raw_path'],raw_sha256=ws[sid]['raw_sha256'],
    reason='原PDF31–34逐页视觉核对；长度键删除原多出的the；两条签名补全部曲率/粒子距离；两条补真实依赖；LJ经验语义待导师。'))
  changed_fields[sid]=changes
 assert all(s==old for s,old in zip(sources,unchanged) if s['source_id'] not in [*SIDS,MENTOR])
 dump(BASE/'ch01_source.json',sources);dump(BASE/'validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json',dict(source_pdf_sha256=expected,pages=pages))
 paths={'Blueprint/Ch01.lean'};pending=list(paths)
 while pending:
  for imp in re.findall(r'(?m)^import ([\w.]+)',(ROOT/pending.pop()).read_text(encoding='utf-8-sig')):
   path=imp.replace('.','/')+'.lean'
   if path.startswith('MolecularDynamics/') and path not in paths:paths.add(path);pending.append(path)
 index=definitions(sorted(paths))
 for choices in list(index.values()):
  for d in choices:
   if d['namespace']:index.setdefault(d['namespace']+'.'+d['name'],[]).append(d)
 materials={};excerpts={}
 for sid in SIDS:
  selected={};pending=referenced(ds[sid]['statement'],index)
  while pending:
   name=sorted(pending)[0];pending.remove(name)
   if name in selected:continue
   choices=index[name];selected[name]=[d for d in choices if d['path']=='Blueprint/Ch01.lean'] or choices
   for d in selected[name]:pending.update(referenced(d['code'],index)-selected.keys())
  chunks=['## 原文JSON','```json',json.dumps(indexed[sid],ensure_ascii=False,indent=2),'```','## 当前完整Lean','```lean',ds[sid]['statement'],'```'];excerpts[sid]=[]
  for name in sorted(selected):
   for d in selected[name]:
    chunks+=['### 实际依赖 '+d['namespace']+'.'+d['name'],'```lean',d['code'],'```']
    excerpts[sid].append(dict(path=d['path'],name=name,file_sha256=sha(ROOT/d['path']),excerpt_sha256=hashlib.sha256(d['code'].encode()).hexdigest()))
  materials[sid]='\n'.join(chunks)+'\n'
 TASK.mkdir(parents=True,exist_ok=True);full=TASK/'BATCH_EAUDIT03.md'
 full.write_text('# EAUDIT03：第1章§1.1.1网站修复及真实依赖复审\n\n'+'\n'.join(materials.values()),encoding='utf-8')
 shared={'BATCH_EAUDIT03.md':sha(full),'Blueprint/Ch01.lean':sha(lean),'blueprint/ch01/ch01_source.json':sha(BASE/'ch01_source.json')}
 reader=PdfReader(pdf);subtasks=[]
 for j,sid in enumerate(SIDS):
  label='EAUDIT03'+chr(97+j);folder=TASK/chr(97+j);folder.mkdir(exist_ok=True);numbers=[int(n) for n in re.findall(r'\d+',indexed[sid]['pdf_page'])]
  nums=list(range(numbers[0],numbers[-1]+1));writer=PdfWriter()
  for p in nums:writer.add_page(reader.pages[p-1])
  crop=folder/(label+'_PAGES.pdf')
  with crop.open('wb') as f:writer.write(f)
  cropped=fitz.open(crop)
  for k,p in enumerate(nums):
   with fitz.open(pdf) as original_page_document:
    assert cropped[k].get_pixmap(matrix=fitz.Matrix(.5,.5)).samples==original_page_document[p-1].get_pixmap(matrix=fitz.Matrix(.5,.5)).samples,(label,p)
  hashes={**shared,label+'_materials':hashlib.sha256(materials[sid].encode()).hexdigest(),label+'_PAGES.pdf':sha(crop)}
  prompt=('先A逐字审校，再C只读完整语义审计；检查真实对象/域/量词/全部结论及EXTRA，勿修改工程或补证明。'
    '\n必须实际写入 /workspace/.mathcopilot/reviews/ch01_eaudit/EAUDIT03_review.json，对象含batch=EAUDIT03、input_sha256、items；回显下列哈希。已有文件共享输入相同则按source_id追加合并，版本冲突则报告。'
    '\nitems每条source_id,json_review{status,issue_codes,corrected_json,issues,evidence},audit{lean_decl,verdict,explanation,counterexample,suggested_fix}；status=APPROVED/CORRECTED/NEEDS_HUMAN，verdict=PASS/FAIL/NEEDS_HUMAN。'
    '\n原PDF页映射='+str(nums)+'；原书数学判断保留疑误。最后仅报告实际文件路径。\ninput_sha256：\n'+json.dumps(hashes,ensure_ascii=False,indent=2)+'\n\n')
  paste=folder/'PASTE.txt';paste.write_text(prompt+materials[sid],encoding='utf-8');mp=folder/'MANIFEST.json'
  m=dict(eaudit='EAUDIT03',source_id=sid,input_sha256=hashes,source_pdf_sha256=expected,pdf_page_mapping=nums,crop_pixel_identity='PASS',
    paste_sha256=sha(paste),dependency_excerpts=excerpts[sid],expected_output='/workspace/.mathcopilot/reviews/ch01_eaudit/EAUDIT03_review.json')
  for _ in range(4):m['total_task_bytes']=paste.stat().st_size+crop.stat().st_size+(mp.stat().st_size if mp.exists() else 0);dump(mp,m)
  total=sum(p.stat().st_size for p in folder.iterdir() if p.is_file());assert total==m['total_task_bytes']<256000
  subtasks.append(dict(subtask=label,source_id=sid,path=folder.relative_to(ROOT).as_posix(),total_bytes=total,manifest_sha256=sha(mp)))
 dump(TASK/'MANIFEST.json',dict(eaudit='EAUDIT03',input_sha256=shared,subtasks=subtasks))
 (TASK/'INDEX.md').write_text('# EAUDIT03：第1章§1.1.1复审\n\n每项粘贴PASTE并上传原页PDF；仅生成，网站由用户提交。\n\n'+
  '\n'.join('- ['+s['subtask']+']('+chr(97+j)+'/PASTE.txt)：'+s['source_id']+'，'+str(s['total_bytes'])+'字节。' for j,s in enumerate(subtasks))+
  '\n\n实际输出 /workspace/.mathcopilot/reviews/ch01_eaudit/EAUDIT03_review.json，必须包含input_sha256及items。LJRepulsion的经验句另等导师裁定，未改极限定理。\n',encoding='utf-8')
 for w in web:
  if w['source_id'] in SIDS:
   w['repair']=dict(eaudit='EAUDIT03',status='awaiting_reaudit',signature_changed=old_ds[w['source_id']]['signature_sha256']!=ds[w['source_id']]['signature_sha256'],
     json_review_locally_verified=True,task_index='blueprint/ch01/mathcopilot_tasks/EAUDIT03/INDEX.md',input_sha256=shared)
  if w['source_id']==MENTOR:w['repair']=dict(eaudit='EAUDIT03',status='awaiting_mentor',signature_changed=False,mentor_question='经验句保留定性覆盖未完成，还是由导师指定算法、时间段及rarely概率语义后另立命题？选项：定性登记 / 指定数学模型。')
  w['effective_status']=display(w)
 dump(BASE/'website_audit.json',web)
 dump(receipt,dict(source_ids=SIDS,mentor_ids=[MENTOR],lean_sha256=sha(lean),source_sha256=sha(BASE/'ch01_source.json'),
   old_signature_sha256={sid:old_ds[sid]['signature_sha256'] for sid in SIDS},changed_source_fields=changed_fields,
   raw_returns={ws[sid]['raw_path']:ws[sid]['raw_sha256'] for sid in [*SIDS,MENTOR]},task_index='blueprint/ch01/mathcopilot_tasks/EAUDIT03/INDEX.md',website_reaudit='not submitted'))
 print('EAUDIT03 prepared', [s['total_bytes'] for s in subtasks])

if __name__=='__main__':prepare()

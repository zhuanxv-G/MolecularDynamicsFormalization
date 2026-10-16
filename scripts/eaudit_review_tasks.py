"""Compact A+C packages for a repaired snapshot, with immutable historical BATCH files."""
import json,re,hashlib,types
from pathlib import Path
import fitz
from pypdf import PdfReader,PdfWriter
from integrate_website_returns import ROOT,sha,read,dump
from build_mathcopilot_compact import definitions,referenced

def declaration_names(text):
 return re.findall(r'(?m)^(?:@\[[^\]\n]+\]\s*)*(?:(?:noncomputable|private|protected)\s+)*(?:theorem|lemma|def|abbrev)\s+(\w+)',text)

def declarations(ch):
 text=(ROOT/f'Blueprint/Ch{ch:02}.lean').read_text(encoding='utf-8-sig')
 marks=list(re.finditer(r'/-- source_id:\s*([^\s·]+)[\s\S]*?-/',text));out={}
 for i,m in enumerate(marks):
  stop=marks[i+1].start() if i+1<len(marks) else text.rfind(f'end MD.Ch{ch:02}')
  raw=text[m.end():stop].strip();d=re.search(r'\b(theorem|def)\s+(\w+)',raw)
  statement=raw if d.group(1)=='def' else raw.split(' := by',1)[0]
  out[m.group(1)]=dict(name=f'MD.Ch{ch:02}.'+d.group(2),statement=statement,block=raw,
    line=text[:m.end()].count('\n')+raw[:d.start()].count('\n')+2,
    signature_sha256=hashlib.sha256(statement.encode()).hexdigest(),block_sha256=hashlib.sha256(raw.encode()).hexdigest())
 return out

def render_document(ch):
 source=(ROOT/'scripts/render_ch02_blueprint.py').read_text(encoding='utf-8')
 source=source.replace('ch02',f'ch{ch:02}').replace('Ch02',f'Ch{ch:02}').replace('第2章',f'第{ch}章').replace('Chapter 2',f'Chapter {ch}')
 source=source.replace(f'from ch{ch:02}_pipeline import declarations as whole_declarations',
   f'from eaudit_review_tasks import declarations as _current_declarations\n    whole_declarations=lambda: _current_declarations({ch})')
 ranges={2:'53–94',3:'97–136',4:'139–174',5:'179–209',6:'211–258'}
 source=source.replace('53–94',ranges[ch])
 module=types.ModuleType('eaudit_current_renderer');module.__file__=str(ROOT/'scripts/eaudit_review_tasks.py')
 exec(compile(source,module.__file__,'exec'),module.__dict__)
 base=ROOT/f'blueprint/ch{ch:02}'
 return module.render(base/f'ch{ch:02}_source.json',ROOT/f'Blueprint/Ch{ch:02}.lean',base/'local_audit.json')

def build(ch,eaudit,section,sids):
 base=ROOT/f'blueprint/ch{ch:02}';task=base/'mathcopilot_tasks'/eaudit
 sources=read(base/f'ch{ch:02}_source.json');indexed={s['source_id']:s for s in sources};ds=declarations(ch)
 pdf=next(ROOT.parent.glob('Leimkuhler2015b*.pdf'));expected=sha(pdf);book=fitz.open(pdf)
 paths={f'Blueprint/Ch{ch:02}.lean'};stack=list(paths)
 while stack:
  for imp in re.findall(r'(?m)^import ([\w.]+)',(ROOT/stack.pop()).read_text(encoding='utf-8-sig')):
   p=imp.replace('.','/')+'.lean'
   if p.startswith('MolecularDynamics/') and p not in paths:paths.add(p);stack.append(p)
 index=definitions(sorted(paths))
 for choices in list(index.values()):
  for d in choices:
   if d['namespace']:index.setdefault(d['namespace']+'.'+d['name'],[]).append(d)
 materials={};excerpts={}
 for sid in sids:
  # A source_id may contain several conclusions and helper declarations.  The
  # primary theorem alone is not the complete repaired statement.
  selected={};pending=referenced(ds[sid]['block'],index)
  while pending:
   name=sorted(pending)[0];pending.remove(name)
   if name in selected:continue
   choices=index[name];selected[name]=[d for d in choices if d['path'].startswith('Blueprint/')] or choices
   for d in selected[name]:pending.update(referenced(d['code'],index)-selected.keys())
  chunks=['## 原文JSON','```json',json.dumps(indexed[sid],ensure_ascii=False,indent=2),'```','## 完整当前Lean（同一source_id的全部声明）','```lean',ds[sid]['block'],'```'];excerpts[sid]=[]
  for name in sorted(selected):
   for d in selected[name]:
    chunks+=['### 实际依赖 '+d['namespace']+'.'+d['name'],'```lean',d['code'],'```']
    excerpts[sid].append(dict(path=d['path'],name=name,file_sha256=sha(ROOT/d['path']),excerpt_sha256=hashlib.sha256(d['code'].encode()).hexdigest()))
  materials[sid]='\n'.join(chunks)+'\n'
 task.mkdir(parents=True,exist_ok=True);full=task/f'BATCH_{eaudit}.md'
 full.write_text(f'# {eaudit}：第{ch}章§{section}网站修复复审\n\n'+'\n'.join(materials.values()),encoding='utf-8')
 shared={full.name:sha(full),f'Blueprint/Ch{ch:02}.lean':sha(ROOT/f'Blueprint/Ch{ch:02}.lean'),f'blueprint/ch{ch:02}/ch{ch:02}_source.json':sha(base/f'ch{ch:02}_source.json')}
 reader=PdfReader(pdf);subtasks=[];output=f'/workspace/.mathcopilot/reviews/ch{ch:02}_eaudit/{eaudit}_review.json'
 for j,sid in enumerate(sids):
  label=eaudit+chr(97+j);folder=task/chr(97+j);folder.mkdir(exist_ok=True)
  ns=[int(n) for n in re.findall(r'\d+',indexed[sid]['pdf_page'])]
  nums=sorted(set(range(ns[0],ns[-1]+1))|set(indexed[sid].get('review_context_pdf_pages',[])))
  writer=PdfWriter()
  for p in nums:writer.add_page(reader.pages[p-1])
  crop=folder/(label+'_PAGES.pdf')
  with crop.open('wb') as f:writer.write(f)
  cropped=fitz.open(crop)
  for k,p in enumerate(nums):
   with fitz.open(pdf) as original:assert cropped[k].get_pixmap(matrix=fitz.Matrix(.5,.5)).samples==original[p-1].get_pixmap(matrix=fitz.Matrix(.5,.5)).samples
  hashes={**shared,label+'_materials':hashlib.sha256(materials[sid].encode()).hexdigest(),label+'_PAGES.pdf':sha(crop)}
  prompt=('以本 PASTE 和附件为准；/workspace 中的 Ch0x.lean、ch0x_source.json、BATCH*.md 等是旧版本，忽略它们。Mathlib 标准库定义按标准数学含义直接采信，只需展开 MolecularDynamics / MD.* 命名空间的项目定义。\n'
    '先A原文逐字核对，再C只读核对全部对象/域/量词/前提/完整结论及EXTRA；不修改工程或补证明，不因sorry判签名FAIL。原书数学疑误保留并NEEDS_HUMAN。'
    f'\n本条{sid}；原PDF页映射={nums}。必须实际写入 {output}，对象含batch={eaudit}、input_sha256、items。'
    '共享输入哈希相同则按source_id追加合并，版本冲突则报告；逐项回显哈希。'
    '\nitems每条source_id,json_review{status,issue_codes,corrected_json,issues,evidence},audit{lean_decl,verdict,explanation,counterexample,suggested_fix}；status=APPROVED/CORRECTED/NEEDS_HUMAN，verdict=PASS/FAIL/NEEDS_HUMAN。'
    '必须用代码实际写入JSON对象（batch、input_sha256、items），写完用json.loads读取自检；对话只回复路径与PASS/FAIL/NEEDS_HUMAN统计。以下input_sha256的全部键和值必须原样回显。\ninput_sha256：\n'+json.dumps(hashes,ensure_ascii=False,indent=2)+'\n\n')
  paste=folder/'PASTE.txt';paste.write_text(prompt+materials[sid],encoding='utf-8');mp=folder/'MANIFEST.json'
  m=dict(eaudit=eaudit,source_id=sid,input_sha256=hashes,source_pdf_sha256=expected,pdf_page_mapping=nums,
    crop_pixel_identity='PASS',paste_sha256=sha(paste),source_block_sha256=ds[sid]['block_sha256'],source_declarations=declaration_names(ds[sid]['block']),dependency_excerpts=excerpts[sid],expected_output=output)
  for _ in range(4):m['total_task_bytes']=paste.stat().st_size+crop.stat().st_size+(mp.stat().st_size if mp.exists() else 0);dump(mp,m)
  total=sum(p.stat().st_size for p in folder.iterdir() if p.is_file());assert total==m['total_task_bytes']<256000,(label,total)
  subtasks.append(dict(subtask=label,source_id=sid,path=folder.relative_to(ROOT).as_posix(),total_bytes=total,manifest_sha256=sha(mp)))
 dump(task/'MANIFEST.json',dict(eaudit=eaudit,input_sha256=shared,subtasks=subtasks))
 (task/'INDEX.md').write_text(f'# {eaudit}：第{ch}章§{section}复审\n\n每项粘贴PASTE.txt并上传同目录原页PDF；仅生成，网站由用户提交。\n\n'+
  '\n'.join('- ['+s['subtask']+']('+chr(97+j)+'/PASTE.txt)：'+s['source_id']+'，'+str(s['total_bytes'])+'字节。' for j,s in enumerate(subtasks))+
  '\n\n要求实际输出 '+output+'，含input_sha256和items；网站执行及语义判定尚未验证。\n',encoding='utf-8')
 return dict(eaudit=eaudit,source_ids=sids,input_sha256=shared,task_index=task.relative_to(ROOT).as_posix()+'/INDEX.md',subtasks=subtasks)

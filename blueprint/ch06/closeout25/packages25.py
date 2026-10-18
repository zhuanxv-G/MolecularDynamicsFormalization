"""Chapter 6 review excerpts: complete project definitions and referenced theorem types.

Theorem proofs are outside semantic review; choice specifications and consistency
bridges are included explicitly. No chapter 1--5 artifacts are regenerated.
"""
from common25 import *
from collections import defaultdict
import fitz
from pypdf import PdfReader,PdfWriter

COMMAND=re.compile(r'(?m)^(?:@\[[^\]\n]+\]\s*)*(?:(?:noncomputable|private|protected|unsafe|partial) +)*(def|abbrev|structure|class|inductive|theorem|lemma|instance|namespace|section|end|open|variable|local|set_option|attribute|notation|scoped|#\w+)\b')
def strip_comments(s):
 # Nested Lean comments are handled by a scanner rather than a greedy regex.
 out=[];i=0;depth=0
 while i<len(s):
  if s[i:i+2]=='/-':depth+=1;i+=2
  elif depth and s[i:i+2]=='-/':depth-=1;i+=2
  elif depth:i+=1
  elif s[i:i+2]=='--':
   j=s.find('\n',i);i=len(s) if j<0 else j
  else:out.append(s[i]);i+=1
 return ''.join(out)
def tokens(s):return set(re.findall(r'[\w₀-₉]+(?:\.[\w₀-₉]+)*',strip_comments(s)))

def masked_comments(s):
 # Preserve source offsets while excluding documentation examples from commands.
 out=list(s);i=0;depth=0
 while i<len(s):
  if s[i:i+2]=='/-':
   depth+=1;out[i:i+2]='  ';i+=2
  elif depth and s[i:i+2]=='-/':
   depth-=1;out[i:i+2]='  ';i+=2
  elif depth:
   if s[i]!='\n':out[i]=' '
   i+=1
  elif s[i:i+2]=='--':
   end=s.find('\n',i);end=len(s) if end<0 else end
   out[i:end]=' '*(end-i);i=end
  else:i+=1
 return ''.join(out)
def index_project():
 paths={'Blueprint/Ch06.lean'};pending=list(paths)
 while pending:
  p=pending.pop()
  for imp in re.findall(r'(?m)^import ([\w.]+)',(ROOT/p).read_text(encoding='utf-8-sig')):
   q=imp.replace('.','/')+'.lean'
   if q.startswith('MolecularDynamics/') and q not in paths:paths.add(q);pending.append(q)
 aliases=defaultdict(list);allitems=[];contexts={}
 for rel in sorted(paths):
  text=(ROOT/rel).read_text(encoding='utf-8-sig');ms=list(COMMAND.finditer(masked_comments(text)));stack=[];context=[]
  for j,m in enumerate(ms):
   code=text[m.start():ms[j+1].start() if j+1<len(ms) else len(text)].rstrip()
   # Remove the next declaration's trailing documentation.
   while code.endswith('-/') and '/-' in code:code=code[:code.rfind('/-')].rstrip()
   kind=m[1];tail=text[m.end():].splitlines()[0].strip()
   if kind in ('namespace','section'):
    stack.append((kind,tail.split()[0] if tail else ''));continue
   if kind=='end':
    if stack:stack.pop()
    continue
   if kind in ('variable','open','local','notation','scoped'):
    context.append(code);continue
   if kind not in ('def','abbrev','structure','class','inductive','theorem','lemma'):continue
   name=re.match(r'[\w.₀-₉]+',tail)
   if not name:continue
   name=name[0];ns='.'.join(x[1] for x in stack if x[0]=='namespace')
   full=(ns+'.'+name).strip('.')
   if kind in ('theorem','lemma'):
    split=re.search(r'\s+:=\s*(?:by\b|\n)',code)
    if split:code=code[:split.start()].rstrip()
    else:
     split=code.rfind(' := ')
     if split>=0:code=code[:split].rstrip()
   d=dict(name=name,namespace=ns,full_name=full,path=rel,line=text[:m.start()].count('\n')+1,kind=kind,code=code)
   allitems.append(d)
   bits=full.split('.')
   for k in range(len(bits)):aliases['.'.join(bits[k:])].append(d)
  contexts[rel]='\n'.join(dict.fromkeys(context))
 return aliases,contexts,allitems

EXPLICIT={
 'BathTaylor':['bathBoltzmannPrinted_corrected'],
 'CanonicalAveragePrinted':['canonicalAveragePrinted_corrected'],
 'CoarseMarkovPrinted':['coarseMarkovPrinted_corrected'],
 'BathReductionPrinted':['bathReductionPrinted_corrected'],
 'VariableFrictionCanonicalPrinted':['variableFrictionCanonicalPrinted_corrected'],
 'Theorem61TimeAveragePrinted':['theorem61TimeAveragePrinted_corrected'],
 'BrownianNegativeDefinitePrinted':['brownianNegativeDefinitePrinted_corrected'],
 'Assumption1Printed':['assumption1Printed_corrected'],
 'MinorizationPrinted':['minorizationPrinted_corrected'],
 'PeriodicConfiningPrinted':['periodicConfiningPrinted_corrected'],
 'LaplacianBoundPrinted':['laplacianBoundPrinted_corrected'],
 'CylinderForwardPrinted':['cylinderForwardPrinted_corrected'],
 'HamiltonianPowerMomentumLaplacian':['laplacianBoundPrinted','laplacianBoundCorrect'],
 'LangevinTimeAverage':['textbookLangevinIntegralSolution_unique_globalLip','textbookLangevinPathEndpoint_restrict','textbookLangevinIntegralSolution_restrict','family_agree','textbookLangevinGlobalRandomPhase_integralSolution_ae'],
 'LangevinCanonicalMixing':['actual_path_solution_exists','textbookLangevinPathSolution_integralSolution'],
 'LangevinTransitionDensity':['actual_path_solution_exists','textbookLangevinPathSolution_integralSolution'],
 'Lemma61Nonempty':['actual_path_solution_exists','textbookLangevinPathSolution_integralSolution'],
 'LangevinGeometricErgodicity':['actual_path_solution_exists','textbookLangevinPathSolution_integralSolution'],
 'WeightedH1':['textbookLangevinCanonicalCoordinateAdjointTestExpression','textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two'],
 'Proposition64Relative':['textbookLangevinCanonicalCoordinateAdjointTestExpression','textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two'],
 'Proposition64Printed':['textbookLangevinCanonicalCoordinateAdjointTestExpression','textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two'],
 'WeightedH1Norm':['textbookLangevinCanonicalCoordinateAdjointTestExpression','textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two'],
 'VectorSDE':['textbookWienerVector_coordinate','textbookWienerVector_coordinates_independent'],
 'MomentumOU':['textbookWienerVector_coordinate','textbookWienerVector_coordinates_independent'],
}
def closure(code,key,index):
 selected={};todo=[(t,'Blueprint/Ch06.lean','MD.Ch06') for t in tokens(code)]
 todo += [(t,'','') for t in EXPLICIT.get(key,[])]
 while todo:
  token,path,ns=todo.pop()
  choices=index.get(token,[])
  if not choices:continue
  exact=[d for d in choices if d['full_name']==ns+'.'+token]
  same=[d for d in choices if d['path']==path]
  if exact:choices=exact
  elif same:choices=same
  elif len(token)<=2 and '.' not in token:
   # Only genuine project type aliases are relevant, not coincident bound variables.
   choices=[d for d in choices if d['path'].endswith('ReviewDefinitions.lean') and d['namespace'] in ['MolecularDynamics.Chapter06Review','MolecularDynamics.Chapter05Review']]
  for d in choices:
   identity=(d['path'],d['line'])
   if identity in selected:continue
   selected[identity]=d
   todo += [(t,d['path'],d['namespace']) for t in tokens(d['code']) if t!=d['name']]
 return sorted(selected.values(),key=lambda d:(d['path'],d['line']))

def main():
 selection=load(OUT/'REAUDIT_SELECTION.json');sids=selection['source_ids']
 src={s['source_id']:s for s in load(BASE/'ch06_source.json')};gg=groups()
 index,contexts,items=index_project();pdf=next(ROOT.parent.glob('Leimkuhler2015b*.pdf'));book=fitz.open(pdf);reader=PdfReader(pdf)
 tasks=BASE/'mathcopilot_tasks';batches=[];depchecks=[]
 for start in range(0,len(sids),3):
  batch=f'EAUDIT{start//3+1:02}';folder=tasks/batch;folder.mkdir(exist_ok=True);subtasks=[]
  for j,sid in enumerate(sids[start:start+3]):
   label=batch+chr(97+j);dest=folder/chr(97+j);dest.mkdir(exist_ok=True)
   source=src[sid];key=sid.split('-')[-1];dep=closure(gg[sid]['code'],key,index)
   nums=[int(x) for x in re.findall(r'\d+',source['pdf_page'])];pages=list(range(nums[0],nums[-1]+1))
   writer=PdfWriter()
   for p in pages:
    page=reader.pages[p-1];writer.add_page(page)
   for page in writer.pages:page.compress_content_streams()
   crop=dest/'PAGES.pdf'
   with crop.open('wb') as f:writer.write(f)
   raster_specs={}
   if crop.stat().st_size>190000:
    # Dense vector plots on PDF259 exceed the inherited attachment budget.
    # Preserve the entire page as a losslessly encoded 126dpi source render.
    compact=fitz.open()
    for p in pages:
     original=book[p-1]
     if p==259:
      pix=original.get_pixmap(matrix=fitz.Matrix(1.75,1.75),alpha=False)
      page=compact.new_page(width=original.rect.width,height=original.rect.height)
      page.insert_image(page.rect,pixmap=pix)
      raster_specs[p]=dict(dpi=126,width=pix.width,height=pix.height,pixel_sha256=hashlib.sha256(pix.samples).hexdigest())
     else:compact.insert_pdf(book,from_page=p-1,to_page=p-1)
    crop.write_bytes(compact.tobytes(garbage=4,deflate=True))
   clipped=fitz.open(crop)
   for k,p in enumerate(pages):
    if p in raster_specs:
     pix=fitz.Pixmap(clipped,clipped[k].get_images()[0][0])
     assert hashlib.sha256(pix.samples).hexdigest()==raster_specs[p]['pixel_sha256']
    else:assert clipped[k].get_pixmap(matrix=fitz.Matrix(.5,.5)).samples==book[p-1].get_pixmap(matrix=fitz.Matrix(.5,.5)).samples
   # Only source fields needed for independent A/C review. Full historical source is hashed below.
   selected_source={k:source.get(k) for k in ['source_id','kind','label','section','printed_page','pdf_page','statement_latex','proof_latex','proof_note','proof_discussion_latex','context_notation','extra_assumptions','statement_scope','coverage_gaps']}
   chunks=['## 原文JSON','```json',json.dumps(selected_source,ensure_ascii=False,indent=2),'```','## 当前完整Lean（全部原文版、修正版及反例）','```lean',gg[sid]['code'],'```']
   for path in sorted({d['path'] for d in dep}):
    # Global variable contexts disambiguate definitions with parameters inherited from sections.
    if contexts[path]:chunks += ['### 文件参数及作用域 '+path,'```lean',contexts[path],'```']
   for d in dep:chunks += ['### '+d['full_name']+' ['+d['path']+':'+str(d['line'])+']','```lean',d['code'],'```']
   materials='\n'.join(chunks)+'\n';hashes={'Blueprint/Ch06.lean':sha(LEAN),'blueprint/ch06/ch06_source.json':sha(BASE/'ch06_source.json'),'PAGES.pdf':sha(crop),'materials_sha256':hashlib.sha256(materials.encode()).hexdigest()}
   prompt='以附件/PASTE 为准，忽略 /workspace 旧文件；Mathlib 定义按标准含义采信。\n'
   prompt+='A逐字核对原文及证明；C只读核对对象、域、量词、前提和全部结论。所有项目定义体及选择规格在下文；仅作为审阅摘录，不是独立模块。theorem/lemma提供完整类型（不审证明）；定义提供完整定义体，按文件作用域解释。不要因sorry判签名FAIL。原文版忠实性、修正版正确性、反例、原书疑误分别说明，不凭旧文件或repair_log猜声明。\n'
   prompt+=f'本条{sid}，subtask={label}；原PDF页映射={pages}。只读，不改工程或补证明。以JSON对象返回batch={batch},input_sha256,items；逐条含source_id,subtask,input_sha256,json_review{{status,issue_codes,corrected_json,issues,evidence}},audit{{lean_decl,verdict,explanation,counterexample,suggested_fix}}。verdict=PASS/FAIL/NEEDS_HUMAN，status=APPROVED/CORRECTED/NEEDS_HUMAN。必须原样回显下列全部哈希。\ninput_sha256:\n'+json.dumps(hashes,ensure_ascii=False,indent=2)+'\n\n'
   paste=dest/'PASTE.txt';paste.write_text(prompt+materials,encoding='utf-8')
   manifest=dict(eaudit=batch,subtask=label,source_id=sid,input_sha256=hashes,paste_sha256=sha(paste),source_pdf_sha256=sha(pdf),pdf_page_mapping=pages,crop_pixel_identity='PASS: copied page render or lossless embedded full-page source pixels',rasterized_pages=raster_specs,source_declarations=gg[sid]['names'],dependency_excerpts=[{**{k:d[k] for k in ['path','line','full_name','kind']},'excerpt_sha256':hashlib.sha256(d['code'].encode()).hexdigest()} for d in dep],project_definition_closure='complete recursive definitions, referenced theorem types, explicit choice and consistency specifications',website_submitted=False)
   mp=dest/'MANIFEST.json';dump(mp,manifest)
   total=sum(q.stat().st_size for q in dest.iterdir() if q.is_file());manifest['total_task_bytes']=total
   for _ in range(3):dump(mp,manifest);manifest['total_task_bytes']=sum(q.stat().st_size for q in dest.iterdir() if q.is_file())
   dump(mp,manifest);total=sum(q.stat().st_size for q in dest.iterdir() if q.is_file())
   assert total==manifest['total_task_bytes']<256000,(sid,total,len(dep))
   for name in EXPLICIT.get(key,[]):assert any(d['name']==name for d in dep),(sid,name)
   subtasks.append(dict(subtask=label,source_id=sid,path=dest.relative_to(ROOT).as_posix(),total_bytes=total,definitions=len(dep),manifest_sha256=sha(mp)))
   depchecks.append(dict(source_id=sid,explicit_specifications=EXPLICIT.get(key,[]),dependency_count=len(dep),total_bytes=total))
   print(label,sid,len(dep),total,flush=True)
  dump(folder/'MANIFEST.json',dict(eaudit=batch,subtasks=subtasks))
  (folder/'INDEX.md').write_text('# '+batch+' 第6章复审\n\n'+ '\n'.join('- '+s['subtask']+'：'+s['source_id']+'；['+chr(97+i)+'/PASTE.txt]('+chr(97+i)+'/PASTE.txt)，同目录PAGES.pdf、MANIFEST.json。' for i,s in enumerate(subtasks))+'\n',encoding='utf-8')
  batches.append(dict(eaudit=batch,source_ids=[s['source_id'] for s in subtasks],subtasks=subtasks))
 dump(tasks/'EAUDIT_MANIFEST.json',batches);dump(OUT/'PACKAGE_VALIDATION.json',dict(batches=len(batches),items=len(sids),checks=depchecks,pixels='copied pages equal original render; PDF259 full-page 126dpi raster has identical embedded source pixels',website_submitted=False))
 (tasks/'EAUDIT_INDEX.md').write_text('# 第6章待用户提交的复审包\n\n共'+str(len(batches))+'包、'+str(len(sids))+'条。各EAUDIT下a/b/c为独立子任务，每份含PASTE.txt、PAGES.pdf、MANIFEST.json；用户合并提交，本轮未向网站提交。\n\n'+'\n'.join('- ['+b['eaudit']+']('+b['eaudit']+'/INDEX.md)：'+'；'.join(b['source_ids']) for b in batches)+'\n',encoding='utf-8')
if __name__=='__main__':main()

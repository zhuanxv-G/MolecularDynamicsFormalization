from pathlib import Path
import json,re,hashlib,sys
ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'blueprint/closeout24'
sys.path.insert(0,str(ROOT/'scripts'))
def load(p):return json.loads(Path(p).read_text(encoding='utf-8-sig'))
def dump(p,d):
 p=Path(p);p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def base(ch):return ROOT/f'blueprint/ch{ch:02}'
def lean(ch):return ROOT/f'Blueprint/Ch{ch:02}.lean'
def groups(ch,text=None):
 text=text if text is not None else lean(ch).read_text(encoding='utf-8-sig')
 marks=list(re.finditer(r'/-- source_id:\s*([^\s·]+)[\s\S]*?-/',text));out={}
 for i,m in enumerate(marks):
  end=marks[i+1].start() if i+1<len(marks) else text.rfind(f'end MD.Ch{ch:02}')
  code=re.sub(r'/\- (?:BEGIN|END) FULL SECTION[^\n]*-/', '',text[m.end():end]).strip()
  names=re.findall(r'(?m)^(?:@\[[^\]\n]+\]\s*)*(?:(?:noncomputable|private|protected)\s+)*(?:theorem|lemma|def|abbrev)\s+(\w+)',code)
  out[m.group(1)]=dict(code=code,names=names,start=m.start(),body_start=m.end(),end=end,line=text[:m.end()].count('\n')+2)
 return out
def add_doc(text,sid,note):
 m=re.search(r'/-- source_id:\s*'+re.escape(sid)+r'(?=\s|·)[\s\S]*?-/',text);assert m,sid
 return text[:m.end()-2]+'[EXTRA] 24号：'+note+'\n'+text[m.end()-2:]


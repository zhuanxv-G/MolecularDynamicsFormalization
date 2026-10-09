"""Check the requested coverage, batch integrity and final proof evidence."""
import json,csv,re,hashlib,subprocess,collections
from pathlib import Path
from ch01_full_data import ROOT,BASE
from ch01_full_tools import declarations

def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()

def validate():
    ss=json.loads((BASE/'ch01_source.json').read_text(encoding='utf-8-sig'))
    sources={s['source_id']:s for s in ss};ds=declarations()
    audit=json.loads((BASE/'local_audit.json').read_text(encoding='utf-8'))['items']
    assert len(ss)==len(sources)==141
    assert set(sources)==set(ds)==set(audit)
    assert all(s['review_status']=='DRAFT' for s in ss)
    assert all(s['statement_latex'].strip() and 'proof_latex' in s for s in ss)
    assert {s['section'].split('.')[1] for s in ss}==set('1234567')
    mapping=json.loads((BASE/'old_mapping.json').read_text(encoding='utf-8'))
    ids={r['id'] for r in csv.DictReader((ROOT/'docs/review/CH01_CLAIMS.csv').open(encoding='utf-8-sig'))}
    assert len(ids)==207
    assert set(mapping['mapped']).isdisjoint(mapping['excluded'])
    assert set(mapping['mapped'])|set(mapping['excluded'])==ids
    assert set(mapping['mapped'].values())<=set(sources)
    assert all('excluded' in x for x in mapping['excluded'].values())
    pagecheck=json.loads((BASE/'source_page_checks.json').read_text(encoding='utf-8'))
    assert digest(ROOT.parent/pagecheck['source_pdf'])==pagecheck['sha256']
    assert [p['printed_page'] for p in pagecheck['pages']]==list(range(1,46))
    for p in pagecheck['pages']:
        assert p['pdf_page']==p['printed_page']+23
        assert digest(ROOT/p['png'])==p['render_sha256']
    manifests=json.loads((BASE/'mathcopilot_tasks/MANIFEST.json').read_text(encoding='utf-8'))
    seen=[]
    for b in manifests:
        path=BASE/'mathcopilot_tasks'/f"{b['batch']}.md"
        text=path.read_text(encoding='utf-8')
        assert 0<len(b['source_ids'])<=8
        assert path.stat().st_size==b['bytes']<40000
        assert digest(path)==b['task_sha256']
        assert b['source_pdf_sha256']==pagecheck['sha256']
        for f,h in b['files'].items():assert digest(ROOT/f)==h,(b['batch'],f)
        entries=[json.loads(x) for x in re.findall(r'```json\n([\s\S]*?)\n```',text)]
        entries=[x for x in entries if isinstance(x,dict)]
        assert [x['source_id'] for x in entries]==b['source_ids']
        for entry in entries:assert entry==sources[entry['source_id']]
        assert '模板A' in text and '模板C' in text and '模板B' not in text
        assert 'counterexample' in text and 'corrected_json' in text
        for sid in b['source_ids']:assert ds[sid]['statement'] in text
        if b['batch']!='BATCH01':assert len({sources[x]['section'] for x in b['source_ids']})==1
        seen+=b['source_ids']
    assert collections.Counter(seen)==collections.Counter(sources.keys())
    assert len(manifests)==23
    for sid,a in audit.items():
        assert a['checked'] and a['signature_sha256']==ds[sid]['signature_sha256'],sid
        assert a['lean_decl']==ds[sid]['name']
        assert a['direct_placeholder']==bool(re.search(r'\bsorry\b',ds[sid]['block']))
        assert a['correspondence']
        if a['direct_placeholder']:assert 'sorryAx' in a['axioms'] and a['final_status']=='incomplete'
        if a['verdict']!='PASS':assert a['final_status']=='incomplete'
        if a['final_status']!='incomplete':assert a['verdict']=='PASS' and 'sorryAx' not in a['axioms']
        if a['direct_placeholder'] and a['verdict']=='PASS':assert a.get('missing') and a.get('proof_stop_reason')
        assert all(x!='sorryAx' for x in a['axioms']) or a['final_status']=='incomplete'
    doc=(ROOT/'docs/review/CH01_BLUEPRINT.zh-CN.md').read_text(encoding='utf-8')
    assert len(re.findall(r'(?m)^## 1\. MD-',doc))==141
    for part,title in [(2,'原文陈述'),(3,'原文证明'),(4,'Lean陈述'),(5,'对照表'),(6,'审计结论'),(7,'状态与证明位置')]:
        assert doc.count(f'### {part}. {title}')==141
    assert all('\n'.join('> '+line for line in s['statement_latex'].splitlines()) in doc for s in ss)
    assert '需要导师判断的问题' in doc and doc.count('待网站审计')>=141
    assert subprocess.check_output(['git','diff','63fa09227e1d898e0cacae3c33241d3d6ecba816','--','MolecularDynamics/'],cwd=ROOT)==b''
    assert not any(p.name!='README.md' for p in (BASE/'mathcopilot_results').iterdir() if p.is_file()),'New website results require integration first'
    tracked=subprocess.check_output(['git','ls-files','-z'],cwd=ROOT).decode().split('\0')[:-1]
    assert len(tracked)==len({p.casefold() for p in tracked}),'Case-colliding Git paths'
    assert not any(p.startswith('Blueprint/ch01/') for p in tracked),'Use lowercase blueprint/ch01 metadata paths'
    report={'status':'passed','source_entries':len(ss),'printed_pages_checked':45,
        'old_mapped':len(mapping['mapped']),'old_excluded':len(mapping['excluded']),
        'batches':len(manifests),'maximum_batch_bytes':max(b['bytes'] for b in manifests),
        'local_verdicts':dict(collections.Counter(a['verdict'] for a in audit.values())),
        'proof_states':dict(collections.Counter(a['proof_status'] for a in audit.values())),
        'final_states':dict(collections.Counter(a['final_status'] for a in audit.values())),
        'direct_placeholders':sum(a['direct_placeholder'] for a in audit.values()),
        'formal_diff_from_baseline':'empty','website_results':0,'heartbeat':'not modified',
        'note':'PASS指交付完整性及本地证据一致，不代替网站或导师语义审计。'}
    (BASE/'validation/DELIVERY_REPORT.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(report,ensure_ascii=False,indent=2))

if __name__=='__main__':validate()

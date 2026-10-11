"""Preserve the earlier spin transcription and bind its visual correction."""
import hashlib,json
from pathlib import Path

def apply(records):
    root=Path(__file__).resolve().parents[1]
    folder=root/'blueprint/ch04/validation/transcription-repair-20261011'
    folder.mkdir(exist_ok=True)
    snapshot=folder/'BEFORE.json'
    keys={'PrintedSpinAxis','PrintedSpinStep','AxisFlowFormal','PrincipalAxisField'}
    if not snapshot.exists():
        old=json.loads((root/'blueprint/ch04/ch04_source.json').read_text(encoding='utf-8'))
        snapshot.write_text(json.dumps([r for r in old if r['source_id'].split('-')[-1] in keys],ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    evidence={p:hashlib.sha256((root/p).read_bytes()).hexdigest() for p in [
        'blueprint/ch04/source_pages/p195-split-detail.png',
        'blueprint/ch04/source_pages/p196-spin-detail.png']}
    for r in records:
        if r['source_id'].split('-')[-1] in keys:
            r['repair_log'].append(dict(date='2026-10-11',reason='原页高倍率复核纠正预备转录：列动量Rπ、方向ΘRᵀ与正式库一致；第二及第三拆分均缺下标。原记录归档，正角与π×ω子流符号疑点仍待审。',before='blueprint/ch04/validation/transcription-repair-20261011/BEFORE.json',visual_sha256=evidence))
    (folder/'RECEIPT.json').write_text(json.dumps(dict(before_sha256=hashlib.sha256(snapshot.read_bytes()).hexdigest(),visual_sha256=evidence,website_audit='待网站审计',correction='π^k←Rπ^k, Θ^k←Θ^k R^T; 第二/第三子场缺下标单列。'),ensure_ascii=False,indent=2)+'\n',encoding='utf-8')

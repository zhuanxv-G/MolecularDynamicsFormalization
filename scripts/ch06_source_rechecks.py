"""Apply immutable original-page rechecks with an explicit source repair log."""
import json
from ch06_data import BASE

def apply(records):
    data=json.loads((BASE/'source_rechecks_20261016.json').read_text(encoding='utf-8'))
    for fix in data['items']:
        r=next(r for r in records if r['source_id'].endswith('-'+fix['key']))
        for field,after in fix['fields'].items():
            assert r[field] in (fix['before'][field],after),(r['source_id'],field)
            r[field]=after
        r['repair_log'].append(dict(date='2026-10-16',action='original_page_recheck',
            reason=fix['reason'],evidence=data['evidence'],before=fix['before'],after=fix['fields'],website='待网站审计'))

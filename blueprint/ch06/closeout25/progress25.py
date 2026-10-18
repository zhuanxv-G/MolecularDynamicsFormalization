from common25 import *

def main():
 rows=load(OUT/'RETURNS.json')
 reps=load(OUT/'REPAIRS.json') if (OUT/'REPAIRS.json').exists() else []
 done={x['source_id'] for x in reps if x['exit_code']==0}
 summary=load(BASE/'WEBSITE_SUMMARY.json')
 summary.update(repairing=25-len(done),local_repairs=len(done))
 dump(BASE/'WEBSITE_SUMMARY.json',summary)
 packs=load(BASE/'mathcopilot_tasks/EAUDIT_MANIFEST.json') if (BASE/'mathcopilot_tasks/EAUDIT_MANIFEST.json').exists() else []
 assigned={s:b['eaudit'] for b in packs for s in b['source_ids']}
 final=(OUT/'DELIVERY_VALIDATION.json').exists()
 title='第6章首轮结果已整合，复审包待用户提交' if final else '25号：第6章网站首轮结果整合与修复中'
 lines=['# '+title,'',f'249条全部到齐并已逐条核验输入哈希：PASS 179 / FAIL 25 / NEEDS_HUMAN 45。FAIL本地修复检查通过{len(done)}条，修复中{25-len(done)}条。',
        '首轮所交版本的评价与本轮修改版分别记录；本轮修改版尚未取得网站复审结论。',
        f'复审包：{len(packs)}包、{len(assigned)}条；只生成，由用户提交。',
        '范围：仅第6章；第1–5章和正式库冻结，不进入第7章。','',
        '| source_id | 网站首轮 | 本轮处理 | 复审状态 |', '|---|---|---|---|']
 for r in rows:
  sid=r['source_id'];ver=r['audit']['verdict']
  action='按建议修复，单文件及逐声明公理检查通过' if sid in done else '修复中，尚未通过新检查' if ver=='FAIL' else '已分流，见website_audit和复审材料' if ver=='NEEDS_HUMAN' else '保留首轮结论'
  status='待复审 / '+assigned[sid] if sid in assigned else '未改版本，保留首轮意见' if ver=='PASS' else '复审包准备中' if not final else '原书疑误待导师裁定'
  lines.append('| '+sid+' | '+ver+' | '+action+' | '+status+' |')
 lines += ['', '已核验：RETURN_REGISTRATION.json中的249条哈希绑定、PDF256与PDF263两处原页。',
           '编译与公理证据：closeout25/compiled/；最终证据：FINAL_COMPILE.json与full/CHECK_REPORT.json（仅相应结果落盘且为PASS时有效）。',
           '完整交付验收：closeout25/DELIVERY_VALIDATION.json；包索引：mathcopilot_tasks/EAUDIT_INDEX.md。','']
 (BASE/'PROGRESS.md').write_text('\n'.join(lines),encoding='utf-8')
 print(title,len(done),len(packs),len(assigned))

if __name__=='__main__':main()

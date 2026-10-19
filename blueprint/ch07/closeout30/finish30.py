from register30 import *
import re

def main():
    v=load(OUT/'DELIVERY_VALIDATION.json');assert v['status']=='PASS'
    assert v['lean_sha256']==sha(ROOT/'Blueprint/Ch07.lean') and v['source_sha256']==sha(BASE/'ch07_source.json')
    status='第7章最终收口完成；第8章首轮网站审校中，等待用户新指令'
    checkpoint=status+'。\n35条复审返回绑定通过（24 PASS/1 FAIL/10 NEEDS_HUMAN）；唯一FAIL按意见局部修复，本地核验通过，未再送网站，FAIL修复中=0。\n373声明单文件编译、逐条公理与一次完整check通过；正式库0 sorry、0 axiom声明；16457个冻结文件一致，其中第8章678个文件字节未变。\n全章最新返回直接PASS 90条；复审人工项8条有明确的修正版/限定签名PASS，2条仅认可已披露范围的定义。53项已证、69项未证；29项勘误或范围核查记录。停止，不推进第8章，不生成新EAUDIT包。'
    for rel in ['AGENTS.md','docs/handoff/CURRENT_STATE.zh-CN.md']:
        p=ROOT/rel;s=p.read_text(encoding='utf-8')
        s,n=re.subn(r'(## 30号运行检查点\n\n)[\s\S]*?(?=\n\n## 历史指令与检查点)',lambda m:m[1]+checkpoint,s,count=1)
        assert n==1
        if rel.endswith('CURRENT_STATE.zh-CN.md') and not s.startswith(status):s=status+'\n\n'+s
        p.write_text(s,encoding='utf-8')
    p=BASE/'PROGRESS.md';s=p.read_text(encoding='utf-8')
    s=s.replace('第7章最终收口：',status+'。\n\n第7章最终收口：',1)
    s=s.replace('完整check状态见closeout30/full/CHECK_REPORT.json。','一次完整check通过；冻结验收见closeout30/DELIVERY_VALIDATION.json。')
    p.write_text(s,encoding='utf-8')
    (BASE/'LOCAL_PIPELINE.md').write_text('# 第7章30号最终收口完成\n\n'+checkpoint+'\n\n验收：closeout30/DELIVERY_VALIDATION.json；全部编译及公理：closeout30/FINAL_COMPILE.json；完整check：closeout30/full/CHECK_REPORT.json。\n未验证：69项未证陈述、随机初值条件解和约束保持、导师裁定；1项修复按指令未再送网站。\n',encoding='utf-8')
    (ROOT/'docs/handoff/RESUME_PROMPT.zh-CN.md').write_text('# 第30号已完成，停止\n\n'+checkpoint+'\n\n若heartbeat唤醒，先核对第30号第5节停止条件与closeout30/DELIVERY_VALIDATION.json及Git远端；满足后只确认完成，不发送续接。ACTIVE、15分钟、原target和既存去重机制保留。\n未获用户新指令前不得修改Blueprint/Ch08.lean或blueprint/ch08/，不得再次送审第7章，不做附加章节。\n',encoding='utf-8')
    p=ROOT/'docs/handoff/WORK_LOG.zh-CN.md'
    with p.open('a',encoding='utf-8') as f:f.write('\n## 2026-10-19 第30号第7章最终收口\n\n35条复审已登记，唯一FAIL局部修复及373声明编译/逐条公理、一次完整check通过；正式库0 sorry/0 axiom，16457冻结文件一致（第8章678文件未变）。\n最新直接PASS 90条，另分版登记8条复审人工项的通过签名；53已证/69未证，29项勘误或范围记录。按30号提交push后停止；第8章首轮网站审校中，等待用户新指令。\n')
    dump(OUT/'COMPLETION.json',dict(status=status,local_validation='PASS',stop_after_commit_push=True,next_action='Commit and push the scoped Chapter 7 delivery, confirm remote equality, then stop.',heartbeat=dict(id='lean-2',active=True,interval_minutes=15,target_unchanged=True),validation_sha256=sha(OUT/'DELIVERY_VALIDATION.json')))
    print(status,flush=True)

if __name__=='__main__':main()

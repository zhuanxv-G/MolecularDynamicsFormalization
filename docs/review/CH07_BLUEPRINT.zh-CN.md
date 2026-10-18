# 第7章 Lean Blueprint 本地审阅材料

当前已整理1条；网站尚未审阅。正文范围为印刷261–326页（PDF282–347），末页仅取Exercises之前的正文。

## 1. MD-7.1-Bias · definition · 印刷p.263 / PDFp.284

### 2. 原文陈述

All standard methods based on discretizing SDEs introduce some stepsize-dependent error in computed averages, which we shall refer to as bias (related to the truncation error of the discretization scheme).

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def bias (exact computed : ℝ) : ℝ := |exact - computed|
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.bias | 离散平均值偏差的定义；本段关于标准方法的概述不作为普遍量化结论。 |

[EXTRA] 将本段bias记号具体写为后文印刷p.266所给的绝对平均误差；不把“所有标准方法”量化成无条件定理。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.bias。


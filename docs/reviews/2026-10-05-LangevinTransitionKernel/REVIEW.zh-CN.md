# Theorem6.2 真实转移核及确定时间条件Markov依赖

原印刷252/PDF273（原图tmp/chapter6-causal/page-273.png）Theorem6.2和Assumption1要求真实Markov模型。本批补上实际条件Markov结构，transition density及后续遍历正文定理仍分开登记。

## 数学链与量词

由真实标准Wiener连续路径推前测度μT和已接受joint initial×Cpath endpoint E_T构造deterministic E_T ∘ (id×const μT)。该定义显式携带E_T可测证明，概率kernel性质由hB推导；每状态K_T(x)=μT.map(E_T(x,·))且等于同一actual global process的X_x(T) law，任意标准Wiener实现的kernel相同。periodic endpoint已有open quotient descent与任意rep一致，不假设chosen rep可测。

令H为[0,S]整个actual solution history，F为真实future noise Cpath。已接受未来独立性和真实law给P.map(H,F)=(P.map H).prod μT；commonAE actual restart给X(S+T)=E_T(H(S),F)。joint endpoint measurability使G(h,w)=(h,E_T(h(S),w))可测。对可测集合逐积分证明product.map G=(P.map H) ⊗ kernel.comap(eval S)，然后调用固定版本condDistrib的disintegration唯一性，并沿H推回实际样本，得到真实X(S+T)条件于整个H的条件分布=K_T(X(S))。

real auxiliary模型C² U与force globalLip；periodic unit-mass/unit-torus/finite Nc、C∞ lattice-periodic U、γ/σ任意、S/T非负。最后主结论∃L hF ∀S T的力Lipschitz实际推导，不作为主结论输入。condDistrib陈述所需IsProbabilityMeasure P直接let绑定hB的Gaussian概率结论，不是附加假设。AE样本集合允许依赖固定S/T；不声称uncountable时间条件律的共同AE或stopping time strongMarkov。completed filtration/semigroup/transition density/actual generator/Harris未完成。

## 验证记录

local01真实kernel基础5public通过；local02可测配对API须prodMk和condDistrib陈述有限测度实例；local03逐积分map_apply需明确fixed-state函数类型；local04 real全部7public通过。local05 periodic endpoint law map composition类型推断，local06显式类型仍触及默认heartbeats200000；local07增加显式pair可测和先声明composition后exact，17public全文件零诊断/退出0，无新增heartbeats设置。固定依赖版本未改。full-check01 2026-10-05T20:15:02.4380876+08:00--2026-10-05T20:17:24.7030669+08:00退出0；9055 jobs/零Lean警告/1080audit基础三公理/138inputs及全部raw SHA复核一致；17public逐名覆盖。机器验收通过，负责人教材语义签核pending。

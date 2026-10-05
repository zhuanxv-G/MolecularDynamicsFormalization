# 下一正文目标 Proposition6.1：真实 canonical 温度分部积分（待证明）

已重新视觉核对印刷222/PDF243页，原PDF243渲染 ../tmp/pdfs/chapter6-temperature/page-243.png，前后印刷221/223 text ../tmp/pdfs/chapter6-temperature/pages-242-244.txt。上一goal Theorem6.2实际模型已完成completed Markov/逐样本连续/progressive，但actual generator/density/Harris仍缺，按范围允许独立推进本正文目标。

原H定义在R^(2Nc)，G C1；0<|Avβ(G·∇H)|<∞、0<Avβ(divG)<∞，第三条 |G exp(-βH)|<∞ 语义是有界（原proof用maxsphere），不能改写成加权G可积而称原命题完整。需原canonical Z=∫exp(-βH)有限正与β=(kBT)^-1上下文，H至少C1，物理β>0显式。原proof把ball积分除volume后边界相对比O(1/R)；这本身只给两个趋零体积平均近似，不能直接得到未除volume的Gibbs平均恒等式。暂不声称原命题假或反例已证。

可补正路线（未实现验证）：ρ=exp(-βH)、F=ρG，derive divF=ρ(divG−β G·∇H)。原期望可积条件给divF和F·∇H integrable，第三条F bounded。先实际证明L1向量场且divF L1的∫divF=0（紧支smooth空间cutoff+真实divergence theorem+DCT）；仅假设divsum L1，不可偷增每个partial全域L1。
再用真实smooth χ(logρ/n)：χ(s)=0 for s≤−2，=1 for s≥−1，bounded derivative；Fn=χ(logρ/n) F，因ρ≥exp(-2n)区域体积有限（ρ L1）及F bounded，Fn L1。divFn=χdivF−β/n χ' F·∇H，derived integrable。∫divFn=0，DCT χdivF→divF，另一项≤β/n*C∫|F·∇H|→0；得∫divF=0，再归一化真实canonical平均与除法正性给温度比值。

新文件可CanonicalTemperature.lean，必要定义ρ/partition/canonical average、Gdotgrad/div及weighted derivative真实推导；候选仅完整无sorry声明进入formal库。compact support special case只作为一般原证明必要依赖，不冒称原Prop完成。下一实读固定mathlib分部积分/compact cutoff和已有StationaryDensityFlow真实fderiv/Haar接口后局部验证。负责人对原第三条uniform bounded语义及最终修正证明待签核。

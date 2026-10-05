# Proposition6.1实际canonical weighted divergence/IBP截断必要依赖

原print222/PDF243重新视觉核对 ../tmp/pdfs/chapter6-temperature/page-243.png，前后221--223/PDF242--244 text已提取。实际SymplecticCoordinates Nc为Fin Nc⊕Fin Nc坐标的2Nc相空间，Lebesgue volume；复用true GibbsWeight/LieDerivative/traceDivergence，无unit mass或torus限制。

## 原文缺口及范围
原第三条写|G exp(-βH)|<∞，按原sphere max估计解释为统一有界C（最终负责人语义pending），不能换成weighted G L1而称原命题完整。原proof除ball体积只把边界相对值界成O(1/R)，仍需证明未除volume的weighted积分恒等式；本批不声称原定理假或反例已证明。完整Proposition6.1仍待全域IBP和density cutoff极限，最后温度β=(kBT)^-1和正性除法。

## 本批真实数学
配分函数为真实∫exp(-βH)，可积时integral_exp_pos给Z>0，canonical average=Z^-1∫fρ且one=1。C1 actual derivative givesdiv(ρG)=ρ(divG−β G·∇H)，两actual weighted observables integrable推导divFlux integrable。

紧支actual C1 field方向导数integrable由真实cont_fderiv和compact support；固定Haar integral_smul_fderiv_eq_neg_fderiv_smul_of_integrable取scalar1给向量导数积分0。真实trace经Pi.basisFun坐标matrix trace是actual coordinate derivative sum，真实CLM.proj积分交换与finiteSum给compact div integral0；该紧支引理用于后续全域空间cutoff，不作为原命题独立特例交付。

实际χ_R=Real.smoothTransition(2−βH/R)，0..1且C1，真实导数带1/R。nonzero χ推出ρ>exp(-2R)；original weighted G bound C因此‖χρG‖≤C exp(2R)ρ，actual Gibbs L1得到真实cutoff flux L1，未增加原ρG L1前提。每fixed z随着Nat R=n+1 cutoff eventually exactly1；实际div(χρG)=χdiv(ρG)−(β/R)transitionDerivative*(G·∇H)ρ。下一证明transition derivative bound、空间cutoff全域IBP及density cutoff积分极限。

## 验证
local01 weighted函数差未展开，local02修正后基础7声明通过。api01未建新模块olean而失败；api02两个不存在Integrable.apply/eval失败，其余实际API可用，不算成功验收。local03 fderiv_apply缺实数域参数；local04 coordinate projection缺显式类型及两个unused simp；local05 projection函数rewrite失败和deprecated finsetSum；local06基础10声明退出0零诊断。local07--09密度导数常数除法API不存在/函数Pi.sub.smul透明表达式和flux pointwise匹配；local10展开Pi函数定义/explicit actual flux derivative后全部18退出0，仅neg_apply弃用警告；local11改用neg_apply全部退出0空日志/零Lean警告。无新增公理/占位/依赖升级。
full-check01 2026-10-05T22:40:54.1848185+08:00--2026-10-05T22:43:09.0075861+08:00退出0；9061 jobs/零Lean警告/1145audit基础三公理/144inputs及全部raw SHA复核一致；18public逐名覆盖。 负责人原文语义pending。Prop6.1本体及Theorem6.2 generator/density/Harris与CORE_SCOPE未完成。

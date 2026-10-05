# Theorem6.2 actual completed-filtration 条件 Markov 必要依赖

印刷252/PDF273，沿用已核对tmp/chapter6-causal/page-273.png。10public；unit mass/unit torus finite Nc；标准actual vector Wiener，同一real/periodic actual global过程。real C² U/global forceLip辅助；periodic C∞lattice U主结论derived forceLip。概率completion由原hB推出，未假设original Ω complete。对每固定NNReal S/T AE，不能称uncountable共同异常集、usual conditions/right-continuity或stopping-time strongMarkov。

## 实际证明
History type tag底层是原Ω，measurable space精确是actual F_S。identity observation从completed Ω可测由F_S.le S，pushforward逐点等于P.completion.trim F_S。已接受future独立于整个F_S，显式comap事件见证转成future独立identity observation；真实product law噪声边缘由completion Cpath law保持与future Wiener law识别。

私有必要lemma只把真实history/future乘积律经可测endpoint映射和AE restart推出compProd；ext集合+prod_apply+compProd_apply及真实K_T(x)=Wiener endpoint law得到disintegration。actual current在F_S可测由同一模型Adapted，端点由joint initial/path measurable；实际global future endpoint共同AE restart沿ae_completion使用。同一actual Y的联合律因此等于historylaw⊗K_T.comap X(S)。condDistrib唯一性及ae_of_ae_map推出该实际过程条件于整个完成化过去的条件核恒等式。periodic主结论最后由已接受势能力Lip推导，不含kernel/Markov结论输入。

## 验证与失败
api01固定mathlib精确API探针退出0。local01 history tag comap id的simplification透明度不够；local02展开后rw comap_id仍有Null tag透明度问题，改显式measurable-comap事件见证解决。local02/03 condDistrib的comap核实例推断因tag透明度失败，local04以真实K_T(XS)逐样本总质量为一直接构造IsMarkovKernel；没有新假设。local04所有10public退出0空日志/零Lean警告。
full-check01 2026-10-05T21:50:18.6212785+08:00--2026-10-05T21:53:07.0779702+08:00退出0；9059 jobs/零Lean警告/1118audit基础三公理/142inputs及全部raw SHA复核一致；10public逐名覆盖。 负责人教材语义pending。progressive/density/actual generator/Harris及CORE_SCOPE未完成。

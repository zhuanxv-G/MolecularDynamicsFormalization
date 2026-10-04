# Lemma7.1实际Markov核不变分布换序

- 原299--300/PDF320--321渲染目视。教材假设ST和TS的唯一不变分布以及额外遍历性；形式化真实Markov核S/T与真正不变概率测度的已知唯一性，构造S作用的分布后推导rhoST=S rhoTS以及rhoTS=T rhoST。
- 实际Kernel复合S∘ₖT先T后S；实际measure action是Kernel ∘ₘ Measure（bind），没有自由符号演算冒充概率作用。真实结合律导出ST(Sρ)=S(TSρ)，真正不变性推出转移不变性，Markov性推出新measure归一化为probability，教材唯一性推出两目标。目标换序等式没有塞进假设。
- 原证明迭代恒等(ST)^(n+1)ρ=S(TS)^n(Tρ)对真实核作用完整归纳。原唯一性在该真实Markov模型下已足够证明结论，额外ergodicity不需要使用；没有声称任意核有唯一分布或从具体数值SDE构造遍历性。
- 原文以rho表示分布，Lean采用真正概率measure，无density存在/具体Lebesgue正则性假设；负责人需最终确认分布/密度语义对应。所有原特殊density实例可在存在该density时经measure equality使用。
- local01/02真实迭代方向及函数推断失败保留，local03退出0零警告；唯一full01/session24263：2026-10-05T07:10:45.9311449+08:00--2026-10-05T07:11:49.0963178+08:00退出0；9018jobs、零警告、669项审计声明仅基础三公理、101项输入稳定，固定版本/Scratch/扫描/公理全部通过。5项公开接受，全部输入/原始日志SHA256实查一致，基础公理恰为propext/Classical.choice/Quot.sound。
- 负责人语义pending，具体数值核构造/ergodicity或整个chapter7/CORE_SCOPE未由本批完成。

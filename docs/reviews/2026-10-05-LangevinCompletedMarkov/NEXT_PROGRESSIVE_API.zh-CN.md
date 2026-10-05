# 下一实际模型依赖：同一过程逐样本连续与渐进可测（待证明）

固定print252/PDF273 Theorem6.2模型依赖。当前actual real/periodic过程已经Adapted和completed filtration条件Markov；新批不重证、不更换process。

1. Cpath B A sample restriction到T = Cpath B T sample，对所有sample成立：按Continuous(B·sample)分类，continuous分支evaluation直接相同，exceptional分支所有horizon都为zero；无Wiener假设。
2. 用已接受PathEndpoint_restrict及上述真正restriction一致，任何t≥0的actual global endpoint（ceil t+1 horizon）逐样本等于time-t path endpoint；任意A≥t同样等于fixed A endpoint。
3. 固定A path solution integralSolution的q/p连续给actual global过程ContinuousOn(Icc0A)，再局部A=t+1的neighborhood equality给ContinuousOn(Ici0)及NNReal continuous。periodic projection连续给同一periodic actual过程continuous。包括原exceptional samples，不用AE continuous直接代替∀sample。
4. 已接受Adapted.stronglyAdapted与StronglyAdapted.isStronglyProgressive_of_continuous及IsStronglyProgressive.isProgressive证明同一actual real/periodic过程IsProgressive completed F；periodic原C∞lattice U继续derived Lip主结论。
固定版本API和实现均待验证；不声称right-continuity/strongMarkov/密度/generator/Harris或全CORE_SCOPE完成。

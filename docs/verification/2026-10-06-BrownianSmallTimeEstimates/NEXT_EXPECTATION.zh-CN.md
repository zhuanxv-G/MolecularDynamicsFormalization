# 下一实际随机生成元依赖：同一q短时间期待与Taylor余项
当前BrownianSmallTimeEstimates18项统一验收中，正式Lean输入冻结；不得同时编译下一候选或改正式输入。
下一 BrownianExpectationEstimates.lean，docs/Draft.lean目前只有真实初稿1public尚未验证：
1. 原实际driftbounded得一个与x,t无关M；sameglobalq真实积分方程给increment norm≤Mt+norm(actualSigmaB_t)，由actualAEmeasurable+真noiseintegrability推actualincrement Bochnerintegrable及E norm≤Mt+C sqrt t。C=sum_i sqrt(2 beta^-1 m_i^-1)，一般正质量/Nc含0，不用qmoment目标作假设。
2. 同一实际q平均increment的drift界norm(E(q_t−x))≤Mt，需要从真实原equation得到boundeddrift integral为qincrement−noise，并用真noise Bochnermean0。避免先假设Gibbsinvariance或SDEgenerator。
3. 真冻结drift remainder期待O(t^1.5)+O(t²)需Fubini，先actualfixedhorizonnoise→CMap(time→q)由已验收jointendpoint_timecontinuity连续，原实际WienerCPath carrier AEmeasurable，全timeAE agreement，保证(actuals,sample) joint integrability。不得把pathwise inequality直接当expectation/Fubini或generator证据。
4. 原SigmaB_t higher-order endpoint law/时间缩放及Gaussian allp finite moments供真正Taylor error；已有actualWienerVectorCoordinate law/coordinates independent/HasLaw gaussianReal_const_mul可复用，原noise allfinitep不是t→0的速率证据。
5. 目标 actualsameprobabilityC0operator在actualsmoothperiodic observable上的真实差商→原mass-weighted differential BrownianGenerator，再才处理sameGibbsLp extension/invariance与actualspectral T identification和5.6算子识别。不得把generator或SDElaw=谱T塞入前提。
负责人C²/C∞core语义签核保持pending；困难不阻塞真实独立估计，未称整Theorem6.1/CORE_SCOPE完成。只本地，不MathCopilot/旧chat/新任务/Goal/automation。
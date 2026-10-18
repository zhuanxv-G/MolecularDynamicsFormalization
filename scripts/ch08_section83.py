from ch08_data import add,EXCLUDED
add('ArrheniusRate','8.3',342,r'''k ∼ A e^{-ΔE/(k_BT)}.''',
'''def arrheniusRate (A ΔE kB T : ℝ) : ℝ := A*Real.exp (-ΔE/(kB*T))
theorem arrheniusRate_nonneg (A ΔE kB T : ℝ) (hA : 0 ≤ A) :
    0 ≤ arrheniusRate A ΔE kB T := mul_nonneg hA (Real.exp_pos _).le''',kind='definition',extra=['A≥0,k_B>0,T>0为速率解释域；只定义原页模型，不声称一般能垒动力学服从此经验律。'])
EXCLUDED += [dict(printed_page='341–342',pdf_page='362–363',object='HMC / Andersen 概述',reason='本节只引用外部文献的遍历/无偏结果，没有给出具体转移核、原子选择律与假设，保留原页文字，不凭空增添核；完整数学规格为明确覆盖缺口。')]

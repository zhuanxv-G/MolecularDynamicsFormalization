from ch07_data import add,EXCLUDED
add('Bias','7.1',263,
'''All standard methods based on discretizing SDEs introduce some stepsize-dependent error in computed averages, which we shall refer to as bias (related to the truncation error of the discretization scheme).''',
'''def bias (exact computed : ℝ) : ℝ := |exact - computed|''',kind='definition',
extra=['将本段bias记号具体写为后文印刷p.266所给的绝对平均误差；不把“所有标准方法”量化成无条件定理。'],
scope='离散平均值偏差的定义；本段关于标准方法的概述不作为普遍量化结论。')
EXCLUDED += [dict(printed_page='261–263',pdf_page='282–284',reason='引言关于采样困难、局部极小点数量的文献估计、Monte-Carlo比较及图7.1为动机和经验说明；bias数学记号已保留。')]

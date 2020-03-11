---
title: 数据分析的多重检验问题(multiple testing)
date: 2017-08-26 09:31:37
tags: FDR
categories: Statistics
---
数据分析中常碰见多重检验(multiple testing)问题，如利用基因芯片数据比较分析两个样品间是否有差异表达基因，或利用质谱定量数据鉴定某一个蛋白在两个样品中是否存在差异表达等。
一般选取差异表达基因有两标准：
(1) Fold Change，即两个样品中同一个基因的表达水平变化倍数; 
(2) p-value，即通过T检验等统计学方法计算每个基因的P值。
<!--more-->
但是由于通常样本量较少，从而对总体方差的估计不很准确，所以T检验的检验效能会降低，并且如果多次使用T检验会显著增加假阳性的次数。例如，当某个基因的p值小于0.05（5%）时，我们通常认为这个基因在两个样本中的表达是有差异的。但是仍旧有5%的概率，这个基因并不是差异表达基因，我们错误地否认了原假设（在两个样本中没有差异表达），导致了假阳性的产生（犯错的概率为5%）。
如果检验一次，犯错的概率是5%；检测10000次，犯错的次数就是500次，即额外多出了500个差异基因的结论（即使实际没有差异）。为了控制假阳性的次数，于是我们需要对p值进行多重检验校正，提高阈值。

### FDR方法
Benjamini于1995年提出一种方法，通过控制FDR(False Discovery Rate)来决定P值的域值。假设你挑选了R个差异表达的基因，其中有S个是真正有差异表达的，另外有V个其实是没有差异表达的，是假阳性的。实践中希望错误比例Q＝V/R平均而言不能超过某个预先设定的值（比如0.05），在统计学上，这也就等价于控制FDR不能超过5％.
根据Benjamini在他的文章中所证明的定理，控制FDR的步骤实际上非常简单。
设总共有m个候选基因，每个基因对应的p值从小到大排列分别是p(1),p(2),...,p(m),则若想控制FDR不能超过q，则只需找到最大的正整数i，使得 p(i)<= (i*q)/m。然后，挑选对应p(1),p(2),...,p(i)的基因做为差异表达基因，这样就能从统计学上保证FDR不超过q。这是Benjamini and Hochber法(BH法)从P值估计FDR的基本原理。

### FDR计算
FDR的计算方法除了可以使用excel的BH计算方法外，对于较大的数据，我们推荐使用R命令p.adjust。
![p.adjust](/imageBed/fdr_padjust.png)
该函数的运算需要先将一系列p值、设定一个校正方法（p.adjust.methods）及所有p值的个数（length(p)）输入到p.adjust函数中。返回结果为校正后的P值，可以用于后续分析了。

### FDR与p-value区别
The False Discovery Rate (FDR) of a set of predictions is the expected percent of false predictions in the set of predictions . For example if the algorithm returns 100 genes with a false discovery rate of .3 then we should expect 70 of them to be correct. FDR的意义为错误拒绝（即拒绝真的原假设）的个数占所有被拒绝的原假设个数的比例的期望值！
The FDR is very different from a p-value, and as such a much higher FDR can be tolerated than with a p-value. In the example above a set of 100 predictions of which 70 are correct might be very useful, especially if there are thousands of genes on the array most of which are not differentially expressed. In contrast p-value of .3 is generally unacceptabe in any circumstance. Meanwhile an FDR of as high as .5 or even higher might be quite meaningful.
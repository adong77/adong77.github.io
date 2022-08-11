---
title: An overview of TruSeq Stranded mRNA sequencing
comments: true
date: 2022-06-27 06:11:53
tags:
categories: Genomics
---
链特异性测序
<!--more-->

## 链特异性测序文库构建流程
这里以TruSeq Stranded mRNA sequencing为例，介绍链特异性测序文库的构建流程，如图所示，红色始终代表sense strand的信息，天蓝色代表antisense strand的信息。
![TruSeq Stranded mRNA sequencing libarry](http://www.ligene.cn/images/Tru-Seq-library.png)

* 首先，利用成熟mRNA带polyA尾的特点，通过oligo dT来富集mRNA；
* 接下来，使用超声波对mRNA进行片段化，然后再使用随机引物进行反转录，这个过程就是第一条链（天蓝色）的合成；
* 接下来，再使用RNaseH酶消化降解掉杂合链中的RNA，然后再进行第二链（红色）的合成，注意这里不使用dTTP，而是使用dUTP。
* 然后，先使用Klenow酶来给3'末端添加一个突出的A；再连接adapter，注意这里的adapter结构；
* 然后再进行PCR反应，由于DNA聚合酶不能以dUTP为模板，所以以sense strand为模板的链没有办法参与到PCR中，因此最终的双链DNA都是右下角那样的。
（需要先降解dUTP链？）
我们最终可以看到，Read1测到的是antisense strand的信息，Read2测到的是sense strand的信息，这和我们之前的理解是一样的哈。


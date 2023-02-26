---
title: 浅谈Nanopore三代测序技术
comments: true
toc: true
date: 2023-01-11 17:35:13
tags: NGS
categories: Genomics
---
第三代测序技术与前两代测序技术相比，其最大的特点就是单分子测序，测序过程无需进行PCR扩增，实现了对每一条DNA分子的单独测序。其中，英国牛津纳米孔公司所开发的纳米孔（Nanopore）测序技术便是三代测序中的中流砥柱。2014年，其推出U盘大小的便携式MinION测序仪，仪器售价仅需$1000，据官网报道最长Reads可长达960Kb。从当前形势来看，一代测序因其准确度高，仍作为突变检测、单菌鉴定等的金标准而存在。以illumina HiSeq为代表的第二代短读长测序技术在测序市场上仍然占有绝对优势，主打低成本和高通量。但第三代测序技术（PacBio与Nanopore）近年来发展很快，主打长读长策略，直击二代测序短序列的软肋，已应用于基因组测序、甲基化研究和突变鉴定等多个研究领域。
<!--more-->

## Nanopore测序原理
纳米孔测序，顾名思义，核心就是利用一个纳米孔，孔内共价结合有分子接头，将纳米孔蛋白固定在电阻膜上，然后使DNA双链解链成单链，再利用马达蛋白牵引核酸单链穿过纳米孔。当一条核酸链穿过纳米孔时，会对膜两边离子的稳定流动产生扰动，从而引起电阻膜上电流的变化。由于纳米孔的直径非常细小，仅允许单个核苷酸通过，而不同碱基的带电性质不一样，因此不同碱基通过蛋白纳米孔时对电流产生的干扰不同，通过实时监测并解码这些电流信号便可确定碱基序列，从而实现测序。纳米孔是对穿过的片段进行测序，而不管DNA片段的长度如何，而不是生成特定长度的序列，这可能是数百个碱基、或者更多个碱基的序列。Nanopore的长序列简化了重复区域的组装和测序，也提高了物种鉴定和宏基因组实验的速度。
![Nanopore-sequencing](https://www.ligene.cn/images/blog/nanopore-1.jpg)

## Nanopore测序中的几种物质
* Reader（跨膜蛋白）：在自然界中，有一种可以嵌入到细胞膜中作为离子或分子通道的跨膜蛋白，具有天然的蛋白纳米孔。经过人为基因工程修饰后，得到Nanopore测序所需的Reader蛋白。
* Membrane（电阻膜）：Reader蛋白会被嵌入到高电阻率的由人工合成的多聚物膜中，膜两侧是离子溶液，在两侧加不同的电位，离子就会在孔中流动，形成电流。
* Motor（马达蛋白）：在Nanopore文库构建时，需要在接头上连接一种马达蛋白，用于将DNA或RNA分子推入纳米孔中。以DNA解螺旋酶作为 Motor为例，它除了可以解开双螺旋，使之变为单链，还可以提供推动力。
* Tether：该蛋白用于锚定DNA或RNA链，防止其在溶液中飘动，并使其进入纳米孔中。
![Nanopore-sequencing2](https://www.ligene.cn/images/blog/nanopore-2.jpg)

## Nanopore测序的具体过程？
Nanopore测序是将人工合成的一种多聚物膜浸在离子溶液中，多聚物膜上布满了经改造的穿膜孔的跨膜通道蛋白（纳米孔），也就是Reader蛋白，在膜两侧施加不同的电压产生电压差，DNA链在马达蛋白的牵引下，解螺旋酶将双链DNA解开成单链；DNA单链分子通过一个孔道蛋白，孔道中有个充当转换器的蛋白分子；DNA单分子停留在孔道中，有一些离子通过带来电流变化，而不同的碱基带来的电流变化不同；转化器蛋白分子感受5个碱基的电流变化；根据电流变化的频谱，应用模式识别算法得到碱基序列。

Nanopore测序得到的序列文件的格式也是HDF5，下机产生后缀为Fast5的序列文件。Fast5文件可经由Poretools软件转换为Fastq文件或Fasta，然后进行后续数据分析。应用Poretools将fast5转换为fastq的示例：https://poretools.readthedocs.io/en/latest/content/examples.html#poretools-fastq

## Nanopore测序技术的主要优势？
* 长读长：Reads可达Mb；适合进行大片段结构变异的检测或大基因组的拼接。
* 设备成本低：测序芯片可清洗再生，重复利用；
* 实时获得序列信息：最快可在1小时内完成测序流程及数据分析，满足动态检测宏基因组需求；
* 便携式测序装置：重量轻且占用空间小，可以随身携带随时测序；实时快速进行微生物分类鉴定。
* 直接测序：直接测序原始DNA和RNA，不需要进行PCR扩增，避免了扩增偏好性；保留了原始碱基修饰信息，能够直接读出甲基化的胞嘧啶。以往转录组分析由于无法直接对RNA进行测序，往往需要先对mRNA进行打断，再反转录为cDNA，无法获取和分析全长转录本。

文字描述不容易理解，下面通过一个视频，更加直观的展示纳米孔测序。
<!-- <iframe src="https://www.bilibili.com/video/BV1La41147dB/?share_source=copy_web&vd_source=d833801a2195b5684770ca2be2c47655" width="800px" height="600px" frameborder="no" framespacing="0" allowfullscreen="true" scrolling="no" sandbox="allow-scripts allow-same-origin allow-popups"> </iframe> -->
<iframe src="//player.bilibili.com/player.html?aid=212732838&bvid=BV1La41147dB&cid=562633133&page=1" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true" width="600px" height="480px"> </iframe>

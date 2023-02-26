---
title: BioEdit本地BLAST
comments: true
toc: true
date: 2022-04-03 16:09:47
tags: [BLAST, BioEdit]
categories: Bioinformatics
---
本练习使用BioEdit进行本地BLAST操作，鉴定16S rDNA测序序列的物种分类。
<!--more-->
BLAST是“Basic Local Alignment Search Tool”的简称，顾名思义，它是基于局部比对算法的搜索工具，可将输入的查询序列(核酸或蛋白质)与数据库中的已知序列进行比对，获得与查询序列相似的已知序列，从而判断查询序列的来源或进化关系等。

一般可通过NCBI网站使用在线BLAST工具，但有时也需要进行本地BLAST，如实验室新测序了一个新细菌的基因组，还没有将此基因组上传的GenBank数据库，将无法通过NCBI在线BLAST搜索此新基因组中的基因。NCBI网站提供最新版本的本地BLAST软件(https://blast.ncbi.nlm.nih.gov)。

本练习使用bioedit软件实现BLAST搜索同源序列，鉴定一个16S测序序列的物种分类。BioEdit使用比较方便，整合了构建数据库和各种BLAST算法(如下图)，但BioEdit集成的BLAST软件是比较老的版本。
![Local BLAST](https://www.ligene.cn/images/book/bioedit-1.png)

> 注：可从配套百度网盘下载bioedit软件及相关文件:
https://pan.baidu.com/s/1eMiHyb7mW4Nrbsfpw9JtdA (提取码: txh5)。

### 下载并安装BioEdit

安装BioEdit的默认路径为C:\BioEdit\，如要修改安装路径，软件可能会报错。

> 可从配套百度网盘文件夹Resources目录下载bioedit软件。

### 准备查询序列与数据库
可使用核酸或蛋白质序列，本练习使用：
* 1)查询序列文件(16S_rRNA_sequences.txt): 两条测序得到的肠道微生物16S rDNA序列。
* 2)细菌16S序列数据库(16SMicrobial.tar.gz): 此数据库为从NCBI网站下载的已经构建好的BLAST数据库，解压后会看到8个文件。

> 注：两文件可从配套网盘文件夹ch05BLAST下载。数据库文件是压缩文件需要解压使用，可使用解压缩软件，如WINRAR、7-zip等。

### 准备本地序列数据库

如果要把基因组数据做成本地数据库，可通过: 
* 1)菜单create a local nucleotide database file建立本地DNA数据库
* 2)菜单create a local protein database file建立本地蛋白质数据库
用于建库的原始数据需要做成fasta格式。

 本练习直接用NCBI网站提供的已经格式化的16S序列数据库，不需要从头建库：
  将前面解压后16SMicrobial目录下的8个文件复制到BioEdit安装目录下的database文件夹(c:\bioedit\database)即可。

4. 运行Local BLAST

Local BLAST窗口的参数设置如图所示：
![BLAST参数](https://www.ligene.cn/images/book/bioedit-2.png)
* 由于本练习所用查询序列与数据库序列都是DNA序列，因此Program选blastn，数据库选择Nucleotide Database的16SMicrobial，注意要点击一下16SMicrobial下拉框并选择此数据库。如果为蛋白质序列则要相应选blastp与Protein Database。

* 将16SRNA sequences.txt中的DNA序列复制粘贴到Query输入框中。
> 注意不要复制fasta格式中的注释行(>开头)。

* 另外，将E-value值设置为1e-6或更小的值，默认值1.0将找到许多不相似的序列，e-value值越小，能找到的序列越相似。但e-value设置为一个很小的值可能找不相序的序列(no hits)，可根据需要调整e-value。其它参数可不用设置。

* 最后点击Do Search进行分析。


### 解读BLAST结果

BLAST结果如下图所示：
![BLAST结果](https://www.ligene.cn/images/book/bioedit-3.png)

结果部分前面有参考文献、碱基长度等信息，下面是获得的同源序列，显示数据库对应序列的ID及注释信息，并根据比对分数(Score)由高到低排列。上图所示的比对匹配分数最高的序列是源自艰难梭菌菌株(clostridium difficile)，即此菌分类可鉴定为艰难梭菌。

> 注意，16S序列比对可能与不同物种的比对具有相同的分数，因此无法确定哪个菌株最合适，说明只靠16S序列信息有时是不能注释到种(species)水平。

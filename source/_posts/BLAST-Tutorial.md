---
title: BLAST+使用教程
comments: true
toc: true
date: 2017-07-05 13:39:37
tags: [BLAST, IGV]
categories: Bioinformatics
---
Linux下最新版BLAST+的本地化安装与基本使用用法。
BLAST的更详细使用方法可参考BLAST手册《BLAST Command Line Applications User Manual》，网址：http://www.ncbi.nlm.nih.gov/books/NBK279690/
<!--more-->
## 1. 下载
从NCBI网址下载最新版BLAST程序：ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/
根据自己的操作系统选择相应的BLAST可执行程序，如Ubuntu 12.04(64位)系统就下载：
$wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.6.0+-x64-linux.tar.gz

## 2. 安装
* 解压缩：
  $tar -zxvf ncbi-blast-2.6.0+-x64-linux.tar.gz
* 移动到本地安装目录（不带版本号，避免因升级而修改配置文件）
  $sudo mv ncbi-blast-2.6.0+/  /opt/blast
* 将BLAST+可执行程序所在目录（bin）的绝对路径加入到环境变量$PATH中，方便通过程序名直接调用。
编辑~/.bashrc文件，在最后加入bin目录
```
echo "export PATH=/opt/blast/bin:\$PATH" >> ~/.bashrc    
source ~/.bashrc  #让配置生效
blastn -version  #显示版本
```
如果显示版本正确，安装成功。

## 3.配置本地BLAST库
* 安装目录/opt/blast下新建一个文件夹，命名为db 。
$mkdir /opt/blast/blastdb

* 在用户home目录下新建一个文件.ncbirc（文件名是以点号开头）。
$vi ~/.ncbirc
在文件中添加内容：
[BLAST]
BLASTDB=/opt/blast/blastdb

配置好后，以后做BLAST选择库的时候就可以只输入名称（比如nr），不用输入绝对路径了。

## 4.基本用法
BLAST程序执行前要先准备查找目标序列(Subject)的数据库，BLAST程序需要有特定格式数据库才能进行搜索，所以要先格式化序列数据库；也可以直接从NCBI下载已经格式化好的数据库，如NT, NR数据库等。然后根据查询序列(Query)为蛋白质或核酸序列选择相应BLAST程序，如blastp或blastn等搜索相似序列。

### 4.1 格式化序列数据库
```
$makeblastdb -in db.fasta -dbtype nucl -parse_seqids -out dbname
参数说明:
-in：待格式化的序列文件
-dbtype：数据库类型，prot或nucl
-out：数据库名
```
如果该库需要经常使用，可将库文件移到前面配置的库文件的目录，今后在其它目录运行blast的时候，便可直接输入库名（不用输入绝对路径），直接使用。
$mv dbname.* /opt/blast/blastdb

### 4.2 运行BLAST程序
* 以核酸序列比对核酸数据库（blastn）为例：
```
$blastn -query seq.fasta -out seq.blast -db dbname -outfmt 6 -evalue 1e-5 -num_descriptions 10 -num_threads 8
参数说明:
	-query： 输入文件路径及文件名
	-out：输出文件路径及文件名
	-db：格式化了的数据库路径及数据库名
	-outfmt：输出文件格式，总共有17种格式，6是tabular格式（对应BLAST的m8格式），最新版BLAST+的17是sam格式。
	-evalue：设置输出结果的e-value值
	-num_descriptions：tabular格式输出结果的条数
	-num_threads：线程数
```
更多参数信息可直接输入blastn -help查阅。

* Blastn程序的default value为magablast。Megablast 是在intra-species或者very closely related species中使用的blast版本，其特点是word_size较大（默认值为28bp），这样就可以在initial match过程排除掉很多情况，从而加快比对速度。而对于inter-species的两个较短片段就无法搜寻到结果，这种情况可以增加 –task blastn，就一切正常了。

* 新BLAST+中最拉风的功能是直接控制输出格式，如：-outfmt format "7 qacc sacc evalue length pident" 
7表示带注释行的tab格式的输出，可以自定义要输出哪些内容，用空格分格跟在7的后面，并把所有的输出控制用双引号括起来，其中qacc查询序列的acc,sacc表示目标序列的acc，evalue即是e值，length即是匹配的长度，pident即是序列相同的百分比。其他可用的选项参见最后。

* 其它程序，如蛋白序列比对蛋白数据库（blastp）以及核酸序列比对蛋白数据库（blastx）等，用法与blastn类似：
```
blastp -query seq.fasta -out seq.blast -db dbname -outfmt 6 -evalue 1e-5 -num_descriptions 10 -num_threads 8
blastx -query seq.fasta -out seq.blast -db dbname -outfmt 6 -evalue 1e-5 -num_descriptions 10 -num_threads 8
```
完整的参数说明可以用-help查询。

### 4.3 也可以直接下载NCBI已经格式化好的库(NCBI-curated database)，直接在本地库中比对，以蛋白质库nr为例：
* 下载库可使用BLAST+自带的update_blastdb.pl脚本
```
cd /opt/blast/blastdb/ 	#切换到本地BLAST库目录
update_blastdb.pl  nr
tar -xzvf *.gz
rm *.gz*  #删除下载的文件
blastp -db nr -query somesequence.fasta
```
* 如果没有下载本地化nr库，可添加-remote选项，进行在线比对（就不能使用-num_threads参数了），但速度慢一些，适合序列不多的情况。

-----

> Formatting options
-outfmt <String>
alignment view options:
0 = Pairwise,
1 = Query-anchored showing identities,
2 = Query-anchored no identities,
3 = Flat query-anchored showing identities,
4 = Flat query-anchored no identities,
5 = BLAST XML,
6 = Tabular,
7 = Tabular with comment lines,
8 = Seqalign (Text ASN.1),
9 = Seqalign (Binary ASN.1),
10 = Comma-separated values,
11 = BLAST archive (ASN.1),
12 = Seqalign (JSON),
13 = Multiple-file BLAST JSON,
14 = Multiple-file BLAST XML2,
15 = Single-file BLAST JSON,
16 = Single-file BLAST XML2,
17 = Sequence Alignment/Map (SAM),
18 = Organism Report
Options 6, 7, and 10 can be additionally configured to produce
a custom format specified by space delimited format specifiers.
The supported format specifiers are:
qseqid means Query Seq-id
qgi means Query GI
qacc means Query accesion
qaccver means Query accesion.version
qlen means Query sequence length
sseqid means Subject Seq-id
sallseqid means All subject Seq-id(s), separated by a ';'
sgi means Subject GI
sallgi means All subject GIs
sacc means Subject accession
saccver means Subject accession.version
sallacc means All subject accessions
slen means Subject sequence length
qstart means Start of alignment in query
qend means End of alignment in query
sstart means Start of alignment in subject
send means End of alignment in subject
qseq means Aligned part of query sequence
sseq means Aligned part of subject sequence
evalue means Expect value
bitscore means Bit score
score means Raw score
length means Alignment length
pident means Percentage of identical matches
nident means Number of identical matches
mismatch means Number of mismatches
positive means Number of positive-scoring matches
gapopen means Number of gap openings
gaps means Total number of gaps
ppos means Percentage of positive-scoring matches
frames means Query and subject frames separated by a '/'
qframe means Query frame
sframe means Subject frame
btop means Blast traceback operations (BTOP)
staxids means unique Subject Taxonomy ID(s), separated by a ';'
(in numerical order)
sscinames means unique Subject Scientific Name(s), separated by a ';'
scomnames means unique Subject Common Name(s), separated by a ';'
sblastnames means unique Subject Blast Name(s), separated by a ';'
(in alphabetical order)
sskingdoms means unique Subject Super Kingdom(s), separated by a ';'
(in alphabetical order)
stitle means Subject Title
salltitles means All Subject Title(s), separated by a '<>'
sstrand means Subject Strand
qcovs means Query Coverage Per Subject
qcovhsp means Query Coverage Per HSP
When not provided, the default value is:
'qseqid sseqid pident length mismatch gapopen qstart qend sstart send
evalue bitscore', which is equivalent to the keyword 'std'
Default = `0'

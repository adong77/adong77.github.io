---
title: Mapping contigs onto reference genome
comments: true
toc: true
date: 2017-07-13 08:40:17
tags: [BLAST,IGV]
categories: Genomics
---
基因组组装会得到许多contigs，一般需要将它们比对到参考基因组序列，以确定contigs在染色体的位置。
参考基因组可以用亲缘关系很近的物种序列，例如同一个物种的不同菌株测序，可以用该种模式菌株的基因组序列作为reference sequence。
<!--more-->
## 1. Mapping contigs onto reference genome
### 1.1 Make the BLAST database with the reference genome
```
$makeblastdb -in reference.fasta -dbtype nucl -parse_seqids -out ref_db
$blastdbcmd -db ref_db -info
```

### 1.2 Run the BLAST query with contigs
$ blastn -task blastn -query contigs.fasta -db ref_db -parse_deflines  -evalue 0.0001 -outfmt 6 -out blast.tab 

### 1.3 Convert BLAST tabular format into BED format
BED format is a format that IGV can accept. You need to have a few column in this file format:
> "chrom start end name score, ...."
These fields are already present in the BLAST tabular format result:
> 'qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore'
To convert to BED format, assuming query is your contigs and subject is the reference:
> "subjectID, subjectStart - 1,  subjectEnd, queryID:queryStart-queryEnd"
Note: 
1. you might need to swap subjectStart and subjectEnd, depending on which one is larger.
2. use tab instead of comma in the final BED file.

### 1.4 Visualization with IGV
The final BED file can be visualized with IGV.

--------

## 2. 最新版BLAST+支持直接用IGV显示
* 最新版blastn支持SAM output format：**-outfmt 17**
参见：NCBI working on SAM output from BLAST+ (https://blastedbio.blogspot.com/2015/07/ncbi-working-on-sam-output-from-blast.html)

* 但输出SAM格式还有一个问题，Query name不能被输出到sam文件对应的序列。
可以通过 -parse_deflines来解决：
```
$makeblastdb -dbtype nucl -in contigseq.fasta -parse_seqids -out testdb
$blastn -query genomeseq.fasta -parse_deflines -db testdb -evalue 0.0001 -outfmt 17 -out test.sam
```
注意：这里**query是reference序列文件，而subject是contigs序列**， 所以需要用contigs序列建库，与前面tabular format的过程相反。

* 输出文件test.sam可直接导入IGV中观察两基因组的比对情况。
    IGV需要以这里的genomeseq.fasta做为reference genome (Genomes->Create .genome file...).

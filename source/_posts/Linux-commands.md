---
title: Linux文本处理命令
comments: true
toc: true
date: 2023-02-13 22:52:50
tags:
categories: Linux
---
掌握基本的grep，sed，awk操作。
我之所以推荐这三个命令是因为，它们很适合快速进行简单的文本操作，可以让很多工作直接快速地在命令行上完成，而不需要编写程序。比如抽取一个文本文件特定的几列信息、匹配相关信息、修改输出等，用awk实现起来非常简单。
掌握了这些之后，你再学习如何利用Linux命令和相关程序组建简单的shell任务流程，到这个阶段，Linux部分基本就OK了。
<!--more-->

## 常用的Linux命令学习资源

CSDN网站提供一个线上Linux环境，可以在线练习Linux命令的使用。
* 线上Linux环境: https://edu.csdn.net/lab/36675?targetLesson=2692
* Linux入门: https://edu.csdn.net/skill/gml/gml-5d30b74764e645f49839c545d784f29e?category=747

## Linux文本处理命令
Linux 命令很多，掌握最实用的一批命令，对于每个实用命令，又只需掌握20%最高频操作。

### grep 匹配
一款强大的文本搜索工具，能使用正则表达式匹配模式搜索文本，并把匹配的行打印出来 
* 格式: grep [options] pattern [file] 

常用参数设置
   * -v 反向选择，输出没有匹配的行, grep -v hello test.txt
   * -n 显示匹配成功的行所在的行号 
   * -c 统计匹配成功的行的数量 
   * -w 完全匹配 
   * -o 只输出匹配的内容 
   * -f 从文件中读取pattern 
   * -E 指定正则表达式模式, grep -E "\d." test.txt 
   * -A 3 额外输出匹配行的后3行,A表示after, grep movie -A 3 test.txt
   * -B 3 额外输出匹配行的前3行, B表示before
   * -C 3 额外输出所在行的前后3行，C表示center

### sed 流编辑器
sed 命令可以用来替换文本行、删除文本行
* 格式:sed [opition] 'script' file(s) | sed [-n] -f scriptfile file(s)

常用参数设置
   * -n 禁止显示所有输入内容，只显示经过sed处理的行
   * -e 直接在命令列模式上进行sed的动作编辑。接要执行的一个或者多个命令
   * -f 执行含有sed工作的文件
   * -r sed的动作支持的扩展正则
   * -i 直接修改读取的文件内容，不修改

用法
sed ''<filename> = cat <filename>
script: [address[,address]] [!] command [arguments]

第一部分：作用区域
* 按行号分，n,m n到m行，n,+m n到n加m行，n~m 从n行开始，每隔m行取一次匹配模式 '/pattern/command' 

第二部分：command,可以使用;号，同时使用多个命令
  *  p 打印p 打印
  *  d 删除
  *  i 在目标行之前插入新的行
  *  a 在目标行之后插入新行
  *  c 替换
  *  w 写
  *  r 读
  *  = 打印行号
  *  s 匹配替换，s/pattern/replacement/[flags],其中，n替换第几处，g 替换所有的。p,w。
  *  y 转换, y/inchars/outchars/,/^>/!,反选

#### 例子
  *  查找并替换每行第一个"hello"为"你好"： sed 's/hello/你好/' 1.txt
  *  查找替换每行中所有的"hello"为"你好"： sed 's/hello/你好/g' 1.txt
  *  删除含有"hello"的行：sed '/hello/d' 1.txt
  *  删除第2行：sed '2d' 1.txt
  *  删除第最后一行：sed 'd' 1.txt
  *  删除第2行到最后一行：sed '2,d' 1.txt

### awk 文本分析语言
awk是一种编程语言，用于在linux下对文本和数据进行按行处理。简单理解就是对文本的每行执行命令awk指定的脚本，它的基本命令格式如下：
* 格式:awk [options] 'script' var = value file(s) | awk [options] -f scriptfile var = value file(s) 

常用参数设置

-F 设定分隔符 

script结构
   * awk '{script}' 
   * awk '/pattern/{script}' 
   * awk 'BEGIN{script} {script} END {script}' 可以执行三段代码

内置变量，`awk 'BEGIN{内置变量}{}'

   * FS 定义输入字段分隔符。同-F
   * RS 定义输入记录分隔符
   * OFS 定义输出字段分隔符
   * ORS 定义输出字段分隔符
   * NF 数据文件中的字段总数，可以理解为列数
   * NR 已处理的载入记录数，行数
   * -v 自定义变量或传递外部变量

#### 例子
1. 打印每行的最后1列(默认用空格分离): awk '{print $NF}' 1.txt
2. 打印每行的行号: awk '{print NR}' 1.txt
3. 对第三列的相同数据对应的第一列求和:
awk '{sum[$3]+=$1}END{for(c in sum){print c,sum[c]}}



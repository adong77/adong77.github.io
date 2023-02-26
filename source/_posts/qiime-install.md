---
title: Ubuntu 16.04LTS安装QIIME
comments: true
toc: true
date: 2017-09-03 14:55:56
tags: 16S
categories: Tutorials
---
## Ubuntu 16.04LTS安装QIIME

1. 构建Ubuntu环境
Linux已内置python且version>2.7，需安装其余必备软件包，版本验证 python --version。
$sudo apt-get install build-essential python-dev python-pip
<!--more-->

2. 安装QIIME(base install)
使用阿里云镜像安装pip软件包，可大幅提高下载速度，只需在命令后加：
-i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
$sudo pip install numpy==1.10.0
$sudo pip install ipython==5.4.1 
$sudo pip install qiime  -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
等待安装完成。
安装时，如提示升级pip：
$sudo pip install --upgrade pip -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
3. 检测安装问题
安装完成后：
$print_qiime_config.py -t
有提示错误，按提示再安装：
$sudo apt-get install python-tk
后显示正常了。
4. 安装R
$sudo apt-get install r-base r-base-dev
$sudo R
> install.packages('vegan')
> install.packages('RColorBrewer')
> install.packages('ape')
> source("http://bioconductor.org/biocLite.R")
> biocLite("metagenomeSeq")
其它第三方软件还有待安装。。。
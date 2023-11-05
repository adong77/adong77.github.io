---
title: macOS setup
comments: true
toc: true
mathjax2: false
date: 2023-11-05 23:15:43
tags: [macOS, Conda]
categories: Bioinformatics
---
终端(Terminal)为macOS使用命令行的界面，与Linux基本命令相同，但是软件安装存在一些差异。
<!--more-->
## 终端

* Mac电脑如何打开终端：command+空格 在聚焦搜索中输入terminal回车。

* macOS环境变量配置与Linux系统配置方法一致，但配置文件为用户主目录下的“.bash_profile”。
$vim ~/.bash_profile

* 编辑完成并保存后，需要运行source命令。
$source ~/.bash_profile

* 手动安装XCODE Command Line Tools:
$xcode-select --install

### macOS的包管理器Homebrew 

macOS安装Homebrew只需要在终端运行以下一行命令：
$/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
因国外的网址较慢，如不能安装，可使用国内的网址进行安装：
$/bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"

* Homebrew安装软件的方法：
$brew install bwa

### Miniconda

Mac电脑上conda配置与创建虚拟环境与Linux系统相同。

* 安装Miniconda:
$wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
$sh Miniconda3-latest-MacOSX-x86_64.sh

* 添加Bioconda通道：
$conda config --add channels defaults
$conda config --add channels bioconda
$conda config --add channels conda-forge

* Conda安装软件的方法：
$conda install bwa

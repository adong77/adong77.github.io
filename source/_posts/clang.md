---
title: 编程语言之C语言
date: 2018-01-05 08:25:23
tags:  C
categories: Programming
---
C语言是一门通用的计算机编程语言，广泛应用于系统与应用软件的开发。它是由Dennis Ritchie与Ken Thompson于1969年至1973年间，为了移植与开发UNIX操作系统，在贝尔实验室设计与开发。C语言具有高效、灵活、功能丰富、表达力强和可移植性好等特点。C语言的设计影响了众多后来的编程语言，例如C++、Objective-C、Java、C#等。
<!--more-->
C语言后来发展出多种版本，如Microsoft C、Turbo C等。为了避免各开发商的C语言语法产生差异，美国国家标准研究所(ANSI)为C语言制定了一套国际标准语法，简称为ANSI C。二十世纪八十年代至今的相关程序开发工具，一般都支持匹配ANSI C的语法。目前，C语言编译器普遍存在于各种不同的操作系统中，例如Microsoft Windows, Mac OS X, Linux等。Windows系统下常用的C语言编译器有Microsoft Visual C/C++；Linux系统下常用的编译器是GCC(GNU C编译器)等。
由于Linux系统也是由C语言开发，其上运行的许多应用软件都由C语言开发，所以我们要对C语言编程有一点了解，才能做好数据分析所需软件的安装工作。**一般Linux开源软件的开发者会提供C语言编写的源代码，如果有些软件安装出问题，可以通过阅读源代码来解决。**
###C语言程序开发
C语言是编译性的高级语言，运行之前需要用编译工具将源代码编译链接成目标文件和可执行文件。C语言编程过程大致可分为四步：编写程序 -> 编译 -> 链接 -> 运行。

* (1) 编写源代码
一个 C 语言程序源代码，可以是 3 行，也可以是数百万行。它可以写在一个或多个扩展名为 ".c" 的文本文件中，例如hello.c。您可以使用文本编辑器notepad、vim等来编写C语言程序。
```
#include <stdio.h>
void main()
{
printf("Hello World!");
}
```
* (2) 用编译工具编译，并链接生成可执行文件
`$gcc -o helloworld hello.c` 
 //编译并链接生成可执行文件helloworld
> 如果c程序有多个源代码文件，可能先分别编译成相应的中间目标文件，最后将所有中间文件链接成一个可执行文件。这样其中一个源文件改动后，不用所有文件都要重新编译。Linux提供自动维护工具make，运行make可以从makefile中读取模块之间的关系，自动维护与更新程序的修改。
`$gcc -c hello.c`   
//只编译生成中间文件hello.o
 
* (3) 运行helloworld可执行文件
`$./helloworld`
//输出"Hello World!"。
 
![C programming](/imageBed/cprogramming.png)

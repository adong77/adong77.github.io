---
title: Notepad2代替Windows记事本
comments: true
toc: true
date: 2017-07-04 21:31:15
tags: Tools
categories: Tutorials
---
Windows记事本的功能比较弱，有时不能胜任文本数据处理，如打开大文件会很慢、不能识别Linux系统的换行符等。
Notepad2是一款优秀的**轻量级文本编辑器**，而Notepad2-mod又增强了一些功能，如语法高亮、代码折叠、自动代替Windows记事本等。
修改版的下载地址：[https://xhmikosr.github.io/notepad2-mod/](https://xhmikosr.github.io/notepad2-mod/)
<!--more-->
### 1.安装
安装过程中注意选上：“Replace Windows notepad with Notepad2-mod”(下图),将自动代替Windows自带的记事本。
![Notepad2 Setup](https://www.ligene.cn/images/blog/notepad2_setup.png)
 
### 2.添加Notepad2到右键菜单，方便右键直接打开文档:
把以下内容拷到任意以.reg为后缀的文件（如notepad2_shortcut.reg），后运行导入系统注册表即可。
```
Windows Registry Editor Version 5.00
 
[HKEY_CLASSES_ROOT\*\shell\Notepad2]
 
[HKEY_CLASSES_ROOT\*\shell\Notepad2\command]
@="\"C:\\Program Files\\Notepad2\\Notepad2.exe\" \"%1\""
```
### 3.简单配置 
* View菜单，不要勾选“Long Line Marker”, "Code Folding"。
* Settings菜单，勾选"Remember Recent Files"。
* File菜单的"Line Endings"可以转换为Windows/Linux/Mac的换行符。
* File菜单的"Encoding"可以设置Default编码为"UTF-8"。
---
title: Windows下连接远程Linux桌面
comments: true
toc: true
date: 2018-01-25 08:45:16
tags: Tools
categories: Linux
---
一般我们是通过命令行界面来使用Linux服务器，但有时也需要用Linux图形界面的软件，如IGV。当需要显示的基因组信息比较大，如测序reads的基因组比对情况，会占用大量内存，在服务器上运行会比较流畅。下面是本地windows电脑显示远程Linux服务器桌面的方法。
<!--more-->
## 1. Windows安装Xming
从SourceForge下载Xming-setup.exe（最新的版本是6.9.0.31）。
Xming的SourceForge网址： http://sourceforge.net/projects/xming/
本地安装，安装过程一切按默认选项。
第一次运行时，找到开始菜单里面的XLaunch来启动，产生一个初始的配置文件。对于简单的使用来说，不需要任何特殊的配置，使用默认即可。 
下图中选择“one window”，设置“Display number”中的数字为0。
![Xming Setup](https://www.ligene.cn/images/blog/Xming.png)
  启动完成后，在任务栏右边会出现一个“X”形状的图标，这表示Xming已经在运行了，将鼠标悬停上去，能看到当前使用的“Display number”使用默认的0.0。

## 2. Linux服务器配置
 修改ssh服务的配置文件：
` $vi /etc/ssh/sshd_config ` 
取消下面一行的注释，如果没有这一行则手动添加： 
X11Forwrding yes 
这样配置的作用就是允许SSH的X转发。

## 3. PuTTY设置
SSH客户端使用PuTTY，PuTTY是freeware+greenware。
PuTTY下载网址：https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html
配置 Session：配置linux服务器IP，连接方式为SSH
Connection > Data：保存连接使用的用户名
Connection > SSH > X11：Enable X11 Forwarding，X display Location 为 "localhost:0"，这里的 0 就是配置 Xming X server 时指定的 Display Number。
保存设置：选Session，Saved sessions输入一个名称，并按右边Save按钮。每次更改PuTTY设置都需要这样保存，下次Load这个Session才是同样的设置。
![putty Setup](https://www.ligene.cn/images/blog/putty.png)
 至此配置完成。
在windows上使用PuTTY连接到Linux服务器，输入xclock &，可以看到X server工作效果了，显示一个时钟图形界面。

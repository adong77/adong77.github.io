---
title: 基于GitHub和Hexo搭建个人博客
date: 2017-06-25 14:39:02
tags: [GitHub, Hexo]
categories: Tutorials
---
第一篇博文，记录此博客的搭建过程。
<!--more-->

1. Git
 sudo apt-get install git -y

2. NodeJS
 curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
 sudo apt-get install nodejs
 
3. Hexo
 sudo npm install hexo-cli -g
 //hexo-cli是hexo的命令行模式, CLI=Command Line Interface, -g 全局安装
 hexo --version #v1.0.4
 
**hexo中所有文件的编码格式均是UTF-8**，不然中文显示会有问题，可以通过Notepad2的File菜单中的Encoding选择UTF-8.



# WSL
 cd /mnt/c/
 hexo init hexoBlog  //其中 hexoBlog 是自己定义的博客根目录名称
 cd hexoBlog/  
**后面安装hexo组件,写博客文章等命令都需要在此目录下进行!**
 
#Hexo组件：
 sudo npm install 
 sudo npm install hexo-deployer-git --save
 //可使用命令hexo d 部署到github上
 sudo npm install hexo-server --save
 sudo npm install hexo-generator-sitemap --save
 sudo npm install hexo-generator-feed --save

# theme
默认安装 landscape主题，你可以安装新主题到themes目录。
```
$ git clone https://github.com/tufu9441/maupassant-hexo.git themes/maupassant
$ npm install hexo-renderer-pug --save
$ npm install hexo-renderer-sass-next --save <!-- $ npm install hexo-renderer-sass --save -->
```
主题的配置参考：https://blog.csdn.net/vosang/article/details/78462021

## 导航栏添加自定义页面

1.命令手动生成自定义页面
``` bash
hexo n page "about"
```
2.编辑`hexo/source/about/index.md`内容
3.修改`themes/maupassant/_config.yml`文件
``` md
menu:
  - page: about
    directory: about/
    icon: fa-user
```
图标用的是awesome font，http://www.fontawesome.com.cn/faicons/，可更换。

> 注意：配置所有的_config.yml文件时（包括theme文件夹中的_config.yml），所有的冒号:后边都要加一个空格，否则执行hexo命令时会报错。
 
# GitHub
 ssh-keygen -t rsa -C "youdng@hotmail.com"
 //登陆GitHub，打开「Settings」->「SSH and GPG keys」，然后点击「new SSH key」，填上任意Title，在Key文本框里粘贴公钥id_rsa.pub文件的内容
 ssh -T git@github.com
 git config --global user.name "adong77"
 git config --global user.email "youdng@hotmail.com"

# 绑定域名
去阿里云买了这个域名www.ligene.cn，我以blog.ligene.cn作为博客的域名。
博客托管在github上的域名是：adong77.github.io，所以建一个CNAME记录，将blog.ligene.cn解析到adong77.github.io。
DNS域名解析最常用的是A记录和CNAME记录，A记录把域名解析到服务器IP，CNAME相当于把一个域名指向另一个域名，因此我这个用的是CNAME，要是托管的服务器也是自己搭的那就用A记录了。
完事之后得等一段时间,使用下面的命令测一下域名的解析:
$ dig blog.sunnyxx.com +nostats +nocomments +nocmd
=> output:
;; global options: +cmd
;blog.ligene.cn.      IN  A
blog.ligene.cn.   600    IN  CNAME   adong77.github.io.
adong77.github.io.  1468    IN  CNAME   github.map.fastly.net.
github.map.fastly.net.  19  IN  A   103.245.222.133
这说明是成功了。

在blog的source目录下建一个CNAME文件，里面写最终指向的域名：blog.ligene.cn。
这样第次更新都会保留CNAME文件。

# 文章中插入图片
把图片与*.md文件放在一起，用这种方式插入图片：
`![](gmail.png)`
如果不想放在同一层级,那么就可以这样插入:
`![](foldername/1.png)` 
表示引用同层级一个叫做"foldername"文件夹中的1.png图片.


# 修改googleapi为sinaapp
由于众所周知的原因，google服务在某地区受阻，导致网页加载较慢。

解决方案：
## googleapi font
在hexo\themes\....\source\css\_base\variable.styl中，注释掉这句：
    //@import url("https://fonts.googleapis.com/css?family=Droid+Serif:400italic,700italic,400,700")  
之后页面会直接加载网站下的：
    http://ibruce.info/css/fonts/fontawesome-webfont.eot  

## google jquery

在hexo\themes\....\layout\_partial\after_footer.ejs(或者index.ejs等)中将
`<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>`
修改为
`<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>`
即可。

作者：王奥(OX)
链接：https://www.zhihu.com/question/24422335/answer/45424856



## 内容发布

### 修改post预设格式

>建议按照个人习惯修改`hexo\scaffolds`中的`post.md`

``` md
title: {{ title }}
date: {{ date }}
comments: true
tags:
categories:
description:
```

### 生成文章

>文章如含有有中文请修改编码为`UTF-8`避免乱码

1.命令生成初始文章，文件名空格会自动加`-`hyphen中横线

``` bash
hexo n "hexo post"
```

2.在`hexo\source\_posts`中编辑生成出来的`hexo-post`文件

``` md
title: hexo post #可以改成中文的，如“新文章”
date: 2015-01-14 21:31:42 #发表日期，可自定义修改排序
categories: blog #文章文类
tags: [博客,文章] #文章标签，可以加入多标签
---
#这里是正文，用Markdown书写
```

3.本地预览文章内容，登录`localhost:4000`查看效果
``` bash
hexo s
```

4.发布内容到`public`文件夹，然后同步到GitHub
``` bash
hexo clean
hexo g
hexo d
```


### source文件夹
存放用户资源的地方。
1. _posts 文件夹
存放博客文章的地方，其中的markdown文件、html文件、org文件等会被解析并放到 public文件夹，发布到站点。
2. 其他开头命名为 _ (下划线)的文件或文件夹
将会被忽略。因此可以在source目录下创建 _drafts 目录用于存放未完成的草稿，其中内容不会发布到网站。
3. 其他开头非_的文件或文件夹
会被拷贝到public目录并上传到站点。
    * 可以创建 img 目录来存放在博客引用到的图片等。
    * 要添加新的页面（例如about），执行 hexo new page PageName 命令即会在 source 中自动新建子目录 PageName 。
    * favicon.ico 在主题配置文件中引用 /favicon.ico 来设置站点的页面图标。


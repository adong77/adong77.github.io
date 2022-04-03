---
title: findNum
comments: true
date: 2021-02-25 14:46:34
tags:
categories: Programming
---
为了解决一道小学三年级的数学题，比较笨的我只能写个小程序，还好大学时学生C语言！
<!--more-->
题目：在方框（---）里填上1-7（每个数字只用一次），使竖式成立。

```c
/***每个方框的数字分别用一个字母代替：
    -e- -c- -b-
x           -a-
---------------
-g- -f- -d-  8
**************************/
#include <iostream>
using namespace std;
 
void findNum()
{
	for(int a=1; a<=7; a++)
	{
		for(int b=1; b<=7; b++)
		{
			if(a!=b)
			{
                int product1 = a * b;  //个位数
                int remainder1 = product1 % 10;
                int division1 = product1 / 10;
                if(remainder1 == 8){
                    for(int c=1;c<=7;c++)
                    {
                        if(c!=a && c!=b)
                        {
                            int product2= c * a + division1;  //十位数
                            int division2 = product2 / 10;
                            int d = product2 % 10;
                            if(d!=a && d!=b && d!=c && d>0 && d<=7)
                            {
                                for (int e=1;e<=7;e++)
                                {
                                    if(e!=a && e!=b &&e!=c &&e!=d)
                                    {
                                        int product3= e * a + division2;  //百位数
                                        int division3 = product3 / 10;
                                        int g = division3;
                                        int f = product3 % 10;
                                        if((f!=a &&f!=b &&f!=c &&f!=d &&f!=e &&f!=g && f <= 7 && f > 0)&&(g!=a &&g!=b &&g!=c &&g!=d &&g!=e && g <=7 && g > 0))
                                        {
                                            cout<<"e:"<<e<<" c:"<<c<<" b:"<<b<<endl<<"x    a:"<<a<<endl<<"g:"<<g<<" f:"<<f<<" d:"<<d<<endl;   
                                        }
                                    }
                                }
                            }
                        }	
                    }
                }
            }
        }
    }
}
 
int main()
{
	findNum();
    return (0);
}
```

正确答案：
e:4 c:5 b:3
x    a:6
g:2 f:7 d:1

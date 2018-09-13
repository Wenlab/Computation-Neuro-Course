Matlab是一个非常成熟的商业软件，它的帮助文档非常详细（见下面help的使用），它官网上的教程也非常好。
所以建议直接看官网的这个快速入门教程：https://ww2.mathworks.cn/help/matlab/getting-started-with-matlab.html

这个入门教程也可以看看：
http://read.pudn.com/downloads156/ebook/691210/matlab%E5%85%A5%E9%97%A8%E6%95%99%E7%A8%8B.pdf

以下是我讲解时用的提示：

------------

matlab可以当作脚本语言，但也可以编写函数（结构化编程）。(script: the dialogue and stage directions for a theatrical production)
脚本可以写在.m文件中，直接调用，就不用每次都重新写命令了。

matlab主要针对矩阵运算（对矩阵运算有很多很强大的优化加速，比如矩阵乘法，矩阵分解，特征值，稀疏矩阵运算，等等），但也支持很多其他类型的数学运算，
但是不适合用来开发大型软件，主要还是适用于科研工作中的科学计算。

matlab不需要定义变量，所有变量均存成 double 的形式。（演示）

matlab中最重要的概念是 向量vector 和 矩阵matrix。（演示）

索引（尽量不用for、while等循环，而使用索引，因为循环是顺序执行，没有任何优化，而使用索引是矩阵运算，Matlab又很多专门的优化，在运算量大的时候速度差别很大）（冒号格式也可以生成非整数向量：[1.1:0.2:2.3]）（删除元素或某几行或某几列）

matlab有丰富的绘图函数。plot, surf, mesh, scatter, ...

控制流：if, switch, while, for, etc.

comment % 可以用%来表示注释，%后面的内容（当前行）作为注释，不起作用。
我们经常用%来临时注释掉一些语句，想要它执行的时候可以很方便地恢复（只要去掉%即可）。

help：help是使用Matlab最重要的一个功能，有不会用的函数，基本只需要help就可以解决，很少需要看教材或者上搜索引擎。
help用来查询已知命令的用法。例如已知 inv 是用来计算反矩阵，键入 help inv 即可得知有关 inv 命令的用法。
（键入 help help 则显示 help 的用法，请试看看！） 
doc inv，可以获得更详细的关于inv的帮助文档。
lookfor：用来寻找未知的命令。例如要寻找计算反矩阵的命令，可键入 lookfor inverse，MATLAB 即会列出所有和关键字 inverse 相关的指令。
找到所需的命令後 ，即可用 help 进一步找出其用法。（lookfor 事实上是对所有在搜寻路径下的 M 档案进行关键字对第一注解行的比对）

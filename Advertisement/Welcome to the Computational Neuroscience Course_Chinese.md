# About the Course

当你在高中第一次学到动作电位和静息电位时，你是否想过，这两个东西可以用一组数学公式来精准预测？

当你在大一第一次学到ASCII和Unicode时，你是否思考过，人脑是如何编码信息的？

当你听闻[AlphaGo击败李世石](https://zh.wikipedia.org/zh-cn/AlphaGo%E6%9D%8E%E4%B8%96%E4%B9%AD%E4%BA%94%E7%95%AA%E6%A3%8B)、[DAllE·2补笔蒙娜丽莎](https://www.google.com/search?q=DAllE%C2%B72+Mona+Lisa&tbm=isch&ved=2ahUKEwiGi62_u8SAAxWGgFYBHbc8DAIQ2-cCegQIABAA&oq=DAllE%C2%B72+Mona+Lisa&gs_lcp=CgNpbWcQA1AAWABgowloAHAAeACAAe0BiAHtAZIBAzItMZgBAKoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=9bLNZMa8AYaB2roPt_mwEA&bih=728&biw=1366)、[ChatGPT助攻陶哲轩](https://www.google.com/search?q=ChatGPT+Terence+Tao&bih=728&biw=1366&hl=en&sxsrf=AB5stBgaCRV6K0D-lgxLa8guKRWzS4wR8A%3A1691202498420&ei=wrPNZPmSGeeV2roPzaeMmA8&ved=0ahUKEwj5-6ShvMSAAxXnilYBHc0TA_MQ4dUDCA8&uact=5&oq=ChatGPT+Terence+Tao&gs_lp=Egxnd3Mtd2l6LXNlcnAiE0NoYXRHUFQgVGVyZW5jZSBUYW9I2CBQAFj5HnAAeACQAQCYAQCgAQCqAQC4AQPIAQD4AQL4AQHiAwQYACBBiAYB&sclient=gws-wiz-serp)时，你是否思考过，生物神经网络和人工神经网络的异同？

你听说过中心极限定理，但该定理如何蕴含一个生物神经网络中幽灵般的矛盾？

你听说过贝叶斯公式，但该公式如何应用于神经系统的解码？

你听说过Yann LeCun，但他的LeNet和Hubel, Wiesel的诺贝尔奖有何关系？

你听说过Geoffrey Hinton，他曾说没能研究SNN是他职业生涯中最大的遗憾之一。那么如何模拟一个SNN？

你听说过Claude Shannon，但他的信息论如何应用于神经科学？

你听说过一句话——“眼睛是心灵的窗户”。但当你凝视着他/她的眼眸时，你是否真的相信，透过他/她的眼睛可以看到对方的灵魂？

---

当你学完这门课，你会知道前面八个问题的答案，而对第九个问题，你会有更深刻的理解。

如果你选择继续往下看，我们就是朋友了。

---

课程目标：让学生初步了解理论神经科学/计算神经科学。

时间：1-18周，1(3,4)

地点：2402

授课教师：温泉

学分：2

---

课程简介：

首先，我们将以一个有趣的数学问题作为序幕。随后，我们将先从单神经元开始，逐渐过渡到多神经元。这是一种物理人非常喜欢的从简单到复杂的方式。    

Part 0, Part 1, Part 2, Part 3所占上课次数约为2、6、6、4。

---

作业与考试：

一共5次作业左右，题目分两种，推公式或写代码。

**这门课的期末考试的形式是最后一次作业，完全开卷，和普通作业是一样的。**

---

编程作业：

语言推荐MATLAB or Python or Julia。

曾经，这门课的编程作业让很多来自数院、物院的学生痛苦，但是现在，时代变了！**强烈推荐使用GPT, Copilot, Gemini, LLAMA, Claude等Large Language Model**，本课涉及的这些小代码对ta们而言完全信手拈来。只要你理解了某个作业的逻辑，编程就不会成为你的限制，就算你现在只会`print("Hello World!")`，你也能在几天之内写完任何一个编程作业，在ta们的助攻下。（PS：如果你想在学计算神经科学之余顺便提升自己的编程能力，比如优雅命名、贴心注释、模块化编程、向量化编程、结构化编程，也可以多和ta们聊聊天）

---

前置课程：微积分、线性代数、概率论与数理统计

---

[GitHub repository of this course](https://github.com/Wenlab/Computation-Neuro-Course):

切换branch来查看不同学期的课程！ 

每个秋季学期，我们都会创建一个新branch，该branch中含有那个学期的所有材料，包括讲义、幻灯片、作业、教材、推荐论文等。

---

一些说明：

本课的难度不在于深度而在于广度。比如说，物院出身的学生要学很多统计的知识。

本课需要你有极强的获取信息的能力。比如说，某些其它学科的概念，某些难度极大的作业题，某本书或者某篇论文或者某个Wikipedia page里已经有答案，你可以去找到它，而不是重复造轮子。



## Part 0 Neuromorphology

这部分我们研究的问题是——神经元为什么要有轴突、树突、树突棘？

我们提供了一种理论解释：如果要求所有神经元两两之间必须通信，那么拥有这三种结构的神经元会让大脑的总体积为最小。

<img src = "D:\Public_repository\Computation-Neuro-Course\Advertisement/figures/4_designs.png" width=70% align="center">

<center>Figure adapted from <a href="https://www.cell.com/fulltext/S0896-6273(04)00498-2"> Chklovskii, 2004 </a></center>

## Part 1 Single Neuron

Reference: [Biological Neuron Model on Wikipedia](https://en.wikipedia.org/wiki/Biological_neuron_model)



从这里，我们进入课程的正题。

单神经元的研究十分透彻，因此Part 1有一条清晰的主线。最后我们得到的model是一个**biological plausible model**，这是一件非常难得的事情。

我们首先介绍Nernst Equation，Walther Nernst部分因此获1920年诺贝尔化学奖。

随后介绍integrate-and-fire model，历史上第一个理论神经科学的模型，由Louis Lapicque和夫人Marcelle Lapicque于1907年提出。

最后介绍Hodgkin-Huxley model，Alan Hodgkin和Andrew Huxley因此获1963年诺贝尔生理学或医学奖。

<img src = "D:\Public_repository\Computation-Neuro-Course\Advertisement/figures/HH_model.png" width=50% align="center">

<center>Electrical circuit diagram of HH model, figure from the Internet</center>

## Part 2 From Single Neuron to Multi Neurons

Reference: CH1-CH4 of *Theoretical Neuroscience*



在这个广告里我们只介绍两个概念——encoding和decoding。

### Encoding

编码是从刺激s到动作电位频率r的过程。

传统的神经科学认为神经元采用简单（Gauss or Sigmoid or cos）的$r=r(s)$来编码信息。下图是猫的V1区的神经元对不同朝向的矩形的电生理记录。(David Hubel和Torsten Wiesel因此获1981年诺贝尔生理学或医学奖) 

<img src = "D:\Public_repository\Computation-Neuro-Course\Advertisement/figures/encode_cat.png" width=70% align="center">

<center><i>Theoretical Neuroscience</i>, figure 1.5</center>

### Decoding

解码是从动作电位频率r到刺激s的过程。

神经科学家认为可以采用贝叶斯公式$P(s|r) = \frac{P(r|s)P(s)}{P(r)}$去从神经活动中解码信息，下图是猴子的MT区的神经元的解码结果。在这个实验中，神经活动解码的结果和行为学结果十分类似。

<img src = "D:\Public_repository\Computation-Neuro-Course\Advertisement/figures/decode_monkey.png" width=30% align="center">

<center><i>Theoretical Neuroscience</i>, figure 3.2</center>

在神经科学研究中，行为学数据指记录动物的行为（比如，你在训练你的宠物狗学会捡回你扔出的飞盘），神经活动数据指用电生理、钙成像、fMRI等手段直接或间接地记录神经元是否发放动作电位（比如，Wilder Penfield，神经科学家兼技术精湛的医生，在给癫痫病人做手术时在征得病人同意的前提下顺手记录了很多电生理数据）。**更进一步地，你可以认为大脑是一个黑箱，刺激是输入，行为学是输出，而记录神经活动是人类对打开黑箱所做的努力**。过去，很多时候，神经活动数据难以得到，只有行为学数据可供分析。现在，随着技术的发展，神经活动的数据越来越多了。

**在体 (in vivo) 的神经活动全都是随机过程 (stochastic process)，而不是确定过程 (deterministic process)。**这就是为什么从Part 2开始会涉及很多统计学知识，也是为什么神经科学非常需要统计。



## Part 3 Multi Neurons

Reference: [Deep Learning of 3Blue1Brown](https://www.youtube.com/watch?v=aircAruvnKk&list=PLZHQObOWTQDNU6R1_67000Dx_ZCJB-3pi)



最后，我们终于来到了多神经元部分。

在Part 2中，我们用一整条曲线$r=r(s)$或$r=r(t)$来表征一个神经元。但在Part 3中，我们只用一个实数$r$来表征一个神经元。这个简化是否过度，存在争议。无论如何，我们在Part 3中的多数时候采用这个简化。

我们会依次介绍前馈神经网络 (feedforward neural network)和循环神经网络 (recurrent neural network)。这是两个最基础的神经网络。

<img src = "D:\Public_repository\Computation-Neuro-Course\Advertisement/figures/neural_network.png" width=70% align="center">

<center>Figure adapted from the Internet</center>

最后，我们会跳出这个简化，介绍一些spiking neural network的内容。



在Part 1，你会感觉到有一条清晰的主线，从Nernst equation，到integrate-and-fire model，再到Hodgkin-Huxley model。但是在Part 2和Part 3，你会感觉课程的主线不再那么清晰。这是因为，每一个学过HH model的人都知道单神经元是如何工作的，但是世界上没有任何一个人知道**生物神经网络（注意不是人工神经网络）**是如何工作的，**没有任何一个人知道它到底如何实现学习、记忆，没有任何一个人知道它到底为什么高效且通用，也没有任何一个人知道它到底为什么需要睡眠**。同时，Part 2和Part 3的部分内容存在争议，不同学者有不同的看法。这给后辈们留下了扬名立万的机会，也许你就是神经网络领域的Alan Hodgkin和Andrew Huxley，到时候这门课的Part 2和Part 3就会很清晰了。随着电生理（Neuropixel）和钙成像（whole brain imaging）的发展，这个目标并非遥不可及。



注：这门课**不会**讲LSTM, Transformer, Diffusion, Mamba等最近大火的深度学习模型。我们在实验室里倒是经常讨论这些，因为我们的长期目标之一是准确追踪小型动物（线虫、果蝇、斑马鱼）的神经元，由于神经元会形变，这是一个难度极高的计算机视觉任务。虽然难，但是成果实在太过诱人。为有牺牲多壮志，敢教日月换新天。



# Homework Paragon

Here are some homework paragons in the previous seasons. However, each season Prof. Quan will assign some brand new homework...

* Visualization of the Beautiful Purkinje. 
  * Purkinje has the largest convergence in the human brain~
  * You will then be asked to do some analysis based on this graph.

<img src = "D:\Public_repository\Computation-Neuro-Course\Advertisement/figures/Purkinje.png" width=70% align="center">

* Visualization of the Connectome of C.elegans. 
  * Below is just a sketch map, each dot is a neuron and each line is a synapse.
  * You will then be asked to do some analysis based on this graph.

<img src = "D:\Public_repository\Computation-Neuro-Course\Advertisement/figures/connectome.png" width=50% align="center">

* Simulation of the HH model.
  * Below is a **limit cycle** of V and n.
  * You will be asked to do many many analysis on this problem.

<img src = "D:\Public_repository\Computation-Neuro-Course\Advertisement/figures/limit_cycle.png" width=70% align="center">

* Ring network.
  * The story of the ring network is a legend: it is firstly raised in theory [(Ben-Yishai, 1995)](https://www.pnas.org/doi/abs/10.1073/pnas.92.9.3844) [(Kechen Zhang, 1996)](https://www.jneurosci.org/content/16/6/2112.short), and then is proofed in experiment [(Kim, 2017)](https://www.science.org/doi/full/10.1126/science.aal4835?casa_token=JgEd3PXJsR4AAAAA%3AhAguf7nUMPOera0f3QGoVIKNlNNdmDliPxwbJ-ocO7Mmge7xd8YHrpvpiaIOxC_yevB6F4CwnpwcvkM).
  * You will be asked to reproduce some of the theory work.

<img src = "D:\Public_repository\Computation-Neuro-Course\Advertisement/figures/ring_network.png" width=70% align="center">

<center>Figure from <a href="https://www.frontiersin.org/articles/10.3389/fncom.2019.00096/full">Caixia Wang, 2020</a></center>

* Hopfield network.
  * You will be asked to use the Hopfield network to realize "memory", like the graph below.
  * You can also try to use this to solve the Travelling Salesman Problem, if you like.

<img src = "D:\Public_repository\Computation-Neuro-Course\Advertisement/figures/Hopfield.png" width=70% align="center">

<center>Figure from Rong Wei, a student of 2022FA class</center>

<img src = "D:\Public_repository\Computation-Neuro-Course\Advertisement/figures/Hopfield_SEM.png" width=70% align="center" style="zoom:25%;"   >

<center>Error-bar stands for SEM</center>

* SNN
  * You will be asked to simulated a SNN

<img src = "D:\Public_repository\Computation-Neuro-Course\Advertisement/figures/SNN_sync.png" width=70% align="center">

<center>An example of syncronized SNN</center>

<img src = "D:\Public_repository\Computation-Neuro-Course\Advertisement/figures/SNN_unsync.png" width=70% align="center">

<center>An example of unsyncronized SNN</center>

# Recommend Reading

## Strongly Recommend

***Theoretical Neuroscience***: Peter Dayan和L. F. Abbott合写的经典教科书。看这本书会节省你的时间。

***Models of the Mind***: 一本科普读物，2021年出版，讲述了神经科学的发展背后的小故事。譬如：Shannon发表了他的论文后，最开始在生物领域激起波澜，而非计算机领域；HH和Rall的故事；Hubel-Wiesel到LeCun再重回视觉研究；神经科学如何从AI领域借鉴RL；最新的三个学说：自由能、千脑智能、IIT。你可以和下面这本1988年的科普读物合在一起看，看看神经科学在30年间有何进展。

***What Mad Pursuit***: Francis Crick于1988年所写的自传，中译名为《狂热的追求》。这本书很薄，若无语言障碍，几小时就能读完。前面讲了他上大学前、研究物理、参加二战、研究分子生物学的故事（DNA双螺旋的发现、遗传密码的发现、mRNA的发现、tRNA的发现均和Crick有关），最后一章讲了他转行神经生物学之后的故事。他和Alan Hodgkin, Andrew Huxley, David Marr, Terry Sejnowski皆好友。Crick把分子生物学和神经生物学的研究现状进行了一番对比后，写出了自己对于理论神经科学领域的批评，值得我们深思。

> For example, we can see how a neural net can store a “memory” of various firing patterns of its “neurons” and how any small part of one of the patterns (the cue) can recall the entire pattern. Also how such a system can be taught by experience to learn tacit rules (just as a child first learns the rules of English grammar tacitly, without being able to state them explicitly)
>
> ...
>
> They are existence proofs that units somewhat like neurons can indeed do surprising things, but there is hardly anything to suggest that the brain actually performs in exactly the way they suggest. 

Crick把物理学追求简洁、普适以及从简到繁的思想用于分子生物学和神经生物学（比如，[他本人对中心法则的解释](https://www.nature.com/articles/227561a0)的清晰程度远超任何教科书），同时，他本人也做过不少生物实验，重视生物学的实验细节，明白构建模型时哪些是可以舍弃的，哪些是必须保留的，而这恰恰是很多理论神经科学的学者所欠缺的。

Crick是一个风流倜傥又狂放不羁的人——和James Watson抛硬币决定DNA双螺旋创始文的一作二作；给手下写信：现在世界上只有我们两个人知道遗传密码是三联的；扬言要创立”分子心理学“（虽然这次豪言变笑谈了）。



## When You Get a Chance

***Dynamical System in Neuroscience***: 一本讲动力系统在神经科学中的应用的书。CH4讲了2D动力系统的相关概念：fixed point, limit cycle, bifurcation。

**《常微分方程》，丁同仁、李承治**：CH8简介了动力系统。

***Introduction to Probability Models***: Ross所写的随机过程经典教材。本课程会涉及泊松过程、马尔可夫过程、平稳过程，此书当然都有。

**《机器学习》 ，周志华**：一本深入浅出地介绍机器学习的书。CH5介绍了深度学习。CH10介绍了降维，Principle Component Analysis, Multi Dimensional Scaling等降维方法在神经科学乃至整个生物学里都很常用。

***Dive Into Deep Learning***: 一本深入浅出地介绍深度学习的书。

***Principles of Neural Design***: 一本讲神经系统被设计成这样的优点的书。CH1和CH2，作者本课一样采用了bottom-up的方法，从大肠杆菌（你没有看错，大肠杆菌虽然是原核生物，虽然没有神经元，但是它也能实现记忆），到草履虫，再到线虫。这本书的文风非常俏皮，和Crick, Ross的一样。

***Vision***: David Marr (1945-1980) 的遗世之作。这本书里，Marr首先提出了他认为理论神经科学研究应该有的三个层次（计算理论、算法、硬件实现），随后提出了一种可以实现人类视觉的算法（image->Primal sketch->2.5D sketch->3D representation）。这本书的最后一章是以Francis Crick为首的科学家对Marr的方法提出质疑和批评，而Marr一个一个回答这些问题，捍卫自己的方法。此书中文版于2022年出版，朱松纯、汤晓鸥、李飞飞为中文版作序，他们像我们一样大时都读过这书。1979年，身患白血病的David Marr知道自己已经时日无多，他选择去The Salk Institute和Francis Crick会面，回来后就专心写这本书。1980，Marr去世。1982，此书出版。日后Marr因为他的工作以及这本书被视为计算机视觉的创始人之一。这本书有些《九阴真经》、《武穆遗书》的味道，不过得到它不需要华山论剑，也不需要倚天屠龙，科大图书馆就有这书，只不过东西图各只有一本罢了。

***Principles of Neurobiology***: 骆利群所写教材，生物学有关的看这本和维基百科就够了。



# What Can You Benefit from This Course?

神经科学诞生于20世纪初，Camillo Golgi和Santiago Ramon y Cajal做了第一个实验方面的研究，Louis Lapicque和夫人Marcelle Lapicque做了第一个理论方面的研究。

从诞生到现在，它一直是世界上最交叉的学科之一，它的研究者们来自数院、物院、统计、生院、AI、工程、心理学，几乎无所不包。我们实验室曾有过数院、物院、统计、生院、CS/EE/AI、化院的学生。各个背景的学生也都可以在这门课中受益。

一句话，我们欢迎各个背景的学生！



如果你来自数院，你可以从这里学到一些动力系统在神经科学上的应用。目前，做神经科学+动力系统的学者大多是数学出身，比如: Steven H. Strogatz, Eugene Izhikevich。



如果你来自物院，你可以了解物理学的思想是如何应用于神经科学中的。从上世纪直到今天，从物理转行做神经的学者都非常之多，本门课中出场的就有: Alan Hodgkin, Andrew Huxley, Francis Crick, J. J. Hopfield, Terry Sejnowski, L. F. Abbott, Haim Sompolinsky, Mu-ming Poo。



如果你来自统计，你可以从这里学到随机过程、贝叶斯推断在神经科学上的应用。除此之外，Part 2涉及的许多数学工具，来自R. A. Fisher, C. R. Rao, George Box, David Cox。随着神经科学的数据越来越多，从统计转做神经的学者也不少。



如果你来自生院，你会发现这门课和之前所学的生物课完全不一样。你最担心的可能是自己的数学水平不够，但是，如果只是理解这门课的大概思路，会微积分、线代、概统这三门课的确就足够了。如果你日后想做理论方面的工作，那确实需要更进一步学习。不要认为生物本科就不能做理论，永远不要限制自己，有一位生物学和心理学本科后来做理论的世界一流科学家：Geoffrey Hinton。



如果你来自大数据/人工智能，你可以从这里学到搞机器学习的人和搞计算神经的人眼里的神经网络有何不同。这门课涉及的数学的难度和机器学习相仿，Part 2和Part 3的很多数学工具和机器学习用到的一模一样（比如：KL divergence, Shannon information, Max Likelihood Estimation, Receiver Operator Characteristic curve, hidden variable)。如果你已经学过机器学习和深度学习，那在Part 2和Part 3你会感觉很轻松。历史上的AI领域的诸人，Alan Turing, Marvin Minsky, David Marr, Geoffrey Hinton, 都对生物神经网络极其感兴趣，那时AI和理论神经科学几乎是同义词。虽然最近二三十年AI和计算神经主要在各自独立发展，但两个领域还是存在一些相互借鉴（更多是我们借鉴你们）。你们的VAE, ResNet, NeuroODE，都给了神经科学一些新的启发。放眼未来，很多学者都认为，实现通用人工智能还是要从生物神经网络中寻找答案。



# About Us

[Home Page of Wen Lab](http://www.wenlab.org/)

[Journal Club Website of Wen Lab](https://cneuroustc.github.io/)

[GitHub Page of Wen Lab](https://github.com/Wenlab)



# Last Word

End with Francis Crick's word:

>The brain sciences have still a very long way to go, but the fascination of the subject and the importance of the answers will inevitably carry it forward.
>
>It is essential to understand our brains in some detail if we are to assess correctly our place in this vast and complicated universe we see all around us.

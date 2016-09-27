%% 基于论文Bilateral Texture Filtering的实现代码说明文档
%% 总共有6个m文件，其中4个写成函数形式，1个是demo,1个是readme。
% 1,函数BTextureF.m是论文代码的核心函数，利用的是mRTV;
% 2,函数BTextureF_deta.m用的是deta，与mRTV的方法进行对比。
% 3，函数two_BTextureF.m提供了一种选择：输入是彩色图像或者灰度图像将分别进行不同的操作。
% 4，函数jbfilter2.m是根据论文对bfiter2.m的一种改进，见论文的公式（2）。
% 5，实际调用见demo_BTextureF.m
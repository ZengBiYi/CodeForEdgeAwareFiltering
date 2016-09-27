% ------------------------------------------------
% SLIC Superpixel (VLFeat Library Implementation)
% SLIC superpixels compared to state-of-the-art superpixel methods_TPAMI12
% ------------------------------------------------

% 清理
clc; close all;
clear all;

% 添加额外函数的路径
run('D:\MyFile\师兄的\WXB-2014-RRT\WXB-2014-RRT\ICDH2014\ICDH2014\Code\Library\VLFeat\toolbox\vl_setup');
% run('E:\Research\Library\VLFeat\toolbox\vl_setup');
% addpath('..\..\Filter\OPT_WLS_Filter',0);
% addpath('..\..\Library',0);

%% 参数设置
% 文件路径
filepath = 'D:\MyFile\Paper\sigraph\fig_library\应用之超像素分割\';

% 输出路径
outputpath = 'D:\MyFile\Paper\sigraph\fig_library\应用之超像素分割\';

% 文件名称
filename = 'barbara_512_color';
fmt = '.png';

% 读取图像
img = double(imread([filepath, filename, fmt]))./255;
% 显示输入图像
figure, imshow(img),title('Input');

% SLIC Param.
regionSize = 30;
regularizer = 0.5;

% WLS滤波参数
lambda = 1.5;
alpha = 1.8;  



% 使用加权最小二乘滤波进行处理
sigma_s = 3;sigma_r = 0.05;
Fltimg = Rolling_LLF(img,sigma_s,sigma_r,2);

% 显示滤波后的结果图像
figure, imshow(Fltimg),title('Filtering');

im = im2single(img);
Fltim = im2single(Fltimg);

%% Create various SLIC segmentations
segments = vl_slic(Fltim, regionSize, regularizer, 'verbose');

% overaly segmentation
[sx,sy] = vl_grad(double(segments), 'type', 'forward');
s = find(sx | sy);
outimg = im;
outimg([s s+numel(im(:,:,1)) s+2*numel(im(:,:,1))]) = 0;

figure, imshow(outimg), title('SLIC Result'); 
outname = [outputpath, filename, '_SLIC_WLS.png'];
imwrite(outimg,[outputpath,filename,'_superpixel_RGLLF.png']) % 保存处理结果 % 保存处理结果
% axis image off; hold on;
% text(5,5,sprintf('regionSize:%.2g\nregularizer:%.2g', regionSize, regularizer), ...
%     'Background', 'white','VerticalAlignment','top')
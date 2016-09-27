clear all;close all
% 文件路径
filepath = 'D:\MyFile\Paper\sigraph\fig_library\应用之细节增强\';

% 输出路径
outputpath = 'D:\MyFile\Paper\sigraph\fig_library\应用之细节增强\';

% 文件名称
filename = 'detail_enhancement_e1';
fmt = '.png';

% 读取图像
img = double(imread([filepath, filename, fmt]))./255;
% img = rgb2gray(img);


sigma_s = 3;sigma_r = 0.05;
sigma = [sigma_s sigma_r];
tic;
outimg = Rolling_LLF(img,sigma_s,sigma_r,2);
% figure,imshow(O,'Border','tight');
toc;


% 细节提升因子
DE_factor = 2;
detail = img - outimg;
outimg1 = detail * DE_factor + img;
figure,imshow(outimg,'Border','tight');
figure,imshow(outimg1,'Border','tight');
% imwrite(outimg,[outputpath,filename,'_RollLLF.png'])
imwrite(outimg1,[outputpath,filename,'_enhanceRGLLF.png'])


%% Bilateral Filter
% BF = bfilter2(img, sigma_s, sigma_r);
% outimg_BF = detail * DE_factor + BF;
% figure,imshow(outimg_BF,'Border','tight');
% imwrite(outimg_BF,[outputpath,filename,'_enhanceBF.png'])


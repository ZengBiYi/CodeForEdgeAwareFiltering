% ------------------------------------------------
% SLIC Superpixel (VLFeat Library Implementation)
% SLIC superpixels compared to state-of-the-art superpixel methods_TPAMI12
% ------------------------------------------------

% ����
clc; close all;
clear all;

% ��Ӷ��⺯����·��
run('D:\MyFile\ʦ�ֵ�\WXB-2014-RRT\WXB-2014-RRT\ICDH2014\ICDH2014\Code\Library\VLFeat\toolbox\vl_setup');
% run('E:\Research\Library\VLFeat\toolbox\vl_setup');
% addpath('..\..\Filter\OPT_WLS_Filter',0);
% addpath('..\..\Library',0);

%% ��������
% �ļ�·��
filepath = 'D:\MyFile\Paper\sigraph\fig_library\Ӧ��֮�����طָ�\';

% ���·��
outputpath = 'D:\MyFile\Paper\sigraph\fig_library\Ӧ��֮�����طָ�\';

% �ļ�����
filename = 'barbara_512_color';
fmt = '.png';

% ��ȡͼ��
img = double(imread([filepath, filename, fmt]))./255;
% ��ʾ����ͼ��
figure, imshow(img),title('Input');

% SLIC Param.
regionSize = 30;
regularizer = 0.5;

% WLS�˲�����
lambda = 1.5;
alpha = 1.8;  



% ʹ�ü�Ȩ��С�����˲����д���
sigma_s = 3;sigma_r = 0.05;
Fltimg = Rolling_LLF(img,sigma_s,sigma_r,2);

% ��ʾ�˲���Ľ��ͼ��
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
imwrite(outimg,[outputpath,filename,'_superpixel_RGLLF.png']) % ���洦���� % ���洦����
% axis image off; hold on;
% text(5,5,sprintf('regionSize:%.2g\nregularizer:%.2g', regionSize, regularizer), ...
%     'Background', 'white','VerticalAlignment','top')
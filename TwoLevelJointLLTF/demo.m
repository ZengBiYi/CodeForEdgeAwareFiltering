%%%%%%%%%%%%%%%%%%%%%
%% Two-level joint local laplacian texture filtering 2015

%% import image
clear all;close all
% �ļ�·��
filepath = 'D:\MyFile\Paper\TMM-draft-template_Ӣ�İ�\fig_library\���ӻ�����֮ͼ1\';

% ���·��
outputpath = 'D:\MyFile\Paper\TMM-draft-template_Ӣ�İ�\fig_library\���ӻ�����֮ͼ1\';

% �ļ�����
filename = 'fishmosaic';
fmt = '.png';

% ��ȡͼ��
img = double(imread([filepath, filename, fmt]))./255;
figure(1),imshow(img),title('input')
w = 5;sigma_s = 5; sigma_r = 0.05;
iter = 5;
M = RollingGuidanceFilter(img,sigma_s,sigma_r,2);
figure(2),imshow(M),title('Guidance')
for i = 1:iter
    J = TwoJointLLF(img,M,w,sigma_s,sigma_r);
    img = J;
end
figure(3),imshow(J), title('output')
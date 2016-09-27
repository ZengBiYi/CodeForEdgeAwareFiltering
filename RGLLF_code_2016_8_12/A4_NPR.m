% ����
clc; close all;
clear all;

% ���֧�ֺ�����
addpath('..\..\Filter\LTV_BGF',0);
addpath('..\..\Library',0);

%% import image

% �ļ�·��
filepath = 'D:\MyFile\Paper\sigraph\fig_library\Ӧ��֮����ʵ�л���\';

% ���·��
outputpath = 'D:\MyFile\Paper\sigraph\fig_library\Ӧ��֮����ʵ�л���\';

% �ļ�����
filename = 'abstract_d1';
fmt = '.png';

% ��ȡͼ��
img = double(imread([filepath, filename, fmt]))./255;
% img = rgb2gray(img);
% ��ʾ����ͼ��
figure, imshow(img), title('Input');
% Param.
% ��˹�˲�����
st_radius = 30;
% st_sigma = 1.5;
st_sigma = 1;

% ˫�������˲�����
% sigmaSpatial = 5;    
sigmaSpatial = 5;
% sigmaRange = 0.05;  
sigmaRange = 0.06;

% ��������
maxIter = 2; 

% Set image abstraction paramters.
max_gradient      = 0.1;    % maximum gradient (for edges)
sharpness_levels  = [3 14]; % soft quantization sharpness
quant_levels      = 255;      % number of quantization levels
min_edge_strength = 0.1;    % minimum gradient (for edges)




        
% RGLLF
sigma_s = 3;sigma_r = 0.02;
F_outimg = Rolling_LLF(img,sigma_s,sigma_r,2);

figure,imshow(F_outimg),title('L0GM Filtering');
imwrite(F_outimg,'filter.png');
% Convert sRGB image to CIELab color space.
if exist('applycform','file')
   F_outimg = applycform(F_outimg,makecform('srgb2lab'));
else
   F_outimg = colorspace('Lab<-RGB',F_outimg);
end

% Determine gradient magnitude of luminance.
[GX,GY] = gradient(F_outimg(:,:,1)/100);
G = sqrt(GX.^2+GY.^2);
G(G>max_gradient) = max_gradient;
G = G/max_gradient;

% Create a simple edge map using the gradient magnitudes.
E = G; 
E(E<min_edge_strength) = 0;

% Determine per-pixel "sharpening" parameter.
S = diff(sharpness_levels)*G+sharpness_levels(1);

% Apply soft luminance quantization.
qB = F_outimg; dq = 100/(quant_levels-1);
qB(:,:,1) = (1/dq)*qB(:,:,1);
qB(:,:,1) = dq*round(qB(:,:,1));
qB(:,:,1) = qB(:,:,1)+(dq/2)*tanh(S.*(F_outimg(:,:,1)-qB(:,:,1)));

% Transform back to sRGB color space.
if exist('applycform','file')
   Q = applycform(qB,makecform('lab2srgb'));
else
   Q = colorspace('RGB<-Lab',qB);
end

% Add gradient edges to quantized bilaterally-filtered image.
outimg = repmat(1-E,[1 1 3]).*Q;

% ��ʾ���ͼ��
figure,imshow(outimg),title('Cartoon Output');
% figure,imshow(outimg),title('���ͼ���α�ʱ�ʾ'), colormap(Jet);
% outname = [outputpath,filename,'_Cartoon_LTV_BGF.bmp'];
imwrite(outimg,[outputpath,filename,'_NPR_RGLLF.png']) % ���洦����

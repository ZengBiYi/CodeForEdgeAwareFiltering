%Bilateral Texture Filtering 
I = double(imread('F:\����\new work\pictures\Texture data collection\Bilateral Texture Filtering-78.jpg'))/255;
figure,imshow(I);
hold on
title('I');
iter = 1;w = 5;sigma = [4 0.05];
% I = rgb2gray(I);save gray_I I;%���Ҫ����Ҷ�ͼ��
two_BTextureF(I,w,sigma,iter);


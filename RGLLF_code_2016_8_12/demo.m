clear all;close all

% 文件路径
filepath = 'D:\MyFile\Paper\sigraph\fig_library\fig3分析之sigma\';

% 输出路径
outputpath = 'D:\MyFile\Paper\sigraph\fig_library\fig3分析之sigma\';

% 文件名称
filename = 'barbara_512_color';
fmt = '.png';

% 读取图像
img = double(imread([filepath, filename, fmt]))./255;
% I = rgb2gray(I);
figure,imshow(img,'Border','tight');title('input')
% % %%%%%%%%%画矩形%%%%%%%%%%%%%%%%%%%%%%
hold on;
x1 = 10;y1 = 270; w1= 80; h1 = 80;
x2 = 350;y2 = 200; w2= 80; h2 = 80;
% x1 = 180;y1 = 330; w1= 100; h1 = 100;
rectangle('position',[x1 y1 w1 h1],'EdgeColor','r','lineWidth',3);
rectangle('position',[x2 y2 w2 h2],'EdgeColor','g','lineWidth',3);
hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%最主要的两个参数
sigma_s = 3;sigma_r = 0.15; 

sigma = [sigma_s sigma_r];
tic;
O = Rolling_LLF(img,sigma_s,sigma_r,2);

% %画纹理
% tex = img-O;
% figure,imshow(mat2gray(tex))
% imwrite(mat2gray(tex),'tex.png')

%输出
figure,imshow(O,'Border','tight');
hold on
rectangle('position',[x1 y1 w1 h1],'EdgeColor','r','lineWidth',3);
rectangle('position',[x2 y2 w2 h2],'EdgeColor','g','lineWidth',3);
hold off
imwrite(O,[outputpath,filename,'_RollLLF.png'])


I1 = img(y1:y1+h1-1,x1:x1+w1-1,:);imwrite(I1,'I1_15.png');figure,imshow(I1)
I2 = img(y2:y2+h2-1,x2:x2+w2-1,:);imwrite(I2,'I2_15.png');figure,imshow(I2)
O1 = O(y1:y1+h1-1,x1:x1+w1-1,:); imwrite(O1,'O1_15.png');figure,imshow(O1)
O2 = O(y2:y2+h2-1,x2:x2+w2-1,:); imwrite(O2,'O2_15.png');figure,imshow(O2)
%%%%%%%%%画线%%%%%%%%%%%%%%%%%%%%%%
% hold on;
% sign1D = 153;left = 1; right = size(I,2);w1 = right-left+1;
% plot([left right],[sign1D sign1D],'Color','r','LineWidth',3);
% hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 %%%%%%%%%%%%%%%%%%%%%%%画1D曲线 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if size(img,3) == 1 % 只有输入图像为灰度图时，才进行绘制一维信号
        sign1D = 153; 
       left = 1; right = size(img,2);w1 = right-left+1;
        % 建立采样点横坐标
        x_ax = linspace(1, w1, w1);

        % 绘制原图和核描述算子的一维对比曲线
        fig = figure;
        PlotImg0 = img(sign1D,left:right);
        plot(x_ax, PlotImg0,'-','Color','black','LineWidth',2),xlim([0,w1]);
        hold on;
%         PlotImg1 = R(sign1D,left:right);
%         plot(x_ax, PlotImg1,'-','Color','b','LineWidth',3),xlim([0,w1]);
%         hold on;
        PlotImg2 = O(sign1D,left:right);
        plot(x_ax, PlotImg2,'-','Color','R','LineWidth',3),xlim([0,w1]);
%         set(gca,'xtick',[]);
%         set(gca,'ytick',[]);
%         set(gca,'position',[0 0 1 1]);
        print(fig,'-dpng','input' )     
    end
    % % 
    figure, close;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


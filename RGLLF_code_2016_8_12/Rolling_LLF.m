%
%   Rolling Guidance Filter 
%
%   res = RollingGuidanceFilter(I,sigma_s,sigma_r,iteration) filters image
%   "I" by removing its small structures. The borderline between "small"
%   and "large" is determined by the parameter sigma_s. The sigma_r is
%   fixed to 0.1. The filter is an iteration process. "iteration" is used
%   to control the number of iterations.
%   
%   Paras: 
%   @I         : input image, DOUBLE image, any # of channels
%   @sigma_s   : spatial sigma (default 3.0). Controlling the spatial 
%                weight of bilateral filter and also the filtering scale of
%                rolling guidance filter.
%   @sigma_r   : range sigma (default 0.1). Controlling the range weight of
%                bilateral filter. 
%   @iteration : the iteration number of rolling guidance (default 4).
%
%
%   Example
%   ==========
%   I = im2double(imread('image.png'));
%   res = RollingGuidanceFilter(I,3,0.05,4);
%   figure, imshow(res);
%
%
%   Note
%   ==========
%   This implementation filters multi-channel/color image by separating its
%   channels, so the result of this implementation will be different with
%   that in the corresponding paper. To generate the results in the paper,
%   please refer to our executable file or C++ implementation on our
%   website.
%
%   ==========
%   The Code is created based on the method described in the following paper:
%   [1] "Rolling Guidance Filter", Qi Zhang, Li Xu, Jiaya Jia, European 
%        Conference on Computer Vision (ECCV), 2014
%
%   The code and the algorithm are for non-comercial use only.
%
%  
%   Author: Qi Zhang (zhangqi@cse.cuhk.edu.hk)
%   Date  : 08/14/2014
%   Version : 1.0 
%   Copyright 2014, The Chinese University of Hong Kong.
% 

function O = Rolling_LLF(I,sigma_s,sigma_r,iteration)
outputpath = 'D:\MyFile\new work\m file\GuidanceLLF\';
if ~exist('iteration','var')
    iteration = 2;
end

if ~exist('sigma_s','var')
    sigma_s = 3;
end

if ~exist('sigma_r','var')
    sigma_r = 0.05;
end

res = I.*0; 

for c=1:size(I,3)
    G = res(:,:,c);
    res(:,:,c) = bilateralFilter(I(:,:,c),G,min(G(:)),max(G(:)),sigma_s,sigma_r);
end

imwrite(res,'Guassian.png');
% % 1D曲线 
%     if size(I,3) == 1 % 只有输入图像为灰度图时，才进行绘制一维信号
%         sign1D = 443; 
%        left = 1; right = size(I,2);w1 = right-left+1;
%         % 建立采样点横坐标
%         x_ax = linspace(1, w1, w1);
% 
%         % 绘制原图和核描述算子的一维对比曲线
%         fig = figure;
%         PlotImg0 = res(sign1D,left:right);
%         plot(x_ax, PlotImg0,'-','Color',[0.4,0.4,0.4],'LineWidth',2),xlim([0,w1]);
%         set(gca,'xtick',[]);
%         set(gca,'ytick',[]);
%         set(gca,'position',[0 0 1 1]);
%         print(fig,'-dpng','Guassian' )     
%     end
%     % % 
%     figure, close;
    
N=20;fact = -1;sigma0 = 0.1; %for fishmosic
% N=20;fact = -1;sigma0 = 0.05; 
O = res;
for i=1:iteration
    disp(['RGF iteration ' num2str(i) '...']);
    for c=1:size(I,3)
        G = O(:,:,c);
        res(:,:,c) = bilateralFilter(I(:,:,c),G,min(G(:)),max(G(:)),sigma_s,sigma_r);
        O(:,:,c) = llf_g(res(:,:,c),sigma0,fact,N);
        
%         % 1D曲线 
%         if size(I,3) == 1 % 只有输入图像为灰度图时，才进行绘制一维信号
%             sign1D = 443; 
%            left = 1; right = size(I,2);w1 = right-left+1;
%             % 建立采样点横坐标
%             x_ax = linspace(1, w1, w1);
% 
%             % 绘制原图和核描述算子的一维对比曲线
%             fig = figure;
%             PlotImg0 = res(sign1D,left:right);
%             plot(x_ax, PlotImg0,'-','Color',[0.4,0.4,0.4],'LineWidth',2),xlim([0,w1]);
%             Fig1Name = [int2str(i) 'BFilter'];
%             set(gca,'xtick',[]);
%             set(gca,'ytick',[]);
%             set(gca,'position',[0 0 1 1]);
%             print(fig,'-dpng', Fig1Name)    
%             
%             fig = figure;
%             PlotImg1 = O(sign1D,left:right);
%             plot(x_ax, PlotImg1,'-','Color',[0.4,0.4,0.4],'LineWidth',2),xlim([0,w1]);
%             Fig2Name = [int2str(i) 'LLFilter'];
%             set(gca,'xtick',[]);
%             set(gca,'ytick',[]);
%             set(gca,'position',[0 0 1 1]);
%             print(fig,'-dpng', Fig2Name)   
%         end
%         % % 
%         figure, close;


%         % 1D曲线 
%         if size(I,3) == 1 % 只有输入图像为灰度图时，才进行绘制一维信号
%             sign1D = 443; 
%            left = 1; right = size(I,2);w1 = right-left+1;
%             % 建立采样点横坐标
%             x_ax = linspace(1, w1, w1);
% 
%             % 绘制原图和核描述算子的一维对比曲线
%             fig = figure;
%             PlotImg0 = I(sign1D,left:right);
%             plot(x_ax, PlotImg0,'-','Color',[0.4,0.4,0.4],'LineWidth',2),xlim([0,w1]);
% 
%     %         hold on;
%     %         PlotImg1 = res(sign1D,left:right);
%     %         plot(x_ax, PlotImg1,'-','color','Green','LineWidth',2),xlim([0,w1]);
%             hold on;
%             PlotImg5 = O(sign1D,left:right);
%             plot(x_ax, PlotImg5,'-','color','Blue','LineWidth',2),xlim([0,w1]);
%     %         hold on;
%         %     PlotImg15 = RFish15(sign1D,left:right);
%         %     plot(x_ax, PlotImg15,'-','color','Red','LineWidth',2),xlim([0,w1]);
%         %     hold on;
%         %     PlotImg20 = RFish20(sign1D,left:right);
%         %     plot(x_ax, PlotImg20,'-','color','yello','LineWidth',2),xlim([0,w1]);
%             hold off;
%             Fig1Name = [int2str(i) 'KerFilter'];
%             set(gca,'xtick',[]);
%             set(gca,'ytick',[]);
%             set(gca,'position',[0 0 1 1]);
%             print(fig,'-dpng', Fig1Name)     
%         end
%         % % 
%         figure, close;
    end
    outname_res = [outputpath, int2str(i), '_JBF.png'];
    outname_O = [outputpath, int2str(i), '_AfterLLF.png'];
%     figure,imshow(res),title('res');
%     figure,imshow(O),title('output');
    imwrite(res,outname_res);
    imwrite(O,outname_O);
end

end

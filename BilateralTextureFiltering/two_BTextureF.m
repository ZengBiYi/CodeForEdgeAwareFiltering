function two_BTextureF(I,w,sigma,iter)
if size(I,3) == 1
   BTFGray(I,w,sigma,iter);
%    BTFGray_deta(I,w,sigma,iter);
else
   BTFColor(I,w,sigma,iter);
%    BTFColor_deta(I,w,sigma,iter);
end

function J = BTFColor(I,w,sigma,iter)
xI = I(:,:,1);yI = I(:,:,2);zI = I(:,:,3);
for it = 1:iter
   xG = BTextureF(xI);
   xG(find(xG(:,:)<0)) = 0;
   xG(find(xG(:,:)>1)) = 1;
   xJ = jbfilter2(xI,xG,w,sigma);
   xI = xJ;
   
   yG = BTextureF(yI);
   yG(find(yG(:,:)<0)) = 0;
   yG(find(yG(:,:)>1)) = 1;
   yJ = jbfilter2(yI,yG,w,sigma);
   yI = yJ;
   
   zG = BTextureF(zI);
   zG(find(zG(:,:)<0)) = 0;
   zG(find(zG(:,:)>1)) = 1;
   zJ = jbfilter2(zI,zG,w,sigma);
   zI = zJ;
end
J = cat(3,xI,yI,zI);
figure,imshow(J)
hold on
title('JC_mRTV');imwrite(J,'JC_mRTV.png');

function J = BTFGray(I,w,sigma,iter)
for it = 1:iter
   G = BTextureF(I);
   G(find(G(:,:)<0)) = 0;
   G(find(G(:,:)>1)) = 1;
   J = jbfilter2(I,G,w,sigma);
   I = J;
end
figure,imshow(J)
hold on
title('JG_mRTV');imwrite(J,'JG_mRTV.png');

function J = BTFColor_deta(I,w,sigma,iter)
xI_deta = I(:,:,1);yI_deta = I(:,:,2);zI_deta = I(:,:,3);
for it = 1:iter
   xG_deta_ = BTextureF_deta(xI_deta);
   xG_deta_(find(xG_deta_(:,:)<0)) = 0;
   xG_deta_(find(xG_deta_(:,:)>1)) = 1;
   xJ_deta = jbfilter2(xI_deta,xG_deta_,w,sigma);
   xI_deta = xJ_deta;
   
   yG_deta = BTextureF_deta(yI_deta);
   yG_deta(find(yG_deta(:,:)<0)) = 0;
   yG_deta(find(yG_deta(:,:)>1)) = 1;
   yJ_deta = jbfilter2(yI_deta,yG_deta,w,sigma);
   yI_deta = yJ_deta;
   
   zG_deta = BTextureF_deta(zI_deta);
   zG_deta(find(zG_deta(:,:)<0)) = 0;
   zG_deta(find(zG_deta(:,:)>1)) = 1;
   zJ_deta = jbfilter2(zI_deta,zG_deta,w,sigma);
   zI_deta = zJ_deta;
end
J = cat(3,xI_deta,yI_deta,zI_deta);
figure,imshow(J)
hold on
title('JC_deta');imwrite(J,'JC_deta.png');

function J = BTFGray_deta(I,w,sigma,iter)
for it = 1:iter
   G = BTextureF_deta(I);
   G(find(G(:,:)<0)) = 0;
   G(find(G(:,:)>1)) = 1;
   J = jbfilter2(I,G,w,sigma);
   I = J;
end
figure,imshow(J)
hold on
title('JG_deta');imwrite(J,'JG_deta.png');

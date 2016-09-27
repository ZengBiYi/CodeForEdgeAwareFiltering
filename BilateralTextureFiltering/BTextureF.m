function Guidance = BTextureF(I)


k = 3;theta = 5*k;q_mRTV = 0;flag = 0;
B0 = filter2(fspecial('average',k),I);
save B B0;
[M,N] = size(B0);ee = zeros(1,M*N);temp = zeros(1,M*N);

I1 = I;
G = I;Guidance = I;%G1 = I或者G1=B0影响并不大。
p_afa = zeros(1,M*N);q_mean_intensity = zeros(1,M*N+1);

Iy(1,:) = I(2,:); Iy(2:M,:) = I(1:M-1,:);
Ix(:,1) = I(:,2); Ix(:,2:N) = I(:,1:N-1);
grad_y = I - Iy; grad_x = I - Ix;
grad = sqrt(grad_x.^2 + grad_y.^2);
%针对每个像素
for i = 1:M
    for j = 2:N   %p(i,j)就代表pixel p，q(i,j+1)就代表pixel q
        flag = flag + 1;num = 0;
        iMin = max(i-k+1,1);
        jMin = max(j-k+1,1);   
        mRTV = zeros(1,3);
        e = 10^(-9);
        %计算每个像素的i*(j+1)个patch
        for g = iMin:i
            for l = jMin:j
                num = num+1;
                imax = min(g+k-1,M);jmax = min(l+k-1,N);
                pat = I1(g:imax,l:jmax);%某个像素的某个patch
                
                max_pat = max(max(pat));min_pat = min(min(pat)); 
                detap = max_pat-min_pat;
               
                pat_grad = grad(g:imax,l:jmax);
                s_grad = sum(sum(pat_grad));

                max_grad = max(max(pat_grad));
                mRTV(num,3) = detap * max_grad / (s_grad + e);
           
                mRTV(num,1) = g; mRTV(num,2) = l;
            end
        end
        p_mRTV = q_mRTV; min_mRTV = min(mRTV(:,3)); q_mRTV = min_mRTV;
        x = find(mRTV(:,3) == min_mRTV);
        imax1 = min(mRTV(x,1)+k-1,M);jmax1 = min(mRTV(x,2)+k-1,N);
        paty = B0(mRTV(x,1):imax1,mRTV(x,2):jmax1);
        q_mean_intensity(flag) = mean(mean(paty));
        G(i,j-1) = q_mean_intensity(flag);%重要
        
        ee(flag) = p_mRTV-q_mRTV;%
        temp(flag) = 1+exp(-theta*ee(flag));
        p_afa(flag) = 2*(1/temp(flag)-0.5);
        Guidance(i,j-1) = p_afa(flag)*G(i,j-1) + (1-p_afa(flag))*B0(i,j-1);%重要
%         if(flag == 1)
%             G1(i,j-1) = p_afa(flag)*G(i,j-1) + (1-p_afa(flag))*q_mean_intensity(flag);
%         else
%             G1(i,j-1) = p_afa(flag)*G(i,j-1) + (1-p_afa(flag))*q_mean_intensity(flag-1);
%         end
    end
end
figure(2),imshow(G)
hold on
title('G');save G G;
figure(3),imshow(Guidance)
hold on
title('G1');save G1 Guidance

             
                
        
        
  
        
                
        
        
  
        
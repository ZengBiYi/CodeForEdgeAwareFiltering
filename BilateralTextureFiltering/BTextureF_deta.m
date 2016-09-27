function G = BTextureF_deta(I)
k = 5;theta = 5*k;
B0 = filter2(fspecial('average',k),I);

figure(2),imshow(B0)

[M,N] = size(B0);
G = I;


for i = 1:M
    for j = 2:N   %p(i,j)就代表pixel p，q(i,j+1)就代表pixel q
        num = 0;
        iMin = max(i-k+1,1);
        jMin = max(j-k+1,1);
        detap = zeros(1,3);
        %计算i*(j+1)个patch
        for g = iMin:i
            for l = jMin:j
                num = num+1;
                imax = min(g+k-1,M);jmax = min(l+k-1,N);
                pat = I(g:imax,l:jmax);
                max_pat = max(max(pat));min_pat = min(min(pat)); 
                detap(num,3) = max_pat-min_pat;
                detap(num,1) = g; detap(num,2) = l;
            end
        end
        min_detap = min(detap(:,3));
        x = find(detap(:,3) == min_detap);
        imax1 = min(detap(x,1)+k,M);jmax1 = min(detap(x,2)+k,N);
        pat2 = B0(detap(x,1):imax1,detap(x,2):jmax1);
        mean_intensity2 = mean(mean(pat2));
        G(i,j-1) = mean_intensity2;
    end
end

figure(4),imshow(G)
             
                
        
        
  
        
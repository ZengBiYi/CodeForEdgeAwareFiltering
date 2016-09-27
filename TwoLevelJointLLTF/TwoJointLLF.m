

function J = TwoJointLLF(I,M,w,sigma_s,sigma_r)

if ~exist('w','var') || isempty(w) || ...
      numel(w) ~= 1 || w < 1
   w = 5;
end
if ~exist('sigma_s','var')
    sigma_s = 3;
end

if ~exist('sigma_r','var')
    sigma_r = 0.1;
end
sigma = [sigma_s sigma_r];

res = zeros(size(I));
for c=1:size(I,3)
    G = M(:,:,c);
    res(:,:,c) = bilateralFilter(I(:,:,c),G,min(G(:)),max(G(:)),sigma_s,sigma_r); 
end


W = ComputeWeight(I,M,w,sigma);

temp = res-I;
J = I + W.*temp;

end

%This is just a toy example!
function y=remapping_function(x)
a = 0.2;
   y=(x-a).*(x>a)+(x+a).*(x<-a); %smoothing
%     y=3.*x.*(abs(x)<0.1)+(x+0.2).*(x>0.1)+(x-0.2).*(x<-0.1); %enhancement
end
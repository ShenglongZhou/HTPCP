clc; clear; close all;
 
exmpno    = 4; 
matype    = {'LC-zmat','LC-sdp','NC-atan','NC-exp'};
exmpna    = matype{exmpno};
n         = 1000;
s         = ceil(0.01*n);
data      = CPdata(n,s,exmpna); 
switch exmpna
case {'LC-zmat', 'LC-sdp'};     func = @(x,T)(data.M(:,T)*x(T)+data.q);
case 'NC-atan'; func = @(x,T)(data.a.*atan(x)+data.M(:,T)*x(T)+data.q);
case 'NC-exp';  func = @(x,T)(data.a.*exp(-x)+data.M(:,T)*x(T)+data.q);
end
       
out = HTPCP(n,func) 
fprintf('relative error: %5.2e\n',norm(data.xopt-out.x)/norm(data.xopt))
 

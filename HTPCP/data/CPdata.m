function data = CPdata(n,s, example)
switch example
    case 'LC-zmat'
         M       = speye(n)-1/n;
         q       = ones(n,1)/n; 
         q(1)    = 1/n-1;
         xopt    = zeros(n,1); 
         xopt(1) = 1;
         Mt      = M;
    case 'LC-sdp'
         Z       = randn(n,ceil(n/2));
         M       = Z*Z';
         [xopt,T]= getsparsex(n,s); 
         Mx      = M(:,T)*xopt(T);
         q       = abs(Mx);
         q(T)    = -Mx(T); 
         Mt      = M;
         M=M/n;  Mt=Mt/n; q=q/n;
    case 'NC-exp'
         Z       = randn(n,ceil(n/2));
         M       = Z*Z';	              
         [xopt,T]= getsparsex(n,s);          
         data.a  = rand(n,1);
         Mx      = data.a.*exp(-xopt)+M(:,T)*xopt(T);
         q       = abs(Mx);
         q(T)    = -Mx(T); 
         M=M/n; Mt=M/n; q=q/n; data.a=data.a/n;
     case 'NC-atan'
         Z      = (10*rand(n,n/2)-5); 
         B      = 10*rand(n)-5; 
         B      = B.*tril(ones(n),0); 
         B      = (B-B');
         ZZ     = Z*Z';
         M      = (ZZ + B);
         Mt     = (ZZ - B);	              
         [xopt,T]= getsparsex(n,s);
         data.a = -rand(n,1);
         Mx      = data.a.*atan(xopt)+M(:,T)*xopt(T);
         q       = abs(Mx);
         q(T)    = -Mx(T); 
         M=M/n; Mt=Mt/n; q=q/n; data.a=data.a/n;         
end
    
data.M    = M;
data.Mt   = Mt;
data.q    = q;
data.n    = n;
data.xopt = xopt;
end


function [x,T]= getsparsex(n,s)
         I       = randperm(n); 
         T       = I(1:s); 
         x       = zeros(n,1); 
         x(T)    = 0.1+abs(randn(s,1));
end
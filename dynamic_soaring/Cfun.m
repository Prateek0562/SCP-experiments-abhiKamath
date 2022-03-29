function [c,ceq,dc,dceq] = Cfun(Z)
%   equality contraints
%   ```````````````````
    [const,~,~,~] = inputs();
    N = 0.125*(length(Z)-2);
    nmax = const(end);
    tfbar = Z(end-1);
    [D,~] = cheb(const(1)-1);    
    rhbar = Z(end);
    
    X = zeros(N,6);
    for i = 1:6
        X(:,i) = Z(N*(i-1)+1:N*i);        
    end
    % size 6Nx1
    ceq = reshape(D*X + 0.5*tfbar*func(Z,const),[6*N,1]);
    
%  inequality constraint
%  `````````````````````
    Vbar = Z(N*(1-1)+1:1*N);
    CL =  Z(N*(1+6-1)+1:N*(1+6));
    
    c = rhbar*Vbar.*Vbar.*CL - nmax*ones(1,N);
%       c = [];

    if nargout > 2 % gradient of the constraints
        dc = [];
        dceq = [];
    end
end
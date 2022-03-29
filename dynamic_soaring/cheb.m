function [D,x] = cheb(N)
% outputs the Chebyshev differentiation matrix and points
if N==0
    D = 0;
    x = 1;
    return
end

x = cos((0:N)*pi/N)';
c1 = repmat([2 ; ones(N-1,1) ; 2].*( ( (-1).^(0:N) )' ),1,N+1);
c2 = repmat([2 , ones(1,N-1) , 2]./( (-1).^(0:N) ),N+1,1);
X = repmat(x,1,N+1);
dX = X-X';

D = (c1./c2).*(1./(dX + eye(N+1))); % off-diagonal elements

D = D - diag(sum(D,2));% diagonal elements

end
function vv = cheb_interp(t,v,tt)
% 29/08/18
% Purnanand Elango

%------------------------------------
% t must have cheb distribution 
% expect t and v to be vectors
% tt should also be a vector
% min(t) = t(1)
% max(t) = t(end)

% if length(t)~= length(v)
%     error('The lengths of the grid vector and the grid function vector must be equal');
% end
% if size(t,2)~=1 || size(v,2)~=1
%     error('The grid and the grid function must be input as a column vector');
% end
% if size(tt,2)~=1
%     error('The grid for interpolant evaluation must be a column vector');
% end

% convert from physical domain (t) to [-1,1] (x)
x = 1 - 2*(t-t(1))/(t(end)-t(1));
xx = 1 - 2*(tt-t(1))/(t(end)-t(1));

vv = zeros(size(xx));
N = length(x);

for i = 1:length(xx)

    % computation of values of cardinal functions pj at xx(i)
    p = ones(1,N);
    for j = 1:N
        a = 1;
        for k = 1:N
            if x(j)~=x(k)
                a = a*(x(j)-x(k));
                p(j) = p(j)*(xx(i)-x(k));
            end
        end
        p(j) = p(j)/a;
        vv(i) = vv(i) + p(j)*v(j);
    end
    
end

end
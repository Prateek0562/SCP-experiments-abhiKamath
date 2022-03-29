function [cost,Dcost] = costfun(Z)
cost = -Z(end);
if nargout > 1 % rhobar required
    Dcost = zeros(size(Z));
    Dcost(end) = 1;
end
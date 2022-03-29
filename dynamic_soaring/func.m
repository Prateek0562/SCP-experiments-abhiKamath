function f = func(Z,const)
    N = const(1);
    f = zeros(N,6);
    rhbar = Z(end);
    x = zeros(N,6);
    for i = 1:6
        x(:,i) = Z(N*(i-1)+1:N*i);
    end
    u = zeros(N,2);
    for i = 7:8
        u(:,i-6) = Z(N*(i-1)+1:N*i);        
    end
%     x = [Vbar, thet, psi, xgbar, ygbar, zgbar]
%     u = [CL, phi]
    
    f(:,1) = -rhbar*x(:,1).*x(:,1).*(const(3) + const(5)*u(:,1).*u(:,1)) - sin(x(:,2)) + x(:,1).*sin(x(:,2)).*cos(x(:,2)).*cos(x(:,3)); 
    f(:,2) =  rhbar*x(:,1).*u(:,1).*cos(u(:,2)) - cos(x(:,2))./x(:,1) - sin(x(:,2)).*sin(x(:,2)).*cos(x(:,3));
    f(:,3) =  rhbar*x(:,1).*u(:,1).*sin(u(:,2))./cos(x(:,2)) - tan(x(:,2)).*sin(x(:,3));
    f(:,4) =  x(:,1).*cos(x(:,2)).*cos(x(:,3)) + x(:,6);
    f(:,5) =  x(:,1).*cos(x(:,2)).*sin(x(:,3));
    f(:,6) = -x(:,1).*sin(x(:,2));
    
end
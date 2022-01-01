function zdot = dyn_func_v2(~,z,u,s)
    g = 9.806;
    % x = z(1);
    % y = z(2);
    vx = z(3);
    vy = z(4);
    ux = u(1);
    uy = u(2);
    zdot = [s*vx;s*vy;s*ux;s*g+s*uy];
end
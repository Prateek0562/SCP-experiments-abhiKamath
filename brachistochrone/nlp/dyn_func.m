function zdot = dyn_func(~,z,thet,s)
    g = 9.806;
    % x = z(1);
    % y = z(2);
    vx = z(3);
    vy = z(4);
    v = norm([vx;vy]);
    zdot = [s*v*cos(thet);s*v*sin(thet);s*g*sin(thet)*cos(thet);s*g*sin(thet)*sin(thet)];
end
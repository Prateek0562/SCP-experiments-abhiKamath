

N = 20;
tau = linspace(0,1,N);
tau_fine = linspace(0,1,N*10);

xT = 3;
yT = 3;

x_true = @(C,t) C * ( t - 0.5 *  sin(2*t) );
y_true = @(C,t) C * ( 0.5 - 0.5 * cos(2*t) );
func = @(Z) [x_true(Z(1),Z(2)) - xT;
             y_true(Z(1),Z(2)) - yT];

Z = fsolve(func,[1;1]);
C = Z(1); T = Z(2);

assert(abs(x_true(C,T) - xT)<1e-7);
assert(abs(y_true(C,T) - yT)<1e-7);



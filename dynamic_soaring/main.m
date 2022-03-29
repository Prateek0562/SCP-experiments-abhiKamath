clear all

% Optimal control formulation for minimizing the required wind gradient (beta)
% using spectral methods (Chebyshev Differentiation Matrix on [-1,1])
% using Zhao's normalization

[const,limits,finpos,Z_init] = inputs();

N = const(1); % couldn't help it, unavoidable.

% linear contraint matrix - change accordingly for loitering and travelling
% imposes periodicity
idx = [1, 2, 3, 4, 5, 6];
AL = zeros(length(idx),8*N+2);
for i = 1:length(idx)
    AL(i,N*(idx(i)-1)+1) = -1;
    AL(i,(idx(i))*N) = 1;
end

bL = finpos; % decides whether the trajectory is open or closed

% initial conditions and the path constraints set as lb and ub
lb = zeros(size(Z_init));
ub = zeros(size(Z_init));

for i = 1:8
lb(N*(i-1)+1:i*N) = limits(i,1)*ones(1,N);
ub(N*(i-1)+1:i*N) = limits(i,2)*ones(1,N);
end
lb(end-1:end) = limits(end-1:end,1);
ub(end-1:end) = limits(end-1:end,2);

% initial conditions
% xgbar(0) = 0
lb(N*(4-1)+1) = 0;
ub(N*(4-1)+1) = 0;

% ygbar(0) = 0
lb(N*(5-1)+1) = 0;
ub(N*(5-1)+1) = 0;

% zgbar(0) = 0
lb(N*(6-1)+1) = 0;
ub(N*(6-1)+1) = 0;

% thet(0) = 0
lb(N*(2-1)+1) = 0;
ub(N*(2-1)+1) = 0;

% optmization call
options = optimoptions(@fmincon,'Algorithm','sqp','SpecifyObjectiveGradient',false,'SpecifyConstraintGradient',false,'Display','iter');
options.MaxFunctionEvaluations = 1000000000; % Default: 25000
options.StepTolerance = 1e-6;
options.MaxIterations = 4000;% Default: 1000
[Z,costval,exitflag] = fmincon(@costfun,Z_init,[],[],AL,bL,lb,ub,@Cfun,options);

rhbar = Z(end);
bet = sqrt((const(2)*const(6))/(2*rhbar*const(7)));
tbar = Z(end-1);
tf = tbar/bet;

x = zeros(3,N);
for i = 4:6
    x(i-3,:) = Z(N*(i-1)+1:N*i)*const(6)/(bet*bet);
end
u = zeros(2,N);
for j = 1:2
    u(j,:) = Z(N*(j+6-1)+1:N*(j+6)); 
end

figure
plot3(x(1,:),x(2,:),x(3,:),'o-b');
title('Trajectory');
xlabel('x');
ylabel('y');
zlabel('z');

save('result','Z','const');
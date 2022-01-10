clear all
clc

problem_data;
len_Z = 5*N+1;

cost_func = @(Z) Z(end);
Aeq = zeros(6,len_Z);
Aeq(1,1) = 1;
Aeq(2,N) = 1;
Aeq(3,N+1) = 1;
Aeq(4,2*N) = 1;
Aeq(5,2*N+1) = 1;
Aeq(6,3*N+1) = 1;
beq = [0;xT;0;yT;0;0];
A = zeros(1,len_Z); A(end) = -1;
b = 0;

% alg = 'interior-point';
alg = 'sqp';
opts = optimoptions('fmincon','Algorithm',alg,'Display','iter','MaxIterations',1e3,'MaxFunctionEvaluations',1e5,'UseParallel',true);
Z = fmincon(@(Z) cost_func(Z),ones(len_Z,1),A,b,Aeq,beq,[],[],@(Z) constr_func(Z,@dyn_func),opts);

z = [Z(1:N),Z(N+1:2*N),Z(2*N+1:3*N),Z(3*N+1:4*N)]';
thet = Z(4*N+1:5*N)';
s = Z(end);
[~,zz,tthet,zprop] = propagate_foh(tau,z,thet,s,@dyn_func,'Single');

figure
plot(zz(1,:),zz(2,:),'-b');
hold on
plot(z(1,:),z(2,:),'om');
plot(x_true(C,phiT*tau_fine),y_true(C,phiT*tau_fine),'-r')
aX = gca;
aX.YDir = 'reverse';
legend('fmicon single shoot','truth');

function [c,ceq] = constr_func(Z,func)
    N = (length(Z)-1)/5;
    z = [Z(1:N),Z(N+1:2*N),Z(2*N+1:3*N),Z(3*N+1:4*N)]';
    thet = Z(4*N+1:5*N)';
    s = Z(end);
    tau = linspace(0,1,N);
    [~,~,~,zprop] = propagate_foh(tau,z,thet,s,func,'Multiple');
    ceq = reshape(z(:,2:end) - zprop(:,2:end),[4*N-4,1]);
    c = [];
end
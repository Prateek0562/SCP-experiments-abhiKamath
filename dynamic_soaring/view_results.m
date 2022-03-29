clear variables
close all
clc

load result

N = const(1);
rhbar = Z(end);
bet = sqrt((const(2)*const(6))/(2*rhbar*const(7)));
tfbar = Z(end-1);
[~,tau] = cheb(const(1)-1);
tbar = 0.5*(1-tau)*tfbar; 
t = tbar/bet;
tf = tfbar/bet;

tt = linspace(0,tf,2*N);

xx = zeros(3,length(tt));
x = zeros(3,N);
for i = 4:6
    x(i-3,:) = Z(N*(i-1)+1:N*i)*const(6)/(bet*bet);
end
x = [1,0,0;0,-1,0;0,0,-1]*x;
for i = 1:3
    xx(i,:) = interp1(t,x(i,:),tt,'spline');
end

V = Z(1:N)*const(6)/bet;
VV = cheb_interp(t,V,tt);

CL = Z(6*N+1:7*N);
CL2 = cheb_interp(t,CL,tt);

Phi = Z(7*N+1:8*N)*180/pi;
Phi2 = cheb_interp(t,Phi,tt);

Thet = Z(N+1:2*N)*180/pi;
Thet2 = cheb_interp(t,Thet,tt);

Psi = Z(2*N+1:3*N)*180/pi;
Psi2 = cheb_interp(t,Psi,tt);

n = (0.5*const(2)/const(7))*VV.*VV.*CL2/const(6);

% Visualization
f1 = figure('Position',[10,10,2500,1500]);
subplot(3,3,1)
plot(tt,n,'-bo');
title('$n$');
xlabel('$t$ [s]');
xlim([min(t),max(t)]);
ylim([min(n),max(n)]);

subplot(3,3,2)
plot(tt,Phi2,'-co');
title('$\phi$ [deg]');
xlabel('$t$ [s]');
xlim([min(t),max(t)]);
ylim([min(Phi2),max(Phi2)]);

subplot(3,3,4)
plot(tt,Thet2,'-ro');
title('$\theta$ [deg]');
xlabel('$t$ [s]');
xlim([min(t),max(t)]);
ylim([min(Thet2),max(Thet2)]);

subplot(3,3,5)
plot(tt,Psi2,'-ko');
title('$\psi$ [deg]');
xlabel('$t$ [s]');
xlim([min(t),max(t)]);
ylim([min(Psi2),max(Psi2)]);

subplot(3,3,7)
plot(tt,VV,'-go');
title('$V$ [m s$^{-1}$]');
xlabel('$t$ [s]');
xlim([min(t),max(t)]);
ylim([min(VV),max(VV)]);

subplot(3,3,8)
plot(tt,CL2,'-yo');
title('$C_{L}$');
xlabel('$t$ [s]');
xlim([min(t),max(t)]);
ylim([min(CL2),max(CL2)]);
hold off
drawnow;


subplot(3,3,[3,6,9])
hold on
axis equal
lim_min = min([min(xx(1,:)),min(xx(2,:)),min(xx(3,:))]);
lim_max = max([max(xx(1,:)),max(xx(2,:)),max(xx(3,:))]);
for i = 1:length(tt)
    plot3(xx(1,1:i),xx(2,1:i),xx(3,1:i),'o-b');
    view(-62,40);
    title('Trajectory');
    xlabel('$x$');
    ylabel('$y$');
    zlabel('$z$');
    axis([lim_min,lim_max,lim_min,lim_max,lim_min,lim_max]);
    axis manual
    drawnow;
end

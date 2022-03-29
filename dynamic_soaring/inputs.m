function [const,limits,finpos,Z_init] = inputs()

% sequence:
% [Vbar, theta, psi, xgbar, ygbar, zgbar, CL, phi, tbar, rhbar]

const = [];

const(1) = 20;                           % N
const(2) = 1.225;                        % rho
const(3) = 0.01;                         % CD0
const(4) = 28;                           % LbyDmax
const(5) = 0.25/(const(3)*(const(4)^2)); % k
const(6) = 9.806;                        % g
const(7) = 5.6;                          % mbyS
const(8) = 6;                            % nmax

% parameters for the initial guess
beta_init = 0.1;
CL0 = 0.5;
V0 = 6*beta_init/const(6);
tfbar_init = 20*beta_init;

limits = zeros(10,2);
limits(1,:) = [10, 80]*beta_init/const(6);                      % Vbar
limits(2,:) = [-2*pi, 2*pi];                                    % thet
limits(3,:) = [-4*pi, 4*pi];                                    % psi
limits(4,:) = [-500, 500]*beta_init*beta_init/const(6);         % xgbar
limits(5,:) = [-500, 500]*beta_init*beta_init/const(6);         % ygbar
limits(6,:) = [-500, 0]*beta_init*beta_init/const(6);           % zgbar
limits(7,:) = [-0.2, 1];                                        % CL
limits(8,:) = [-60*pi/180, 60*pi/180];                          % phi
limits(9,:) = [0, Inf];                                         % tbar
limits(10,:) = [0, Inf];                                        % rhbar

finpos = [0;0;2*pi;0;0;0];  % decides whether the trajectory is open of closed
                            % pay heed to the coordinate system used.

% initial guess for the parameters (since its a parameter optmization problem)
[~,tau] = cheb(const(1)-1);
tbar = 0.5*(1-tau)*tfbar_init; 

% Vbar_init = V0*(1 - 0.5*sin(pi*tbar/tfbar_init));
Vbar_init = V0*(3+cos(2*pi*tbar/tfbar_init));
thet_init = (1*pi/6)*sin(2*pi*tbar/tfbar_init); % Default: 80
psi_init = 1+2*pi*tbar/tfbar_init; % specifically for loiter
                                    
xgbar_init = zeros(1,const(1)); 
ygbar_init = zeros(1,const(1));
zgbar_init = zeros(1,const(1));
% xgbar_init = 20*(1-cos(2*pi*tbar/tfbar_init))';
% ygbar_init = -20*sqrt(2)*sin(2*pi*tbar/tfbar_init)';
% zgbar_init = -20*(1-cos(2*pi*tbar/tfbar_init))';

CL_init = CL0*ones(1,const(1));
phi_init = 0.25*pi*ones(1,const(1));

rhbar_init = (0.5*const(2)*const(6))/(const(7)*beta_init*beta_init);

Z_init = [Vbar_init', thet_init', psi_init', xgbar_init, ygbar_init, zgbar_init, CL_init, phi_init, tfbar_init, rhbar_init];

% rhbar = (0.5*1.225*9.806)/(50*bet^2);
% bet = sqrt((9.806*1.225)/(2*rhbar*50));

end
function [tt,xx,uu,xprop] = propagate_foh(tbar,xbar,ubar,sbar,func,shoot_type)
% tbar : 1 x K
% zbar : nx x K
% ubar : nu x K
% sbar : scalar
% func : dynamics function handle with ToF scaling 

    [~,K] = size(xbar);
    % [nu,~] = size(ubar);

    pos_err = [];
    vel_err = [];
    
    tt = [];
    xx = [];
    xprop = xbar(:,1);
    uu = [];

    switch shoot_type
        case 'Single'
            x_IC = xbar(:,1);
            for k=1:K-1
                % FOH
                ufunc = @(t) ( ubar(:,k)*(tbar(k+1)-t) + ubar(:,k+1)*(t-tbar(k)) )/( tbar(k+1) - tbar(k) );
                [tfine,xfine] = ode45(@(t,x) func(t,x,ufunc(t),sbar),tbar(k:k+1),x_IC);
                x_IC = xfine(end,:)';
                tt = [tt,tfine(1:end-1)'];
                xx = [xx,xfine(1:end-1,:)'];
                xprop = [xprop,xfine(end,:)'];
                pos_err(end+1) = norm(xfine(end,1:2)' - xbar(1:2,k+1));
                vel_err(end+1) = norm(xfine(end,3:4)' - xbar(3:4,k+1));
                for j=1:length(tfine(1:end-1))
                    uu = [uu,ufunc(tfine(j))];
                end
            end
        case 'Multiple'
            for k=1:K-1
                % FOH
                ufunc = @(t) ( ubar(:,k)*(tbar(k+1)-t) + ubar(:,k+1)*(t-tbar(k)) )/( tbar(k+1) - tbar(k) );
                [tfine,xfine] = ode45(@(t,x) func(t,x,ufunc(t),sbar),tbar(k:k+1),xbar(:,k));
                tt = [tt,tfine(1:end-1)'];
                xx = [xx,xfine(1:end-1,:)'];
                xprop = [xprop,xfine(end,:)'];                
                pos_err(end+1) = norm(xfine(end,1:2)' - xbar(1:2,k+1));
                vel_err(end+1) = norm(xfine(end,3:4)' - xbar(3:4,k+1));
                for j=1:length(tfine(1:end-1))
                    uu = [uu,ufunc(tfine(j))];
                end
            end
        otherwise
            error('Invalid shooting type.');
    end
    tt = [tt,tfine(end)];
    xx = [xx,xfine(end,:)'];
    uu = [uu,ufunc(tfine(end))];
%     fprintf('Max position err:          %04.1f m\nMax speed err:             %04.1f m/s\n',max(pos_err),max(vel_err));
end
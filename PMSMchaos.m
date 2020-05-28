clear, clc;
% parameter(1) = Rs % 0.011
% parameter(2) = Ld % 0.018
% parameter(3) = Lq % 0.018
% parameter(4) = Fi % 0.055
% parameter(5) = p % 4
% parameter(6) = J % 0.1
% parameter(7) = b % 0.2
% Parameter = [0.011; 0.018; 0.018; 0.055; 4; 0.1; 0.2]; %chaotic values
parameter = [24.4444 2.8877];
% x(1) = id
% x(2) = iq
% x(3) = omegaP
x0 = [1; 1; 1]; %initial condition
% u(1) = ud
% u(2) = uq
% u(3) = TL
u = [0; 0; 0];
dt = 0.01;
tLimit = 200;
tspan = dt:dt:tLimit;
tud = tspan;
ud = 100*sin(2*pi*tud);

%% Lorenz only
opts = odeset('RelTol',1e-6,'AbsTol',1e-6);
[t, x] = ode45(@(t, x)LorenzFunctionU(t, x, parameter, tud, ud), tspan, x0, opts);
%plot3(x(:,1), x(:,2), x(:,3));
%plot(x(:,3)/Parameter(5));

xx = x(5000:end,:);
tt = t(5000:end,:);
point = [mean(xx(:,1)),mean(xx(:,2)),mean(xx(:,3))];
% Figure Poincare section x-y
nvector = [0,0,1];
section = FsectionSingle(point, nvector, xx, tt);
figure('color',[1 1 1]);
set(gcf,'position',[50 50 500 400]);
plot(section(:,2), section(:,3), '.', 'MarkerSize', 10, 'color', [0, 0, 0]);
set(gca,'fontsize',15,'fontname','Times');
xlabel('$\tilde{id}$','interpreter','latex','Fontname', 'Times New Roman','FontSize',16,'FontAngle','italic');
ylabel('$\tilde{iq}$','interpreter','latex','Fontname', 'Times New Roman','FontSize',16,'FontAngle','italic');
grid on;
set(gca,'position',[0.12 0.15 0.84 0.82]);

% Figure Poincare section x-z
nvector = [0,1,0];
section = FsectionSingle(point, nvector, xx, tt);
figure('color',[1 1 1]);
set(gcf,'position',[50 50 500 400]);
plot(section(:,2), section(:,4), '.', 'MarkerSize', 10, 'color', [0, 0, 0]);
set(gca,'fontsize',15,'fontname','Times');
xlabel('$\tilde{id}$','interpreter','latex','Fontname', 'Times New Roman','FontSize',16,'FontAngle','italic');
ylabel('$\tilde{\omega}p$','interpreter','latex','Fontname', 'Times New Roman','FontSize',16,'FontAngle','italic');
grid on;
set(gca,'position',[0.125 0.15 0.84 0.82]);
% set(gca,'XLim',[15 30], 'YLim',[-8, -2]);

% Figure Poincare section y-z
nvector = [1,0,0];
section = FsectionSingle(point, nvector, xx, tt);
figure('color',[1 1 1]);
set(gcf,'position',[50 50 500 400]);
plot(section(:,3), section(:,4), '.', 'MarkerSize', 10, 'color', [0, 0, 0]);
set(gca,'fontsize',15,'fontname','Times');
xlabel('$\tilde{iq}$','interpreter','latex','Fontname', 'Times New Roman','FontSize',16,'FontAngle','italic');
ylabel('$\tilde{\omega}p$','interpreter','latex','Fontname', 'Times New Roman','FontSize',16,'FontAngle','italic');
grid on;
set(gca,'position',[0.125 0.15 0.84 0.82]);
% set(gca,'XLim',[-12 2], 'YLim',[-10, 0]);

%% Logistic Map
% xvals = [];
% iFrom = 200/dt;
% iLimit = tLimit/dt-iFrom;
% for beta = 0.12:0.00001:0.14
%     Parameter(7) = beta;
%     opts = odeset('RelTol',1e-12,'AbsTol',1e-12);
%     [t, x] = ode45(@(t, x)PMSMfunction(t, x, u, Parameter), tspan, x0, opts);
%     for i = 0:iLimit  
%         xvals(1, length(xvals)+1) = beta;
%         xvals(2, length(xvals)) = x(i+iFrom,1);
%         xvals(3, length(xvals)) = x(i+iFrom,2);
%         xvals(4, length(xvals)) = x(i+iFrom,3);
%         if(abs(x(i+iFrom,3)-x(i+iFrom-1,3))<0.001)
%             break;
%         end       
%     end
% end
% 
% plot(xvals(1,:), xvals(4,:), '.', 'LineWidth', 1, 'MarkerSize', 1.2, 'color', [0.1, 0.1, 1]);
% set(gca,'XLim',[0.12 0.14]);



clear, clc;
R = 0.011;
L = 0.018;
Fi = 0.055;
p = 4;
JM = 0.002; JL = 0.1;
BM = 0.18; BS = 0.002;
KS = 500;

A1 = -(BM*KS)/(JM*JL);
A2 = -(JM*KS+JL*KS+BM*BS)/(JM*JL);
A3 = -(JL*BS+JM*BS+JL*BM)/(JM*JL);
A4 = (p*Fi)/(JM*JL);
C1 = -R/L; C2 = KS*p; C3 = BS*p; C4 = JL*p; C5 = 1/L;
D1 = -R/L; D2 = -KS*p; D3 = -BS*p; D4 = -JL*p;
D5 = (Fi*KS*p)/L; D6 = (Fi*BS*p)/L;
D7 = (Fi*JL*p)/L; D8 = 1/L;
parameter = [A1,A2,A3,A4,C1,C2,C3,C4,C5,D1,D2,D3,D4,D5,D6,D7,D8];
B3 = JL; B2 = BS; B1 = KS;
% x(1) = id
% x(2) = iq
x0 = [0, 0, 0, 1, 1]; %initial condition
% u(1) = ud
% u(2) = uq
u = [0; 0];
dt = 0.01;
tLimit = 300;
tspan = dt:dt:tLimit;

%% Lorenz only
opts = odeset('RelTol',1e-6,'AbsTol',1e-6);
[t, x] = ode45(@(t, x)PMSMfunFlex(t, x, parameter), tspan, x0, opts);
%plot3(x(:,1), x(:,2), x(:,3));
%plot(x(:,3)/Parameter(5));
id = x(:,4);
iq = x(:,5);
omega = B1*x(:,1)+B2*x(:,2)+B3*x(:,3);

iFrom = 5000;
xx = [id(iFrom:end),iq(iFrom:end),omega(iFrom:end)];
tt = t(iFrom:end);
% point = [mean(xx(:,1)),mean(xx(:,2)),mean(xx(:,3))];

% Figure Poincare section x-y
point = [0,0,-1];
nvector = [0,0,1];
section = FsectionSingle(point, nvector, xx, tt);
figure('color',[1 1 1]);
set(gcf,'position',[50 50 500 400]);
plot(section(:,2), section(:,3), '.', 'MarkerSize', 10, 'color', [0, 0, 0]);
set(gca,'fontsize',15,'fontname','Times');
xlabel('$i_d$','interpreter','latex','Fontname', 'Times New Roman','FontSize',16,'FontAngle','italic');
ylabel('$i_q$','interpreter','latex','Fontname', 'Times New Roman','FontSize',16,'FontAngle','italic');
grid on;
set(gca,'position',[0.135 0.15 0.84 0.82]);

% Figure Poincare section x-z
point = [0,-0.1,0];
nvector = [0,1,0];
section = FsectionSingle(point, nvector, xx, tt);
figure('color',[1 1 1]);
set(gcf,'position',[50 50 500 400]);
plot(section(:,2), section(:,4), '.', 'MarkerSize', 10, 'color', [0, 0, 0]);
set(gca,'fontsize',15,'fontname','Times');
xlabel('$i_d$','interpreter','latex','Fontname', 'Times New Roman','FontSize',16,'FontAngle','italic');
ylabel('$\omega_M$','interpreter','latex','Fontname', 'Times New Roman','FontSize',16,'FontAngle','italic');
grid on;
set(gca,'position',[0.125 0.15 0.84 0.82]);
% set(gca,'XLim',[15 30], 'YLim',[-8, -2]);

% Figure Poincare section y-z
point = [3.5,0,0];
nvector = [1,0,0];
section = FsectionSingle(point, nvector, xx, tt);
figure('color',[1 1 1]);
set(gcf,'position',[50 50 500 400]);
plot(section(:,3), section(:,4), '.', 'MarkerSize', 10, 'color', [0, 0, 0]);
set(gca,'fontsize',15,'fontname','Times');
xlabel('$i_q$','interpreter','latex','Fontname', 'Times New Roman','FontSize',16,'FontAngle','italic');
ylabel('$\omega_M$','interpreter','latex','Fontname', 'Times New Roman','FontSize',16,'FontAngle','italic');
grid on;
set(gca,'position',[0.125 0.15 0.84 0.82]);
% set(gca,'XLim',[-2 -1], 'YLim',[-1.5, 0]);

%% Logistic Map



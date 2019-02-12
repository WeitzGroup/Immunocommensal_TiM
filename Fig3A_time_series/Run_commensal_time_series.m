% Code to simulate pathogenic+commensal bacteria model (ODE)
% Dependencies: (1) commODE.m (2)simComm.m (3) myEventsFcn.m

clear
clc
close all

% Define color vectors
BPvector = [237 41 57]./255;
BCvector = [65 105 225]./255;
Ivector = [159 0 197]./255;

% Figure titles
title_all = {'Commensal only','Immunity only','Commensal and immunity'};

    %---------parameters--------------
    % pathogenic bacteria growth rate
    p.r = 0.75;
    % commensal bacteria growth rate
    p.rc = p.r;
    %p.rc = 0.675;
    % bacteria carrying capacity for pathogen growth
    %p.Kp = 2e10;
    p.Kp = 1e10;
    % bacteria carrying capacity for commensal growth
    p.Kc = 1e10;
    % Perturbation parameters from competitive exclusion case
    p.lambda_PC = 0.75;
    p.lambda_CP = 1.25;
    % immune response killing rate parameter:
    p.ep = 8.2e-8;
    % bacterial conc. at which immune response is half as effective:
    p.Kd = 4.1e7;
    % maximum growth rate of immune response:
    p.a = 0.97;
    % conc. of bacteria at which imm resp growth rate is half its maximum:
    p.Kn = 1e7;
    % Max immune intensity
    p.Ki = 2.4e7;


% Initial conditions
Io_all=[0 2.7e6 2.7e6];
BCo_all=[1e9 0 1e9];

%Run duration
Tmax=100;

for ifig=1:3

Io = Io_all(ifig); 
BP = 3e7;
BC = BCo_all(ifig);
 
[y, time] = simComm(p,Io,BP,BC,Tmax);

%----------------------------------------
% plotting
%----------------------------------------

% Plot default values
set(0,'DefaultAxesLinewidth',2)
set(0, 'DefaultAxesFontName', 'Arial')

figure(ifig)
semilogy(time,y(:,1),'Color', BPvector, 'Linewidth',3);
hold on;
semilogy(time,y(:,2),'Color', BCvector,'Linewidth',3)
semilogy(time,y(:,3),'LineStyle','--','Color', Ivector,'Linewidth',3)
%text(-25,1e12,'a','FontSize',25,'FontWeight','bold');

%-----------------------------------------------------
xlabel('Hours post infection', 'FontSize', 20,'fontweight','normal')
set(gca,'XTick',[0:20:Tmax]);
ylabel('Density (g^{-1})', 'FontSize', 20,'fontweight','normal')
h = findobj('Color',BPvector);
j = findobj('Color',BCvector);
i = findobj('Color',Ivector); 

if ifig==1
v = [h(1) j(1)];
h_leg = legend(v, 'pathogenic-bacteria','commensal-bacteria','Location','southwest');
elseif ifig==2
v = [h(1) i(1)];
h_leg = legend(v,'pathogenic-bacteria','host immunity','Location','southeast');
else
v = [j(1) i(1) h(1)];
h_leg = legend(v, 'commensal-bacteria', 'host immunity','pathogenic-bacteria','Location','southeast');
end

axis([0,Tmax,1e5,1e11])
set(gca,'YTick',[10.^(5:2:11)])
legend boxoff
set(gca,'FontSize',20,'fontweight','normal')
title(title_all{ifig},'Fontsize',25,'Interpreter','none');
set(gca, 'Units','inches','Position',[1 1 3 2.5])
set(h_leg, 'FontSize',15,'fontweight','normal')
set(gcf,'PaperPositionMode','manual','PaperPosition',[0.25 2.5 8 6],'PaperUnits','inches')

end

% 
 figure(1)
 saveas(gcf, 'fig3A_panel1', 'fig')
 saveas(gcf,'fig3A_panel1','epsc')
 saveas(gcf, 'fig3A_panel1', 'png')
 
 figure(2)
 saveas(gcf, 'fig3A_panel2', 'fig')
 saveas(gcf,'fig3A_panel2','epsc')
 saveas(gcf, 'fig3A_panel2', 'png')
 
 figure(3)
 saveas(gcf, 'fig3A_panel3', 'fig')
 saveas(gcf,'fig3A_panel3','epsc')
 saveas(gcf, 'fig3A_panel3', 'png')
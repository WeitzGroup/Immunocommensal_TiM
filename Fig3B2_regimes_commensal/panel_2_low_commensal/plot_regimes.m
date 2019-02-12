%% Plotting the heat map of bacteria/virus at steady state
    lwidth=3; lbsize=25; tlbsize=20; flb_size=20;
    set(0,'DefaultLineLinewidth',lwidth)
    set(0,'DefaultAxesLinewidth',lwidth)
    set(0,'DefaultAxesFontSize',tlbsize)
    
    % Set tick labels and markers on figure
    lamb_CP_tick=lamb_CP_min:(lamb_CP_max-lamb_CP_min)/4:lamb_CP_max;
    epsKI_tick=epsKI_min:(epsKI_max-epsKI_min)/3:epsKI_max;
    CP_span=lamb_CP_max-lamb_CP_min;
    epsKI_span=epsKI_max-epsKI_min;
    BS_tick_lb={'10^{6}','10^{7}','10^{8}','10^{9}','10^{10}'};


%% Plotting different regimes of infection outcomes
B_thres = 1; % Extinction threshold of bacteria
loglast_BP=log10(last_BP); 
loglast_BC=log10(last_BC); 
%loglast_BP(loglast_BP<0)=0;
regime = zeros(size(last_BP));
regime(last_BP>B_thres & last_BC<B_thres) = -1; % Regime of pathogen winning
regime(last_BP>B_thres & last_BC>B_thres) = 0; % Regime of coexistence
regime(last_BP<B_thres & last_BC>B_thres) = 1; % Regime of commensal winning

% Threshold marking different regimes
R_th_CP=p.Kc/p.Kp;
%R_th_epsKI=(1-p.ep*p.Ki/p.r)/R_th_CP;
R_th_epsKI=0.9;

% Define color map for different regimes
c3_map=[1, 0, 0
1, 1, 1
0, 1, 0];

% Plot different regimes of outcome
figure(1)
imagesc(lamb_CP_range,epsKI_range,regime); 
colormap(c3_map);
caxis([-1,1]);
set(gca,'Ydir','normal','XTick',lamb_CP_tick,'YTick',epsKI_tick)
line([R_th_CP R_th_CP],[epsKI_min-1 R_th_epsKI],'LineStyle',':','color','black','LineWidth',lwidth)
line([lamb_CP_min-1 lamb_CP_max+1],[R_th_epsKI R_th_epsKI+0.025],'LineStyle','--','color','black','LineWidth',lwidth)
text(0.3,2.3,'3B2','FontSize',lbsize,'FontWeight','bold');
title('Low commensal inhibition','FontSize',tlbsize);

str='Coexistence';
text(lamb_CP_min+0.25*CP_span,epsKI_min+0.15*epsKI_span,str,'Fontsize',flb_size,...
    'HorizontalAlignment','center','VerticalAlignment','middle');
str='B_P wins';
text(lamb_CP_min+0.75*CP_span,epsKI_min+0.15*epsKI_span,str,'Fontsize',flb_size,...
    'HorizontalAlignment','center','VerticalAlignment','middle');
str='B_C wins';
text(lamb_CP_min+0.5*CP_span,epsKI_min+0.6*epsKI_span,str,'Fontsize',flb_size,...
    'HorizontalAlignment','center','VerticalAlignment','middle');

xlabel('$\textrm{Competition } B_P \dashv B_C \;(\lambda_{CP})$','fontsize',tlbsize,'Interpreter','latex'); 
ylabel('$\textrm{Max immune killing } \epsilon K_I \; (\textrm{h}^{-1})$','fontsize',tlbsize,'Interpreter','latex');

 saveas(gcf, 'Fig3B2_panel_2', 'fig')
 saveas(gcf,'Fig3B2_panel_2','epsc')
 saveas(gcf, 'Fig3B2_panel_2', 'png')

%return
%% Plotting heat maps of pathogen and commensal population densities (optional)
% Heat map of pathogenic bacterial concentration
figure(2);
title('Pathogenic Bacteria','FontSize',lbsize);

% Take logarithm of data
loglast_BP=log10(last_BP); 
loglast_BP(loglast_BP<0)=0;

% Plot heat map
imagesc(lamb_CP_range,epsKI_range,loglast_BP); 
set(gca,'Ydir','normal','XTick',lamb_CP_tick,'YTick',epsKI_tick)
line([R_th_CP R_th_CP],[epsKI_min-1 R_th_epsKI],'LineStyle',':','color','black','LineWidth',lwidth)
line([lamb_CP_min-1 lamb_CP_max+1],[R_th_epsKI R_th_epsKI+0.025],'LineStyle','--','color','black','LineWidth',lwidth)
text(0.3,2.3,'3B2','FontSize',lbsize,'FontWeight','bold');
title('Low commensal inhibition','FontSize',tlbsize);

str='Coexistence';
text(lamb_CP_min+0.25*CP_span,epsKI_min+0.15*epsKI_span,str,'Fontsize',flb_size,...
    'HorizontalAlignment','center','VerticalAlignment','middle');
str='B_P wins';
text(lamb_CP_min+0.75*CP_span,epsKI_min+0.15*epsKI_span,str,'Fontsize',flb_size,...
    'HorizontalAlignment','center','VerticalAlignment','middle');
str='B_C wins';
text(lamb_CP_min+0.5*CP_span,epsKI_min+0.6*epsKI_span,str,'Fontsize',flb_size,...
    'HorizontalAlignment','center','VerticalAlignment','middle');

xlabel('$\textrm{Competition } B_P \dashv B_C \;(\lambda_{CP})$','fontsize',tlbsize,'Interpreter','latex'); 
ylabel('$\textrm{Max immune killing } \epsilon K_I \; (\textrm{h}^{-1})$','fontsize',tlbsize,'Interpreter','latex');

lowestValue = 6.01;
highestValue = 10;
map=parula(256);
colormap(map);
c_lim=[floor(lowestValue-2/256), ceil(highestValue)];
caxis(c_lim);
map(1,:)=[1,1,1];
colormap(map);

c=colorbar;
set(c,'Linewidth',lwidth,'Ytick',[c_lim(1):1:c_lim(2)],...
'Yticklabel',BS_tick_lb);
ylabel(c,'<B_P> (cell/g)','fontsize',lbsize);
title(c,'\begin{tabular}{c}Pathogen density\\$\langle B_P\rangle \textrm{(g}^{-1}\textrm{)}$\end{tabular}','Interpreter','latex','fontsize',tlbsize);

 saveas(gcf, 'Fig3B2_p2_pathogen', 'fig')
 saveas(gcf,'Fig3B2_p2_pathogen','epsc')
 saveas(gcf, 'Fig3B2_p2_pathogen', 'png')
 
% Heat map of commensal bacterial concentration
figure(3);
title('Commensal Bacteria','FontSize',lbsize);

% Take logarithm of data
loglast_BC=log10(last_BC); 
loglast_BC(loglast_BC<0)=0;

% Plot heat map
imagesc(lamb_CP_range,epsKI_range,loglast_BC); 
set(gca,'Ydir','normal','XTick',lamb_CP_tick,'YTick',epsKI_tick)
line([R_th_CP R_th_CP],[epsKI_min-1 R_th_epsKI],'LineStyle',':','color','black','LineWidth',lwidth)
line([lamb_CP_min-1 lamb_CP_max+1],[R_th_epsKI R_th_epsKI+0.025],'LineStyle','--','color','black','LineWidth',lwidth)
text(0.3,2.3,'3B2','FontSize',lbsize,'FontWeight','bold');
title('Low commensal inhibition','FontSize',tlbsize);

str='Coexistence';
text(lamb_CP_min+0.25*CP_span,epsKI_min+0.15*epsKI_span,str,'Fontsize',flb_size,...
    'HorizontalAlignment','center','VerticalAlignment','middle');
str='B_P wins';
text(lamb_CP_min+0.75*CP_span,epsKI_min+0.15*epsKI_span,str,'Fontsize',flb_size,...
    'HorizontalAlignment','center','VerticalAlignment','middle');
str='B_C wins';
text(lamb_CP_min+0.5*CP_span,epsKI_min+0.6*epsKI_span,str,'Fontsize',flb_size,...
    'HorizontalAlignment','center','VerticalAlignment','middle');

%,...
%    'XTickLabel',lamb_CP_tick_lb,'YTickLabel',epsKI_tick_lb);
xlabel('$\textrm{Competition } B_P \dashv B_C \;(\lambda_{CP})$','fontsize',tlbsize,'Interpreter','latex'); 
ylabel('$\textrm{Max immune killing } \epsilon K_I \; (\textrm{h}^{-1})$','fontsize',tlbsize,'Interpreter','latex');
lowestValue = min(loglast_BC(loglast_BC(:)>0));
highestValue = max(loglast_BC(:));
lowestValue = 6.01;
highestValue = 10;
map=parula(256);
colormap(map);
c_lim=[floor(lowestValue-2/256), ceil(highestValue)];
caxis(c_lim);
map(1,:)=[1,1,1];
colormap(map);
c=colorbar;
set(c,'Linewidth',lwidth,'Ytick',[c_lim(1):1:c_lim(2)],...
'Yticklabel',BS_tick_lb);
ylabel(c,'<B_C> (cell/g)','fontsize',lbsize);
title(c,'\begin{tabular}{c}Commensal density\\$\langle B_C\rangle \textrm{(g}^{-1}\textrm{)}$\end{tabular}','Interpreter','latex','fontsize',tlbsize);

 saveas(gcf, 'Fig3B2_p2_commensal', 'fig')
 saveas(gcf,'Fig3B2_p2_commensal','epsc')
 saveas(gcf, 'Fig3B2_p2_commensal', 'png')
 
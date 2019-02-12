% Code to simulate pathogenic+commensal bacteria model (ODE)
% No commensal
% Dependencies: (1) commODE.m (2)simComm.m (3) myEventsFcn.m

clear
clc
close all

    %---------parameters--------------
    % pathogenic bacteria growth rate
    p.r = 0.75;
    % commensal bacteria growth rate
    p.rc = p.r;
    %p.rc = 0.675;
    % bacteria carrying capacity for pathogen growth
    %p.Kp = 7e9;
    p.Kp = 1e10;
    % bacteria carrying capacity for commensal growth
    p.Kc = 1e10;
    % Competition parameters
    p.lambda_PC = 0.75;
    %p.lambda_CP = 1.25;
    % immune response killing rate parameter:
    p.ep = 8.2e-8;
    % bacterial conc. at which immune response is half as effective:
    p.Kd = 4.1e7;
    % maximum growth rate of immune response:
    p.a = 0.97;
    % max capacity of immune response:
    p.Ki = 2.4e7;
    % conc. of bacteria at which imm resp growth rate is half its maximum:
    p.Kn = 1e7;
    % Decay rate of immune response
    p.m = 0;
    
    % Scanning parameters for lambda_CP and \eps K_i
    lamb_CP_min=0.5;lamb_CP_max=1.5;lamb_CP_step=0.05;
    lamb_CP_range=lamb_CP_min:lamb_CP_step:lamb_CP_max;
    
    epsKI_min=0.5;epsKI_max=2;epsKI_step=0.05;
    epsKI_range=epsKI_min:epsKI_step:epsKI_max;
    
    len_lamb_CP=length(lamb_CP_range); len_epsKI=length(epsKI_range);

% Arrays to store the bacteria and immune steady state densities
last_BP=zeros(len_epsKI,len_lamb_CP);
last_BC=zeros(len_epsKI,len_lamb_CP);
last_I=zeros(len_epsKI,len_lamb_CP);
    
Io = 2.7e6; % Healthy basline immune response
%Io = 0; % No immune response
%Io = p.Ki; % Initialize at max immune response

BPo = 3e7; % pathogenic bacteria

BCo = 1e9; % commensal bacteria
%BCo = 0; % no commensal bacteria

Tsamp=1000;
Tmax=1100;
tic

for c_lamb_CP=1:len_lamb_CP
% c_lamb_CP
p.lambda_CP=lamb_CP_range(c_lamb_CP);

for c_epsKI=1:len_epsKI
p.Ki = epsKI_range(c_epsKI)/p.ep;
%p.lambda_CP = lamb_PC;

[y, time] = simComm(p,Io,BPo,BCo,Tmax);

T_range=time>Tsamp;
last_BP(c_epsKI,c_lamb_CP)=mean(y(T_range,1));
last_BC(c_epsKI,c_lamb_CP)=mean(y(T_range,2));
last_I(c_epsKI,c_lamb_CP)=mean(y(T_range,3));

end
end

toc

%----------------------------------------
% plotting
%----------------------------------------

run('plot_regimes')

save('output.mat')


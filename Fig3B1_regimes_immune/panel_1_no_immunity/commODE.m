% Phage pathogenic+commensal bacteria model ODE

function [ dx ] = commODE( t,x,p )

dx = [0;0;0];

%-----------Parameters------------
% pathogenic bacteria growth rate
r = p.r;
% commensal bacteria growth rate
rc = p.rc;
% bacteria carrying capacity for pathogen growth
Kp = p.Kp;
% bacteria carrying capacity for commensal growth
Kc = p.Kc;
% Perturbation parameters from competitive exclusion case
lambda_PC = p.lambda_PC;
lambda_CP = p.lambda_CP;
% immune response killing rate parameter:
ep = p.ep;
% bacterial conc. at which immune response is half as effective:
Kd = p.Kd;
% maximum growth rate of immune response:
a = p.a;
% max capacity of immune response:
Ki = p.Ki;
% conc. of bacteria at which imm resp growth rate is half its maximum:
Kn = p.Kn;

BP = x(1);
BC = x(2);
I = x(3);

% Change in susceptible bacterial population
dx(1) = r*BP*(1-(BP+lambda_PC*BC)/Kp)-(ep*I*BP/(1+(BP/Kd)));
% Change in commensal bacterial population
dx(2) = rc*BC*(1-(lambda_CP*BP+BC)/Kc);
% Change immune response
dx(3) = a*I*(BP/(BP+Kn))*(1-(I/Ki));

end


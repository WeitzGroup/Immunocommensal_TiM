%Function to simulate immunocommensal dynamics (commODE)

function [ y, time ] = simComm( p, immune, bacteria, commensal, Tmax)

    %initial conditions
    BPo = bacteria;
    BCo = commensal;
    Io = immune;
    %tspan = 0:2;
    %y0 = [BPo;BCo;Io];

    options = odeset('Events',@myEventsFcn);
    
    %% Simulating initial fixed period after pathogen exposure for time-delayed 
    % introduction of commensals (optional)
    %[t1,y1] = ode45(@commODE,tspan,y0,options,p);
    %BP = y1(end,1);
    %BC = y1(end,2);
    %I = y1(end,4);
    %tspan2 = 2:Tmax;
    %yi = [BP;BC;P;I];

    tspan2 = 0:Tmax;
    yi = [BPo;BCo;Io];
    
    % simulating diff eq after phage addition
    [t2,y2] = ode45(@commODE,tspan2,yi,options,p);

    %----------------------------------------
    % continue simulation after pathogen or commensals die

    check = 0;
    currentTime = t2(end);
    if currentTime < Tmax-1 % Bacterial pop died before end of simulation
        check = 1;
        BP2 = y2(end,1);
        if BP2 <= 1
            BP2 = 0;
        end
        BC2 = y2(end,2);
        if BC2 <= 1
            BC2 = 0;
        end
        I2 = y2(end,3);
        tspan3 = currentTime:Tmax;
        yii = [BP2;BC2;I2];

        % simulating diff eq
        [t3,y3] = ode45(@commODE,tspan3,yii,options,p);
    end
    %----------------------------------------
    % continue simulation after pathogenic or commensals die

    % Check if run completed without bacteria dying
    if check == 1
        currentTime2 = t3(end);
    else
        currentTime2 = Tmax;
    end
    if currentTime2 < Tmax-1
        BP3 = y3(end,1);
        if BP3 <= 1
            BP3 = 0;
        end
        BC3 = y3(end,2);
        if BC3 <= 1
            BC3 = 0;
        end
        I3 = y3(end,3);
        tspan4 = currentTime2:Tmax;
        yiii = [BP3;BC3;I3];

        % simulating diff eq
        [t4,y4] = ode45(@commODE,tspan4,yiii,options,p);

        time = [t2; t3; t4];
        y = [y2; y3; y4];
    elseif check == 1
        time = [t2; t3];
        y = [y2; y3];
    else
        y = y2;
        time = t2;
    end
end


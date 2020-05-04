%% SCRIPT FILE: Mainaintng TV ratios in patients with discrepancies (Ab)
% Using the runElectricalAnalogueModel function. The function takes two
% parameters: whichModel, param_config to select the model and select the
% parameters configuration.
%
% param_config can be either an integer or a structure with parameters to
% be used in the model.
%
% Guide:
% PATIENT A: C_L @ 100%
% PATIENT B: C_L @ 80%
%
%% Tidy up

whichModel = 'modified';
param_config = 'siunits'; 
change2clinical = true;

% search on different configurations of PIP and R_V1
newR_V1 = 3150; % starting point (value in SI units)
newR_V2 = 0;

%% 

factorV1 = 10;
finished = false;
iter=1;
while ~finished
    param_struct = getParametersWithPatients('A', 'b', param_config);  
    param_struct.R_V1 = newR_V1*(200+factorV1);
    param_struct.R_V2 = newR_V2;
    
    [~, t, y] = runElectricalAnalogueModel(whichModel, param_struct);
    tva = tidalVolume(t, y(1).Volume, change2clinical);
    tvb = tidalVolume(t, y(2).Volume, change2clinical);
    
    fprintf('%d | %3.2f, %3.2f, %3.2f\n', iter, tva, tvb, abs(tva-tvb))
    factorV1 = factorV1 + 10;
    iter=iter+1;
    finished = abs(tva-tvb)<5 || iter>50;
end
%
originalPIP = param_struct.v_M_inhale; 
factorPIP = 98.0665; % Value in SI units
finished = false;
iter=1;
while ~finished
    param_struct.v_M_inhale = originalPIP+factorPIP;
    
    [~, t, y] = runElectricalAnalogueModel(whichModel, param_struct);
    tva = tidalVolume(t, y(1).Volume, change2clinical);
    tvb = tidalVolume(t, y(2).Volume, change2clinical);
    
    fprintf('%d | %3.2f, %3.2f, %3.2f\n', iter, tva, tvb, abs(tva-tvb))
    factorPIP = factorPIP + 98.0665/3;
    iter=iter+1;
    finished = mean([tva tvb])>490 || iter>50; % condition in SI units
end

fprintf('PIP=%3.2f, R_V1=%3.2f, TV1=%3.2f, TV2=%3.2f\n', ...
    param_struct.v_M_inhale/98.0665, param_struct.R_V1, tva, tvb);

table_test3.PIP_ab = param_struct.v_M_inhale/98.0665; % conversion to clinical 
table_test3.RV1_ab = param_struct.R_V1;
table_test3.tvab_A = tva;
table_test3.tvab_B = tvb;

t_Ab = t;
y_Ab = y;
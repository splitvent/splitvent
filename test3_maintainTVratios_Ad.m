%% SCRIPT FILE: Mainaintng TV ratios in patients with discrepancies (Ad)
% Using the runElectricalAnalogueModel function. The function takes two
% parameters: whichModel, param_config to select the model and select the
% parameters configuration.
%
% param_config can be either an integer or a structure with parameters to
% be used in the model.
%
% Guide:
% PATIENT A: C_L @ 100%
% PATIENT D: C_L @ 60%
%
%% Tidy up
clc;

% whichModel = 10; % 0 + 10 (US_PHS recommendations)
whichModel = 'modified';
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)
modR_I = 3150*1.8;
modR_E = 3150*1.8;
modC_L = 5.50646758e-07; % 54 ml/cmH2O
modPIP = 15*98.0665; % PIP @ 15 cmH2O

% grid search on different configurations of PIP and R_V1
newPIP = linspace(12, 20, 5);
newR_V1 = 3150;
newR_V2 = 0;

%% Grid search

factorV1 = 10;
finished = false;
iter=1;
while ~finished
    param_struct = getParametersWithPatients('A', 'd', param_config);
    param_struct.R_D1 = modR_I;
    param_struct.R_D2 = modR_I;
    param_struct.R_E1 = modR_E;
    param_struct.R_E2 = modR_E;
    param_struct.C_L1 = modC_L;
    param_struct.C_L2 = modC_L*0.6;
    
    param_struct.R_U1 = newR_V1*(200+factorV1);
    param_struct.R_U2 = newR_V2;
    param_struct.v_M_inhale = modPIP;
    
    [~, t, y] = runElectricalAnalogueModel(whichModel, param_struct);
    tva = tidalVolume(t, y(1).Volume);
    tvb = tidalVolume(t, y(2).Volume);
    
    fprintf('%d | %3.2f, %3.2f, %3.2f\n', iter, tva, tvb, abs(tva-tvb))
    factorV1 = factorV1 + 10;
    iter=iter+1;
    finished = abs(tva-tvb)<5 || iter>50;
end
%
factorPIP = 98.0665;
finished = false;
iter=1;
while ~finished
    param_struct.v_M_inhale = modPIP+factorPIP;
    
    [~, t, y] = runElectricalAnalogueModel(whichModel, param_struct);
    tva = tidalVolume(t, y(1).Volume);
    tvb = tidalVolume(t, y(2).Volume);
    
    fprintf('%d | %3.2f, %3.2f, %3.2f\n', iter, tva, tvb, abs(tva-tvb))
    factorPIP = factorPIP + 98.0665/3;
    iter=iter+1;
    finished = mean([tva tvb])>490 || iter>50;
end

fprintf('PIP=%3.2f, R_V1=%3.2f, TV1=%3.2f, TV2=%3.2f\n', ...
    param_struct.v_M_inhale/98.0665, param_struct.R_U1, tva, tvb);

table_test3.PIP_ad = param_struct.v_M_inhale/98.0665;
table_test3.RV1_ad = param_struct.R_U1;
table_test3.tvad_A = tva;
table_test3.tvad_D = tvb;

t_Ad = t;
y_Ad = y;
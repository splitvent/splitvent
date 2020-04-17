%% Set initial parameters for simscape electrical model
% Run a specific cell in this script file to save a specific set of
% parameters to the given MAT-file. Then, open the MODEL EXPLORER on
% Simulink and load the MODEL WORKSPACE with the MAT file you just created.
%

%% DEFAULT (CLINICAL UNITS)
clear v_M_exhale v_M_inhale R_M R_V1 R_V2 R_I1 R_I2 R_L1 R_L2 C_L1 C_L2 ...
    R_aL1 R_aL2 C_aL1 C_aL2 RaR_E1 R_E2 R_O RR I E IE_ratio...
    R_ETT1 R_ETT2 R_EV1 R_EV2;
clc;

% Set the parameters...
v_M_exhale = 5; % cmH2O (PEEP)
v_M_inhale = 20; % (PIP)
R_M = 0; %

R_V1 = 0.06; % cmH2O/L/s
R_V2 = 0.06; 
R_I1 = 0.06; % tube length = 1.8 ms
R_I2 = 0.06;
R_EV1 = 0;
R_EV2 = 0;

R_L1 = 2;
R_L2 = 2;
C_L1 = 0.054; % L/cmH2O
C_L2 = 0.054;
R_ETT1 = 8; % DOI: 10.1378/chest.96.6.1374
R_ETT2 = 8; % and 10.31744/einstein_journal/2020AO4805
% the factor of 0.8 was taken
% from Campbell & Brown (1963)


% === artificial patients (bags)s ====
R_aL1 = 2;
R_aL2 = 2;
C_aL1 = 0.054;
C_aL2 = 0.054;
% =======

R_E1 = 0.06;
R_E2 = 0.06;
R_O = 0;

RR = 15;
I = 1;
E = 2;
IE_ratio = I/ E;


save(fullfile('parameterfiles', 'Ventilator_Parameters_ClinicalUnits.mat'));

%% SI UNITS
clear v_M_exhale v_M_inhale R_M R_V1 R_V2 R_I1 R_I2 R_L1 R_L2 C_L1 C_L2 ...
    R_aL1 R_aL2 C_aL1 C_aL2 RaR_E1 R_E2 R_O RR I E IE_ratio...
    R_ETT1 R_ETT2 R_EV1 R_EV2;
clc;

v_M_exhale = 490; % cmH2O (PEEP)
v_M_inhale = 1471; % (PIP)
R_M = 0; %

R_V1 = 5670; % cmH2O/L/s
R_V2 = 5670;
R_I1 = 5670; % tube length = 1.8 ms
R_I2 = 5670;
R_EV1 = 0;
R_EV2 = 0;

R_L1 = 196133;
R_L2 = 196133;
C_L1 = 5.50647e-7; % L/cmH2O
C_L2 = 5.50647e-7;
R_ETT1 = 784000;
R_ETT2 = 784000;

% === artificial patients (bags)s ====
R_aL1 = 196133;
R_aL2 = 196133;
C_aL1 = 5.50647e-7;
C_aL2 = 5.50647e-7;
% =======

R_E1 = 5670;
R_E2 = 5670;
R_O = 0;

RR = 15;
I = 1;
E = 2;
IE_ratio = I/ E;

save(fullfile('parameterfiles', 'Ventilator_Parameters_SIUnits.mat'));

%% Set initial parameters for simscape electrical model
% Run a specific cell in this script file to save a specific set of
% parameters to the given MAT-file. Then, open the MODEL EXPLORER on
% Simulink and load the MODEL WORKSPACE with the MAT file you just created.
%

%% Original parameters
% First, clear any parameter from this model that might be in the workspace
clear v_M_exhale v_M_inhale R_M R_U1 R_U2 R_D1 R_D2 R_L1 R_L2 C_L1 C_L2 ...
    R_aL1 R_aL2 C_aL1 C_aL2 RaR_E1 R_E2 R_O RR I E IE_ratio...
    ETT_factor1 ETT_factor2;
clc;

% Set the parameters...
v_M_exhale = 5;% Pa PEEP = 5cmH20
v_M_inhale = 20; % PIP = 20cmH2O
R_M = 1; % Pa*s/m^3
% current = m^3/s
% charge = m^3
% tube length = 1.5 m?
R_U1 = 1;
R_U2 = 1;
R_D1 = 1;
R_D2 = 1;

R_L1 = 1e2; % want 2.0cmH2O/L/s
R_L2 = 1e2;
C_L1 = 1e-3; % 0.064 L/cmH2O into m^3/Pa
C_L2 = 2e-3;
R_ETT1 = 1e3;
R_ETT2 = 1e3;

% === artificial patients ====
R_aL1 = 1e2; % want 2.0cmH2O/L/s
R_aL2 = 1e2;
C_aL1 = 1e-3; % 0.064 L/cmH2O into m^3/Pa
C_aL2 = 2e-3;
% =======

R_E1 = 1;
R_E2 = 1;
R_O = 1;

RR = 15;
I = 1;
E = 2;
IE_ratio = I/E;

% ... and save them with a useful name
save(fullfile('parameterfiles', 'Ventilator_Electrical_Parameters.mat'));

%% Conversion to SI units
% First, clear any parameter from this model that might be in the workspace
clear v_M_exhale v_M_inhale R_M R_U1 R_U2 R_D1 R_D2 R_L1 R_L2 C_L1 C_L2 ...
    R_aL1 R_aL2 C_aL1 C_aL2 RaR_E1 R_E2 R_O RR I E IE_ratio...
    R_ETT1 R_ETT2;
clc;

% Set the parameters...
v_M_exhale = 490;% Pa PEEP = 5cmH20
v_M_inhale = 1960; % PIP = 20cmH2O
R_M = 4000; % Pa*s/m^3
% current = m^3/s
% charge = m^3
% tube length = 1.5 m?
R_U1 = 4000;
R_U2 = 4000;
R_D1 = 4000;
R_D2 = 4000;

R_L1 = 196133; % want 2.0cmH2O/L/s
R_L2 = 196133;
C_L1 = 6.5261838e-7; % 0.064 L/cmH2O into m^3/Pa
C_L2 = 6.5261838e-7;
R_ETT1 = 1961330;
R_ETT2 = 1961330;

% === artificial patients ====
R_aL1 = 196133; % want 2.0cmH2O/L/s
R_aL2 = 196133;
C_aL1 = 6.5261838e-7; % 0.064 L/cmH2O into m^3/Pa
C_aL2 = 6.5261838e-7;
% =======

R_E1 = 4000;
R_E2 = 4000;
R_O = 4000;

RR = 15;
I = 1;
E = 2;
IE_ratio = I/E;

% ... and save them with a useful name
save(fullfile('parameterfiles', 'Ventilator_Electrical_Parameters_SIUnits.mat'));

%% THESE WE ARE RUNNING!! - 4/4/20
% Set the parameters...
v_M_exhale = 490;% Pa PEEP = 5cmH20
v_M_inhale = 1960; % PIP = 20cmH2O
R_M = 0; % Pa*s/m^3
% current = m^3/s
% charge = m^3
% tube length = 1.5 m?
R_U1 = 3150; % Poiseille law for straight laminar pipe
R_U2 = 3150; % assuming D = 22e-3 m, mu = 18.13e-6 Pa.s,
R_D1 = 3150; % L = 1 m, => R = (128*mu*L)/(pi*D^4)
R_D2 = 3150;

R_L1 = 196133; % want 2.0cmH2O/L/s
R_L2 = 196133;
C_L1 = 6.5261838e-7; % 0.064 L/cmH2O into m^3/Pa
C_L2 = 6.5261838e-7;
R_ETT1 = 980000*0.8; % DOI: 10.1378/chest.96.6.1374
R_ETT2 = 980000*0.8; % and 10.31744/einstein_journal/2020AO4805
% the factor of 0.8 was taken
% from Campbell & Brown (1963)

% === artificial patients ====
R_aL1 = 196000; % want 2.0cmH2O/L/s
R_aL2 = 196000;
C_aL1 = 6.5261838e-7; % 0.064 L/cmH2O into m^3/Pa
C_aL2 = 6.5261838e-7;
% =======

R_E1 = 3150;
R_E2 = 3150;
R_O = 0;

RR = 15;
I = 1;
E = 2;
IE_ratio = I/E;
% ... and save them with a useful name
save(fullfile('parameterfiles', 'Ventilator_Electrical_Parameters_CHOSEN.mat'));


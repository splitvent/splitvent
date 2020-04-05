function [param_struct] = getInitialParameters(param_config)
% GET MODEL PARAMETERS STRUCTURE. Creates a structure which contains all
% the model parameters. To be changed and run programatically using
% function runElectricalAnalogueModel.
%
%
if nargin < 1
    param_config = -1;
end
switch param_config
    case -1 % do not change parameters at all
        param_struct = [];        
    case {1, 11} % original configuration
        % Set the parameters...
        param_struct.v_M_exhale = 5;% Pa PEEP = 5cmH20
        param_struct.v_M_inhale = 20; % PIP = 20cmH2O
        param_struct.R_M = 1; % Pa*s/m^3
        % current = m^3/s
        % charge = m^3
        % tube length = 1.5 m?
        param_struct.R_U1 = 1; % change to R_V1
        param_struct.R_U2 = 1; % change to R_V2
        param_struct.R_D1 = 1; % change to R_I1
        param_struct.R_D2 = 1; % change to R_I2
        
        param_struct.R_L1 = 1e2; % want 2.0cmH2O/L/s
        param_struct.R_L2 = 1e2;
        param_struct.C_L1 = 1e-3; % 0.064 L/cmH2O into m^3/Pa
        param_struct.C_L2 = 2e-3;
        param_struct.R_ETT1 = 1e3;
        param_struct.R_ETT2 = 1e3;
        
        % === artificial patients ====
        param_struct.R_aL1 = 1e2; % want 2.0cmH2O/L/s
        param_struct.R_aL2 = 1e2;
        param_struct.C_aL1 = 1e-3; % 0.064 L/cmH2O into m^3/Pa
        param_struct.C_aL2 = 2e-3;
        % =======
        
        param_struct.R_E1 = 1;
        param_struct.R_E2 = 1;
        param_struct.R_O = 1;
        
        param_struct.RR = 15;
        param_struct.I = 1;
        param_struct.E = 2;
        
    case {2, 12} % Original SI Units
        % Set the parameters...
        param_struct.v_M_exhale = 490;% Pa PEEP = 5cmH20
        param_struct.v_M_inhale = 1960; % PIP = 20cmH2O
        param_struct.R_M = 4000; % Pa*s/m^3
        % current = m^3/s
        % charge = m^3
        % tube length = 1.5 m?
        param_struct.R_U1 = 4000;
        param_struct.R_U2 = 4000;
        param_struct.R_D1 = 4000;
        param_struct.R_D2 = 4000;
        
        param_struct.R_L1 = 196133; % want 2.0cmH2O/L/s
        param_struct.R_L2 = 196133;
        param_struct.C_L1 = 6.5261838e-7; % 0.064 L/cmH2O into m^3/Pa
        param_struct.C_L2 = 6.5261838e-7;
        param_struct.R_ETT1 = 1961330;
        param_struct.R_ETT2 = 1961330;
        
        % === artificial patients ====
        param_struct.R_aL1 = 196133; % want 2.0cmH2O/L/s
        param_struct.R_aL2 = 196133;
        param_struct.C_aL1 = 6.5261838e-7; % 0.064 L/cmH2O into m^3/Pa
        param_struct.C_aL2 = 6.5261838e-7;
        % =======
        
        param_struct.R_E1 = 4000;
        param_struct.R_E2 = 4000;
        param_struct.R_O = 4000;
        
        param_struct.RR = 15;
        param_struct.I = 1;
        param_struct.E = 2;
    case {3, 13} % SI Units - based on literature
        % Set the parameters...
        param_struct.v_M_exhale = 490;% Pa PEEP = 5cmH20
        param_struct.v_M_inhale = 1960; % PIP = 20cmH2O
        param_struct.R_M = 4000; % Pa*s/m^3
        % current = m^3/s
        % charge = m^3
        % tube length = 1.5 m?
        param_struct.R_U1 = 3150; % Poiseille law for straight laminar pipe
        param_struct.R_U2 = 3150; % assuming D = 22e-3 m, mu = 18.13e-6 Pa.s, 
        param_struct.R_D1 = 3150; % L = 1 m, => R = (128*mu*L)/(pi*D^4)
        param_struct.R_D2 = 3150;
        
        param_struct.R_L1 = 196133; % want 2.0cmH2O/L/s
        param_struct.R_L2 = 196133;
        param_struct.C_L1 = 6.5261838e-7; % 0.064 L/cmH2O into m^3/Pa
        param_struct.C_L2 = 6.5261838e-7;
        param_struct.R_ETT1 = 980000*0.8; % DOI: 10.1378/chest.96.6.1374
        param_struct.R_ETT2 = 980000*0.8; % and 10.31744/einstein_journal/2020AO4805
                                          % the factor of 0.8 was taken
                                          % from Campbell & Brown (1963)
        
        % === artificial patients ====
        param_struct.R_aL1 = 196000; % want 2.0cmH2O/L/s
        param_struct.R_aL2 = 196000;
        param_struct.C_aL1 = 6.5261838e-7; % 0.064 L/cmH2O into m^3/Pa
        param_struct.C_aL2 = 6.5261838e-7;
        % =======
        
        param_struct.R_E1 = 3150;
        param_struct.R_E2 = 3150;
        param_struct.R_O = 3150;
        
        param_struct.RR = 15;
        param_struct.I = 1;
        param_struct.E = 2;
end

if param_config > 10
    param_struct.R_M = 0;
    param_struct.R_O = 0;
end

param_struct.IE_ratio = param_struct.I/ param_struct.E;


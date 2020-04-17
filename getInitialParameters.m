function [param_struct] = getInitialParameters(param_config)
% GET MODEL PARAMETERS STRUCTURE. Creates a structure which contains all
% the model parameters. To be changed and run programatically using
% function runElectricalAnalogueModel.
%
%
if nargin < 1
    param_config = 'clinical';
end
switch param_config       
    case {'clinical', 'medical', 'clinicalunits', 'medicalunits'}
        % Set the parameters...
        param_struct.v_M_exhale = 5; % cmH2O (PEEP) 
        param_struct.v_M_inhale = 20; % (PIP) 
        param_struct.R_M = 0; % 

        param_struct.R_V1 = 0.06; % cmH2O/L/s
        param_struct.R_V2 = 0.06; 
        param_struct.R_I1 = 0.06; % tube length = 1.8 ms
        param_struct.R_I2 = 0.06; 
        param_struct.R_EV1 = 0;
        param_struct.R_EV2 = 0;
        
        param_struct.R_L1 = 2; 
        param_struct.R_L2 = 2;
        param_struct.C_L1 = 0.054; % L/cmH2O 
        param_struct.C_L2 = 0.054;
        param_struct.R_ETT1 = 8;
        param_struct.R_ETT2 = 8;
        
        % === artificial patients (bags)s ====
        param_struct.R_aL1 = 2; 
        param_struct.R_aL2 = 2;
        param_struct.C_aL1 = 0.054; 
        param_struct.C_aL2 = 0.054;
        % =======
        
        param_struct.R_E1 = 0.06;
        param_struct.R_E2 = 0.06;
        param_struct.R_O = 0;
        
        param_struct.RR = 15;
        param_struct.I = 1;
        param_struct.E = 2;
        
    case {'si', 'siunits','SIunits', 'SI'} % Original SI Units
         % Set the parameters...
        param_struct.v_M_exhale = 490; % cmH2O (PEEP) 
        param_struct.v_M_inhale = 1471; % (PIP) 
        param_struct.R_M = 0; % 

        param_struct.R_V1 = 5670; % cmH2O/L/s
        param_struct.R_V2 = 5670; 
        param_struct.R_I1 = 5670; % tube length = 1.8 ms
        param_struct.R_I2 = 5670; 
        param_struct.R_EV1 = 0;
        param_struct.R_EV2 = 0;
        
        param_struct.R_L1 = 196133; 
        param_struct.R_L2 = 196133;
        param_struct.C_L1 = 5.50647e-7; % L/cmH2O 
        param_struct.C_L2 = 5.50647e-7;
        param_struct.R_ETT1 = 784000;
        param_struct.R_ETT2 = 784000;
        
        % === artificial patients (bags)s ====
        param_struct.R_aL1 = 196133; 
        param_struct.R_aL2 = 196133;
        param_struct.C_aL1 = 5.50647e-7; 
        param_struct.C_aL2 = 5.50647e-7;
        % =======
        
        param_struct.R_E1 = 5670;
        param_struct.R_E2 = 5670;
        param_struct.R_O = 0;
        
        param_struct.RR = 15;
        param_struct.I = 1;
        param_struct.E = 2;
        
end

param_struct.IE_ratio = param_struct.I/ param_struct.E;


function [param_struct] = getParametersWithPatients(patient1, patient2, param_config)
% GET PARAMETER STRUCTURE WITH SPECIFIC COMPLIANCES FOR patient1 and
% patient2. Input values patientX are strings with the code: 
%
% Guide:
% PATIENT A: C_L @ 100% 
% PATIENT B: C_L @ 80% 
% PATIENT C: C_L @ 70%
% PATIENT D: C_L @ 60%
%
% param_config allows to choose between different parameter configurations
% [default=13 => 3 (literature SI Units) + 10 (RM=RO=0)]
%

if nargin < 3
    param_config = 13;
end

[param_struct] = getInitialParameters(param_config);

switch patient1
    case {'a', 'A'}
        factor1 = 1;
    case {'b', 'B'}
        factor1 = 0.8;
    case {'c', 'C'}
        factor1 = 0.7;
    case {'d', 'D'}
        factor1 = 0.6;
    otherwise
        disp('[ERROR] Specified patient not found.');
        factor1 = 1;
end

switch patient2
    case {'a', 'A'}
        factor2 = 1;
    case {'b', 'B'}
        factor2 = 0.8;
    case {'c', 'C'}
        factor2 = 0.7;
    case {'d', 'D'}
        factor2 = 0.6;
    otherwise
        disp('[ERROR] Specified patient not found.');
        factor2 = 1;
end

param_struct.C_L1 = factor1*param_struct.C_L1;
param_struct.C_L2 = factor2*param_struct.C_L2;
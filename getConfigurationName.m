function [strconfig] = getConfigurationName(param_config)
% GET MODEL PARAMETERS CONFIGURATION NAME. Simple string describing the
% configuration chosen. This file should be kept in parallel to
% getInitialParameters.m
%
%

if nargin < 1
    param_config = 'clinical';
elseif isstruct(param_config)
    strconfig = "User defined parameters";
    return;
end

switch param_config       
    case {'clinical', 'medical', 'clinicalunits', 'medicalunits'}
        strconfig = 'Clinical Units';
        
    case {'si', 'siunits','SIunits', 'SI'} % Original SI Units
        strconfig = 'SI Units';
       
    otherwise
        strconfig = 'New configuration';
end
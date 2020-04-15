function [peep] = getPEEP(t,y_patientX_Pressure, changeOutputToClinical)
% ESTIMATION OF PEEP from SIMULATION OUTPUT. Output in cmH2O
%

if nargin < 3 % default is to use clinical, so no change is required
    changeOutputToClinical = false;
end

if changeOutputToClinical == 1
    [peep, ~] = siunits2clinical(min(y_patientX_Pressure(t>5)), 'pressure');
else 
    peep = min(y_patientX_Pressure(t>5));
end
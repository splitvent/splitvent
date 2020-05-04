function [tv] = tidalVolume(t,y_patientX_Volume, changeOutputToClinical)
% ESTIMATION OF TIDAL VOLUME from SIMULATION OUTPUT. Output in cmH2O
%

if nargin < 3 % default is to use clinical, so no change is required
    changeOutputToClinical = false;
end

if changeOutputToClinical== 1
    diffMaxMinVolume = max(y_patientX_Volume(t>5)) - min(y_patientX_Volume(t>5));
    [tv, ~] = siunits2clinical(diffMaxMinVolume, 'volume');
else 
    tv = max(y_patientX_Volume(t>5)) - min(y_patientX_Volume(t>5));
end
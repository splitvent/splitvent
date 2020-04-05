function [tv] = tidalVolume(t,y_patientX_Volume)
% ESTIMATION OF TIDAL VOLUME from SIMULATION OUTPUT. Output in cmH2O
%

diffMaxMinVolume = max(y_patientX_Volume(t>5)) - min(y_patientX_Volume(t>5)); 
[tv, ~] = siunits2clinical(diffMaxMinVolume, 'volume');
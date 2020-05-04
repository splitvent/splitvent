function [res_mod, param_mod] = adjustTidalVolume(whichModel, paramUnits, results, parameters)
% ADJUST TIDAL VOLUME for GROUPS of PATIENTS. 
% 

expnames = fieldnames(results);

for ix=1:length(expnames)
    thisPair = expnames{ix};
    spltvnt_info(sprintf('Patients: %s', thisPair));
    [res_mod.(thisPair), param_mod.(thisPair)] = adjustPairTidalVolume(...
        whichModel, paramUnits, results.(thisPair), parameters.(thisPair));
end
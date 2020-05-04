function [parameters, results] = runExperiment(whichModel, param_config, patientPairs, verbose)
% RUN EXPERIMENT. Utilises function RUNELECTRICALANALOGUEMODEL function on
% pairs of patients specified in cell array 'patientPairs's. Function does
% not return times or signals.
% 

if nargin < 4
    verbose = false;
end

numExp = length(patientPairs);
change2clinical = strcmpi(param_config,'siunits');
for ix=1:numExp
    pair = patientPairs{ix}; 
    
    patient1 = pair(1);
    patient2 = pair(2);
    
    spltvnt_info(sprintf('Patient 1 [%s], Patient2 [%s]', patient1, patient2));
    parameters.(pair) = getParametersWithPatients(patient1, patient2, param_config);
    [~, t.(pair), y.(pair)] = runElectricalAnalogueModel(whichModel, parameters.(pair), verbose);
    
    [tV, peep] = getTVandPEEP(t.(pair), y.(pair), change2clinical);
    
    results.(pair) = [siunits2clinical(parameters.(pair).v_M_inhale, 'pressure')...
        tV peep];
end


function [t, y, parameters, results] = runExperiment(whichModel, param_config, patientPairs)
% RUN EXPERIMENT. Utilises function RUNELECTRICALANALOGUEMODEL function on
% pairs of patients specified in cell array 'patientPairs's
% 

numExp = length(patientPairs);
change2clinical = strcmpi(param_config,'siunits');
for ix=1:numExp
    pair = patientPairs{ix}; 
    
    patient1 = pair(1);
    patient2 = pair(2);
    
    fprintf('Patient 1 [%s], Patient2 [%s]\n', patient1, patient2);
    parameters.(pair) = getParametersWithPatients(patient1, patient2, param_config);
    [~, t.(pair), y.(pair)] = runElectricalAnalogueModel(whichModel, parameters.(pair));
    
    tV = [tidalVolume(t.(pair), y.(pair)(1).Volume, change2clinical) ...
        tidalVolume(t.(pair), y.(pair)(2).Volume, change2clinical)];
    
    peep = [getPEEP(t.(pair), y.(pair)(1).Pressure, change2clinical)...
        getPEEP(t.(pair), y.(pair)(2).Pressure, change2clinical)];
    
    results.(pair) = [siunits2clinical(parameters.(pair).v_M_inhale, 'pressure')...
        tV peep];
end


%% DEMO FILE: Modified model - Equilibriate TV on different patients
% Using the runElectricalAnalogueModel function. The function takes two
% parameters: whichModel, param_config to select the model and select the
% parameters configuration.
%
% param_config can be either an integer or a structure with parameters to
% be used in the model.
%
% Guide:
% PATIENT A: C_L @ 100%
% PATIENT B: C_L @ 70%
% PATIENT C: C_L @ 60%
% PATIENT D: C_L @ 50%
%
%% Setup 
v_ = false; % verbose runElectricalAnalogueModel (default = false)
p_ = true;  % plot results (default = true)

%% Test 3

whichModel = 'modified'; 
paramUnits = 'siunits';  
patientpairs = {'Ab', 'Ac', 'Ad'};

[params_3, results_3] = runExperiment(whichModel, paramUnits, patientpairs);
[res_mod_3, param_mod_3] = adjustTidalVolume(whichModel, paramUnits, results_3, params_3);

%% Plots and results
if p_ == true 
    [t_3, y_3] = runExperimentsFromParameterStructures(whichModel, param_mod_3);
end

clc;

spltvnt_info('RESULTS. Display all tables generated');

spltvnt_info('\n\tModified model - Equilibriate different patients');
disp(resultsInTables(res_mod_3, param_mod_3, {'R_V1', 'R_V2'}));

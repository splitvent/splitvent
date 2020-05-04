%% DEMO FILE: Standard model - Different patients
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

%% Test 2: Standard model

whichModel = 'standard';
paramUnits = 'siunits'; % 
patientpairs = {'Ab', 'Ac', 'Ad'};

[params_2, results_2] = runExperiment(whichModel, paramUnits, patientpairs);
[res_mod_2, param_mod_2] = adjustTidalVolume(whichModel, paramUnits, results_2, params_2);

%% Plots and results
if p_ == true % plots will be created
   [t_2, y_2] = runExperimentsFromParameterStructures(whichModel, param_mod_2);
   plotStandardModel2_DifferentPatients;
end

spltvnt_info('RESULTS. Display all tables generated');
spltvnt_info('\tStandard model - control PIP where TV(1) < 490');
disp(resultsInTables(res_mod_2, param_mod_2));
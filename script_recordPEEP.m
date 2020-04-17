%% SCRIPT FILE: Tests where PEEP is recorded for different pairs of patients
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
%% Tests 1 and 2: Standard model

whichModel = 'standard';
param_config = 'siunits'; % 
patientpairs = {'Aa', 'Bb', 'Cc', 'Dd', 'Ab', 'Ac', 'Ad'};

[~, ~, params_1n2, results_1n2] = runExperiment(whichModel, param_config, patientpairs);

[res_mod_1n2, param_mod_1n2] = ...
    modifyVentilatorSettings(whichModel, param_config, results_1n2, params_1n2);

[t_1n2, y_1n2] = runExperimentsFromParameterStructures(whichModel, param_mod_1n2);

%% Test 3: Modified model - Equilibriate TV on different patients

whichModel = 'modified';
param_config = 'siunits'; % 
patientpairs = {'Ab', 'Ac', 'Ad'};

[~, ~, params_3, results_3] = runExperiment(whichModel, param_config, patientpairs);

[res_mod_3, param_mod_3] = ...
    modifyVentilatorSettings(whichModel, param_config, results_3, params_3);

[t_3, y_3] = runExperimentsFromParameterStructures(whichModel, param_mod_3);

%% Test 4: Modified model - Adjust TV on the same patient

whichModel = 'modified';
param_config = 'siunits'; % 
patientpairs = {'Cc'};

[~, ~, params_4, results_4] = runExperiment(whichModel, param_config, patientpairs);
[res_mod_4, param_mod_4] = modifyVentilatorSettings('standard', param_config, results_4, params_4);

[res_mod_4.Cc_increase, param_mod_4.Cc_increase] = adjustTV4matchingPatients(...
    whichModel, param_config, res_mod_4.Cc, param_mod_4.Cc,'increase', 0.3);

[res_mod_4.Cc_decrease, param_mod_4.Cc_decrease] = adjustTV4matchingPatients(...
    whichModel, param_config, res_mod_4.Cc, param_mod_4.Cc,'decrease', 0.3);

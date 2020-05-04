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
%% Setup 
v_ = false; % verbose runElectricalAnalogueModel (default = false)
p_ = true;  % plot results (default = true)


%% Tests 1 and 2: Standard model

whichModel = 'standard';
paramUnits = 'siunits'; % 
patientpairs = {'Aa', 'Bb', 'Cc', 'Dd', 'Ab', 'Ac', 'Ad'};

[params_1n2, results_1n2] = runExperiment(whichModel, paramUnits, patientpairs);
[res_mod_1n2, param_mod_1n2] = adjustTidalVolume(whichModel, paramUnits, results_1n2, params_1n2);

if p_ == true % plots will be created
   [t_1n2, y_1n2] = runExperimentsFromParameterStructures(whichModel, param_mod_1n2);
   script_plotStandardModelTests_1n2;
end
%% Test 3: Modified model - Equilibriate TV on different patients

whichModel = 'modified'; 
paramUnits = 'siunits';  
patientpairs = {'Ab', 'Ac', 'Ad'};

[params_3, results_3] = runExperiment(whichModel, paramUnits, patientpairs);
[res_mod_3, param_mod_3] = adjustTidalVolume(whichModel, paramUnits, results_3, params_3);

if p_ == true 
    [t_3, y_3] = runExperimentsFromParameterStructures(whichModel, param_mod_3);
end

%% Test 4: Modified model - Adjust TV on the same patient

whichModel = 'modified';
paramUnits = 'siunits'; % 
patientpairs = {'Cc'};

[params_4, results_4] = runExperiment(whichModel, paramUnits, patientpairs);
params_4.Cc.R_V1 = 0;
params_4.Cc.R_V2 = 0;
[res_mod_4.Cc, param_mod_4.Cc] = adjustPairTidalVolume('standard', paramUnits, results_4.Cc, params_4.Cc);

options.option = 'increase';
options.percentage = 30;
[res_mod_4.(['Cc_' options.option]), ...
 param_mod_4.(['Cc_' options.option])] = adjustPairTidalVolume(...
    whichModel, paramUnits, res_mod_4.Cc, param_mod_4.Cc, options);

options.option = 'decrease';
options.percentage = 0.30;
[res_mod_4.(['Cc_' options.option]), ...
 param_mod_4.(['Cc_' options.option])] = adjustPairTidalVolume(...
    whichModel, paramUnits, res_mod_4.Cc, param_mod_4.Cc, options);

if p_==true
    [t_4, y_4] = runExperimentsFromParameterStructures(whichModel, param_mod_4);
end
    
%% Display all tables
clc;

spltvnt_info('RESULTS. Display all tables generated');
spltvnt_info('\tStandard model - control PIP where TV(1) < 490');
disp(resultsInTables(res_mod_1n2, param_mod_1n2));

spltvnt_info('\n\tModified model - Equilibriate different patients');
disp(resultsInTables(res_mod_3, param_mod_3, {'R_V1', 'R_V2'}));

spltvnt_info('\n\tModified model - control TV in equal patients');
disp(resultsInTables(res_mod_4, param_mod_4, {'R_V1', 'R_V2'}));


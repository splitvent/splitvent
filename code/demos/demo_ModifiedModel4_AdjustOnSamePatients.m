
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

%% Plots and results

if p_==true
    [t_4, y_4] = runExperimentsFromParameterStructures(whichModel, param_mod_4);
    plotModifiedModel4_AdjustOnSamePatients;
end

clc;

spltvnt_info('RESULTS. Display all tables generated');
spltvnt_info('\n\tModified model - control TV in equal patients');
disp(resultsInTables(res_mod_4, param_mod_4, {'R_V1', 'R_V2'}, paramUnits));


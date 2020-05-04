%% SCRIPT FILE: Tests where PEEP is controlled for an Aa pair of patients
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

whichModel = 'IEcontrol';
param_config = 'siunits'; %
patientpairs = {'Aa'};

[tnormal, ynormal, parameters, results] = runExperiment(whichModel, param_config, patientpairs);
parameters.Aa_mod = parameters.Aa;
parameters.Aa_mod.R_EV1 = 5*parameters.Aa.R_ETT1;

[~, t, y] = runElectricalAnalogueModel(whichModel, parameters.Aa_mod);
if strcmpi(param_config, 'siunits')
    results.Aa_mod = [siunits2clinical(parameters.Aa_mod.v_M_inhale, 'pressure') ...
        tidalVolume(t,y(1).Volume, true) tidalVolume(t,y(2).Volume, true)...
        getPEEP(t,y(1).Pressure, true) getPEEP(t,y(2).Pressure, true)];
else
    results.Aa_mod = [parameters.Aa_mod.v_M_inhale...
        tidalVolume(t,y(1).Volume) tidalVolume(t,y(2).Volume)...
        getPEEP(t,y(1).Pressure) getPEEP(t,y(2).Pressure)];
end

%%
disp(results);
figure(3)
varnames = {'pressure', 'volume', 'flow', 'modifiedvol'};

for ix=1:4
    subplot(4,1,ix)
    plotSingleVariable(t,y(1),varnames{ix})
    hold on
    plotSingleVariable(t,y(2),varnames{ix})
    hold off
    [~, newyticks] = siunits2clinical(yticks, varnames{ix});
    yticklabels(newyticks);
    title(upper(varnames{ix}));
    legend({'REV1=RETT', 'REV2=0'}, 'Location', 'northeast', ...
        'Orientation', 'horizontal')
end




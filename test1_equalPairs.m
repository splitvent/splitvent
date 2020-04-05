%% SCRIPT FILE: TEST 1. Equal pairs for model validation 
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
%% Tidy up
clc;

% whichModel = 10; % 0 + 10 (US_PHS recommendations)
whichModel = 'standard';
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)
modR_I = 3150*1.8;
modR_E = 3150*1.8;
modC_L = 5.50646758e-07; % 54 ml/cmH2O
modPIP = 15*98.0665; % PIP @ 15 cmH2O

%% TWO PATIENTs A
disp('STEP 1. TWO PATIENTs A');

[param_stepA] = getInitialParameters(param_config);

% On-the-fly modifications to the parameters
param_stepA.v_M_inhale = modPIP;
param_stepA.R_D1 = modR_I;
param_stepA.R_D2 = modR_I;
param_stepA.R_E1 = modR_E;
param_stepA.R_E2 = modR_E;
param_stepA.C_L1 = modC_L;
param_stepA.C_L2 = modC_L;

[sim_stepA, t_stepA, y_stepA] = ...
    runElectricalAnalogueModel(whichModel, param_stepA);

tVaa = [tidalVolume(t_stepA, y_stepA(1).Volume) tidalVolume(t_stepA, y_stepA(2).Volume)];
results.Aa = [tVaa (tVaa(2)-tVaa(1))];

%% TWO PATIENTs B
disp('STEP 2. TWO PATIENTs B');

[param_stepB] = getParametersWithPatients('B', 'B', param_config);
% On-the-fly modifications to the parameters
param_stepB.v_M_inhale = modPIP; % PIP @ 15 cmH2O
param_stepB.R_D1 = modR_I;
param_stepB.R_D2 = modR_I;
param_stepB.R_E1 = modR_E;
param_stepB.R_E2 = modR_E;
param_stepB.C_L1 = 0.8*modC_L;
param_stepB.C_L2 = 0.8*modC_L;

[sim_stepB, t_stepB, y_stepB] = ...
    runElectricalAnalogueModel(whichModel, param_stepB);

tVbb = [tidalVolume(t_stepB, y_stepB(1).Volume) tidalVolume(t_stepB, y_stepB(2).Volume)];
results.Bb = [tVbb (tVbb(2)-tVbb(1))];

%% TWO PATIENTs C
disp('STEP 3. TWO PATIENTs C');

[param_stepC] = getParametersWithPatients('C', 'C', param_config);
% On-the-fly modifications to the parameters
param_stepC.v_M_inhale = modPIP; % PIP @ 15 cmH2O
param_stepC.R_D1 = modR_I;
param_stepC.R_D2 = modR_I;
param_stepC.R_E1 = modR_E;
param_stepC.R_E2 = modR_E;
param_stepC.C_L1 = 0.7*modC_L;
param_stepC.C_L2 = 0.7*modC_L;

[sim_stepC, t_stepC, y_stepC] = ...
    runElectricalAnalogueModel(whichModel, param_stepC);

tVcc = [tidalVolume(t_stepC, y_stepC(1).Volume) tidalVolume(t_stepC, y_stepC(2).Volume)];
results.Cc = [tVcc (tVcc(2)-tVcc(1))];

%% TWO PATIENTs D
disp('STEP 4. TWO PATIENTs D');

[param_stepD] = getParametersWithPatients('D', 'D', param_config);
% On-the-fly modifications to the parameters
param_stepD.v_M_inhale = modPIP; % PIP @ 15 cmH2O
param_stepD.R_D1 = modR_I;
param_stepD.R_D2 = modR_I;
param_stepD.R_E1 = modR_E;
param_stepD.R_E2 = modR_E;
param_stepD.C_L1 = 0.6*modC_L;
param_stepD.C_L2 = 0.6*modC_L;

[sim_stepD, t_stepD, y_stepD] = ...
    runElectricalAnalogueModel(whichModel, param_stepD);

tVdd = [tidalVolume(t_stepD, y_stepD(1).Volume) tidalVolume(t_stepD, y_stepD(2).Volume)];
results.Dd = [tVdd (tVdd(2)-tVdd(1))];

%% Set variable name to pressure

varName = 'pressure';
figure(11)
set(gcf, 'Position', [36         101        1556         879]);
subplot(211)
plotSingleVariable(t_stepA, y_stepA(1), varName, '-+');
hold on;
plotSingleVariable(t_stepB, y_stepB(1), varName, '-');
plotSingleVariable(t_stepC, y_stepC(1), varName, '--');
plotSingleVariable(t_stepD, y_stepD(1), varName, '-.');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

plotSingleVariable(t_stepA, y_stepA(1), 'control', ':k');

hold off;
grid on;

legend({'Pressure A(1)', 'B(1)', 'C(1)', ...
    'D(1)', 'Control'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Different patients', varName), 'FontSize', 20);

subplot(212)
plotSingleVariable(t_stepA, y_stepA(2), varName, '-+');
hold on;
plotSingleVariable(t_stepB, y_stepB(2), varName, '-');
plotSingleVariable(t_stepC, y_stepC(2), varName, '--');
plotSingleVariable(t_stepD, y_stepD(2), varName, '-.');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

plotSingleVariable(t_stepA, y_stepA(2), 'control', ':k');

hold off;
grid on;

legend({'Pressure A(2)', 'B(2)', 'C(2)', ...
    'D(2)', 'Control'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Different patients', varName), 'FontSize', 20);


varName = 'volume';
figure(12)
set(gcf, 'Position', [36         101        1556         879]);
subplot(211)
plotSingleVariable(t_stepA, y_stepA(1), varName, '-+');
hold on;
plotSingleVariable(t_stepB, y_stepB(1), varName, '-');
plotSingleVariable(t_stepC, y_stepC(1), varName, '--');
plotSingleVariable(t_stepD, y_stepD(1), varName, '-.');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'Volume A(1)', 'B(1)', 'C(1)', ...
    'D(1)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Different patients', varName), 'FontSize', 20);

subplot(212)
plotSingleVariable(t_stepA, y_stepA(2), varName, '-+');
hold on;
plotSingleVariable(t_stepB, y_stepB(2), varName, '-');
plotSingleVariable(t_stepC, y_stepC(2), varName, '--');
plotSingleVariable(t_stepD, y_stepD(2), varName, '-.');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'Volume A(2)', 'B(2)', 'C(2)', ...
    'D(2)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Different patients', varName), 'FontSize', 20);

varName = 'flow';
figure(13)
set(gcf, 'Position', [36         101        1556         879]);
subplot(211)
plotSingleVariable(t_stepA, y_stepA(1), varName, '-+');
hold on;
plotSingleVariable(t_stepB, y_stepB(1), varName, '-');
plotSingleVariable(t_stepC, y_stepC(1), varName, '--');
plotSingleVariable(t_stepD, y_stepD(1), varName, '-.');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'Flow A(1)', 'B(1)', 'C(1)', ...
    'D(1)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Different patients', varName), 'FontSize', 20);

subplot(212)
plotSingleVariable(t_stepA, y_stepA(2), varName, '-+');
hold on;
plotSingleVariable(t_stepB, y_stepB(2), varName, '-');
plotSingleVariable(t_stepC, y_stepC(2), varName, '--');
plotSingleVariable(t_stepD, y_stepD(2), varName, '-.');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'Flow A(2)', 'B(2)', 'C(2)', ...
    'D(2)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);

title(sprintf('Comparison of %s - Different patients', varName), 'FontSize', 20);

figure(14) % Modified Volume
set(gcf, 'Position', [36         101        1556         879]);
varName = 'ModifiedVol';
subplot(211)
plotSingleVariable(t_stepA, y_stepA(1), varName, '-+');
hold on;
plotSingleVariable(t_stepB, y_stepB(1), varName, '-');
plotSingleVariable(t_stepC, y_stepC(1), varName, '--');
plotSingleVariable(t_stepD, y_stepD(1), varName, '-.');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'Volume A(1)', 'B(1)', 'C(1)', ...
    'D(1)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Different patients', varName), 'FontSize', 20);

subplot(212)
plotSingleVariable(t_stepA, y_stepA(2), varName, '-+');
hold on;
plotSingleVariable(t_stepB, y_stepB(2), varName, '-');
plotSingleVariable(t_stepC, y_stepC(2), varName, '--');
plotSingleVariable(t_stepD, y_stepD(2), varName, '-.');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'Volume A(2)', 'B(2)', 'C(2)', ...
    'D(2)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Different patients', varName), 'FontSize', 20);


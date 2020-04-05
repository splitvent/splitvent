%% SCRIPT FILE: Tests with discrepancies in patients
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

%% Patients discrepancies
disp('Discrepancies in patients');

patient1 = {'A', 'B', 'C', 'D'};
perc = [1 0.8 0.7 0.60];
patient2 = {'a', 'b', 'c', 'd'};

for ix=1:length(patient1)
    for jx=(ix+1):length(patient2)
        fprintf('Patient 1 [%s], Patient2 [%s]\n', patient1{ix}, patient2{jx});
        whichPair = [patient1{ix} patient2{jx}]; % for handling the output structure
        param_struct.(whichPair) = ...
            getParametersWithPatients(patient1{ix}, patient2{jx}, param_config);
        
        % On-the-fly modifications to the parameters
        param_struct.(whichPair).v_M_inhale = modPIP;
        param_struct.(whichPair).R_D1 = modR_I;
        param_struct.(whichPair).R_D2 = modR_I;
        param_struct.(whichPair).R_E1 = modR_E;
        param_struct.(whichPair).R_E2 = modR_E;
        param_struct.(whichPair).C_L1 = modC_L*perc(ix);
        param_struct.(whichPair).C_L2 = modC_L*perc(jx);
        
        
        [~, t.(whichPair), y.(whichPair)] = ...
            runElectricalAnalogueModel(whichModel, param_struct.(whichPair));
        tV = [tidalVolume(t.(whichPair), y.(whichPair)(1).Volume) tidalVolume(t.(whichPair), y.(whichPair)(2).Volume)];
        results.(whichPair) = [tV (tV(2)-tV(1))];
    end
end

%% Comparison plots - All vs all
figure(21)
set(gcf, 'Position', [36         101        1556         879]);
plotPairwiseComparison(t, y, 'pressure');
figure(22)
set(gcf, 'Position', [36         101        1556         879]);
plotPairwiseComparison(t, y, 'volume');
figure(23)
set(gcf, 'Position', [36         101        1556         879]);
plotPairwiseComparison(t, y, 'flow');
figure(24)
set(gcf, 'Position', [36         101        1556         879]);
plotPairwiseComparison(t, y, 'modifiedVol');



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
param_config = 'siunits'; % 

%% Patients discrepancies
disp('Discrepancies in patients');

patient1 = {'A', 'B', 'C', 'D'};
patient2 = {'a', 'b', 'c', 'd'};

for ix=1:length(patient1)
    for jx=(ix+1):length(patient2)
        fprintf('Patient 1 [%s], Patient2 [%s]\n', patient1{ix}, patient2{jx});
        
        whichPair = [patient1{ix} patient2{jx}]; % for handling the output structure
        param_struct.(whichPair) = getParametersWithPatients(patient1{ix}, patient2{jx}, param_config);      
        
        [~, t.(whichPair), y.(whichPair)] = runElectricalAnalogueModel(whichModel, param_struct.(whichPair));
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



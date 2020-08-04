% SCRIPT. CREATE CSV TABLES PER FIGURE. Given the manuscript submitted to
% RSOS (DOI:10.1101/2020.04.07.20056309), this produces the data necessary
% to produce the four figures (Fig 3B, 4B, 5B and 6B) and stores them into
% CSV files in the SPLTVNTHOME_ variable (this can be generated using the
% configureSplitvent script).
%
% This script must be run ater running the script_run program. 

path2csv = SPLTVNTHOME_; % run configureSplitvent to regenerate this variable.
fig3bprefix = 'Fig3B_standardSplitter_PressureVolumeFlow_PatientModelsAtoD_';
fig4bprefix = 'Fig4B_standardSplitter_comparison_PressureVolumeFlow_dissimilarPatientModels_';
fig5bprefix = 'Fig5B_modifiedSplitter_normaliseTidalVolume_dissimilarPatientModels_';
fig6bprefix = 'Fig6B_modifiedSplitter_adjustTidalVolume_Patients_C_C_';

csv_1n2 = createCSVtablesFromOutputs(t_1n2, y_1n2);
csv_3 = createCSVtablesFromOutputs(t_3, y_3);
csv_4 = createCSVtablesFromOutputs(t_4, y_4);

% Figure 3B
writetable(csv_1n2.Aa(:,1:6), fullfile(path2csv, [fig3bprefix 'LungModelA.csv']));
writetable(csv_1n2.Bb(:,1:6), fullfile(path2csv, [fig3bprefix 'LungModelB.csv']));
writetable(csv_1n2.Cc(:,1:6), fullfile(path2csv, [fig3bprefix 'LungModelC.csv']));
writetable(csv_1n2.Dd(:,1:6), fullfile(path2csv, [fig3bprefix 'LungModelD.csv']));

% Figure 4B
writetable(csv_1n2.Ab, fullfile(path2csv, [fig4bprefix 'Patients_A_B.csv']));
writetable(csv_1n2.Ac, fullfile(path2csv, [fig4bprefix 'Patients_A_C.csv']));
writetable(csv_1n2.Ad, fullfile(path2csv, [fig4bprefix 'Patients_A_D.csv']));

% Figure 5B
writetable(csv_3.Ab, fullfile(path2csv, [fig5bprefix 'Patients_A_B.csv']));
writetable(csv_3.Ac, fullfile(path2csv, [fig5bprefix 'Patients_A_C.csv']));
writetable(csv_3.Ad, fullfile(path2csv, [fig5bprefix 'Patients_A_D.csv']));

% Figure 6B
writetable(csv_4.Cc, fullfile(path2csv, [fig6bprefix 'baseline.csv']));
writetable(csv_4.Cc_decrease, fullfile(path2csv, [fig6bprefix 'decrease.csv']));
writetable(csv_4.Cc_increase, fullfile(path2csv, [fig6bprefix 'increase.csv']));
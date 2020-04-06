% Run everything

tic;
%% Identical patients - standard splitter
test1_equalPairs;
clear t y;

%% Different patients (Ab, Ac, Ad) - standard splitter
test2_differentPatients;
script_reachPIP490;

%% Equilibriating different patients' tidal volume - modified splitter.
test3_maintainTVratios_Ab;
test3_maintainTVratios_Ac;
test3_maintainTVratios_Ad;
test3_plots;

%% Adjusting tidal volume for identical patients - modified splitter.
test4_varyingRatiosForEqualPatients;
TIMERUN=toc;

%% Display table results
disp('table_test1_and_test2');
disp(table_test1_and_test2);

disp('table_test3');
disp(table_test3);

disp('table_test4')
disp(table_test4);

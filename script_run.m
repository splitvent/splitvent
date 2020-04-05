% Run everything

tic; 
test1_equalPairs;
clear t y;
test2_differentPatients;
script_reachPIP490;

test3_maintainTVratios_Ab;
test3_maintainTVratios_Ac;
test3_maintainTVratios_Ad;
test3_plots;
test4_varyingRatiosForEqualPatients;
TIMERUN=toc;

%% 
disp('table_test3');
disp(table_test3);

disp('table_test4')
disp(table_test4);
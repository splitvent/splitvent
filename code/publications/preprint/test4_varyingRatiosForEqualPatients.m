%% Tidy up
clc;

whichModel = 'modified';
param_config = 'siunits';
change2clinical = true;

%% TWO PATIENTs C - baseline
disp('STARTING POINT: TWO PATIENTs C');

%param_base = PARAMS.Cc;

param_base.R_V1 = 0;
param_base.R_V2 = 0;

[~, t_base, y_base] = runElectricalAnalogueModel(whichModel, param_base);
tVcc = [tidalVolume(t_base, y_base(1).Volume, change2clinical)...
    tidalVolume(t_base, y_base(2).Volume, change2clinical)];
peepCc = [getPEEP(t_base, y_base(1).Pressure, change2clinical) ...
    getPEEP(t_base, y_base(2).Pressure, change2clinical)];

resultstest4.Cc = [tVcc peepCc];

table_test4.PIP(1) = param_base.v_M_inhale/98.0665;
table_test4.RV1(1) = param_base.R_V1;
table_test4.RV2(1) = param_base.R_V2;
table_test4.tv1(1) = tVcc(1);
table_test4.tv2(1) = tVcc(2);
table_test4.peep1(1) = peepCc(1);
table_test4.peep2(1) = peepCc(2);

%% decrease TV2 by 30%
newR_V1 = 3150;
factorV1 = 10;
finished = false;
iter=1;
while ~finished
    param_struct = param_base;
    param_struct.R_V2 = newR_V1*(200+factorV1);
    
    [~, t, y] = runElectricalAnalogueModel(whichModel, param_struct);
    tv1 = tidalVolume(t, y(1).Volume, change2clinical);
    tv2 = tidalVolume(t, y(2).Volume, change2clinical);
    peep1 = getPEEP(t, y(1).Pressure, change2clinical);
    peep2 = getPEEP(t, y(2).Pressure, change2clinical);
    
    fprintf('%d | %3.2f, %3.2f, %3.2f\n', iter, tv1, tv2, tv1/tv2);
    factorV1 = factorV1 + 10;
    iter=iter+1;
    finished = tv1/tv2 > 1.3 || iter>50;
end
resultstest4.Cc_decreaseTV2 = [tv1 tv2 peep1 peep2];
t_decrease = t;
y_decrease = y;
fprintf('PIP=%3.2f, R_V2=%3.2f, TV1=%3.2f, TV2=%3.2f\n', ...
    param_struct.v_M_inhale/98.0665, param_struct.R_V2, tv1, tv2);

table_test4.PIP(2) = param_struct.v_M_inhale/98.0665; % conversion to SI units
table_test4.RV1(2) = param_struct.R_V1;
table_test4.RV2(2) = param_struct.R_V2;
table_test4.tv1(2) = tv1;
table_test4.tv2(2) = tv2;
table_test4.peep1(2) = peep1;
table_test4.peep2(2) = peep2;

%% increase TV2 by 30%
factorPIP = 98.0665/3;
finished = false;

iter=1;
while ~finished
    param_struct = param_base;
    param_struct.v_M_inhale = param_base.v_M_inhale+factorPIP;
    
    [~, t, y] = runElectricalAnalogueModel(whichModel, param_struct);
    tv1 = tidalVolume(t, y(1).Volume, change2clinical);
    tv2 = tidalVolume(t, y(2).Volume, change2clinical);
    
    fprintf('%d | %3.2f, %3.2f, %3.2f\n', iter, tv1, tv2, tv2/tv1);
    factorPIP = factorPIP + 98.0665/3;
    iter=iter+1;
    finished = (tv1/resultstest4.Cc_decreaseTV2(1))>1.3 || iter>50;
end

newR_V1 = 3150; % value in SI units
factorV1 = 10;
finished = false;
iter=1;
while ~finished
    param_struct.R_V1 = newR_V1*(200+factorV1);
    
    [~, t, y] = runElectricalAnalogueModel(whichModel, param_struct);
    tv1 = tidalVolume(t, y(1).Volume, change2clinical);
    tv2 = tidalVolume(t, y(2).Volume, change2clinical);
    peep1 = getPEEP(t, y(1).Pressure, change2clinical);
    peep2 = getPEEP(t, y(2).Pressure, change2clinical);
    
    fprintf('%d | %3.2f, %3.2f, %3.2f\n', iter, tv1, tv2, tv2/tv1);
    factorV1 = factorV1 + 10;
    iter=iter+1;
    finished = tv2/tv1 > 1.3 || iter>50;
end
t_increase = t;
y_increase = y;
resultstest4.Cc_increaseTV2 = [tv1 tv2 peep1 peep2];
fprintf('PIP=%3.2f, R_V1=%3.2f, TV1=%3.2f, TV2=%3.2f\n', ...
    param_struct.v_M_inhale/98.0665, param_struct.R_V1, tv1, tv2);

table_test4.PIP(3) = param_struct.v_M_inhale/98.0665;
table_test4.RV1(3) = param_struct.R_V1;
table_test4.RV2(3) = param_struct.R_V2;
table_test4.tv1(3) = tv1;
table_test4.tv2(3) = tv2;
table_test4.peep1(3) = peep1;
table_test4.peep2(3) = peep2;

%% PLOTs

varName = 'pressure';
figure(41)
set(gcf, 'Position', [36         101        1556         879]);
subplot(211)
plotSingleVariable(t_base, y_base(1), varName, '-+');
hold on;
plotSingleVariable(t_decrease, y_decrease(1), varName, '-');
plotSingleVariable(t_increase, y_increase(1), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'Base', 'Decrease 30%', 'Increase %30'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Adjust TV for identical patients (CC)', varName), 'FontSize', 20);

subplot(212)
plotSingleVariable(t_base, y_base(2), varName, '-+');
hold on;
plotSingleVariable(t_decrease, y_decrease(2), varName, '-');
plotSingleVariable(t_increase, y_increase(2), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);


hold off;
grid on;

legend({'Base', 'Decrease 30%', 'Increase %30'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Adjust TV for identical patients (CC)', varName), 'FontSize', 20);


varName = 'volume';
figure(42)
set(gcf, 'Position', [36         101        1556         879]);
subplot(211)
plotSingleVariable(t_base, y_base(1), varName, '-+');
hold on;
plotSingleVariable(t_decrease, y_decrease(1), varName, '-');
plotSingleVariable(t_increase, y_increase(1), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'Base', 'Decrease 30%', 'Increase %30', ...
    }, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Adjust TV for identical patients (CC)', varName), 'FontSize', 20);

subplot(212)
plotSingleVariable(t_base, y_base(2), varName, '-+');
hold on;
plotSingleVariable(t_decrease, y_decrease(2), varName, '-');
plotSingleVariable(t_increase, y_increase(2), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'Base', 'Decrease 30%', 'Increase %30', ...
    }, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Adjust TV for identical patients (CC)', varName), 'FontSize', 20);

varName = 'flow';
figure(43)
set(gcf, 'Position', [36         101        1556         879]);
subplot(211)
plotSingleVariable(t_base, y_base(1), varName, '-+');
hold on;
plotSingleVariable(t_decrease, y_decrease(1), varName, '-');
plotSingleVariable(t_increase, y_increase(1), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'Base', 'Decrease 30%', 'Increase %30', ...
    }, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Adjust TV for identical patients (CC)', varName), 'FontSize', 20);

subplot(212)
plotSingleVariable(t_base, y_base(2), varName, '-+');
hold on;
plotSingleVariable(t_decrease, y_decrease(2), varName, '-');
plotSingleVariable(t_increase, y_increase(2), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'Base', 'Decrease 30%', 'Increase %30', ...
    }, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);

title(sprintf('Comparison of %s - Adjust TV for identical patients (CC)', varName), 'FontSize', 20);

figure(44) % Modified Volume
set(gcf, 'Position', [36         101        1556         879]);
varName = 'ModifiedVol';
subplot(211)
plotSingleVariable(t_base, y_base(1), varName, '-+');
hold on;
plotSingleVariable(t_decrease, y_decrease(1), varName, '-');
plotSingleVariable(t_increase, y_increase(1), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'Base', 'Decrease 30%', 'Increase %30', ...
    }, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Adjust TV for identical patients (CC)', varName), 'FontSize', 20);

subplot(212)
plotSingleVariable(t_base, y_base(2), varName, '-+');
hold on;
plotSingleVariable(t_decrease, y_decrease(2), varName, '-');
plotSingleVariable(t_increase, y_increase(2), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'Base', 'Decrease 30%', 'Increase %30', ...
   }, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Adjust TV for identical patients (CC)', varName), 'FontSize', 20);

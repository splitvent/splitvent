% you need the values for t,y for Ab, Ac and Ad
%
%

%%
varName = 'pressure';
figure(31)
set(gcf, 'Position', [36         101        1556         879]);
subplot(211)
plotSingleVariable(t_Ab, y_Ab(1), varName, '-+');
hold on;
plotSingleVariable(t_Ac, y_Ac(1), varName, '-');
plotSingleVariable(t_Ad, y_Ad(1), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'AB', 'AC', 'AD'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Equilibrating mismatched patients', varName), 'FontSize', 20);

subplot(212)
plotSingleVariable(t_Ab, y_Ab(2), varName, '-+');
hold on;
plotSingleVariable(t_Ac, y_Ac(2), varName, '-');
plotSingleVariable(t_Ad, y_Ad(2), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);


hold off;
grid on;

legend({'AB', 'AC', 'AD'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Equilibrating mismatched patients', varName), 'FontSize', 20);


varName = 'volume';
figure(32)
set(gcf, 'Position', [36         101        1556         879]);
subplot(211)
plotSingleVariable(t_Ab, y_Ab(1), varName, '-+');
hold on;
plotSingleVariable(t_Ac, y_Ac(1), varName, '-');
plotSingleVariable(t_Ad, y_Ad(1), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'AB', 'AC', 'AD', ...
    }, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Equilibrating mismatched patients', varName), 'FontSize', 20);

subplot(212)
plotSingleVariable(t_Ab, y_Ab(2), varName, '-+');
hold on;
plotSingleVariable(t_Ac, y_Ac(2), varName, '-');
plotSingleVariable(t_Ad, y_Ad(2), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'AB', 'AC', 'AD', ...
    }, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Equilibrating mismatched patients', varName), 'FontSize', 20);

varName = 'flow';
figure(33)
set(gcf, 'Position', [36         101        1556         879]);
subplot(211)
plotSingleVariable(t_Ab, y_Ab(1), varName, '-+');
hold on;
plotSingleVariable(t_Ac, y_Ac(1), varName, '-');
plotSingleVariable(t_Ad, y_Ad(1), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'AB', 'AC', 'AD', ...
    }, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Equilibrating mismatched patients', varName), 'FontSize', 20);

subplot(212)
plotSingleVariable(t_Ab, y_Ab(2), varName, '-+');
hold on;
plotSingleVariable(t_Ac, y_Ac(2), varName, '-');
plotSingleVariable(t_Ad, y_Ad(2), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'AB', 'AC', 'AD', ...
    }, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);

title(sprintf('Comparison of %s - Equilibrating mismatched patients', varName), 'FontSize', 20);

figure(34) % Modified Volume
set(gcf, 'Position', [36         101        1556         879]);
varName = 'ModifiedVol';
subplot(211)
plotSingleVariable(t_Ab, y_Ab(1), varName, '-+');
hold on;
plotSingleVariable(t_Ac, y_Ac(1), varName, '-');
plotSingleVariable(t_Ad, y_Ad(1), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'AB', 'AC', 'AD', ...
    }, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Equilibrating mismatched patients', varName), 'FontSize', 20);

subplot(212)
plotSingleVariable(t_Ab, y_Ab(2), varName, '-+');
hold on;
plotSingleVariable(t_Ac, y_Ac(2), varName, '-');
plotSingleVariable(t_Ad, y_Ad(2), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'AB', 'AC', 'AD', ...
   }, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Equilibrating mismatched patients', varName), 'FontSize', 20);

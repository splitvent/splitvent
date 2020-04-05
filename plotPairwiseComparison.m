function plotPairwiseComparison(t_struct, y_struct, variableName)
% PLOT PAIRWISE COMPARISON. Useful when comparing different patients.
%

mymark1 = {'+-', '+-', '+-', '-o', '-o', '-x'};
mymark2 = {'-o', '-x','-d', '-x','-d', '-d'};
pat1 = {'A', 'A', 'A', 'B', 'B', 'C'};
pat2 = {'B', 'C', 'D', 'C', 'D', 'D'};

experiment = fieldnames(y_struct); 
for ix=1:length(experiment)
    subplot(2,3,ix)
    plotSingleVariable(t_struct.(experiment{ix}), ...
        y_struct.(experiment{ix})(1), variableName, mymark1{ix});
    hold on;
    plotSingleVariable(t_struct.(experiment{ix}), ...
        y_struct.(experiment{ix})(2), variableName, mymark2{ix});
    if strcmpi(variableName, 'pressure')
        plotSingleVariable(t_struct.(experiment{ix}), ...
            y_struct.(experiment{ix})(1), 'control', ':k');
        legendCell = {pat1{ix}, pat2{ix}, 'Control'};
    else
        legendCell = {pat1{ix}, pat2{ix}};
    end
    [~, newyticks] = siunits2clinical(yticks, variableName);
    yticklabels(newyticks);
    
    hold off;
    grid on;

    legend(legendCell, 'Location', 'southoutside', ...
        'Orientation', 'horizontal', 'FontSize', 16);
    title(sprintf('Comparison of %s - %s', variableName, experiment{ix}), 'FontSize', 20);
end
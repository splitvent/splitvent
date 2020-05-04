function plotPairwiseComparison(t_struct, y_struct, variableName, patientpairs)
% PLOT PAIRWISE COMPARISON. Useful when comparing different patients.
%

if nargin < 4
    patientpairs = {'Ab', 'Ac', 'Ad', 'Bc', 'Bd', 'Cd'};
end

pat1={};
pat2={};
mymark1={};
mymark2={};
patNum = length(patientpairs);

for ix=1:patNum
    pat1=[pat1 {patientpairs{ix}(1)}];
    pat2=[pat2 {patientpairs{ix}(2)}];
    [mk1, mk2] = marksByPair(patientpairs{ix});
    mymark1 = [mymark1 {mk1}];
    mymark2 = [mymark2 {mk2}];
end
spr = 1;
spc = patNum;

experiment = fieldnames(y_struct);
for ix=1:patNum
    t=t_struct.(patientpairs{ix});
    y=y_struct.(patientpairs{ix});
    subplot(spr,spc,ix)
    plotSingleVariable(t, y(1), variableName, mymark1{ix});
    hold on;
    plotSingleVariable(t, y(2), variableName, mymark2{ix});
    if strcmpi(variableName, 'pressure')
        plotSingleVariable(t, y(1), 'control', ':k');
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
    title(sprintf('Comparison of %s - %s', variableName, patientpairs{ix}), 'FontSize', 20);
end


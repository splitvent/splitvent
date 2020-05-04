varNames = fieldnames(y_2.Aa);
varNames(1) = [];
expNames = fieldnames(y_2);

for ix=1:length(varNames)
    varName = varNames{ix};
    
    figure(20+ix)
    set(gcf, 'Position', [36         101        1556         500]);
    plotPairwiseComparison(t_2, y_2, varName, expNames);
    
end


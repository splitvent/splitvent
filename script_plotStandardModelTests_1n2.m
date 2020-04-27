% PLOT RESULTS FOR TESTS WITH STANDARD MODEL
%
%
%%

varNames = fieldnames(y_1n2.Aa);
varNames(1) = [];
expNames = fieldnames(y_1n2);
expNames1 = expNames(1:4);
expNames2 = expNames(5:7);

for ix=1:length(varNames)
    figure(10+ix)
    set(gcf, 'Position', [36         101        1556         879]);
    varName = varNames{ix};
    for k=1:2
        subplot(2,1,k)
        for jx=1:length(expNames1)
            patientpair = expNames{jx};
            [mk1, mk2] = marksByPair(patientpair);
            mks = {mk1 mk2};
            
            plotSingleVariable(t_1n2.(expNames1{jx}), y_1n2.(expNames1{jx})(k), ...
                varName, mks{k});
            if jx==1
                hold on;
            end
            if strcmpi(varName,'pressure')
            plotSingleVariable(t_1n2.(expNames1{1}), y_1n2.(expNames1{1})(1), 'control', ':k');
            s = ['(' num2str(k) ')'];
            legendArray = {[varName 32 'A' s], ['B' s], ['C' s], ['D' s], 'Control'};
        else
            legendArray = {[varName 32 'A' s], ['B' s], ['C' s], ['D' s]};
        end
        end
        
        [~, newyticks] = siunits2clinical(yticks, varName);
        yticklabels(newyticks);
        
        hold off;
        grid on;
        
        legend(legendArray, 'Location', 'southoutside','Orientation', 'horizontal', 'FontSize', 16);
        title(sprintf('Comparison of %s - Different patients', varName),'FontSize', 20);
    end
    
    figure(20+ix)
    set(gcf, 'Position', [36         101        1556         879]);
    plotPairwiseComparison(t_1n2, y_1n2, varName, expNames2);
    
end


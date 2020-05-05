% PLOT RESULTS FOR TESTS WITH MODIFIED MODEL
%
%
%%

varNames = fieldnames(y_4.Cc);
varNames(1) = [];
varNames(contains(varNames, 'Volume')) = [];
expNames = fieldnames(y_4);

figure(31)
subplotpos = [1 2; 3 4; 5 6];
for ix=1:length(varNames)
    set(gcf, 'Position', [36 101  879 1556]);
    varName = varNames{ix};
    for jx=1:length(expNames)
        for k=1:2
            
            patientpair = expNames{jx}(1:2);
            [mk1, mk2] = marksByPair(patientpair);
            mks = {mk1 mk2};
            
            subplot(3,2,subplotpos(ix, k))
            plotSingleVariable(t_4.(expNames{jx}), y_4.(expNames{jx})(k), ...
                varName, mks{k});
            if jx==1
                hold on;
            end
            s = ['(' num2str(k) ')'];
            legendArray = strcat(expNames',  s);
            [~, newyticks] = siunits2clinical(yticks, varName);
            yticklabels(newyticks);
            
            legend(legendArray, 'Location', 'southoutside','Orientation', 'horizontal', 'FontSize', 16);
            title(sprintf('Comparison of %s - Different patients', varName),'FontSize', 20);
            
        end
    end
    
    
    hold off;
    grid on;

end



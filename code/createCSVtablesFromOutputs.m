function [csv] = createCSVtablesFromOutputs(t, y, excludeVars)
% CREATE TABLES FROM OUTPUTS. Takes structures for time (t) and the
% different experiment outputs stored in y (e.g y.Aa, y.Bd, ...) and
% produces tables, which can later be put into CSV files using the matlab
% function writetable.
%

if nargin < 3
    excludeVars = {};
end

fnames = fieldnames(y);
varnames = {'Pressure', 'Flow', 'Volume', 'ModifiedVol'};

for ix=1:length(fnames)
    thisPair = fnames{ix};
    [p1, p2] = splitPairs(thisPair, ['_' upper(thisPair) '_']);
    time = t.(thisPair);
    
    wherestart = find(diff(y.(thisPair)(1).Control),2);
    wherestart(1) = [];
    whereend = find(diff(y.(thisPair)(1).Control));
    whereend(end) = [];
    whereend = whereend(end);
    
    T1 = struct2table(y.(thisPair)(1));
    T2 = struct2table(y.(thisPair)(2));
    
    T1.Control = siunits2clinical(T1.Control, 'Pressure');
    for qx=1:4
        T1.(varnames{qx}) = siunits2clinical(T1.(varnames{qx}), varnames{qx});
        T2.(varnames{qx}) = siunits2clinical(T2.(varnames{qx}), varnames{qx});
    end
    
    if ~isempty(excludeVars)
        for jx=1:length(excludeVars)
            T1.(excludeVars{jx}) = [];
            T2.(excludeVars{jx}) = [];
        end
    end
    
    if ~contains(excludeVars, 'Control')
        T2.Control = [];
    end
    
    T1.Properties.VariableNames = strcat(T1.Properties.VariableNames, p1);
    T2.Properties.VariableNames = strcat(T2.Properties.VariableNames, p2);
        
    csv.(thisPair) = [table(time) T1 T2];
    csv.(thisPair) = csv.(thisPair)(wherestart:whereend, :);
end

end
function T = resultsInTables(results, parameters, extraColumns, paramUnits)
% SAVE RESULTS IN TABLE STRUCTURE. Readability
%

if nargin < 3
    % no extracolumns
    xtravars = 0;
    extraColumns = {};
    extraVarTypes = {};
    paramUnits = 'clinical';
elseif nargin < 4
    paramUnits = 'clinical';
    if isempty(extraColumns)
        xtravars = 0;
        extraColumns = {};
        extraVarTypes = {};
    end
    
else
    xtravars = length(extraColumns);
    extraVarTypes = repmat({'double'}, 1, xtravars);
end

change2clinical = strcmpi(paramUnits,'siunits');

expnames = fieldnames(results);
exps = length(expnames); % rows
vars = 5 + xtravars; % cols

varTypes = [repmat({'double'}, 1, 5) extraVarTypes];
varNames = [{'PIP', 'TV1', 'TV2', 'PEEP1', 'PEEP2'} extraColumns];

T = table('Size', [exps vars], 'VariableTypes', varTypes, ...
    'VariableNames',  varNames, 'RowNames', expnames);

varUnits = {};
for ix=1:vars
    
    for jx=1:exps
        if jx==1
            varUnits = [varUnits {selectUnits(varNames{ix})}];
        end
        if ix<=5
            T.(varNames{ix})(jx) = results.(expnames{jx})(ix);
        else
            switch extraColumns{ix-5}(1)
                case 'R'
                    valueintable = siunits2clinical(...
                        parameters.(expnames{jx}).(extraColumns{ix-5}), 'resistance', ...
                        change2clinical);
                case 'C'
                    valueintable = siunits2clinical(parameters.(...
                        expnames{jx}).(extraColumns{ix-5}), 'compliance', ...
                        change2clinical);
                otherwise
                    valueintable = parameters.(expnames{jx}).(extraColumns{ix-5});
            end
            
            T.(varNames{ix})(jx) = valueintable;
        end
    end
    
end

T.Properties.VariableUnits = varUnits;

end


function [str] = selectUnits(varname)
ch = varname(1);
switch ch
    case 'R'
        str = 'cmH2O/L/s';
    case 'C'
        str = 'L/cmH2O';
    case 'P'
        str = 'cmH2O';
    case {'T', 'V'}
        str = 'mL';
    otherwise
        str = '';
end
end
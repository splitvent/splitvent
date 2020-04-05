function plotSingleVariable(t,y,varName, linestylevar)
% PLOT SINGLE VARIABLE. varName is a string with the variable to be plotted.
% 

if nargin < 4 
    linestylevar = '-';
end
wherestart = find(diff(y(1).Control),2);
wherestart(1) = [];

fnames = fieldnames(y);
if sum(contains(fnames, varName, 'IgnoreCase', true)) > 0
    whichField = contains(fnames, varName, 'IgnoreCase', true);
    plot(t(wherestart:end), y.(fnames{whichField})(wherestart:end), linestylevar, 'LineWidth', 2);
    axis tight
else
    disp('Structure variable name not found.');
end
    



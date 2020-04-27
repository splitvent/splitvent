function [t_struct, y_struct] = runExperimentsFromParameterStructures(whichModel, parameters, verbose)
% RUN EXPERIMENTS FROM PARAETER STRUCTURES. Utilises function RUNELECTRICALANALOGUEMODEL 
% function on configurations of structures defined in parameters. 
% 
% The objective ofthis function is to obtain the different signals per
% experiment defined in parameters structure. 
%
% For example: 
%       % First run your models and adjustments:
%       whichModel = 'standard';
%       paramUnits = 'siunits'; % 
%       patientpairs = {'Bb','Dd'};
%       [paramstruc, res] = runExperiment(whichModel, paramUnits, patientpairs);
%       [finalres, finalparamstruc] = adjustTidalVolume(whichModel, paramUnits, res, paramstruc);
%
%       % Then, for all patient pairs in this example, Bb and Dd, obtain
%       % the signal structures (t.Bb, y.Bb) and (t.Dd, y.Dd) with this function
%       [t,y] = runExperimentsFromParameterStructures(whichModel, finalparamstruc)
% 


if nargin < 3
    verbose = false;
end

expnames = fieldnames(parameters);
for ix=1:length(expnames)
    pair = expnames{ix};
    [~, t_struct.(pair), y_struct.(pair)] = ...
        runElectricalAnalogueModel(whichModel, parameters.(pair), verbose);
end
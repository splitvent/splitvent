function [t, y] = runExperimentsFromParameterStructures(whichModel, parameters)
%

expnames = fieldnames(parameters);
for ix=1:length(expnames)
    pair = expnames{ix};
    [~, t.(pair), y.(pair)] = runElectricalAnalogueModel(whichModel, parameters.(pair));
end
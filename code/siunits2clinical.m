function [vecout, cellout] = siunits2clinical(vecin, whichConversion)
% CONVERT PASCAL TO cmH2O. Optional cellarray of values for plotting.
% 

switch lower(whichConversion)
    case 'pressure'
        % pascal 2 cmh2o
        const = 0.0101972;
    case {'volume', 'modifiedvol'}
        % m^3 to mL
        const = 1e6;
    case 'flow'
        % m^3/s to L/min ?
        const = 60000;
    otherwise 
        const = 1;
end
        
vecout = vecin.*const;
cellout = cell(length(vecin), 1);

for ix=1:length(vecin)
    str = sprintf('%2.1f', vecout(ix));
    cellout{ix} = str;
end

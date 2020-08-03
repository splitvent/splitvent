function [vecout, cellout] = siunits2clinical(vecin, whichConversion, change2clinical)
% CONVERT SI UNITS TO CLINICAL. Converts SI units to clinical between the
% following values:
%
%               whichConversion:    SI UNITS    :   CLINICAL     :
%               ::::::::::::::::::::::::::::::::::::::::::::::::::
%                    Pressure  :        Pa      :    cm H20      :
%                    Volume    :       m^3      :      mL        :
%                    Flow      :      m^3/s     :     L/min      :
%                    Resistance:     Pa s/m^3   :  cm H20/L/s    :
%                    Compliance:      m^3/Pa    :   L/cm H2O     :
%

if nargin < 3
    change2clinical = true;
end

if change2clinical == false
    const = 1;
else
    
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
        case 'resistance'
            const = 0.06/5670;
        case 'compliance'
            const = 0.054/5.5e-7;
        otherwise
            const = 1;
    end
end

vecout = vecin.*const;
cellout = cell(length(vecin), 1);

for ix=1:length(vecin)
    str = sprintf('%2.1f', vecout(ix));
    cellout{ix} = str;
end

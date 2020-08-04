function [p1, p2] = splitPairs(patientpair, prefix)
% 
if nargin < 2
    prefix='';
end

p1 = strcat(prefix, '1', upper(patientpair(1)));
p2 = strcat(prefix, '2', upper(patientpair(2)));

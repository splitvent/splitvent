function [mk1, mk2] = marksByPair(patientpair)
% Helper function for plotting
p1 = patientpair(1);
p2 = patientpair(2);

switch p1
    case {'a', 'A'}
        mk1 = 'k-+';
    case {'b', 'B'}
        mk1 = 'k-';
    case {'c', 'C'}
        mk1 = 'k--';
    case {'d', 'D'}
        mk1 = 'k-.';
end

switch p2
    case {'a', 'A'}
        mk2 = 'k-+';
    case {'b', 'B'}
        mk2 = 'k-';
    case {'c', 'C'}
        mk2 = 'k--';
    case {'d', 'D'}
        mk2 = 'k-.';
end
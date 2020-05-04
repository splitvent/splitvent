function spltvnt_info(msg, condition2print)
% SPLITVENT INFO. Function for output to console based. Use jointly with
% sprintf. A breakline (\n) character is always print.
% confition2print = true (default), 
% if condition2print == false, then nothing gets shown in console.
% 

if nargin < 2
    condition2print = true;
end

if condition2print == true
    fprintf([msg '\n']);
end


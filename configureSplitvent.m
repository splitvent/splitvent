clc;

SPLTVNTHOME_ = pwd;
test_ = input(sprintf('Is this the right folder for splitvent? \n\t[%s]\n Y/N [Y]:',...
    SPLTVNTHOME_),'s');
if isempty(test_)
    test_='Y';
end

if strcmpi(test_, 'n')
    disp('Pick the location of splitvent');
    pause(0.5);
    SPLTVNTHOME_ = uigetdir(pwd,'Pick a directory');
end

fprintf('Adding the following to the MATLAB path:\n%s\n%s\n%s\n', ...
    fullfile(SPLTVNTHOME_, 'code'), ...
    fullfile(SPLTVNTHOME_, 'code', 'demos'), ...
    fullfile(SPLTVNTHOME_, 'code', 'publications', 'preprint'));

addpath(fullfile(SPLTVNTHOME_, 'code'), ...
    fullfile(SPLTVNTHOME_, 'code', 'demos'), ...
    fullfile(SPLTVNTHOME_, 'code', 'publications', 'preprint'));
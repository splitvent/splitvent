function [simout, t, y, y_adv] = runElectricalAnalogueModel(whichModel, param_config, verbose)
% RUN ELECTRICAL ANALOGUE MODEL ON SIMULINK. This function programatically
% can run any from the electrical analogue model
%
% USAGE: [simout] = runElectricalAnalogueModel(whichModel, param_config)
%
% INPUTS:   whichModel = 'baseline' - standard-splitter
%           whichModel = 'modified' - modified-splitter
%           whichModel = -1 => ssc_vent_splitter_electrical_single (model_single)
%           whichModel = 0  => ssc_vent_splitter_electrical (model_0)[default]
%           whichModel = 1  => ssc_vent_splitter_electrical_parallelbag (model_1)
%           whichModel = 2  => ssc_vent_splitter_electrical_seriesbag (model_2)
%           whichModel = 3  => ssc_vent_splitter_electrical_seriesbagpipe (model_3)
%
%           param_config = -1 (default) does not change anything
%           param_config = 1 Original parameter configuration.
%           param_config = 2 Original parameter configuration (SI units)
%

userDefinedParams = false;
if nargin < 3
    verbose = false;
end

if nargin == 0
    whichModel='standard';
elseif nargin < 2
    param_config = 'clinical';
elseif isstruct(param_config)
    userDefinedParams = true;
end

switch whichModel
    case {'baseline', 'standard'}
        mdl = fullfile('models','standard_splitter');
    case 'modified'
        mdl = fullfile('models','modified_splitter');
    case {'checkvalves', 'diodes'}
        mdl = fullfile('models','modified_splitter_checkvalves');
    case {'iecontrol', 'ie', 'IEcontrol', 'IE'}
        mdl = fullfile('models','modified_splitter_IEcontrol');
end

spltvnt_info(sprintf('[runModel] Running model [%s]', mdl), verbose);

mdl_handle = load_system(mdl);
mdlWks = get_param(mdl_handle,'ModelWorkspace');
if userDefinedParams == false
    [param_struct] = getInitialParameters(param_config);
else
    % the user can get a list of parameters and pass it as a structure inside
    % param_config.
    param_struct = param_config;
end

if ~isempty(param_struct)
    % a specific parameter configuration was asked for.
    spltvnt_info(sprintf('[runModel] Changing simulation parameters to: %s', ...
        getConfigurationName(param_config)), verbose);

    param_names = fieldnames(param_struct);
    for ix=1:length(param_names)
        assignin(mdlWks, param_names{ix}, param_struct.(param_names{ix}));
    end
end

spltvnt_info(sprintf('[runModel] Model loaded [%s] Running...', mdl), verbose);

simout = sim(mdl,'SaveOutput','on','StartTime', '0', 'StopTime', '15', ...
    'FixedStep', '1e-6','OutputSaveName','yOut', 'SaveTime','on',...
    'TimeSaveName','tOut', 'AbsTol','1e-9');

spltvnt_info(sprintf('[runModel] Finished.'), verbose);

if nargout > 1
    t = simout.ScopeData.time;
    y(1).Control = simout.ScopeData.signals(1).values;
    y(1).Pressure = simout.ScopeData.signals(2).values;
    y(1).Flow = simout.ScopeData.signals(3).values;
    y(1).Volume = simout.ScopeData.signals(4).values;
    y(1).ModifiedVol = modifyVolume(y(1).Volume);

    y(2).Control = simout.ScopeData.signals(1).values;
    y(2).Pressure = simout.ScopeData.signals(5).values;
    y(2).Flow = simout.ScopeData.signals(6).values;
    y(2).Volume = simout.ScopeData.signals(7).values;
    y(2).ModifiedVol = modifyVolume(y(2).Volume);


    spltvnt_info(sprintf('[runModel] Optional output saved to variables.'), verbose);
    if nargout > 3
        y_adv(1).Flow_RV = simout.ScopeAdvanced.signals(1).values;
        y_adv(1).Flow_E = simout.ScopeAdvanced.signals(2).values;
        y_adv(1).Flow_O = simout.ScopeAdvanced.signals(5).values; % same on both
        y_adv(1).Flow_M = simout.ScopeAdvanced.signals(6).values; % same on both

        y_adv(2).Flow_RV = simout.ScopeAdvanced.signals(3).values;
        y_adv(2).Flow_E = simout.ScopeAdvanced.signals(4).values;
        y_adv(2).Flow_O = simout.ScopeAdvanced.signals(5).values; % same on both
        y_adv(2).Flow_M = simout.ScopeAdvanced.signals(6).values; % same on both
    end
end

end

function [ymod] = modifyVolume(y)
[~,YLOWER] = envelope(y, 6, 'peak');
ymod = y-YLOWER;
end

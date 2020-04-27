function [res_mod, param_mod] = adjustPairTidalVolume(whichModel, paramUnits, results, parameters, options)
% ADJUST TIDAL VOLUME for a pair of patients.
%

verbose = false;
if nargin < 5
    options = 'default';
else
    [options, percentage] = parseOptions(options);
end

change2clinical = strcmpi(paramUnits,'siunits');
res_mod = results;
param_mod = parameters;

originalPIP = param_mod.v_M_inhale;
tv1 = res_mod(2);
tv2 = res_mod(3);
peep1 = res_mod(4);
peep2 = res_mod(5);

if change2clinical==true % starting point (value in SI units)
    newR_V = 3150;
    increasePIP = 98.0665;
else                     % starting point (value in clinical units)
    newR_V = 0.06;
    increasePIP = 1;
end
deltaPIP = increasePIP/6;
increaseRV = 200;

switch lower(options)
    case 'default'
        
        if ~strcmpi(whichModel, 'standard')  % R_V only available in modified, or newer
            finished = abs(res_mod(2)-res_mod(3))<5;
            iter=1;
            spltvnt_info('Adjusting R_V1', ~finished);
            while ~finished
                param_mod.R_V1 = newR_V*increaseRV;
                param_mod.R_V2 = 0;
                
                [~, t, y] = runElectricalAnalogueModel(whichModel, param_mod, verbose);
                [tv1, tv2, peep1, peep2] = getTVandPEEP(t,y,change2clinical);
                
                spltvnt_info(sprintf('%d | R=%3.2f | %3.2f, %3.2f, %3.2f', ...
                    iter, newR_V*increaseRV,  tv1, tv2, abs(tv1-tv2)));
                
                % update
                increaseRV = increaseRV + 10;
                iter=iter+1;
                finished = abs(tv1-tv2)<5 || iter>50;
            end
            res_mod(2:5) = [tv1 tv2 peep1 peep2];
            
            finished = mean(res_mod(2:3))>490;
        else 
            finished = res_mod(2)>490;
        end
        
        iter=1;
        spltvnt_info('Adjusting PIP', ~finished);
        while ~finished
            param_mod.v_M_inhale = originalPIP+increasePIP;
            
            [~, t, y] = runElectricalAnalogueModel(whichModel, param_mod, verbose);
            [tv1, tv2, peep1, peep2] = getTVandPEEP(t,y,change2clinical);
            
            res_mod(2:5) = [tv1 tv2 peep1 peep2];
            
            spltvnt_info(sprintf('%d | PIP=%3.2f | %3.2f, %3.2f', ...
                iter, originalPIP+increasePIP, tv1, tv2));
            increasePIP = increasePIP + deltaPIP;
            iter=iter+1;
            finished = mean([tv1 tv2])>490 || iter>50; % condition in SI units
        end
    case 'increase'
        if percentage > 1
            percentage = percentage/100;
        end
        originalTV1 = tv1;
        finishedCondition = 1 + percentage;
        finished = false;
        iter = 1;
        spltvnt_info('Adjusting PIP');
        while ~finished
            param_mod = parameters;
            param_mod.v_M_inhale = originalPIP+increasePIP;
            
            [~, t, y] = runElectricalAnalogueModel(whichModel, param_mod, verbose);
            [tv1, tv2, peep1, peep2] = getTVandPEEP(t,y,change2clinical);
            
            spltvnt_info(sprintf('%d | PIP=%3.2f | %3.2f, %3.2f', ...
                iter, originalPIP+increasePIP, tv1, tv2));
            increasePIP = increasePIP + deltaPIP;
            iter=iter+1;
            finished = (tv1/originalTV1)>finishedCondition || iter>50;
        end
        
        finished = false;
        iter=1;
        spltvnt_info('Adjusting R_V1');
        while ~finished
            param_mod.R_V1 = newR_V*increaseRV;
            
            [~, t, y] = runElectricalAnalogueModel(whichModel, param_mod, verbose);
            [tv1, tv2, peep1, peep2] = getTVandPEEP(t,y,change2clinical);
            
            spltvnt_info(sprintf('%d | %3.2f, %3.2f, %3.2f', iter, tv1, tv2, tv2/tv1));
            increaseRV = increaseRV + 10;
            iter=iter+1;
            finished = tv2/tv1 > finishedCondition || iter>50;
        end
        
    case 'decrease'
        if percentage > 1
            percentage = percentage/100;
        end
        finishedCondition = 1 + percentage;

        finished = false;
        iter=1;
        spltvnt_info('Adjusting R_V2');
        while ~finished
            param_mod = parameters;
            param_mod.R_V2 = newR_V*increaseRV;
            
            [~, t, y] = runElectricalAnalogueModel(whichModel, param_mod, verbose);
            [tv1, tv2, peep1, peep2] = getTVandPEEP(t,y,change2clinical);
            
            spltvnt_info(sprintf('%d | %3.2f, %3.2f, %3.2f', iter, tv1, tv2, tv1/tv2));
            increaseRV = increaseRV + 10;
            iter=iter+1;
            finished = tv1/tv2 > finishedCondition || iter>50;
        end
        
end
outPIP = param_mod.v_M_inhale;
if change2clinical==true
    outPIP = siunits2clinical(outPIP, 'pressure');
end
res_mod = [outPIP tv1 tv2 peep1 peep2];

end

function [o, val] = parseOptions(st)
if isstr(st)
    o = st;
    val = [];
elseif isstruct(st)
    o = st.option;
    val = st.percentage;
else
    disp('ERROR parsing options. Reverting to default');
    o = 'default';
    val = [];
end
end

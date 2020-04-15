function [res_mod, param_mod] = modifyVentilatorSettings(whichModel, param_config, results, parameters)
%

change2clinical = strcmpi(param_config,'siunits');

if strcmpi(whichModel, 'standard') % only raise PIP in cases where TV<490
    fprintf('[%s] Standard model: raising PIP when necessary.\n', mfilename);
    expnames = fieldnames(results);
    res_mod = results;
    param_mod = parameters;
    
    for ix=1:length(expnames)
        if change2clinical==true
            increasePIP = 98.0665; % Value in SI units
        else
            increasePIP = 1; % Value in clinical units
        end
        deltaPIP = increasePIP/6;
        
        disp(expnames{ix});
        originalPIP = param_mod.(expnames{ix}).v_M_inhale;
        tv1 = results.(expnames{ix})(2);
        tv2 = results.(expnames{ix})(3);
        peep1 = results.(expnames{ix})(4);
        peep2 = results.(expnames{ix})(5);
        finished = tv1>490;
        iter=1;
        while ~finished
            param_mod.(expnames{ix}).v_M_inhale = originalPIP+increasePIP;
            
            [~, t, y] = runElectricalAnalogueModel(whichModel, param_mod.(expnames{ix}));
            tv1 = tidalVolume(t, y(1).Volume, change2clinical);
            tv2 = tidalVolume(t, y(2).Volume, change2clinical);
            peep1 = getPEEP(t, y(1).Pressure, change2clinical);
            peep2 = getPEEP(t, y(2).Pressure, change2clinical);
            
            fprintf('%d | %3.2f, %3.2f, %3.2f\n', iter, tv1, tv2, abs(tv1-tv2))
            increasePIP = increasePIP + deltaPIP;
            iter = iter+1;
            finished = tv1>490 || iter>50;
        end
        outPIP = param_mod.(expnames{ix}).v_M_inhale;
        if change2clinical==true
            outPIP = siunits2clinical(outPIP, 'pressure');
        end
        res_mod.(expnames{ix}) = [outPIP tv1 tv2 peep1 peep2];
    end
else
    fprintf('[%s] Model %s: equilibriating TV through PIP and R_V1.\n', mfilename, whichModel);
    % equilibriate TV, as we have control over PIP and the R_Vs
    expnames = fieldnames(results);
    res_mod = results;
    param_mod = parameters;
    
    for ix=1:length(expnames)
        if change2clinical==true
            newR_V1 = 3150; % starting point (value in SI units)
            increasePIP = 98.0665; % Value in SI units
        else
            newR_V1 = 0.06; % starting point (value in clinical units)
            increasePIP = 1; % Value in clinical units
        end
        deltaPIP = increasePIP/6;
        
        newR_V2 = 0;
        factorV1 = 210;
        finished = abs(res_mod.(expnames{ix})(2)-res_mod.(expnames{ix})(3))<5;
        iter=1;
        while ~finished 
            param_mod.(expnames{ix}).R_V1 = newR_V1*factorV1;
            param_mod.(expnames{ix}).R_V2 = newR_V2;
            
            [~, t, y] = runElectricalAnalogueModel(whichModel, param_mod.(expnames{ix}));
            tv1 = tidalVolume(t, y(1).Volume, change2clinical);
            tv2 = tidalVolume(t, y(2).Volume, change2clinical);
            
            fprintf('%d | %3.2f, %3.2f, %3.2f\n', iter, tv1, tv2, abs(tv1-tv2))
            factorV1 = factorV1 + 10;
            iter=iter+1;
            finished = abs(tv1-tv2)<5 || iter>50;
        end
        %
        originalPIP = param_mod.(expnames{ix}).v_M_inhale;
        tv1 = results.(expnames{ix})(2);
        tv2 = results.(expnames{ix})(3);
        peep1 = results.(expnames{ix})(4);
        peep2 = results.(expnames{ix})(5);

        finished = false;
        iter=1;
        while ~finished
            param_mod.(expnames{ix}).v_M_inhale = originalPIP+increasePIP;
            
            [~, t, y] = runElectricalAnalogueModel(whichModel, param_mod);
            tv1 = tidalVolume(t, y(1).Volume, change2clinical);
            tv2 = tidalVolume(t, y(2).Volume, change2clinical);
            peep1 = getPEEP(t, y(1).Pressure, change2clinical);
            peep2 = getPEEP(t, y(2).Pressure, change2clinical);
            
            fprintf('%d | %3.2f, %3.2f, %3.2f\n', iter, tv1, tv2, abs(tv1-tv2))
            increasePIP = increasePIP + deltaPIP;
            iter=iter+1;
            finished = mean([tv1 tv2])>490 || iter>50; % condition in SI units
        end
        outPIP = param_mod.(expnames{ix}).v_M_inhale;
        if change2clinical==true
            outPIP = siunits2clinical(outPIP, 'pressure');
        end
        res_mod.(expnames{ix}) = [outPIP tv1 tv2 peep1 peep2];
    end
end


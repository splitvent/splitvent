function [res_mod, param_mod] = adjustTV4matchingPatients(whichModel, param_config, results, parameters, modification, percentage)
%

change2clinical = strcmpi(param_config, 'siunits');

if change2clinical == true
    newR_V = 3150;
    deltaPIP = 98.0665/6;
else
    newR_V = 0.06;
    deltaPIP = 1/6;
end
increasePIP = deltaPIP;


if percentage > 1
    percentage = percentage/100;
end
finishedCondition = 1 + percentage;
res_mod = results;
param_mod = parameters;

[~, t, y] = runElectricalAnalogueModel(whichModel, param_mod);
tv1 = tidalVolume(t, y(1).Volume, change2clinical);
tv2 = tidalVolume(t, y(2).Volume, change2clinical);
peep1 = getPEEP(t, y(1).Pressure, change2clinical);
peep2 = getPEEP(t, y(2).Pressure, change2clinical);

originalTV1 = tv1;

switch lower(modification)
    case {'increase'}
        finished = false;
        iter=1;
        while ~finished
            param_mod = parameters;
            param_mod.v_M_inhale = parameters.v_M_inhale+increasePIP;
            
            [~, t, y] = runElectricalAnalogueModel(whichModel, param_mod);
            tv1 = tidalVolume(t, y(1).Volume, change2clinical);
            tv2 = tidalVolume(t, y(2).Volume, change2clinical);
            
            fprintf('%d | %3.2f, %3.2f, %3.2f\n', iter, tv1, tv2, tv2/tv1);
            increasePIP = increasePIP + deltaPIP;
            iter=iter+1;
            finished = (tv1/originalTV1)>finishedCondition || iter>50;
        end
        
        factorV1 = 200;
        finished = false;
        iter=1;
        while ~finished
            param_mod.R_V1 = newR_V*factorV1;
            
            [~, t, y] = runElectricalAnalogueModel(whichModel, param_mod);
            tv1 = tidalVolume(t, y(1).Volume, change2clinical);
            tv2 = tidalVolume(t, y(2).Volume, change2clinical);
            peep1 = getPEEP(t, y(1).Pressure, change2clinical);
            peep2 = getPEEP(t, y(2).Pressure, change2clinical);
            
            fprintf('%d | %3.2f, %3.2f, %3.2f\n', iter, tv1, tv2, tv2/tv1);
            factorV1 = factorV1 + 10;
            iter=iter+1;
            finished = tv2/tv1 > 1.3 || iter>50;
        end
        
    case {'decrease'}
        factorV1 = 200;
        finished = false;
        iter=1;
        while ~finished
            param_mod = parameters;
            param_mod.R_V2 = newR_V*factorV1;
            
            [~, t, y] = runElectricalAnalogueModel(whichModel, param_mod);
            tv1 = tidalVolume(t, y(1).Volume, change2clinical);
            tv2 = tidalVolume(t, y(2).Volume, change2clinical);
            peep1 = getPEEP(t, y(1).Pressure, change2clinical);
            peep2 = getPEEP(t, y(2).Pressure, change2clinical);
            
            fprintf('%d | %3.2f, %3.2f, %3.2f\n', iter, tv1, tv2, tv1/tv2);
            factorV1 = factorV1 + 10;
            iter=iter+1;
            finished = tv1/tv2 > finishedCondition || iter>50;
        end
end

outPIP = param_mod.v_M_inhale;
if change2clinical==true
    outPIP = siunits2clinical(outPIP, 'pressure');
end
res_mod = [outPIP tv1 tv2 peep1 peep2];
fprintf('PIP=%3.2f, R_V1=%3.2f, R_V2=%3.2f, TV1=%3.2f, TV2=%3.2f, \n', ...
    outPIP, param_mod.R_V1, param_mod.R_V2, tv1, tv2);




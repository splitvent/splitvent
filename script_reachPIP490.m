% Test 1 complement.
% you need:
% - the results structure
% - param_stepA,B,C and D
% - param_struct.Ab, .Ac, .Ad
%
% if things don't wrk, clear the workspace and run test1 and test2
% 

RES.Bb = results.Bb;
RES.Cc = results.Cc;
RES.Dd = results.Dd;
RES.Ab = results.Ab;
RES.Ac = results.Ac;
RES.Ad = results.Ad;

PARAMS.Bb = param_stepA;
PARAMS.Cc = param_stepB;
PARAMS.Dd = param_stepC;
PARAMS.Ab = param_struct.Ab;
PARAMS.Ac = param_struct.Ac;
PARAMS.Ad = param_struct.Ad;

testnames = fieldnames(RES);

for ix=1:length(testnames)
    disp(testnames{ix});
    factorPIP = 98.0665/6;
    finished = RES.(testnames{ix})(1)>490;
    tv1 = RES.(testnames{ix})(1);
    tv2 = RES.(testnames{ix})(2);
    iter=1;
    while ~finished
        PARAMS.(testnames{ix}).v_M_inhale = modPIP+factorPIP;
        
        [~, t, y] = runElectricalAnalogueModel(whichModel, PARAMS.(testnames{ix}));
        tv1 = tidalVolume(t, y(1).Volume);
        tv2 = tidalVolume(t, y(2).Volume);
        
        fprintf('%d | %3.2f, %3.2f, %3.2f\n', iter, tv1, tv2, abs(tv1-tv2))
        factorPIP = factorPIP + 98.0665/6;
        iter=iter+1;
        finished = tv1>490 || iter>50;
    end
    outputs.(testnames{ix}) = [PARAMS.(testnames{ix}).v_M_inhale tv1 tv2];
end
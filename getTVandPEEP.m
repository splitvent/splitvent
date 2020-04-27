function [tv1, tv2, peep1, peep2] = getTVandPEEP(t,y,change2clinical)
% GET TIDAL VOLUME AND PEEP.
%

switch nargout
    case 1
        tv1(1) = tidalVolume(t, y(1).Volume, change2clinical);
        tv1(2) = tidalVolume(t, y(2).Volume, change2clinical);
        tv1(3) = getPEEP(t, y(1).Pressure, change2clinical);
        tv1(4) = getPEEP(t, y(2).Pressure, change2clinical);
    case 2
        tv(1) = tidalVolume(t, y(1).Volume, change2clinical);
        tv(2) = tidalVolume(t, y(2).Volume, change2clinical);
        peep(1) = getPEEP(t, y(1).Pressure, change2clinical);
        peep(2) = getPEEP(t, y(2).Pressure, change2clinical);
        
        tv1 = tv; 
        tv2 = peep;
    case 4
        tv1 = tidalVolume(t, y(1).Volume, change2clinical);
        tv2 = tidalVolume(t, y(2).Volume, change2clinical);
        peep1 = getPEEP(t, y(1).Pressure, change2clinical);
        peep2 = getPEEP(t, y(2).Pressure, change2clinical);
end

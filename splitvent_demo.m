spltvnt_info('Select the demo from the list:');

spltvnt_info(' [1] Standard model - Pairs of equal patients.');
spltvnt_info(' [2] Standard model - Different patient pairs.');
spltvnt_info(' [3] Modified model - Equilibriate patients TV.');
spltvnt_info(' [4] Modified model - Adjust TV for same patients.');
spltvnt_info(' [5] IEcontrol model - Control PEEP.');
spltvnt_info('Cancel','C');

demoinput_ = input('Your choice [default=1]: ', 's');
if isempty(demoinput_)
    demoinput_ = '1';
end

switch demoinput_
    case '1'
        demo_StandardModel1_SamePatients; 
    case '2'
        demo_StandardModel2_DifferentPatients;
    case '3'
        demo_ModifiedModel3_Equilibriate;
    case '4'
        demo_ModifiedModel4_AdjustOnSamePatients;
    case '5'
        script_controlPEEP;
    case {'A', 'a'}
        demo_StandardModel1_SamePatients; 
        demo_StandardModel2_DifferentPatients;
        demo_ModifiedModel3_Equilibriate;
        demo_ModifiedModel4_AdjustOnSamePatient;
    otherwise 
        spltvnt_info('Cancelled demo.');
end
clear demoinput_;
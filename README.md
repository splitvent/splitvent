# splitvent: A model for Single Ventilator/Dual Patient Ventilation

[![View splitvent on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://uk.mathworks.com/matlabcentral/fileexchange/75074-splitvent)

This repository is the work corresponding to the paper titled:
**A Simulated Single Ventilator/Dual Patient Ventilation Strategy for Acute
Respiratory Distress Syndrome during the COVID-19 Pandemic**. This can be found
in [link (to be updated)](https://www.medrxiv.org/content/10.1101/2020.04.07.20056309v1).

**Requirements.** This repository includes two Simscape (Simulink `4.8`) models
and several Matlab `2020a` functions and scripts, therefore the Simulink models
will not run on any lower version of Matlab.

## Disclaimer
The study done through this code **does not encourage, endorse or support**
the use of a single ventilator to support two patients, but to quantify
the potential risks and provide a quantitative test of a potential solution.
We recognise the adoption of one ventilator to support two patients _as a
last resort_ requires several key developments still.

# Quick Start
The Simulink models are accessed programatically through the code, therefore it
is not necessary to open them to run tests. The models correspond to the
**standard-splitter** and our proposed **modified-splitter**. We assume four
different lung models, called patients A, B, C and D.
To run this code and the figures presented in the paper, simply run the following
command
```matlab
script_run;
```
You will be presented with several figures, corresponding to the graphs of
(1) Pressure, (2) Volume, (3) Flow and (4) Tidal Volume (labelled as `ModifiedVol`).
There are four figures presented per experiment, therefore the figure numbers
correspond to `Experiment#` `Measurement#`, e.g. Figure `34` would correspond to the
Tidal Volume graph of the third experiment.

Looking at the `script_run.m` file, we organised the tests into different
scripts:
```matlab
%% Identical patients - standard splitter
test1_equalPairs;
clear t y;

%% Different patients (Ab, Ac, Ad) - standard splitter
test2_differentPatients;
script_reachPIP490;

%% Equilibriating different patients' tidal volume - modified splitter.
test3_maintainTVratios_Ab;
test3_maintainTVratios_Ac;
test3_maintainTVratios_Ad;
test3_plots;

%% Adjusting tidal volume for identical patients - modified splitter.
test4_varyingRatiosForEqualPatients;
```
## Run your own models
To run any variation of the models we have provided, try to follow the same
flow as any of the scripts, but more importantly, you will need to add your
model to the `runElectricalAnalogueModel.m` file, as seen on the next example:
```Matlab
switch whichModel
    case {'baseline', 'standard'} % our standard splitter
        mdl = fullfile('models','standard_splitter');
    case 'modified' % our modified splitter
        mdl = fullfile('models','modified_splitter');
    case 'your-new-model' % add a useful name for your model here
        mdl = fullfile('models','your_model_name');
end
```
and then run it as in the following example:
```Matlab
param_config = 13; % default parameters
whichModel = 'your-new-model'; % Same name you put in runElectricalAnalogueModel.m
[simout, t, y] = runElectricalAnalogueModel(whichModel, param_config);
```


# Licensing and Citation
This project is part of the MIT LICENSE, read all the terms and conditions in
the [LICENSE](./LICENSE) file. If this code is useful in your research consider
citing this work following the 
[link (to be updated)](https://www.medrxiv.org/content/10.1101/2020.04.07.20056309v1), 
or using the following BibTeX 
entry:

```BibTeX
# Bib file entry to be updated shortly
@article {Solis-Lemus2020.04.07.20056309,
	author = {Solis-Lemus, Jose A. and Costar, Edward and Doorly, Denis and Kerrigan, Eric C. and Kennedy, Caroline H. and Tait, Frances and Niederer, Steven A and Vincent, Peter E. and Williams, Steven E.},
	title = {A Simulated Single Ventilator / Dual Patient Ventilation Strategy for Acute Respiratory Distress Syndrome During the COVID-19 Pandemic},
	year = {2020},
	doi = {10.1101/2020.04.07.20056309},
	publisher = {Cold Spring Harbor Laboratory Press},
	URL = {https://www.medrxiv.org/content/early/2020/04/07/2020.04.07.20056309},
	eprint = {https://www.medrxiv.org/content/early/2020/04/07/2020.04.07.20056309.full.pdf},
	journal = {medRxiv}
}
```

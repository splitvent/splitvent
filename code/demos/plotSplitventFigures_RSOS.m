% Plot all Figures form RSOS paper
% 
 
%markers
ma='+-';
mb='-';
mc='--';
md='-.';
xaxis = [3.5 12];
%%  Figure 3
t=csv_1.Aa.time;
ctrl = csv_1.Aa.Control_AA_1A;

figure(3)
subplot(311)
pressure = [csv_1.Aa.Pressure_AA_1A csv_1.Bb.Pressure_BB_1B ...
            csv_1.Cc.Pressure_CC_1C csv_1.Dd.Pressure_DD_1D];
ctrl(ctrl==max(ctrl)) = max(pressure(:));
plot(t, pressure(:,1), ma, t, pressure(:,2), mb, t, pressure(:,3), ...
    mc, t, pressure(:,4), md, t, ctrl, ':k', 'LineWidth', 1.5);
grid on
yticks(linspace(5, 15, 11));
yticklabels({'' '6' '' '' '' '10' '' '' '' '14' ''})
xticks(linspace(3.5, 12, 9))
xticklabels([]);
ylabel(sprintf('Pressure \n(cmH_2O)'), 'FontSize', 18, 'FontWeight', 'bold');
xlim(xaxis);
legend({'Lung Model A', 'Lung Model B', 'Lung Model C', 'Lung Model D'}, ...
    'Location', 'northeast')

subplot(312)
tidalvolume = [csv_1.Aa.ModifiedVol_AA_1A csv_1.Bb.ModifiedVol_BB_1B ...
            csv_1.Cc.ModifiedVol_CC_1C csv_1.Dd.ModifiedVol_DD_1D];
plot(t, tidalvolume(:,1), ma, t, tidalvolume(:,2), mb, t, tidalvolume(:,3), ...
    mc, t, tidalvolume(:,4),  md, 'LineWidth', 1.5);
grid on
yticklabels({'' '49' '' '' '' '245' '' '' '' '441' ''})
yticks(linspace(0, 490, 11));
xticks(linspace(3.5, 12, 9))
xticklabels([]);
xlim(xaxis);
ylabel(sprintf('Tidal Volume \n(ml)'), 'FontSize', 18, 'FontWeight', 'bold')


subplot(313)
flow = [csv_1.Aa.Flow_AA_1A csv_1.Bb.Flow_BB_1B ...
            csv_1.Cc.Flow_CC_1C csv_1.Dd.Flow_DD_1D];
plot(t, flow(:,1), ma, t, flow(:,2), mb, t, flow(:,3), ...
    mc, t, flow(:,4), md,'LineWidth', 1.5);
grid on;
yticklabels({'' '-48' '' '' '' '0' '' '' '' '48' ''})
yticks(linspace(-60, 60, 11));
xticks(linspace(3.5, 12, 9))
xticklabels([]);
ylabel(sprintf('Flow \n(L/min)'), 'FontSize', 18, 'FontWeight', 'bold');
xlabel(sprintf('Time (s)'), 'FontSize', 18, 'FontWeight', 'bold');
xlabel(sprintf('Time (s)'), 'FontSize', 18, 'FontWeight', 'bold');
xlim(xaxis);

%% Figure 4
t=csv_2.Ab.time;
ctrl=csv_2.Ab.Control_AB_1A;

figure(4)
pressure = [csv_2.Ab.Pressure_AB_1A csv_2.Ab.Pressure_AB_2B ...
            csv_2.Ac.Pressure_AC_1A csv_2.Ac.Pressure_AC_2C ...
            csv_2.Ad.Pressure_AD_1A csv_2.Ad.Pressure_AD_2D];
ctrl(ctrl==max(ctrl)) = max(pressure(:));

% artificial values (dummyt, dummy) to preserve colour scheme of plots
dummyt = t(1);
dummy = pressure(1);

subplot(331)
plot(t, pressure(:,1), ma, t, pressure(:,2), mb, t, ctrl, ':k', dummyt, dummy, 'w', 'LineWidth', 1.5);
grid on
yticks(linspace(5, 15, 11));
yticklabels({'' '6' '' '' '' '10' '' '' '' '14' ''})
xticklabels([]);
xticks(linspace(3.5, 12, 9))
ylabel(sprintf('Pressure \n(cmH_2O)'), 'FontSize', 18, 'FontWeight', 'bold');
xlim(xaxis);
legend({'Lung Model A', 'Lung Model B'},'Location', 'northoutside', 'Orientation', 'horizontal');

subplot(332)
plot(t, pressure(:,3), ma, dummyt, dummy, 'w', t, pressure(:,4), mc, t, ctrl, ':k', 'LineWidth', 1.5);
grid on
yticks(linspace(5, 15, 11));
yticklabels([])
xticklabels([]);
xticks(linspace(3.5, 12, 9))
xlim(xaxis);
legend({'Lung Model A', '', 'Lung Model C'},'Location', 'northoutside','Orientation', 'horizontal');

subplot(333)
plot(t, pressure(:,5), ma,  dummyt, dummy, 'w',  dummyt, dummy, 'w', t, pressure(:,6), md, t, ctrl, ':k', 'LineWidth', 1.5);
grid on
yticks(linspace(5, 15, 11));
yticklabels([])
xticklabels([]);
xticks(linspace(3.5, 12, 9))
xlim(xaxis);
legend({'Lung Model A', '', '', 'Lung Model D'},'Location', 'northoutside', 'Orientation', 'horizontal');

tidalvolume = [csv_2.Ab.ModifiedVol_AB_1A csv_2.Ab.ModifiedVol_AB_2B ...
            csv_2.Ac.ModifiedVol_AC_1A csv_2.Ac.ModifiedVol_AC_2C ...
            csv_2.Ad.ModifiedVol_AD_1A csv_2.Ad.ModifiedVol_AD_2D];
        
subplot(334)
plot(t, tidalvolume(:,1), ma, t, tidalvolume(:,2), mb, 'LineWidth', 1.5);
grid on
yticklabels({'' '49' '' '' '' '245' '' '' '' '441' ''})
yticks(linspace(0, 490, 11));
xticklabels([]);
xticks(linspace(3.5, 12, 9))
xlim(xaxis);
ylabel(sprintf('Tidal Volume \n(ml)'), 'FontSize', 18, 'FontWeight', 'bold')

subplot(335)
plot(t, tidalvolume(:,3), ma, dummyt, dummy, 'w', t, tidalvolume(:,4), mc, 'LineWidth', 1.5);
grid on
yticks(linspace(0, 490, 11));
yticklabels([])
xticklabels([]);
xticks(linspace(3.5, 12, 9))
xlim(xaxis);

subplot(336)
plot(t, tidalvolume(:,5), ma, dummyt, dummy, 'w',dummyt, dummy, 'w', t, tidalvolume(:,6), md, 'LineWidth', 1.5);
grid on
yticks(linspace(0, 490, 11));
yticklabels([])
xticklabels([]);
xticks(linspace(3.5, 12, 9))
xlim(xaxis);

flow = [csv_2.Ab.Flow_AB_1A csv_2.Ab.Flow_AB_2B ...
        csv_2.Ac.Flow_AC_1A csv_2.Ac.Flow_AC_2C ...
        csv_2.Ad.Flow_AD_1A csv_2.Ad.Flow_AD_2D];

subplot(337)
plot(t, flow(:,1), ma, t, flow(:,2), mb, 'LineWidth', 1.5);
grid on
yticklabels({'' '-48' '' '' '' '0' '' '' '' '48' ''})
yticks(linspace(-60, 60, 11));
xticklabels([]);
xlim(xaxis);
ylabel(sprintf('Flow \n(L/min)'), 'FontSize', 18, 'FontWeight', 'bold');
xlabel(sprintf('Time (s)'), 'FontSize', 18, 'FontWeight', 'bold');

subplot(338)
plot(t, flow(:,3), ma,  dummyt, dummy, 'w', t, flow(:,4), mc, 'LineWidth', 1.5);
grid on
yticks(linspace(-60, 60, 11));
yticklabels([])
xticklabels([]);
xlim(xaxis);
xticks(linspace(3.5, 12, 9))
xlabel(sprintf('Time (s)'), 'FontSize', 18, 'FontWeight', 'bold');


subplot(339)
plot(t, flow(:,5), ma,dummyt, dummy, 'w',dummyt, dummy, 'w', t, flow(:,6), md, 'LineWidth', 1.5);
grid on
yticks(linspace(-60, 60, 11));
yticklabels([])
xticks(linspace(3.5, 12, 9))
xticklabels([]);
xlabel(sprintf('Time (s)'), 'FontSize', 18, 'FontWeight', 'bold');
xlim(xaxis);

%% Figure 5
t=csv_3.Ab.time;
figure(5)

pressure1 = [csv_3.Ab.Pressure_AB_1A ...
             csv_3.Ac.Pressure_AC_1A ...
             csv_3.Ad.Pressure_AD_1A];
pressure2 = [csv_3.Ab.Pressure_AB_2B ...
             csv_3.Ac.Pressure_AC_2C ...
             csv_3.Ad.Pressure_AD_2D];

% artificial values (dummyt, dummy) to preserve colour scheme of plots
dummyt = t(1);
dummy = pressure(1);
         
subplot(321)
plot(dummyt, dummy, 'w', t, pressure1(:,1), mb, t, pressure1(:,2), mc, t, pressure1(:,3), md, 'LineWidth', 1.5);
grid on
yticks(linspace(5, 15, 11));
yticklabels({'' '6' '' '' '' '10' '' '' '' '14' ''})
xticklabels([]);
xticks(linspace(3.5, 12, 9))
xlim(xaxis);
ylabel(sprintf('Pressure \n(cmH_2O)'), 'FontSize', 18, 'FontWeight', 'bold');
title('Patient 1', 'FontSize', 18, 'FontWeight', 'bold');

subplot(322)
plot(dummyt, dummy, 'w', t, pressure2(:,1), mb, t, pressure2(:,2), mc, t, pressure2(:,3), md, 'LineWidth', 1.5);
grid on
yticks(linspace(5, 15, 11));
yticklabels([]);
xticklabels([]);
xticks(linspace(3.5, 12, 9));
xlim(xaxis);
legend({'', 'Model A / Model B','Model A / Model C', 'Model A / Model D'},'Location', 'northeast');
title('Patient 2', 'FontSize', 18, 'FontWeight', 'bold');

tidalvolume1 = [csv_3.Ab.ModifiedVol_AB_1A ...
             csv_3.Ac.ModifiedVol_AC_1A ...
             csv_3.Ad.ModifiedVol_AD_1A];
tidalvolume2 = [csv_3.Ab.ModifiedVol_AB_2B ...
             csv_3.Ac.ModifiedVol_AC_2C ...
             csv_3.Ad.ModifiedVol_AD_2D];
         
subplot(323)
plot(dummyt, dummy, 'w', t, tidalvolume1(:,1), mb, t, tidalvolume1(:,2), mc, t, tidalvolume1(:,3), md, 'LineWidth', 1.5);
grid on
yticklabels({'' '49' '' '' '' '245' '' '' '' '441' ''})
yticks(linspace(0, 490, 11));
xticklabels([]);
xticks(linspace(3.5, 12, 9))
xlim(xaxis);
ylabel(sprintf('Tidal Volume \n(mL)'), 'FontSize', 18, 'FontWeight', 'bold');

subplot(324)
plot(dummyt, dummy, 'w', t, tidalvolume2(:,1), mb, t, tidalvolume2(:,2), mc, t, tidalvolume2(:,3), md, 'LineWidth', 1.5);
grid on
yticks(linspace(0, 490, 11));
yticklabels([]);
xticklabels([]);
xticks(linspace(3.5, 12, 9));
xlim(xaxis);

flow1 = [csv_3.Ab.Flow_AB_1A ...
             csv_3.Ac.Flow_AC_1A ...
             csv_3.Ad.Flow_AD_1A];
flow2 = [csv_3.Ab.Flow_AB_2B ...
             csv_3.Ac.Flow_AC_2C ...
             csv_3.Ad.Flow_AD_2D];
   
subplot(325)
plot(dummyt, dummy, 'w', t, flow1(:,1), mb, t, flow1(:,2), mc, t, flow1(:,3), md, 'LineWidth', 1.5);
grid on
yticklabels({'' '-48' '' '' '' '0' '' '' '' '48' ''})
yticks(linspace(-60, 60, 11));
xticklabels([]);
xticks(linspace(3.5, 12, 9))
ylabel(sprintf('Tidal Volume \n(mL)'), 'FontSize', 18, 'FontWeight', 'bold');
xlabel(sprintf('Time (s)'), 'FontSize', 18, 'FontWeight', 'bold');
xlim(xaxis);

subplot(326)
plot(dummyt, dummy, 'w', t, flow2(:,1), mb, t, flow2(:,2), mc, t, flow2(:,3), md, 'LineWidth', 1.5);
grid on
yticks(linspace(-60, 60, 11));
yticklabels([]);
xticklabels([]);
xticks(linspace(3.5, 12, 9));
xlim(xaxis);
xlabel(sprintf('Time (s)'), 'FontSize', 18, 'FontWeight', 'bold');

%% Figure 6

t=csv_3.Ab.time;
figure(6)

pressure1 = [csv_4.Cc.Pressure_CC_1C ...
             csv_4.Cc_decrease.Pressure_CC_DECREASE_1C ...
             csv_4.Cc_increase.Pressure_CC_INCREASE_1C];
pressure2 = [csv_4.Cc.Pressure_CC_2C ...
             csv_4.Cc_decrease.Pressure_CC_DECREASE_2C ...
             csv_4.Cc_increase.Pressure_CC_INCREASE_2C];

% artificial values (dummyt, dummy) to preserve colour scheme of plots
dummyt = t(1);
dummy = pressure1(1);
         
subplot(321)
plot(t, pressure1(:,1), ma, t, pressure1(:,2), mb, t, pressure1(:,3), mc, 'LineWidth', 1.5);
grid on
yticks(linspace(5, 15, 11));
yticklabels({'' '6' '' '' '' '10' '' '' '' '14' ''})
xticklabels([]);
xticks(linspace(3.5, 12, 9))
xlim(xaxis);
ylabel(sprintf('Pressure \n(cmH_2O)'), 'FontSize', 18, 'FontWeight', 'bold');
title('Patient 1', 'FontSize', 18, 'FontWeight', 'bold');

subplot(322)
plot(t, pressure2(:,1), ma, t, pressure2(:,2), mb, t, pressure2(:,3), mc, 'LineWidth', 1.5);
grid on
yticks(linspace(5, 15, 11));
yticklabels([]);
xticklabels([]);
xticks(linspace(3.5, 12, 9));
xlim(xaxis);
legend({'C-C','C-C(-)', 'C-C(+)'},'Location', 'northeast');
title('Patient 1', 'FontSize', 18, 'FontWeight', 'bold');


tidalvolume1 = [csv_4.Cc.ModifiedVol_CC_1C ...
             csv_4.Cc_decrease.ModifiedVol_CC_DECREASE_1C ...
             csv_4.Cc_increase.ModifiedVol_CC_INCREASE_1C];
tidalvolume2 = [csv_4.Cc.ModifiedVol_CC_2C ...
             csv_4.Cc_decrease.ModifiedVol_CC_DECREASE_2C ...
             csv_4.Cc_increase.ModifiedVol_CC_INCREASE_2C];
         
subplot(323)
plot(t, tidalvolume1(:,1), ma, t, tidalvolume1(:,2), mb, t, tidalvolume1(:,3), mc, 'LineWidth', 1.5);
grid on
yticklabels({'' '49' '' '' '' '245' '' '' '' '441' ''})
yticks(linspace(0, 490, 11));
xticklabels([]);
xticks(linspace(3.5, 12, 9))
xlim(xaxis);
ylabel(sprintf('Tidal Volume \n(mL)'), 'FontSize', 18, 'FontWeight', 'bold');

subplot(324)
plot(t, tidalvolume2(:,1), ma, t, tidalvolume2(:,2), mb, t, tidalvolume2(:,3), mc, 'LineWidth', 1.5);
grid on
yticks(linspace(0, 490, 11));
yticklabels([]);
xticklabels([]);
xticks(linspace(3.5, 12, 9));
xlim(xaxis);

flow1 = [csv_4.Cc.Flow_CC_1C ...
             csv_4.Cc_decrease.Flow_CC_DECREASE_1C ...
             csv_4.Cc_increase.Flow_CC_INCREASE_1C];
flow2 = [csv_4.Cc.Flow_CC_2C ...
             csv_4.Cc_decrease.Flow_CC_DECREASE_2C ...
             csv_4.Cc_increase.Flow_CC_INCREASE_2C];
   
subplot(325)
plot(t, flow1(:,1), ma, t, flow1(:,2), mb, t, flow1(:,3), mc, 'LineWidth', 1.5);
grid on
yticklabels({'' '-48' '' '' '' '0' '' '' '' '48' ''})
yticks(linspace(-60, 60, 11));
xticklabels([]);
xticks(linspace(3.5, 12, 9))
ylabel(sprintf('Tidal Volume \n(mL)'), 'FontSize', 18, 'FontWeight', 'bold');
xlabel(sprintf('Time (s)'), 'FontSize', 18, 'FontWeight', 'bold');
xlim(xaxis);

subplot(326)
plot( t, flow2(:,1), ma, t, flow2(:,2), mb, t, flow2(:,3), mc, 'LineWidth', 1.5);
grid on
yticks(linspace(-60, 60, 11));
yticklabels([]);
xticklabels([]);
xticks(linspace(3.5, 12, 9));
xlim(xaxis);
xlabel(sprintf('Time (s)'), 'FontSize', 18, 'FontWeight', 'bold');
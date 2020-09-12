clear;
clc;
close all;
addpath(genpath('Sims/'));
addpath(genpath('Messungen/'))
addpath(genpath('../functions'))
pos_fig1 = [0 0 800 800];

struct_TP_meas = importdata('Messungen/TP_first_order.txt');
struct_HP_meas = importdata('Messungen/HP_first_order.txt');

struct_TP_sim = importdata('Sims/Tiefpass_erster_ordnung_1khz.txt');
struct_HP_sim.textdata = importdata('Sims/Hochpass_erster_Ordnung_1kHz.txt').textdata;
struct_HP_sim.data(:,1) = importdata('Sims/Hochpass_erster_Ordnung_1kHz.txt').data(:,1); %%frequencies
struct_HP_sim.data(:,2) = sqrt(importdata('Sims/Hochpass_erster_Ordnung_1kHz.txt').data(:,2).^2 + importdata('Sims/Hochpass_erster_Ordnung_1kHz.txt').data(:,3).^2);
struct_HP_sim.data(:,3) = importdata('Sims/Hochpass_erster_Ordnung_1kHz.txt').data(:,4);
struct_HP_sim.data(:,4) = 180 ./ pi .* angle(importdata('Sims/Hochpass_erster_Ordnung_1kHz.txt').data(:,2) + importdata('Sims/Hochpass_erster_Ordnung_1kHz.txt').data(:,3).*1j);

for i=1:length(struct_HP_sim.data(:,4))
    if(struct_HP_sim.data(i,4)<=(-179.9))
        j=1;
    end
    if(j==1)
        
        struct_HP_sim.data(i,4) = struct_HP_sim.data(i,4)-360;
    end
    if(struct_HP_sim.data(i,4)<=(-360))
        struct_HP_sim.data(i,4) = struct_HP_sim.data(i,4)+360;
    end
end
for i=1:length(struct_HP_meas.data(:,4))
    struct_HP_meas.data(i,4) = (struct_HP_meas.data(i,4))*-1;
    struct_HP_meas.data(i,4)
end

fig_TP_fo = figure('Name', 'Tiefpass erster Ordnung');  
bodePlot_din461(fig_TP_fo, struct_TP_sim.data(:,1), ...
    struct_TP_sim.data(:,4), ...
    struct_TP_sim.data(:,3), ...
    struct_TP_sim.data(:,2), '', false);
bodePlot_din461(fig_TP_fo, struct_TP_meas.data(:,1)./1.2, ...
    struct_TP_meas.data(:,2),...
    struct_TP_meas.data(:,3),...
    struct_TP_meas.data(:,4),'*-', true);
subplot(2,1,1)
legend('Simulation', 'Messung')
ylim([-1 21])
subplot(2,1,2)
legend('Simulation', 'Messung')
set(fig_TP_fo,'Position',pos_fig1)


fig_HP_fo = figure('Name', 'Hochpass erster Ordnung');
bodePlot_din461(fig_HP_fo, struct_HP_sim.data(:,1), ...
    struct_HP_sim.data(:,3), ...
    struct_HP_sim.data(:,2), ...
    struct_HP_sim.data(:,4), '', false);
bodePlot_din461(fig_HP_fo, struct_HP_meas.data(:,1), ...
    struct_HP_meas.data(:,2),...
    struct_HP_meas.data(:,3),...
    struct_HP_meas.data(:,4),'*-', true);
subplot(2,1,1)
legend('Simulation', 'Messung')
ylim([-1 21])
subplot(2,1,2)
legend('Simulation', 'Messung')
ylim([-282 -80])
set(fig_HP_fo,'Position',pos_fig1)

hgexport(fig_TP_fo, 'Plots/TP_first_order.eps')
hgexport(fig_HP_fo, 'Plots/HP_first_order.eps')

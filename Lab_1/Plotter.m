clear;
clc;
close all;
addpath(genpath('Sims/'));
addpath(genpath('Messungen/'))
addpath(genpath('../functions'))
pos_fig1 = [0 0 800 800];

%% Datenimport
%simulationen
struct_folger_sim = importdata('Sims/Folger_spect.txt');
struct_inv_verst_sim = importdata('Sims/inv_verst.txt', ' ');
struct_niinv_verst_sim = importdata('Sims/niinv_verst.txt', ' ');

struct_folger_meas = importdata('Messungen/folger_meas.txt');
struct_inv_verst_meas = importdata('Messungen/inv_verst_meas.txt');
struct_niinv_verst_meas = importdata('Messungen/niinv_verst_meas.txt');
%Messungen

%% Folgerschaltung
fig_folger = figure('Name', 'Folgerschaltung');
%print sim
bodePlot_din461(fig_folger,struct_folger_sim.data(:,1),...
    struct_folger_sim.data(:,4),...
    struct_folger_sim.data(:,3),...
    struct_folger_sim.data(:,2), '', false);
%print Meas
bodePlot_din461(fig_folger, struct_folger_meas.data(:,1), ...
    struct_folger_meas.data(:,2),...
    struct_folger_meas.data(:,3),...
    struct_folger_meas.data(:,4),'*-', true);
legend('Simulation', 'Messung');
subplot(2,1,1)
legend('Simulation', 'Messung');

set(fig_folger,'Position',pos_fig1)

%% invertierender Verstï¿½rker
fig_inv_verst = figure('Name', 'invertierender Verstärker');
% print sims 
for i = 0 : 1
bodePlot_din461(fig_inv_verst,struct_inv_verst_sim.data(:,1),...
    struct_inv_verst_sim.data(:,12+i),...
    struct_inv_verst_sim.data(:,8+i),...
    struct_inv_verst_sim.data(:,2+i), '', false);
end

%print Meas
bodePlot_din461(fig_inv_verst, struct_inv_verst_meas.data(:,1), ...
    struct_inv_verst_meas.data(:,2), ...
    struct_inv_verst_meas.data(:,3), ...
    struct_inv_verst_meas.data(:,4), '-*', true);
%xlim([1 1e5])
subplot(2,1,1)
ylim([-10 61])
legend('simualtion \nu = 60dB', 'simualtion \nu = 40dB', 'Messung \nu=20dB')
set(fig_inv_verst,'Position',pos_fig1)
subplot(2,1,2)
legend('simualtion \nu = 60dB', 'simualtion \nu = 40dB', 'Messung \nu=20dB')


%% nicht invertierender Verstï¿½rker

fig_niinv_verst = figure('Name', 'nicht invertierender VerstÃ¤rker');
% Print sims
for i = 0 : 2
bodePlot_din461(fig_niinv_verst,struct_niinv_verst_sim.data(:,1),...
    struct_niinv_verst_sim.data(:,14+i),...
    struct_niinv_verst_sim.data(:,8+i),...
    struct_niinv_verst_sim.data(:,2+i), '', false);
end

%Print Meas
bodePlot_din461(fig_niinv_verst, struct_niinv_verst_meas.data(:,1), ...
    struct_niinv_verst_meas.data(:,2), ...
    struct_niinv_verst_meas.data(:,3), ...
    struct_niinv_verst_meas.data(:,4), '-*', false);

bodePlot_din461(fig_niinv_verst, struct_niinv_verst_meas.data(:,1), ...
    struct_niinv_verst_meas.data(:,2), ...
    struct_niinv_verst_meas.data(:,5), ...
    struct_niinv_verst_meas.data(:,6), '-*', true);
subplot(2,1,1)
legend('simualtion \nu = 40dB', 'simualtion \nu = 20dB','simualtion \nu = 0dB', 'Messung \nu = 20dB', 'Messung \nu = 40dB')
subplot(2,1,2)
legend('simualtion \nu = 40dB', 'simualtion \nu = 20dB','simualtion \nu = 0dB', 'Messung \nu = 20dB', 'Messung \nu = 40dB')

set(fig_niinv_verst,'Position',pos_fig1)


%% Figure export
hgexport(fig_folger,'Plots/Folger.eps')
hgexport(fig_inv_verst, 'Plots/inv_verst.eps')
hgexport(fig_niinv_verst, 'Plots/niinv_verst.eps')
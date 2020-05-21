clear;
clc;
close all;
addpath(genpath('Sims/'));
addpath(genpath('Messungen/'))
addpath(genpath('../functions'))

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

%% invertierender Verst�rker
fig_inv_verst = figure('Name', 'invertierender Verstärker');
% print sims 
for i = 0 : 3
if i < 3
    printscales = false;
    
else
    printscales = true;
end
bodePlot_din461(fig_inv_verst,struct_inv_verst_sim.data(:,1),...
    struct_inv_verst_sim.data(:,12+i),...
    struct_inv_verst_sim.data(:,8+i),...
    struct_inv_verst_sim.data(:,2+i), '', printscales);
end

%print Meas

xlim([1 1e5])
subplot(2,1,1)
xlim([1 1e5])
ylim([-10 100])
legend('sim1', 'sim2','sim3', 'sim4')

%% nicht invertierender Verst�rker

fig_niinv_verst = figure('Name', 'nicht invertierender Verstärker');
% Print sims
for i = 0 : 5
if i < 5
    printscales = false;
    
else
    printscales = true;
end
bodePlot_din461(fig_niinv_verst,struct_niinv_verst_sim.data(:,1),...
    struct_niinv_verst_sim.data(:,14+i),...
    struct_niinv_verst_sim.data(:,8+i),...
    struct_niinv_verst_sim.data(:,2+i), '', printscales);
end

%Print Meas

legend('sim1', 'sim2','sim3', 'sim4')

%% Figure export

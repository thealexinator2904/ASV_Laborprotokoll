clear;
clc;
close all;
addpath(genpath('Sims/'));
addpath(genpath('Messungen/'))
addpath(genpath('../functions'))

struct_TP_meas = importdata('Messungen/TP_first_order.txt');
struct_HP_meas = importdata('Messungen/HP_first_order.txt');

fig_TP_fo = figure('Name', 'Tiefpass erster Ordnung');
bodePlot_din461(fig_TP_fo, struct_TP_meas.data(:,1)./1.2, ...
    struct_TP_meas.data(:,2),...
    struct_TP_meas.data(:,3),...
    struct_TP_meas.data(:,4),'*-', true);


fig_HP_fo = figure('Name', 'Hochpass erster Ordnung');
bodePlot_din461(fig_HP_fo, struct_HP_meas.data(:,1), ...
    struct_HP_meas.data(:,2),...
    struct_HP_meas.data(:,3),...
    struct_HP_meas.data(:,4),'*-', true);

hgexport(fig_TP_fo, 'Plots/TP_first_order.eps')
hgexport(fig_HP_fo, 'Plots/HP_first_order.eps')
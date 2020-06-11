clear;
clc;
close all;
addpath(genpath('Sims/'));
addpath(genpath('Messungen/'))
addpath(genpath('../functions'))

struct_gleichrichter.mitTP = importdata('Sims/geichrichter_mit_TP.txt');
struct_gleichrichter.ohneTP = importdata('Sims/geichrichter_ohne_TP.txt');

struct_mikrofonV = importdata('Sims/MikrofonV.txt');
struct_mikrofonV_AD823 = importdata('Sims/MikrofonV_AD823.txt');

fig_GR = figure('Name', 'Präzisionsgleichrichter');
plot(struct_gleichrichter.ohneTP.data(:,1)*1e3, struct_gleichrichter.ohneTP.data(:,2)*1e3)
xlim([54 60])
grid minor
hold on
plot(struct_gleichrichter.mitTP.data(:,1)*1e3, struct_gleichrichter.mitTP.data(:,2)*1e3)
din461('t',  'U_{OUT}','ms', 'mV')

fig_mikro = figure('Name', 'Mikrofonverstärker');
semilogx(struct_mikrofonV.data(:,1), struct_mikrofonV.data(:,2))
grid on
hold on
semilogx(struct_mikrofonV_AD823.data(:,1), struct_mikrofonV_AD823.data(:,2))
din461('f',  '\nu','Hz', '')
legend('LM358', 'AD823')

hgexport(fig_GR, 'Plots/Gleichrichter.eps')
hgexport(fig_mikro, 'Plots/Mikrofonverstaerker.eps')
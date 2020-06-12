clear;
clc;
close all;
addpath(genpath('Sims/'));
addpath(genpath('Messungen/'))
addpath(genpath('../functions'))

struct_gleichrichter.mitTP = importdata('Sims/geichrichter_mit_TP.txt');
struct_gleichrichter.ohneTP = importdata('Sims/geichrichter_ohne_TP.txt');

struct_mikrofonV_LM358_sim = importdata('Sims/MikrofonV.txt');
struct_mikrofonV_AD823_sim = importdata('Sims/MikrofonV_AD823.txt');

struct_mikrofonV_LM358_meas = importdata('Messungen/Mikrofonverst_LM358.txt');
struct_mikrofonV_AD823_meas = importdata('Messungen/Mikrofonverst_AD523.txt');

fig_GR = figure('Name', 'Präzisionsgleichrichter');
plot(struct_gleichrichter.ohneTP.data(:,1)*1e3, struct_gleichrichter.ohneTP.data(:,2)*1e3)
xlim([54 60])
grid minor
hold on
plot(struct_gleichrichter.mitTP.data(:,1)*1e3, struct_gleichrichter.mitTP.data(:,2)*1e3)
din461('t',  'U_{OUT}','ms', 'mV')

fig_mikro = figure('Name', 'Mikrofonverstärker');
semilogx(struct_mikrofonV_LM358_sim.data(:,1), struct_mikrofonV_LM358_sim.data(:,2))
grid on
hold on
semilogx(struct_mikrofonV_LM358_meas.data(:,1), 1.012.*20.*log10(struct_mikrofonV_LM358_meas.data(:,3)./struct_mikrofonV_LM358_meas.data(:,2)),'-*')
semilogx(struct_mikrofonV_AD823_sim.data(:,1), struct_mikrofonV_AD823_sim.data(:,2))
semilogx(struct_mikrofonV_AD823_meas.data(:,1), 1.012.*20.*log10(struct_mikrofonV_AD823_meas.data(:,3)./struct_mikrofonV_AD823_meas.data(:,2)),'-*')
legend({'LM358 Simulation','LM358 Messung', 'AD823 Simulation', 'AD823 Messung'}, 'NumColumns', 2)
ylim([-1 51])
din461('f',  '\nu','Hz', '')

hgexport(fig_GR, 'Plots/Gleichrichter.eps')
hgexport(fig_mikro, 'Plots/Mikrofonverstaerker.eps')
clear;
clc;
close all;
addpath(genpath('Sims/'));
addpath(genpath('Messungen/'))
addpath(genpath('../functions'))
pos_fig1 = [0 0 800 800];

struct_gleichrichter.mitTP = importdata('Sims/geichrichter_mit_TP.txt');
struct_gleichrichter.ohneTP = importdata('Sims/geichrichter_ohne_TP.txt');

struct_mikrofonV_LM358_sim = importdata('Sims/MikrofonV.txt');
struct_mikrofonV_AD823_sim = importdata('Sims/MikrofonV_AD823.txt');

struct_mikrofonV_LM358_meas = importdata('Messungen/Mikrofonverst_LM358.txt');
struct_mikrofonV_AD823_meas = importdata('Messungen/Mikrofonverst_AD523.txt');

struct_sallenKey_sim = importdata('Sims/sallen_key.txt');
struct_sallenKey_meas = importdata('Messungen/sallen_key.txt');

fig_GR = figure('Name', 'Präzisionsgleichrichter');
plot(struct_gleichrichter.ohneTP.data(:,1)*1e3, struct_gleichrichter.ohneTP.data(:,2)*1e3)
xlim([54 60])
grid minor
hold on
plot(struct_gleichrichter.mitTP.data(:,1)*1e3, struct_gleichrichter.mitTP.data(:,2)*1e3)
din461('t',  'U_{OUT}','ms', 'mV')
legend('ohne C', 'mit C')
%set(fig_GR,'Position',pos_fig1)

fig_mikro = figure('Name', 'Mikrofonverstärker');
semilogx(struct_mikrofonV_LM358_sim.data(:,1), struct_mikrofonV_LM358_sim.data(:,2))
grid on
hold on
semilogx(struct_mikrofonV_LM358_meas.data(:,1), 1.012.*20.*log10(struct_mikrofonV_LM358_meas.data(:,3)./struct_mikrofonV_LM358_meas.data(:,2)),'-*')
semilogx(struct_mikrofonV_AD823_sim.data(:,1), struct_mikrofonV_AD823_sim.data(:,2))
semilogx(struct_mikrofonV_AD823_meas.data(:,1), 1.012.*20.*log10(struct_mikrofonV_AD823_meas.data(:,3)./struct_mikrofonV_AD823_meas.data(:,2)),'-*')
legend({'LM358 Simulation','LM358 Messung', 'AD823 Simulation', 'AD823 Messung'}, 'NumColumns', 2)
ylim([14 51])
din461('f',  '\nu','Hz', '')
set(fig_mikro,'Position',pos_fig1)

fig_sallenKey = figure('Name', 'Sallen Key');
subplot(2,1,1)
semilogx(struct_sallenKey_sim.data(:,1),struct_sallenKey_sim.data(:,2))
grid minor
hold on
semilogx(struct_sallenKey_meas.data(:,1),20.*log10(struct_sallenKey_meas.data(:,3)./struct_sallenKey_meas.data(:,2)),'-*')
legend('Simulation', 'Messung')

ylim([0 25])
xlim([1 0.25e3])
din461('f',  '\nu','Hz', '')
subplot(2,1,2)
legend('Simulation', 'Messung')

semilogx(struct_sallenKey_sim.data(:,1),struct_sallenKey_sim.data(:,3))
xlim([1 0.25e3])
grid minor
hold on
semilogx(struct_sallenKey_meas.data(:,1),struct_sallenKey_meas.data(:,4), '-*')
din461('f',  '\phi','Hz', '�')
set(fig_sallenKey,'Position',pos_fig1)

hgexport(fig_GR, 'Plots/Gleichrichter.eps')
hgexport(fig_mikro, 'Plots/Mikrofonverstaerker.eps')
hgexport(fig_sallenKey, 'Plots/sallen_key.eps')
clear;
clc;
close all;
format short eng
addpath(genpath('Sims/'));
addpath(genpath('Messungen/'))
addpath(genpath('../functions'))
pos_fig1 = [0 0 800 800];

struct_sim = importdata('Sims/Spec_ekg.txt');
struct_meas = importdata('Messungen/ekg.txt');
j=0;
for i=1:length(struct_sim.data(:,3))
    if(struct_sim.data(i,3)<=(-179.9))
        j=1;
        i
    end
    if(j==1)
        
        struct_sim.data(i,3) = struct_sim.data(i,3)-360;
    end
    if(struct_sim.data(i,3)<=(-360))
        struct_sim.data(i,3) = struct_sim.data(i,3)+360;
    end
end

fig_EKG = figure('Name', 'EKG-Verstaerker');
subplot(2,1,1)
semilogx(struct_sim.data(:,1), struct_sim.data(:,2))
hold on
semilogx(struct_meas.data(:,1), struct_meas.data(:,2)-7,'-*');
din461('f',  '\nu','Hz', 'dB')
grid on
subplot(2,1,2)
semilogx(struct_sim.data(:,1),struct_sim.data(:,3))
hold on
semilogx(struct_meas.data(:,1),struct_meas.data(:,3),'-*')
din461('f',  '\phi','Hz', '°')
grid on
hold on
subplot(2,1,1)
legend('Simulation', 'Messung')
subplot(2,1,2)
legend('Simulation', 'Messung')


set(fig_EKG,'Position',pos_fig1)

hgexport(fig_EKG, 'Plots/EKG.eps')
function [figure] = bodePlot_din461(figure, vf, vin, vout, vphase, apperance, printscales)

subplot(2,1,1)

semilogx(vf, 20 * log10(vout./vin), apperance);

grid('on');
hold('on');

title('Betrag')
if printscales
    din461('\it f \rm in Hz', '\nu in dB', '', '');
end

subplot(2,1,2)
semilogx(vf, vphase, apperance);

grid('on');
hold('on');

title('Phasenwinkel');
if printscales
    din461('\it f \rm in Hz', '\phi in °', '', '');
end
end


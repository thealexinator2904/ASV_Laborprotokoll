function [figure] = bodePlot_din461(figure, vf, vin, vout, vphase, apperance, printscales)

subplot(2,1,1)

semilogx(vf, 20 * log10(vout./vin), apperance);

grid('on');
hold('on');

title('Betrag')
if printscales
    din461('\it f', '\nu', 'Hz', 'db');
end

subplot(2,1,2)
semilogx(vf, vphase, apperance);

grid('on');
hold('on');

title('Phasenwinkel');
if printscales
    din461('\it f', '\phi', 'Hz', '°');
end
end


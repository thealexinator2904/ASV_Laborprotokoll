fc = 30;
wc = 2*pi*fc;
b1 = 1;
a1 = sqrt(2);
C1 = 1e-9;
C2 = 4.7e-9;

R1 = (a1*C2 + sqrt(a1^2*C2^2-4*b1*C1*C2))/(4*pi*30*C1*C2)
R2 = (a1*C2 - sqrt(a1^2*C2^2-4*b1*C1*C2))/(4*pi*30*C1*C2)

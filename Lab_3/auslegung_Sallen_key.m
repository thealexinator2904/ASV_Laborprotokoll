clear
clc
close all

format short eng
format compact

A0 = 10;
fc = 30;
wc = 2*pi*fc;
a1 = sqrt(2);
b1 = 1;
C1 = 100e-9;
C2 = 330e-9;

R1 = (sqrt(2)*sqrt(2*A0*wc^2*C2^2 - 2 *wc^2 *C1 *C2 - wc^2 *C2^2) - sqrt(2) *wc* C2)/(2 *(A0 *wc^2 *C2^2 - wc^2* C1* C2 - wc^2 *C2^2))
R2 = 1/(wc^2*R1*C1*C2)

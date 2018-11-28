%% Impedance Matching Network
%% Ensure components able to make load to 50 ohms
clc;
close all;
clear all;
%operating freq.
f=435e6;
%Z0
R1=50;
%ZL at 435 MHz
R2=10.61-26.69i;
%ind. value (ideal) from online calculator
L=17.248475483094268e-9;
%cap. value (ideal) from online calculator
C=14.099255114313758e-12;
%reactances
XL=i*2*pi*f*L;
XC=1/(i*2*pi*f*C);
%Zin should be close to 50 ohms
Zin=(R2+XL)*(XC)/(R2+XL+XC);
%% Plot VSWR for unmatched and matched cases
%freq. span
freq=420e6:1e6:450e6;
%impedances of antenna at various freq. in freq. span from EZNEC
z=[9.396-38.89i 9.472-38.08i 9.549-37.26i 9.626-36.45i 9.705-35.63i 9.783-34.83i 9.863-34.01i 9.943-33.2i 10.02-32.38i 10.11-31.57i 10.19-30.76i 10.27-29.94i 10.36-29.13i 10.44-28.32i 10.52-27.5i 10.61-26.69i 10.7-25.87i 10.79-25.05i 10.87-24.24i 10.96-23.42i 11.05-22.61i 11.14-21.79i 11.23-20.97i 11.33-20.16i 11.42-19.33i 11.51-18.52i 11.61-17.69i 11.71-16.88i 11.8-16.05i 11.9-15.23i 12-14.41i];
%reflection coefficent
rc=(z-50)./(z+50);
%swr
swr=(1+abs(rc))./(1-abs(rc));
%Plot VSWR for unmatched case
plot(freq,swr);
title('SWR (Imp. of 10.61-26.69i at 435 MHz)');
xlabel('Freq.(MHz)');
ylabel('SWR');
%Matched Case
XL_M=i.*2.*pi.*freq.*L;
XC_M=1./(i*2*pi.*freq.*C);
%new impedances of load with matching network
znew=z+XL_M;
znew=1./znew+1./XC_M;
znew=1./znew;
%plot
figure;
rc=(znew-50)./(znew+50);
swr=(1+abs(rc))./(1-abs(rc));
plot(freq,swr);
title('SWR Matched (Ideal)');
xlabel('Freq.(MHz)');
ylabel('SWR');
%% Realistic values for inductor and capacitor
C=15e-12;
L= 17e-9;
%Reactance of components
XL_M=i.*2.*pi.*freq.*L;
XC_M=1./(i*2*pi.*freq.*C);
%New impedances of load with matching network
znew=z+XL_M;
znew=1./znew+1./XC_M;
znew=1./znew;
%plot
figure;
rc=(znew-50)./(znew+50);
swr=(1+abs(rc))./(1-abs(rc));
plot(freq,swr);
title('SWR Matched (Realistic including +/- Tolerances)');
xlabel('Freq.(MHz)');
ylabel('SWR');
%% Realistic including Tolerances +5% of inuductor and capacitor
C=14e-12*1.05;
L= 17e-9*1.05;
%Reactance of components
XL_M=i.*2.*pi.*freq.*L;
XC_M=1./(i*2*pi.*freq.*C);
%New impedances of load with matching network
znew=z+XL_M;
znew=1./znew+1./XC_M;
znew=1./znew;
%plot
hold on;
rc=(znew-50)./(znew+50);
swr=(1+abs(rc))./(1-abs(rc));
plot(freq,swr);
xlabel('Freq.(MHz)');
ylabel('SWR');
%% Realistic including Tolerances -5% of inuductor and capacitor
C=14e-12*0.95;
L= 17e-9*0.95;
%Reactances
XL_M=i.*2.*pi.*freq.*L;
XC_M=1./(i*2*pi.*freq.*C);
%Impedance of load
znew=z+XL_M;
znew=1./znew+1./XC_M;
znew=1./znew;
%Plot
hold on;
rc=(znew-50)./(znew+50);
swr=(1+abs(rc))./(1-abs(rc));
plot(freq,swr);
xlabel('Freq.(MHz)');
ylabel('SWR');
legend('No Tolerances', '+5%','-5%');

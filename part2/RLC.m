%clean up before running
close all;
clear variables;
clc;

%initializing values (from given values)
R = 250;
C = 3.5*10^(-6);
L = 600*10^(-3);
qCi = 500*10^(-9); 
dqCi = 0;

ti = 0; %start time = 0;
tf = 0.2; %end time -> re adapt according to input
h = 10^(-4); %small interval chosen

%initialize empty arrays
N = round(tf/h);
Vin = zeros(1,N);
T = zeros(1,N);

%input signals
Vin1 = @(t) 5*heaviside(t);
Vin2 = @(t) (5*exp((-t.^2)/(3e-6)));
Vin3A = @(t) (5*square(2*pi*5*t));
Vin3B = @(t) (5*square(2*pi*109*t));
Vin3C = @(t) (5*square(2*pi*500*t));
Vin4A = @(t) (5*sin(2*pi*5*t));
Vin4B = @(t) (5*sin(2*pi*109*t));
Vin4C = @(t) (5*sin(2*pi*500*t));

tf = 0.05;
f1 = @(t, qC, dqC) dqC;
f2 = @(t, qC, dqC) (Vin1(t)-R*dqC-qC/C)/L; %change Vin1 here as well

%run rk4th
[t_out, qC_out, dqC_out] = RK4(f1, f2, ti, qCi, dqCi, tf, h);

%plot
figure(1); %clf(1)
dqC_out = dqC_out * R;
plot(t_out, dqC_out, 'b',t_out, Vin1(t_out), 'r')
hold on;
grid on;
%plot(t_out, Vin1(t_out), 'r')
xlabel('Time(s)');
title('Input 1: 5');
ylabel('Voltage(V)')
set(gca, 'fontsize', 16);
legend('Output Signal Capacitor(V)', 'Input Signal (V)', 'location', 'northeast');

%*************************************************************************

%Vin2
tf = 0.05;
f1 = @(t, qC, dqC) dqC;
f2 =@(t, qC, dqC) (Vin2(t)-R*dqC-qC/C)/L;
[t_out, qC_out, dqC_out] = RK4(f1, f2, ti, qCi, dqCi, tf, h);
figure(2);
dqC_out = dqC_out * R;
plot(t_out, dqC_out, 'b')
hold on;
grid on;
plot(t_out, Vin2(t_out), 'r');
xlabel('Time(s)')
title('Input 2: 5*exp((-t^2)/(3e-6))');
ylabel('Voltage(V)')
set(gca, 'fontsize', 16);
legend('Output Signal Capacitor(V)', 'Input Signal (V)', 'location', 'northeast');

%*************************************************************************

%Vin3A
tf = 0.2;
f1 = @(t, qC, dqC) dqC;
f2 =@(t, qC, dqC) (Vin3A(t)-R*dqC-qC/C)/L;
[t_out, qC_out, dqC_out] = RK4(f1, f2, ti, qCi, dqCi, tf, h);
figure(3);
dqC_out = dqC_out * R;
plot(t_out, dqC_out, 'b')
hold on;
grid on;
plot(t_out, Vin3A(t_out), 'r');
xlabel('Time(s)')
title('Input 3A: square 5Hz');
ylabel('Voltage(V)')
set(gca, 'fontsize', 16);
legend('Output Signal Capacitor(V)', 'Input Signal (V)', 'location', 'northeast');
%*************************************************************************

%Vin3B
tf = 0.04;
f1 = @(t, qC, dqC) dqC;
f2 =@(t, qC, dqC) (Vin3B(t)-R*dqC-qC/C)/L;
[t_out, qC_out, dqC_out] = RK4(f1, f2, ti, qCi, dqCi, tf, h);
figure(4);
dqC_out = dqC_out * R;
plot(t_out, dqC_out, 'b')
hold on;
grid on;
plot(t_out, Vin3B(t_out), 'r');
xlabel('Time(s)')
title('Input 3B: square 109Hz');
ylabel('Voltage(V)')
set(gca, 'fontsize', 16);
legend('Output Signal Capacitor(V)', 'Input Signal (V)', 'location', 'northeast');

%*************************************************************************

%Vin3C
tf = 0.02;
f1 = @(t, qC, dqC) dqC;
f2 =@(t, qC, dqC) (Vin3C(t)-R*dqC-qC/C)/L;
[t_out, qC_out, dqC_out] = RK4(f1, f2, ti, qCi, dqCi, tf, h);
figure(5);
dqC_out = dqC_out * R;
plot(t_out, dqC_out, 'b')
hold on;
grid on;
plot(t_out, Vin3C(t_out), 'r');
xlabel('Time(s)')
title('Input 3C: square 500Hz');
ylabel('Voltage(V)')
set(gca, 'fontsize', 16);
legend('Output Signal Capacitor(V)', 'Input Signal (V)', 'location', 'northeast');

%*************************************************************************

%Vin4A
tf = 0.2;
f1 = @(t, qC, dqC) dqC;
f2 =@(t, qC, dqC) (Vin4A(t)-R*dqC-qC/C)/L;
[t_out, qC_out, dqC_out] = RK4(f1, f2, ti, qCi, dqCi, tf, h);
figure(6);
dqC_out = dqC_out * R;
plot(t_out, dqC_out, 'b')
hold on;
grid on;
plot(t_out, Vin4A(t_out), 'r');
xlabel('Time(s)')
title('Input 4A: sine 5Hz');
ylabel('Voltage(V)')
set(gca, 'fontsize', 16);
legend('Output Signal Capacitor(V)', 'Input Signal (V)', 'location', 'northeast');
%*************************************************************************

%Vin4B
tf = 0.04;
f1 = @(t, qC, dqC) dqC;
f2 =@(t, qC, dqC) (Vin4B(t)-R*dqC-qC/C)/L;
[t_out, qC_out, dqC_out] = RK4(f1, f2, ti, qCi, dqCi, tf, h);
figure(7);
dqC_out = dqC_out * R;
plot(t_out, dqC_out, 'b')
hold on;
grid on;
plot(t_out, Vin4B(t_out), 'r');
xlabel('Time(s)')
title('Input 3B: sine 109Hz');
ylabel('Voltage(V)')
set(gca, 'fontsize', 16);
legend('Output Signal Capacitor(V)', 'Input Signal (V)', 'location', 'northeast');

%*************************************************************************

%Vin4C
tf = 0.04;
f1 = @(t, qC, dqC) dqC;
f2 =@(t, qC, dqC) (Vin4C(t)-R*dqC-qC/C)/L; 
[t_out, qC_out, dqC_out] = RK4(f1, f2, ti, qCi, dqCi, tf, h);
figure(8);
dqC_out = dqC_out * R;
plot(t_out, dqC_out, 'b')
hold on;
grid on;
plot(t_out, Vin4C(t_out), 'r');
xlabel('Time(s)')
title('Input 4C: sine 500Hz');
ylabel('Voltage(V)')
set(gca, 'fontsize', 16);
legend('Output Signal Capacitor(V)', 'Input Signal (V)', 'location', 'northeast');

%**************************************************************************

%Squarewaves : comparing
tf = 0.04;
f1 = @(t, qC, dqC) dqC;
f2 =@(t, qC, dqC) (Vin3A(t)-R*dqC-qC/C)/L;
[t_out, qC_out, dqC_out] = RK4(f1, f2, ti, qCi, dqCi, tf, h);
figure(9);
dqC_out = dqC_out * R;
plot(t_out, dqC_out, 'b')
hold on;
grid on;


f1 = @(t, qC, dqC) dqC;
f2 =@(t, qC, dqC) (Vin3B(t)-R*dqC-qC/C)/L;
[t_out, qC_out, dqC_out] = RK4(f1, f2, ti, qCi, dqCi, tf, h);
dqC_out = dqC_out * R;
plot(t_out, dqC_out, 'g')


f1 = @(t, qC, dqC) dqC;
f2 =@(t, qC, dqC) (Vin3C(t)-R*dqC-qC/C)/L;
[t_out, qC_out, dqC_out] = RK4(f1, f2, ti, qCi, dqCi, tf, h);
dqC_out = dqC_out * R;
plot(t_out, dqC_out, 'r')


xlabel('Time(s)')
title('Comparing squarewave inputs');
ylabel('Voltage(V)')
set(gca, 'fontsize', 16);
legend('f=5Hz', 'f=109Hz', 'f=500Hz', 'location', 'northeast');

%*************************************************************************

%Sinewaves : comparing
tf = 0.04;

f1 = @(t, qC, dqC) dqC;
f2 =@(t, qC, dqC) (Vin4A(t)-R*dqC-qC/C)/L;
[t_out, qC_out, dqC_out] = RK4(f1, f2, ti, qCi, dqCi, tf, h);
figure(10);
dqC_out = dqC_out * R;
plot(t_out, dqC_out, 'b')
hold on;
grid on;



f1 = @(t, qC, dqC) dqC;
f2 =@(t, qC, dqC) (Vin4B(t)-R*dqC-qC/C)/L;
[t_out, qC_out, dqC_out] = RK4(f1, f2, ti, qCi, dqCi, tf, h);
dqC_out = dqC_out * R;
plot(t_out, dqC_out, 'g')


f1 = @(t, qC, dqC) dqC;
f2 =@(t, qC, dqC) (Vin4C(t)-R*dqC-qC/C)/L;
[t_out, qC_out, dqC_out] = RK4(f1, f2, ti, qCi, dqCi, tf, h);
dqC_out = dqC_out * R;
plot(t_out, dqC_out, 'r')


xlabel('Time(s)')
title('Comparing sinewave inputs');
ylabel('Voltage(V)')
set(gca, 'fontsize', 16);
legend('f=5Hz', 'f=109Hz', 'f=500Hz', 'location', 'northeast');

% Simulation of an RC circuit
% Given a 1st order ODE "func"
% we solve for state q, where Vout = q/c
% As we are given a 1st order ODE we can use numerical analysis methods,
% so as to not integrate directly, but instead estimate the values,
% given initial conditions
%
% Normally 1st order ODE's are seen in dy/dx=f(x,y) form
% In our circuit case let
% let q = y and t = x

% the initial conditions for this high pass filter
R = 1000;
C = 100e-9;
q0 = 500e-9;
tf = 0.003;
h  = 0.00001;

% our function, of (t,q) aka(x,y)
func = @(t,q) (1/R)*(Vin(t) - q/C );


%% Step signal with amplitude Vin = 2.5V
% Vin is a function in terms of t
Vin = @(t) 2.5*heaviside(t);

% Solving for q
[Vout, t] = RK2(q0,h,tf,func,Vin,R,C);
% In our function case we are investigating Vout, where Vout = q/C

% % plotting the graph of the result
subplot(1,2,1);
plot(t,Vout);
title('Vout against time for Step Signal, input of 2.5V');
xlabel('Time / s');
ylabel('Vout / V');


%% Impulsive signal and decay:
% Vin = 2.5*e^(-(t^2)/tau)
% Vin = 2.5*e^(-t/tau)
% where tau = 100 (microseconds^2) and tau = 100 microseconds respectively

Vin = @(t) 2.5*exp(-(t^2)/(100e-12));
[Vout, t] = RK2(q0,h,tf,func,Vin,R,C);
subplot(1,2,2);
hold on
plot(t,Vout);
 
Vin = @(t) 2.5*exp(-t/(100e-6));
[Vout, t] = RK2(q0,h,tf,func,Vin,R,C);
plot(t,Vout,'red');


%% Sine, Square and Sawtooth waves
% Amplitude Vin = 5 V and different periods:
% T = 100 µs,T = 10 µs, T = 500 µs, T = 1000 µs . 
% For square and sawtooth wave, try Matlab help: ?square-?,
% resp. ?sawtooth wave"


%% Sine


Vin = @(t) 5*sin((2*pi/(10e-6))*t);
[Vout, t] = RK2(q0,h,tf,func,Vin,R,C);
figure(2)
hold on
plot(t,Vout,'m');

Vin = @(t) 5*sin((2*pi/(100e-6))*t);
func = @(t,q) (1/R)*(Vin(t) - q/C );
[Vout, t] = RK2(q0,h,tf,func,Vin,R,C);
hold on
plot(t,Vout,'r');

Vin = @(t) 5*sin((2*pi/(500e-6))*t);
[Vout, t] = RK2(q0,h,tf,func,Vin,R,C);
hold on
plot(t,Vout,'b');

Vin = @(t) 5*sin((2*pi/(1000e-6))*t);
[Vout, t] = RK2(q0,h,tf,func,Vin,R,C);
hold on
plot(t,Vout,'g');

title('Vout against time for Sine Signal, input of 5V');
xlabel('Time / s');
ylabel('Vout / V');
legend('T=10e-6','T=100e-6', 'T=500e-6','T=1000e-6');


%% Square

Vin = @(t) 5*square((2*pi/(10e-6))*t);
[Vout, t] = RK2(q0,h,tf,func,Vin,R,C);
figure(3)
hold on
plot(t,Vout,'m');

Vin = @(t) 5*square((2*pi/(100e-6))*t);
[Vout, t] = RK2(q0,h,tf,func,Vin,R,C);
plot(t,Vout,'r');

Vin = @(t) 5*square((2*pi/(500e-6))*t);
[Vout, t] = RK2(q0,h,tf,func,Vin,R,C);
plot(t,Vout,'b');

Vin = @(t) 5*square((2*pi/(1000e-6))*t);
[Vout, t] = RK2(q0,h,tf,func,Vin,R,C);
plot(t,Vout,'g');

title('Vout against time for Square Signal, input of 5V');
xlabel('Time / s');
ylabel('Vout / V');
legend('T=10e-6','T=100e-6', 'T=500e-6','T=1000e-6');

%% Sawtooth

Vin = @(t) 5*sawtooth((2*pi/(10e-6))*t);
[Vout, t] = RK2(q0,h,tf,func,Vin,R,C);
figure(5);
hold on;
plot(t,Vout,'m');

Vin = @(t) 5*sawtooth((2*pi/(100e-6))*t);
[Vout, t] = RK2(q0,h,tf,func,Vin,R,C);
plot(t,Vout,'r');

Vin = @(t) 5*sawtooth((2*pi/(500e-6))*t);
[Vout, t] = RK2(q0,h,tf,func,Vin,R,C);
plot(t,Vout,'b');

Vin = @(t) 5*sawtooth((2*pi/(1000e-6))*t);
[Vout, t] = RK2(q0,h,tf,func,Vin,R,C);
plot(t,Vout,'g');


title('Vout against time for Sawtooth Signal, input of 5V');
xlabel('Time / s');
ylabel('Vout / V');
legend('T=10e-6','T=100e-6', 'T=500e-6','T=1000e-6');

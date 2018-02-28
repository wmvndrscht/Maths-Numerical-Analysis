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
h  = 0.000001;

method = "midpoint";

% our function, of (t,q) aka(x,y)
func = @(t,q) (1/R)*(Vin(t) - q/C );


%% Step signal with amplitude Vin = 2.5V
% Vin is a function in terms of t
Vin = @(t) 2.5*heaviside(t);

% Solving for q
[Step_Vout, Step_t] = RK2(q0,h,tf,func,Vin,R,C,method);
% In our function case we are investigating Vout, where Vout = q/C

% % plotting the graph of the result
subplot(1,2,1);
plot(Step_t,Step_Vout);
title('Vout against time for Step Signal, input of 2.5V');
xlabel('Time / s');
ylabel('Vout / V');


%% Impulsive signal and decay:
% Vin = 2.5*e^(-(t^2)/tau)
% Vin = 2.5*e^(-t/tau)
% where tau = 100 (microseconds^2) and tau = 100 microseconds respectively

Vin = @(t) 2.5*exp(-(t^2)/(100e-12));
[Impulse_Vout, Impulse_t] = RK2(q0,h,tf,func,Vin,R,C,method);
subplot(1,2,2);
hold on
plot(Impulse_t,Impulse_Vout);
 
Vin = @(t) 2.5*exp(-t/(100e-6));
[Impulse_Vout2, Impulse_t2] = RK2(q0,h,tf,func,Vin,R,C,method);
plot(Impulse_t2,Impulse_Vout2,'red');


%% Sine, Square and Sawtooth waves
% Amplitude Vin = 5 V and different periods:
% T = 100 µs,T = 10 µs, T = 500 µs, T = 1000 µs . 
% For square and sawtooth wave, try Matlab help: ?square-?,
% resp. ?sawtooth wave"


%% Sine


Vin = @(t) 5*sin((2*pi/(10e-6))*t);
[Sine_Vout1, Sine_t1] = RK2(q0,h,tf,func,Vin,R,C,method);
figure(2)
hold on
plot(Sine_t1,Sine_Vout1,'m');

Vin = @(t) 5*sin((2*pi/(100e-6))*t);
[Sine_Vout2, Sine_t2] = RK2(q0,h,tf,func,Vin,R,C,method);
hold on
plot(Sine_t2,Sine_Vout2,'r');

Vin = @(t) 5*sin((2*pi/(500e-6))*t);
[Sine_Vout3, Sine_t3] = RK2(q0,h,tf,func,Vin,R,C,method);
hold on
plot(Sine_t3,Sine_Vout3,'b');

Vin = @(t) 5*sin((2*pi/(1000e-6))*t);
[Sine_Vout4, Sine_t4] = RK2(q0,h,tf,func,Vin,R,C,method);
hold on
plot(Sine_t4,Sine_Vout4,'g');

title('Vout against time for Sine Signal, input of 5V');
xlabel('Time / s');
ylabel('Vout / V');
legend('T=10e-6','T=100e-6', 'T=500e-6','T=1000e-6');


%% Square

Vin = @(t) 5*square((2*pi/(10e-6))*t);
[Square_Vout1, Square_t1] = RK2(q0,h,tf,func,Vin,R,C,method);
figure(3)
hold on
plot(Square_t1,Square_Vout1,'m');

Vin = @(t) 5*square((2*pi/(100e-6))*t);
[Square_Vout2, Square_t2] = RK2(q0,h,tf,func,Vin,R,C,method);
plot(Square_t2,Square_Vout2,'r');

Vin = @(t) 5*square((2*pi/(500e-6))*t);
[Square_Vout3, Square_t3] = RK2(q0,h,tf,func,Vin,R,C,method);
plot(Square_t3,Square_Vout3,'b');

Vin = @(t) 5*square((2*pi/(1000e-6))*t);
[Square_Vout4, Square_t4] = RK2(q0,h,tf,func,Vin,R,C,method);
plot(Square_t4,Square_Vout4,'g');

title('Vout against time for Square Signal, input of 5V');
xlabel('Time / s');
ylabel('Vout / V');
legend('T=10e-6','T=100e-6', 'T=500e-6','T=1000e-6');

%% Sawtooth

Vin = @(t) 5*sawtooth((2*pi/(10e-6))*t);
[Sawtooth_Vout1, Sawtooth_t1] = RK2(q0,h,tf,func,Vin,R,C,method);
figure(5);
hold on;
plot(Sawtooth_t1,Sawtooth_Vout1,'m');

Vin = @(t) 5*sawtooth((2*pi/(100e-6))*t);
[Sawtooth_Vout2, Sawtooth_t2] = RK2(q0,h,tf,func,Vin,R,C,method);
plot(Sawtooth_t2,Sawtooth_Vout2,'r');

Vin = @(t) 5*sawtooth((2*pi/(500e-6))*t);
[Sawtooth_Vout3, Sawtooth_t3] = RK2(q0,h,tf,func,Vin,R,C,method);
plot(Sawtooth_t3,Sawtooth_Vout3,'b');

Vin = @(t) 5*sawtooth((2*pi/(1000e-6))*t);
[Sawtooth_Vout4, Sawtooth_t4] = RK2(q0,h,tf,func,Vin,R,C,method);
plot(Sawtooth_t4,Sawtooth_Vout4,'g');


title('Vout against time for Sawtooth Signal, input of 5V');
xlabel('Time / s');
ylabel('Vout / V');
legend('T=10e-6','T=100e-6', 'T=500e-6','T=1000e-6');

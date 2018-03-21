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


% (q0,h,tf,func,method)  

% the initial conditions for this high pass filter
R = 1000;
C = 100e-9;
q0 = 500e-9;
tf = 0.001;
h  = 0.000001;

method = "midpoint";




%% Step signal with amplitude Vin = 2.5V
% Vin is a function in terms of t
Vin = @(t) 2.5*heaviside(t);

% our function, of (t,q)
func = @(t,q) (1/R)*(Vin(t) - q/C );

% Solving for q
[step_q, Step_t] = RK2(q0,h,tf,func,method);
Step_Vout = step_q./C;
% In our function case we are investigating Vout, where Vout = q/C

% % plotting the graph of the result
figure(1)
plot(Step_t,Step_Vout);
hold on
plot(Step_t,Vin(Step_t));
title('Vout against time for Step Signal, input of 2.5V');
xlabel('Time / s');
ylabel('Vout / V');
legend('Vout', 'Vin');


%% Impulsive signal and decay:
% Vin = 2.5*e^(-(t^2)/tau)
% Vin = 2.5*e^(-t/tau)
% where tau = 100 (microseconds^2) and tau = 100 microseconds respectively

Vin = @(t) 2.5*exp(-(t.^2)/(100e-12));
func = @(t,q) (1/R)*(Vin(t) - q/C );
[Impulse_qout, Impulse_t] = RK2(q0,h,tf,func,method);
Impulse_Vout = Impulse_qout./C;
figure(2)
subplot(1,2,1)
plot(Impulse_t,Vin(Impulse_t));
hold on
plot(Impulse_t,Impulse_Vout);
title('Vout against time for Impulsive Signal ');
xlabel('Time / s');
ylabel('Vout / V');
legend('Input = Vin . e-(t^2/tau)', 'Output');

 
Vin = @(t) 2.5*exp(-t/(100e-6));
func = @(t,q) (1/R)*(Vin(t) - q/C );
[Decay_qout, Decay_t] = RK2(q0,h,tf,func,method);
Decay_Vout = Impulse_qout./C;
subplot(1,2,2)
plot(Decay_t,Vin(Decay_t));
hold on
plot(Decay_t,Decay_Vout,'red');
title('Vout against time for Impulsive Decay');
xlabel('Time / s');
ylabel('Vout / V');
legend('Input = Vin . e-(t/tau)', 'Output');


%% Sine, Square and Sawtooth waves
% Amplitude Vin = 5 V and different periods:
% T = 100 µs,T = 10 µs, T = 500 µs, T = 1000 µs . 
% For square and sawtooth wave, try Matlab help: ?square-?,
% resp. ?sawtooth wave"


%% Sine

tf = 0.003;

Vin = @(t) 5*sin((2*pi/(10e-6))*t);
func = @(t,q) (1/R)*(Vin(t) - q/C );
[Sine_qout1, Sine_t1] = RK2(q0,h,tf,func,method);
Sine_Vout1 = Sine_qout1./C;
figure(3)
hold on
plot(Sine_t1,Sine_Vout1,'m');

Vin = @(t) 5*sin((2*pi/(100e-6))*t);
func = @(t,q) (1/R)*(Vin(t) - q/C );
[Sine_qout2, Sine_t2] = RK2(q0,h,tf,func,method);
Sine_Vout2 = Sine_qout2./C;
hold on
plot(Sine_t2,Sine_Vout2,'r');

Vin = @(t) 5*sin((2*pi/(500e-6))*t);
func = @(t,q) (1/R)*(Vin(t) - q/C );
[Sine_qout3, Sine_t3] = RK2(q0,h,tf,func,method);
Sine_Vout3 = Sine_qout3./C;
hold on
plot(Sine_t3,Sine_Vout3,'b');

Vin = @(t) 5*sin((2*pi/(1000e-6))*t);
func = @(t,q) (1/R)*(Vin(t) - q/C );
[Sine_qout4, Sine_t4] = RK2(q0,h,tf,func,method);
Sine_Vout4 = Sine_qout4./C;
hold on
plot(Sine_t4,Sine_Vout4,'g');

title('Vout against time for Sine Signal, input of 5V');
xlabel('Time / s');
ylabel('Vout / V');
legend('T=10e-6','T=100e-6', 'T=500e-6','T=1000e-6');


%% Square

Vin = @(t) 5*square((2*pi/(10e-6))*t);
func = @(t,q) (1/R)*(Vin(t) - q/C );
[Square_qout1, Square_t1] = RK2(q0,h,tf,func,method);
Square_Vout1 = Square_qout1./C;
figure(4)
hold on
plot(Square_t1,Square_Vout1,'m');

Vin = @(t) 5*square((2*pi/(100e-6))*t);
func = @(t,q) (1/R)*(Vin(t) - q/C );
[Square_qout2, Square_t2] = RK2(q0,h,tf,func,method);
Square_Vout2 = Square_qout2./C;
plot(Square_t2,Square_Vout2,'r');

Vin = @(t) 5*square((2*pi/(500e-6))*t);
func = @(t,q) (1/R)*(Vin(t) - q/C );
[Square_qout3, Square_t3] = RK2(q0,h,tf,func,method);
Square_Vout3 = Square_qout3./C;
plot(Square_t3,Square_Vout3,'b');

Vin = @(t) 5*square((2*pi/(1000e-6))*t);
func = @(t,q) (1/R)*(Vin(t) - q/C );
[Square_qout4, Square_t4] = RK2(q0,h,tf,func,method);
Square_Vout4 = Square_qout4./C;
plot(Square_t4,Square_Vout4,'g');

title('Vout against time for Square Signal, input of 5V');
xlabel('Time / s');
ylabel('Vout / V');
legend('T=10e-6','T=100e-6', 'T=500e-6','T=1000e-6');

%% Sawtooth

Vin = @(t) 5*sawtooth((2*pi/(10e-6))*t);
func = @(t,q) (1/R)*(Vin(t) - q/C );
[Sawtooth_qout1, Sawtooth_t1] = RK2(q0,h,tf,func,method);
Sawtooth_Vout1 = Sawtooth_qout1./C;
figure(5);
hold on;
plot(Sawtooth_t1,Sawtooth_Vout1,'m');

Vin = @(t) 5*sawtooth((2*pi/(100e-6))*t);
func = @(t,q) (1/R)*(Vin(t) - q/C );
[Sawtooth_qout2, Sawtooth_t2] = RK2(q0,h,tf,func,method);
Sawtooth_Vout2 = Sawtooth_qout2./C;
plot(Sawtooth_t2,Sawtooth_Vout2,'r');

Vin = @(t) 5*sawtooth((2*pi/(500e-6))*t);
func = @(t,q) (1/R)*(Vin(t) - q/C );
[Sawtooth_qout3, Sawtooth_t3] = RK2(q0,h,tf,func,method);
Sawtooth_Vout3 = Sawtooth_qout3./C;
plot(Sawtooth_t3,Sawtooth_Vout3,'b');

Vin = @(t) 5*sawtooth((2*pi/(1000e-6))*t);
func = @(t,q) (1/R)*(Vin(t) - q/C );
[Sawtooth_qout4, Sawtooth_t4] = RK2(q0,h,tf,func,method);
Sawtooth_Vout4 = Sawtooth_qout4./C;
plot(Sawtooth_t4,Sawtooth_Vout4,'g');


title('Vout against time for Sawtooth Signal, input of 5V');
xlabel('Time / s');
ylabel('Vout / V');
legend('T=10e-6','T=100e-6', 'T=500e-6','T=1000e-6');

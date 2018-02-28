% Write a script called error script.m in which you carry out error analysis for the basic case
% with R, C, qC(0) as above, and as input a cosine wave of period T = 100 µs and amplitude V¯
% in = 5 V.
% Obtain the exact solution of the ODE, and for each method of the three from Exercise 1, obtain a
% numercial solution: again, switching methods by only commenting out lines of code appropriately.
% Compare the numerical solution with the exact solution, obtaining the error as a function of t. Plot the
% error function. Vary the time step h for a suitable number and range of values, and obtain a log-log
% plot to show the order of the error. Be sure to explain and justify your empirical observation.

% the initial conditions
R = 1000;
C = 100e-9;
q0 = 500e-9;
ti = 0;
tf = 0.003;
h  = 0.000001;
T = 100e-6;
w = 2*pi/T;

% First find the exact solution
Vin = @(t) 5*cos(2*pi*t/T);
exactfunc = @(t) (Vin(t)*C)/(1+(w*R*C)^2)*cos(w*t) + (Vin(t)*w*R*C^2)/(1+(w*R*C)^2)*sin(w*t) + (q0 - (Vin(t)*C)/(1+(w*R*C)^2))*exp(-t/(R*C)) ;
time = ti:h:tf;
N = round((tf-ti)/h);
for i=1:N+1
    t = time(i);
    q(i) = exactfunc(t);
    exact = q/C;
    
end

% Create graph for each of the 3 methods
% 1. Heun  -  2. Midpoint  -  3. Ralston
% On each graph compare exact with Runge Kutta method
% As spec defines one must be able to comment out code,
% this is repeated 3 times

func = @(t,q) (1/R)*(Vin(t) - q/C );
[Heun_Vout, Heun_t] = RK2(q0,h,tf,func,Vin,R,C, "heun");
[Midpoint_Vout, Midpoint_t] = RK2(q0,h,tf,func,Vin,R,C, "midpoint");
[Ralston_Vout, Ralston_t] = RK2(q0,h,tf,func,Vin,R,C, "ralston");

figure(1)
plot(Heun_t,Heun_Vout,'g');
hold on
plot(time,exact,'m');
% hold on
% plot(Midpoint_t,Midpoint_Vout),'r';
% hold on
% plot(Ralston_t,Ralston_Vout,'b');

clear all

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
tf = 0.001;
h  = 0.000001;
T = 100e-6;
w = 2*pi/T;
N = round((tf-ti)/h);

Vin = @(t) 5*cos(2*pi*t/T);

% First find the exact solution

[exact,t] = exactresult(R,C,q0,ti,tf,h,T,w);


% Create graph for each of the 3 methods
% 1. Heun  -  2. Midpoint  -  3. Ralston
% On each graph compare exact with Runge Kutta method
% As spec defines one must be able to comment out code,
% this is repeated 3 times

func = @(t,q) (1/R)*(Vin(t) - q/C );
[Heun_Vout, Heun_t] = RK2(q0,h,tf,func,Vin,R,C, "heun");
[Midpoint_Vout, Midpoint_t] = RK2(q0,h,tf,func,Vin,R,C, "midpoint");
[Ralston_Vout, Ralston_t] = RK2(q0,h,tf,func,Vin,R,C, "ralston");

for i=1:N
    Heun_error(i) = abs(Heun_Vout(i)-exact(i));
    Midpoint_error(i) = abs(Midpoint_Vout(i)-exact(i));
    Ralston_error(i) = abs(Ralston_Vout(i)-exact(i));   
end

figure(1)
hold on
plot(Heun_t,Heun_error,'m-x');
plot(Midpoint_t,Midpoint_error,'r-x');
plot(Ralston_t,Ralston_error,'b-x');

t=ti:h:tf-h;
delta=0.000001:0.000004:0.00003;

for j=1:8
    [exact,t] = exactresult(R,C,q0,ti,tf,delta(j),T,w);
    [Heunh_Vout, Heun_t] = RK2(q0,delta(j),tf,func,Vin,R,C, "heun");
    [Midpointh_Vout, Midpoint_t] = RK2(q0,delta(j),tf,func,Vin,R,C, "midpoint");
    [Ralstonh_Vout, Ralston_t] = RK2(q0,delta(j),tf,func,Vin,R,C, "ralston");
    Herr(j) = max(abs(Heunh_Vout-exact));
    Merr(j) = max(abs(Midpointh_Vout-exact));
    Rerr(j) = max(abs(Ralstonh_Vout-exact));
end

figure(2)
hold on
loglog(delta,Herr)
loglog(delta,Merr)
loglog(delta,Rerr)





function [exact,time] = exactresult(R,C,q0,ti,tf,h,T,w)
    exactfunc = @(t) (5*C*cos(w*t))/(1+(w*R*C)^2) + (5*sin(w*t)*w*R*C^2)/(1+(w*R*C)^2) + (q0 - (5*C)/(1+(w*R*C)^2))*exp(-t/(R*C)) ;
    time = ti:h:tf;
    N = round((tf-ti)/h);
    for i=1:N
        q(i) = exactfunc(time(i));
    end
    exact = q./C;
end

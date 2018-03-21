clear all

% the initial conditions
R = 1000;
C = 100e-9;
q0 = 500e-9;
ti = 0;
tf = 0.005;
h  = 0.000001;
T = 100e-6;
w = 2*pi/T;
N = round((tf-ti)/h);

Vin = @(t) 5*cos(2*pi*t/T);

% First find the exact solution
[exact,t] = exactresult(R,C,q0,ti,tf,h,T,w);

%% 
% Find the results for each method for a defined h
% 1. Heun  -  2. Midpoint  -  3. Ralston
% On each graph compare exact with Runge Kutta method

func = @(t,q) (1/R)*(Vin(t) - q/C );
[Heun_qout, Heun_t] = RK2(q0,h,tf,func,"heun");
Heun_Vout = Heun_qout./C;
[Midpoint_qout, Midpoint_t] = RK2(q0,h,tf,func, "midpoint");
Midpoint_Vout = Midpoint_qout./C;
[Ralston_qout, Ralston_t] = RK2(q0,h,tf,func,"ralston");
Ralston_Vout = Ralston_qout./C;


% Find the absolute error (method - exact) for points calculated for 
% each method

for i=1:N
    Heun_error(i) = abs(Heun_Vout(i)-exact(i));
    Midpoint_error(i) = abs(Midpoint_Vout(i)-exact(i));
    Ralston_error(i) = abs(Ralston_Vout(i)-exact(i));   
end

% Plot each of the absolute errors as a function of t
figure(1)
hold on
plot(Heun_t,Heun_error,'LineWidth',1.4,'Color',[0.8 0.8 1]);
plot(Midpoint_t,Midpoint_error,'LineWidth',1.2,'Color',[0.0 0.8 1.0]);
plot(Ralston_t,Ralston_error,'LineWidth',1.2,'Color',[0.5 0.2 0.9]);
title('Absolute error for each method');
xlabel('Time / s');
ylabel('Absolute Error / V');
legend('Heun','Midpoint', 'Ralston');


%% Find max absolute error for different h

t=ti:h:tf-h;
delta=0.000001:0.000004:0.00002;

for j=1:5
    [exact,t] = exactresult(R,C,q0,ti,tf,delta(j),T,w);
    [Heunh_qout, Heun_t] = RK2(q0,delta(j),tf,func, "heun");
    Heunh_Vout = Heunh_qout./C;
    [Midpointh_qout, Midpoint_t] = RK2(q0,delta(j),tf,func,"midpoint");
    Midpointh_Vout = Midpointh_qout./C;
    [Ralstonh_qout, Ralston_t] = RK2(q0,delta(j),tf,func,"ralston");
    Ralstonh_Vout = Ralstonh_qout./C;
    Herr(j) = max(abs(Heunh_Vout-exact));
    Merr(j) = max(abs(Midpointh_Vout-exact));
    Rerr(j) = max(abs(Ralstonh_Vout-exact));
end

% plot results on a log log graph to show linear relationship
figure(2)
hold on
plot(log(delta),log(Herr),'LineWidth',1.4,'Color',[0.8 0.8 1]);
plot(log(delta),log(Merr),'LineWidth',1.2,'Color',[0.0 0.8 1.0]);
plot(log(delta),log(Rerr),'LineWidth',1.2,'Color',[0.5 0.2 0.9]);
title('LogLog plot for Max absolute error vs h');
xlabel('log(H) / s');
ylabel('log(Max absolute error) / V');
legend('Heun','Midpoint', 'Ralston');


% function to calculate exact value of cosine function

function [exact,time] = exactresult(R,C,q0,ti,tf,h,T,w)
    exactfunc = @(t) (5*C*cos(w*t))/(1+(w*R*C)^2) + (5*sin(w*t)*w*R*C^2)/(1+(w*R*C)^2) + (q0 - (5*C)/(1+(w*R*C)^2))*exp(-t/(R*C)) ;
    time = ti:h:tf;
    N = round((tf-ti)/h);
    for i=1:N
        q(i) = exactfunc(time(i));
    end
    exact = q./C;
end

%initial conditions
%in our case, as in the cw, it specifies any function in dy/dx form
%therefore let qc = y and t = x

R = 1000;
C = 100e-9;
qc0 = 500e-9;
tf = 0.003;
h  = 0.00001;

%Vin is a function in terms of t
Vin = @(t) 2.5*heaviside(t);
func = @(t,q) (1/R)*(Vin(t) - q/C );

[Vout, t] = RK2(qc0,h,tf,func);
figure;
plot(t,Vout);


%

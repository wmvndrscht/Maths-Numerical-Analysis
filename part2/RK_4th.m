function[x, y, z] = RK_4th(f1, f2, xi, yi, zi, tf, h)

N = round(tf/h);
x = zeros(1,N);
y = zeros(1,N);
z = zeros(1,N);

x(1) = xi;
y(1) = yi;
z(1) = zi;
for i=1:N-1
    
    k1 = feval(f1 ,x(i), y(i), z(i));
    m1 = feval(f2, x(i), y(i), z(i));
    k2 = feval(f1, x(i) + h/2, y(i) + h/2*k1, z(i) + h/2*m1);
    m2 = feval(f2, x(i) + h/2, y(i) + h/2*k1, z(i) + h/2*m1);
    k3 = feval(f1, x(i) + h/2, y(i) + h/2*k2, z(i) + h/2*m2);
    m3 = feval(f2, x(i) + h/2, y(i) + h/2*k2, z(i) + h/2*m2);
    k4 = feval(f1, x(i) + h, y(i) + h*k3, z(i)+ h*m3);
    m4 = feval(f2, x(i) + h, y(i) + h*k3, z(i)+ h*m3);
    y(i+1)= y(i) + h/6 * (k1 + 2*k2 + 2*k3 + k4);
    z(i+1)= z(i) + h/6 * (m1 + 2*m2 + 2*m3 + m4);
    x(i+1) = x(i) + h;

end
end

function[next_dq, next_q] = RK_4th(t, q, dq, f1, f2, h)

% compute q and y(dq) for all t; dq -> vout and q->dq
%y(i) = dq(i)
% => y'(i) = f(t(i), y(i), q(i))#

k1 = feval(f1, t, q, dq);
m1 = feval(f2, t, q, dq);
k2 = feval(f1, t + (1/2)*h, q + (1/2)*k1*h, dq + (1/2)*m1*h);
m2 = feval(f2, t + (1/2)*h, q + (1/2)*k1*h, dq + (1/2)*m1*h);
k3 = feval(f1, t + (1/2)*h, q + (1/2)*k2*h, dq + (1/2)*k2*h);
m3 = feval(f2, t + (1/2)*h, q + (1/2)*m2*h, dq + (1/2)*m2*h);
k4 = feval(f1, t + h, q + k3*h, dq + m3*h);
m4 = feval(f2, t + h, q + k3*h, dq + m3*h);
next_q = q + h*((1/6)*(k1 + 2*k2 + 2*k3 + k4));
next_dq = dq + h*((1/6)*(m1 + 2*m2 + 2*m3 + m4));

end

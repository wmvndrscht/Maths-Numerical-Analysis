function [Vout, t] = RK2(qc0,h,tf,func)
    
    ti = 0;
    N = round((tf-ti)/h);
    t=ti:h:tf;
    q = zeros(1,N);
    q(1) = qc0;
    
    for j=1:N
        k1 = func(t(j),q(j));
        %qp = q(j) + h*k1;
        %k2 = func(t(j)+h,qp); %heun
        %k2 = func(t(j)+0.5*h,q(j)+h*0.5*k1); %midpoint
        k2 = func(t(j) + 2*h/3, q(j) + 2*h*k1/3); %ralston
        %qave = 0.5*(k1+k2); %heun
        %q(j+1) = q(j) + h*qave; %heun
        %q(j+1) = q(j) + h*k2; %midpoint
        q(j+1) = q(j) + 0.25*h*(k1 + 3*k2); %ralston
    end
    
    Vout = q;


end


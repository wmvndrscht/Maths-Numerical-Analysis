function [Vout, t] = RK2(qc0,h,tf,func)
    
    ti = 0;
    N = round((tf-ti)/h);
    t=ti:h:tf;
    q = zeros(1,N);
    q(1) = qc0;
    
    for j=1:N-1 
        qp = q(j) + h*func(t(j),q(j));
        k1 = func(t(j),q(j));
        k2 = func(t(j)+h,qp);
%         k2 = func(t(j)+0.5*h,q(j)+0.5*k1); %midpoint meth
        qave = 0.5*(k1+k2); 
        q(j+1) = q(j) + h*qave;
%         q(j+1) = q(j) + h*k2; %midpoint meth
    end


end


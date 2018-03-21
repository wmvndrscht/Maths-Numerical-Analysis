function [q, t] = RK2(q0,h,tf,func,method)  

    ti = 0;                 %initial time
    N = round((tf-ti)/h);   %N = number of steps
    t=ti:h:tf-h;            %range of t values
    q = zeros(1,N);         %initialise q array
    q(1) = q0;              %set initial q value
    
    for j=1:N-1
        k1 = func(t(j),q(j));
        if(method == "heun")
            qp = q(j) + h*k1; %heun
            k2 = func(t(j)+h,qp); %heun
            qave = 0.5*(k1+k2); %heun
            q(j+1) = q(j) + h*qave; %heun
        elseif(method == "midpoint")
            k2 = func(t(j)+0.5*h,q(j)+h*0.5*k1); %midpoint
            q(j+1) = q(j) + h*k2; %midpoint
        else
            k2 = func(t(j) + 2*h/3, q(j) + 2*h*k1/3); %ralston
            q(j+1) = q(j) + 0.25*h*(k1 + 3*k2); %ralston
        end
    end

end


%implement boundary conditions
%use gridsize of 5 to start
% u(0; y) = u(1; y) = 0 ; for 0 < y < 1;
% u(x; 1) = 0 ; for 0 < x < 1;
% u(x; 0) = 0 ; for 0 < x < 0:2 and 0:8 < x < 1;
% u(x; 0) = 1 ; for 0:2 < x < 0:8:
clear;
k = 3/16; %initial value of all P
ep = 1/10; %residual size parameter
num = 9;  %number of unknowns
uold = [0 1 1 1 0;
     0 k k k 0;
     0 k k k 0;
     0 k k k 0;
     0 0 0 0 0];
 unew = uold;
 cnt=0
while cnt<9 
    cnt = 0; 
    for n = 2:1:4
        for m = 2:1:4
            unew(m,n) = (uold(m+1, n)+uold(m-1, n)+uold(m, n+1)+uold(m, n-1)-4*uold(m, n))/4;
            r = abs(unew(m, n)-uold(m, n));
            if r < ep
                cnt=cnt+1;
            end
        end
    end
    if cnt == 9 
        break;
    end
    
end

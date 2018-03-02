%implement boundary conditions

% u(0; y) = u(1; y) = 0 ; for 0 < y < 1;
% u(x; 1) = 0 ; for 0 < x < 1;
% u(x; 0) = 0 ; for 0 < x < 0:2 and 0:8 < x < 1;
% u(x; 0) = 1 ; for 0:2 < x < 0:8:
clear;
n = 15; %size 

ep = 0.15; %residual size parameter
num = (n-2)^2;  %number of unknowns
uold = zeros(n);
lb= ceil((n*1/5)+1);
ub= floor((n*4/5));
for c = lb:1:ub
    uold(n,c) = 1;
end
k = (ub-lb+1)/(n^2-(n-2)^2); %initial value of all P = (number of ones)/(total area of boundary)
for y = 2:1:n-1
        for x = 2:1:n-1
            uold(x,y)=k;
        end
end
 unew = uold;
 cnt=0;
while cnt<num 
    cnt = 0; %count set to 0 at beginning of loop
    for y = 2:1:n-1
        for x = 2:1:n-1
            unew(x,y) = (uold(x+1, y)+uold(x-1, y)+uold(x, y+1)+uold(x, y-1)-4*uold(x, y))/4;
            r = abs(unew(x, y)-uold(x, y));
            if r < ep
                cnt=cnt+1; %count increments
            end
        end
    end
    if cnt == num %if condition r<ep if true for all r then exit the loop
        break;
    end
    uold = unew;
end
para = 1/(n-1);
[X,Y] = meshgrid(0:para:1,0:para:1);
S = surf(X,Y,unew,unew);


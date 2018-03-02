clear;
%total numbers
x=100;
y=100;
h=1/x; %gridsize
k=(0.6*x)/(4*x-4); %average of all values of known boundary points
ep=0.001; %residual size

%initially set all values to k
for i=1:x+1
    for j=1:y+1
        u(i,j)=k;
    end
end

%boundary conditions
%u(0,y)=u(1,y) =0, for 0<y<1;
%u(x,1) =0, for 0<x<1;
%u(x,0) =0, for 0<x<0.2 and 0.8<x<1;
for i=1:y+1
    u(1,i)=0;
    u(x+1,i)=0;
    u(i,x+1)=0;
    u(i,1)=0;
end

%u(x,0) =1, for 0.2<x<0.8.
for i=((0.2*x)+1):((0.8*x)+1)
    u(i,1)=1;
end


cnt=x*y;
for i=1:cnt
    cnt=0;
     for n = 2:x
        for m = 2:y
            r=(u(m+1, n)+u(m-1, n)+u(m, n+1)+u(m, n-1)-4*u(m, n))/4;
            u(m,n) = u(m,n)+r;
            if r<ep
                cnt=cnt+1;
            end
        end
     end
end

[X,Y]=meshgrid(0:h:1,0:h:1);
S=surf(X,Y,u,u);













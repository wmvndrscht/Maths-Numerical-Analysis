clear;
%u(x,y)=x^2+y+2xy-1

clear;
%total numbers
x=100;
y=100;
h=1/x; %gridsize

%residual size
ep = 0.001;

%??how to get k
for i=1:x+1
    for j=1:y+1
        u(i,j)=0;
    end
end

%u(0,y)=y-1;
%u(1,y)=3y;
for i=1:y+1
    u(1,i)=((i-1)-1)/y;
    u(x+1,i)=(3*(i-1))/y;
end

%u(x,0)=x^2-1;
%u(x,1)=x^2+2*x;
for i=1:x+1
    u(i,1)=((i-1)^2-1)/x;
    u(i,y+1)=((i-1)^2+2*(i-1))/x;
end

cnt=x*y;
for i=1:cnt
    cnt=0;
     for n = 2:x
        for m = 2:y
            r=(u(m+1, n)+u(m-1, n)+u(m, n+1)+u(m, n-1)-4*u(m, n)-2)/4;
            u(m,n) = u(m,n)+r;
            if r<ep
                cnt=cnt+1;
            end
        end
     end
end

[X,Y]=meshgrid(0:h:1,0:h:1);
S=surf(X,Y,u,u);


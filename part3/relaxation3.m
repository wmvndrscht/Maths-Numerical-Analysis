    clear;
%u(x,y)=x^2+y+2xy-1
 
clear;
%total numbers
x=100;
y=100;
h=1/x; %gridsize
g(100,100)=2;
%residual size
ep = 0.001;
 
%set k to a small number
for i=1:x+1
    for j=1:y+1
        u(i,j)=0.15;
    end
end
 
%u(0,y)=y-1;
%u(1,y)=3y;
for i=1:y+1
    u(1,i)=(i-1)*h-1;
    u(x+1,i)=3*(i-1)*h;
end
 
%u(x,0)=x^2-1;
%u(x,1)=x^2+2*x;
for i=1:x+1
    u(i,1)=(h*(i-1))^2-1;
    u(i,y+1)=(h*(i-1))^2+2*(i-1)*h;
end
 
cnt=x*y;
for i=1:cnt
    cnt=0;
     for n = 2:x
        for m = 2:y
            r=(u(m+1, n)+u(m-1, n)+u(m, n+1)+u(m, n-1)-4*u(m, n)-g(m,n)*h^2)/4;
            u(m,n) = u(m,n)+r;
            if r<ep
                cnt=cnt+1;
            end
        end
     end
end
 
[X,Y]=meshgrid(0:h:1,0:h:1);
S=surf(X,Y,u,u);

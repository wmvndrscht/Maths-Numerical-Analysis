clear;
%u(x,y)=x^2+y+2xy-1

%initial average
k =
%residual size
ep =
%No of unknowns
num=64;
uold = [0 0.44 0.96 1.56 2.24 3;
        -0.2 k k k k 2.4;
        -0.4 k k k k 1.8;
        -0.6 k k k k 1.2;
        -0.8 k k k k 0.6;
        -1 -0.96 -0.84 -0.64 -0.36 0];

unew = uold;



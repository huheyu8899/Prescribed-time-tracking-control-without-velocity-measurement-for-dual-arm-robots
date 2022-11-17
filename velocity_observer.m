function  [dx_hat1,dx_hat2]= velocity_observer(xo,um,x_hat1,x_hat2)
%k1=200;k2=5000;d=0.95;
k1=200;k2=10000;d=0.95;
e1=xo-x_hat1;
dx_hat1=x_hat2+k1*e1;
dx_hat2=d*um+k2*e1;

end
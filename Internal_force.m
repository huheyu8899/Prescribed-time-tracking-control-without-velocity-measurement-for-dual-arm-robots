function   Fi  = Internal_force(Fe,xo)

  L0=0.5;
  Jo1=[1 0 L0*sin(xo(3)); 0 1 -L0*cos(xo(3));0 0 1];
  Jo2=[1 0 -L0*sin(xo(3));0 1 L0*cos(xo(3)); 0 0 1];
  Jo=[Jo1' Jo2']';
  Fi=Fe-pinv(Jo')*Jo'*Fe;
end
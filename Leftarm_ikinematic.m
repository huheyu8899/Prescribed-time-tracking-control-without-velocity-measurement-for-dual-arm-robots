
function q=Leftarm_ikinematic(xo)
   u=xo;
   L1=2;L2=1.5;L3=0.5;L0=0.5;
   xbase=-0.5;ybase=0;
   theta=u(3);
   x=u(1)-L3*cos(theta)-xbase-L0;y=u(2)-L3*sin(theta)-ybase;
   if (x==0 && y>0)
       q0=pi/2;
   elseif (x==0 && y<0)
       q0=-pi/2;
   else
       q0=atan(y/x);
   end

   a0=sqrt(x^2+y^2);
   q1=-acos((x^2+y^2+L1^2-L2^2)/(2*a0*L1))+q0;
   q2=acos((x^2+y^2+L2^2-L1^2)/(2*a0*L2))+q0-q1;
   q3=theta-q1-q2;
   q=[q1;q2;q3];
end

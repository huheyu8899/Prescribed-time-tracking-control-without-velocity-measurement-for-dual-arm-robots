
function Aom  = compute_Dom(q1,q2,xo)
%笛卡尔位置
   L11=2; L12=1.5; L13=0.5;
   L21=2; L22=1.5; L23=0.5;
   L0=0.5;
   q11=q1(1);q12=q1(2);q13=q1(3);
   q21=q2(1);q22=q2(2);q23=q2(3);

   je111=-L11*sin(q11)-L12*sin(q11+q12)-L13*sin(q11+q12+q13);
   je112=-L12*sin(q11+q12)-L13*sin(q11+q12+q13);
   je113=-L13*sin(q11+q12+q13);
   je121=L11*cos(q11)+L12*cos(q11+q12)+L13*cos(q11+q12+q13);
   je122=L12*cos(q11+q12)+L13*cos(q11+q12+q13);
   je123=L13*cos(q11+q12+q13);
   je131=1;
   je132=1;
   je133=1;
   Je1=[je111 je112 je113;je121 je122 je123;je131 je132 je133];

   je211=-L21*sin(q21)-L22*sin(q21+q22)-L23*sin(q21+q22+q23);
   je212=-L22*sin(q21+q22)-L23*sin(q21+q22+q23);
   je213=-L23*sin(q21+q22+q23);
   je221=L21*cos(q21)+L22*cos(q21+q22)+L23*cos(q21+q22+q23);
   je222=L22*cos(q21+q22)+L23*cos(q21+q22+q23);
   je223=L23*cos(q21+q22+q23);
   je231=1;
   je232=1;
   je233=1;
   Je2=[je211 je212 je213;je221 je222 je223;je231 je232 je233];

   Jo1=[1 0 L0*sin(xo(3)); 0 1 -L0*cos(xo(3));0 0 1];
   Jo2=[1 0 -L0*sin(xo(3));0 1 L0*cos(xo(3)); 0 0 1];

   Je=[Je1 zeros(3); zeros(3) Je2];
   Jo=[Jo1' Jo2']';

   Aom=pinv(Je)*Jo;
end
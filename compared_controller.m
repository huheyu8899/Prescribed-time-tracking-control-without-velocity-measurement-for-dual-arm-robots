function [um,ddxo,tol,Fe,dae,deltau]= compared_controller(r1,r2,DAom,xd,dxd,ts,Fic,Fi,q1,dq1,ddq1,q2,dq2,ddq2,x_hat1,x_hat2,xo,dxo,ae)
%笛卡尔位置
L11=2; L12=1.5; L13=0.5;
L21=2; L22=1.5; L23=0.5;
Lt=0.2;
m0=1;I0=0.8;g=9.81;L0=0.5;
P1=[14.25 3.900 0.2250 0.3000 3.0750 0.0750 64.7460 19.1295 1.4715]';
p11=P1(1);p12=P1(2);p13=P1(3);p14=P1(4);p15=P1(5);p16=P1(6);p17=P1(7);p18=P1(8);p19=P1(9);
P2=[14.25 3.900 0.2250 0.3000 3.0750 0.0750 64.7460 19.1295 1.4715]';
p21=P2(1);p22=P2(2);p23=P2(3);p24=P2(4);p25=P2(5);p26=P2(6);p27=P2(7);p28=P2(8);p29=P2(9);

q11=q1(1);q12=q1(2);q13=q1(3);
dq11=dq1(1);dq12=dq1(2);dq13=dq1(3);
q21=q2(1);q22=q2(2);q23=q2(3);
dq21=dq2(1);dq22=dq2(2);dq23=dq2(3);

d111=p11+2*p12*cos(q12)+2*p13*cos(q13)+2*p14*cos(q12+q13);
d112=p15+p12*cos(q12)+2*p13*cos(q13)+p14*cos(q12+q13);
d113=p16+p13*cos(q13)+p14*cos(q12+q13);
d121=d112;
d122=p15+2*p13*cos(q13);
d123=p16+p13*cos(q13);
d131=d113;
d132=d123;
d133=p16;

c111=-p12*dq12*sin(q12)-p13*dq13*sin(q13)-p14*(dq12+dq13)*sin(q12+q13);
c112=-p12*(dq12+dq13)*sin(q12)-p13*dq13*sin(q13)-p14*(dq11+dq12+dq13)*sin(q12+q13);
c113=-p13*(dq11+dq12+dq13)*sin(q13)-p14*(dq11+dq12+dq13)*sin(q12+q13);
c121=p12*dq11*sin(q12)-p13*dq13*sin(q13)+p14*dq11*sin(q12+q13);
c122=-p13*dq13*sin(q13);
c123=-p13*(dq11+dq12+dq13)*sin(q13);
c131=p13*(dq11+dq12)*sin(q13)+p14*dq11*sin(q12+q13);
c132=p13*(dq11+dq12)*sin(q13);
c133=0;

g11=p17*cos(q11)+p18*cos(q11+q12)+p19*cos(q11+q12+q13);
g12=p18*cos(q11+q12)+p19*cos(q11+q12+q13);
g13=p19*cos(q11+q12+q13);

je111=-L11*sin(q11)-L12*sin(q11+q12)-L13*sin(q11+q12+q13);
je112=-L12*sin(q11+q12)-L13*sin(q11+q12+q13);
je113=-L13*sin(q11+q12+q13);
je121=L11*cos(q11)+L12*cos(q11+q12)+L13*cos(q11+q12+q13);
je122=L12*cos(q11+q12)+L13*cos(q11+q12+q13);
je123=L13*cos(q11+q12+q13);
je131=1;
je132=1;
je133=1;

D1=[d111 d112 d113;d121 d122 d123;d131 d132 d133];
C1=[c111 c112 c113;c121 c122 c123;c131 c132 c133];
G1=[g11;g12;g13];
Je1=[je111 je112 je113;je121 je122 je123;je131 je132 je133];



d211=p21+2*p22*cos(q22)+2*p23*cos(q23)+2*p24*cos(q22+q23);
d212=p25+p22*cos(q22)+2*p23*cos(q23)+p24*cos(q22+q23);
d213=p26+p23*cos(q23)+p24*cos(q22+q23);
d221=d212;
d222=p25+2*p23*cos(q23);
d223=p26+p23*cos(q23);
d231=d213;
d232=d223;
d233=p26;

c211=-p22*dq22*sin(q22)-p23*dq23*sin(q23)-p24*(dq22+dq23)*sin(q22+q23);
c212=-p22*(dq22+dq23)*sin(q22)-p23*dq23*sin(q23)-p24*(dq21+dq22+dq23)*sin(q22+q23);
c213=-p23*(dq21+dq22+dq23)*sin(q23)-p24*(dq21+dq22+dq23)*sin(q22+q23);
c221=p22*dq21*sin(q22)-p23*dq23*sin(q23)+p24*dq21*sin(q22+q23);
c222=-p23*dq23*sin(q23);
c223=-p23*(dq21+dq22+dq23)*sin(q23);
c231=p23*(dq21+dq22)*sin(q23)+p24*dq21*sin(q22+q23);
c232=p23*(dq21+dq22)*sin(q23);
c233=0;

g21=p27*cos(q21)+p28*cos(q21+q22)+p29*cos(q21+q22+q23);
g22=p28*cos(q21+q22)+p29*cos(q21+q22+q23);
g23=p29*cos(q21+q22+q23);

je211=-L21*sin(q21)-L22*sin(q21+q22)-L23*sin(q21+q22+q23);
je212=-L22*sin(q21+q22)-L23*sin(q21+q22+q23);
je213=-L23*sin(q21+q22+q23);
je221=L21*cos(q21)+L22*cos(q21+q22)+L23*cos(q21+q22+q23);
je222=L22*cos(q21+q22)+L23*cos(q21+q22+q23);
je223=L23*cos(q21+q22+q23);
je231=1;
je232=1;
je233=1;

D2=[d211 d212 d213;d221 d222 d223;d231 d232 d233];
C2=[c211 c212 c213;c221 c222 c223;c231 c232 c233];
G2=[g21;g22;g23];
Je2=[je211 je212 je213;je221 je222 je223;je231 je232 je233];

Ma=[m0 0 0;0 m0 0;0 0 I0];
Ca=0;
Ga=[0;m0*g;0];

Jo1=[1 0 L0*sin(xo(3)); 0 1 -L0*cos(xo(3));0 0 1];
Jo2=[1 0 -L0*sin(xo(3));0 1 L0*cos(xo(3)); 0 0 1];

%动力学参数已知
M0=[D1 zeros(3);zeros(3) D2];
C0=[C1 zeros(3);zeros(3) C2];
G0=[G1' G2']';
Je=[Je1 zeros(3); zeros(3) Je2];
Jo=[Jo1' Jo2']';

Aom=pinv(Je)*Jo;
Dom=DAom;                                                  
Mt=M0*Aom+Je'*pinv(Jo')*Ma;
Ct=C0*Aom+M0*Dom+Je'*pinv(Jo')*Ca;
Gt=G0+Je'*pinv(Jo')*Ga;

kb1=0.2;kb2=5;


    T=4;rhof=0.5;
    if ts<T
       omega=(T/(T-ts))^4*exp(ts);
       rho=1/((1-rhof)/omega+rhof);
       drho=1/(rho*rho)*(1-rhof)*(1/(omega*omega))*omega*((T-ts+4)/(T-ts));
    else
       rho=1/rhof;
       drho=0;
    end


%rho=1;drho=0;
%r1=[0 0 0]';
%r2=[0 0 0]';
z1=x_hat1-xd-r1;
s1=rho*z1;
%sigma=drho/rho;
%alpha1=-500*z1-1*sigma*z1+dxd-1*r1-1*z1/(kb1*kb1-s1'*s1);
alpha1=-500*z1-1*z1+dxd-1*r1-z1/(kb1*kb1-s1'*s1);

z2=x_hat2-alpha1-r2;
s2=rho*z2;

c=[0 0 0 0]';sigma=2;
kesix1=[xo(1) xd(1) dxd(1) x_hat2(1)]';
faix1=exp(-(kesix1-c)'*(kesix1-c)/sigma^2);

kesix2=[xo(2) xd(2) dxd(2) x_hat2(2)]';
faix2=exp(-(kesix2-c)'*(kesix2-c)/sigma^2);

kesix3=[xo(3) xd(3) dxd(3) x_hat2(3)]';
faix3=exp(-(kesix3-c)'*(kesix3-c)/sigma^2);

Ax=[faix1 faix2 faix3]';
faix=1+norm(Ax,2)*norm(Ax,2);


s_um=-100*z2-ae(1)*faix/(kb2*kb2-s2'*s2)*rho^2*z2
dae=-0.1*ae(1)+2*faix/((kb2*kb2-s2'*s2)^2)*(rho^4)*(z2'*z2);
%ux=-200*z2-kx1*ae(1)*faix*z2;

%um=ux-kx1*ae(1)*faix*z2;
um=[0 0 0]';
if abs(s_um(1)) < 100000
   um(1)=s_um(1);
else
   um(1)=100000;
end

if abs(s_um(2)) < 100000
   um(2)=s_um(2);
else
   um(2)=100000;
end

if abs(s_um(3)) < 100000
   um(3)=s_um(3);
else
   um(3)=100000;
end

deltau=um-s_um;

tol=Je'*pinv(Jo')*um+0*Je'*Fic;
%计算Fi时采用通过Fic进行迂回的方法。直接把Fi引入改模块，编译时报错。
ddxo=Mt\(tol-Ct*dxo-Gt-Je'*Fi);
Fe1=pinv(Je1')*(tol(1:3)-D1*ddq1-C1*dq1-G1);
Fe2=pinv(Je2')*(tol(4:6)-D2*ddq2-C2*dq2-G2);
Fe=[Fe1' Fe2']';
end
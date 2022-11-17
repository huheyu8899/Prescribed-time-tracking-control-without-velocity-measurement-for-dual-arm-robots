function [um,fait,ddxo,tol,Fe,dae]= practical_prescribed_time_controller(mo,Tx,epsx,DAom,xd,dxd,t,Fic,Fi,q1,dq1,ddq1,q2,dq2,ddq2,x_hat2,xo,dxo,ae)
%笛卡尔位置
L11=2; L12=1.5; L13=0.5;
L21=2; L22=1.5; L23=0.5;
Lt=0.2;
g=9.81;L0=0.5;
m0=mo;I0=0.8*mo;
%xbase=-1.5;ybase=0;
%P1=[4.81 1.29 0.05 0.05 1.30 0.12 3.62 1.29 0.05]';
P1=[14.25 3.900 0.2250 0.3000 3.0750 0.0750 64.7460 19.1295 1.4715]';
p11=P1(1);p12=P1(2);p13=P1(3);p14=P1(4);p15=P1(5);p16=P1(6);p17=P1(7);p18=P1(8);p19=P1(9);
%P2=[4.81 1.29 0.05 0.05 1.30 0.12 3.62 1.29 0.05]';
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


%动力学参数未知
%M0=diag([5 1 0.1 5 1 0.1]);
%C0=diag([0 0 0   0 0 0]);
%G0=[2 1 0 2 1 0]';

%动力学参数已知
M0=[D1 zeros(3);zeros(3) D2];
C0=[C1 zeros(3);zeros(3) C2];
G0=[G1' G2']';
Je=[Je1 zeros(3); zeros(3) Je2];
Jo=[Jo1' Jo2']';



%Aom=[pinv(Jom1') pinv(Jom2')]';
%Dom=[(pinv(Jom1)*dJom1*(Jom1))' (pinv(Jom2)*dJom2*(Jom2))']';

Aom=pinv(Je)*Jo;
Dom=DAom;                                                  
Mt=M0*Aom+Je'*pinv(Jo')*Ma;
Ct=C0*Aom+M0*Dom+Je'*pinv(Jo')*Ca;
Gt=G0+Je'*pinv(Jo')*Ga;

ex=xo-xd;

%T=0.5;eps=0.005;
T=Tx;eps=epsx;
Yetax1=0.2;Yetax2=0.2;Yetax3=0.2;
b=eps/sqrt(Yetax1^2+Yetax2^2+Yetax3^2);

ex1=ex(1);ex2=ex(2);ex3=ex(3);
if t <=T
    fait=(1-b)*(1-t/T)^3+b;
    dfait=-3/T*(1-b)*(1-t/T)^2;
else
    fait=b;
    dfait=0;
end


if ex1 <= -Yetax1*fait
    hex1=0;
    dhex1=0;
elseif (ex1<0) && (ex1>-Yetax1*fait)
    hex1=6*(ex1/(Yetax1*fait))^5+15*(ex1/(Yetax1*fait))^4+10*(ex1/(Yetax1*fait))^3+1;
    dhex1=30*(ex1/(Yetax1*fait))^4+60*(ex1/(Yetax1*fait))^3+30*(ex1/(Yetax1*fait))^2;
elseif (ex1>=0) && (ex1<Yetax1*fait)
    hex1=-6*(ex1/(Yetax1*fait))^5+15*(ex1/(Yetax1*fait))^4-10*(ex1/(Yetax1*fait))^3+1;
    dhex1=-30*(ex1/(Yetax1*fait))^4+60*(ex1/(Yetax1*fait))^3-30*(ex1/(Yetax1*fait))^2;
else
    hex1=0;
    dhex1=0;
end


if ex2 <= -Yetax2*fait
    hex2=0;
    dhex2=0;
elseif (ex2<0) && (ex2>-Yetax2*fait)
    hex2=6*(ex2/(Yetax2*fait))^5+15*(ex2/(Yetax2*fait))^4+10*(ex2/(Yetax2*fait))^3+1;
    dhex2=30*(ex2/(Yetax2*fait))^4+60*(ex2/(Yetax2*fait))^3+30*(ex2/(Yetax2*fait))^2;
elseif (ex2>=0) && (ex2<Yetax2*fait)
    hex2=-6*(ex2/(Yetax2*fait))^5+15*(ex2/(Yetax2*fait))^4-10*(ex2/(Yetax2*fait))^3+1;
    dhex2=-30*(ex2/(Yetax2*fait))^4+60*(ex2/(Yetax2*fait))^3-30*(ex2/(Yetax2*fait))^2;
else
    hex2=0;
    dhex2=0;
end
        
if ex3 <= -Yetax3*fait
    hex3=0;
    dhex3=0;
elseif (ex3<0) && (ex3>-Yetax3*fait)
    hex3=6*(ex3/(Yetax3*fait))^5+15*(ex3/(Yetax3*fait))^4+10*(ex3/(Yetax3*fait))^3+1;
    dhex3=30*(ex3/(Yetax3*fait))^5+60*(ex3/(Yetax3*fait))^4+30*(ex3/(Yetax3*fait))^2;
elseif (ex3>=0) && (ex3<Yetax3*fait)
    hex3=-6*(ex3/(Yetax3*fait))^5+15*(ex3/(Yetax3*fait))^4-10*(ex3/(Yetax3*fait))^3+1;
    dhex3=-30*(ex3/(Yetax3*fait))^5+60*(ex3/(Yetax3*fait))^4-30*(ex3/(Yetax3*fait))^2;
else
    hex3=0;
    dhex3=0;
end


mu1=1/hex1 - dhex1*ex1/(fait*hex1*hex1);
nu1=dhex1*dfait*ex1*ex1/(fait*fait*hex1*hex1);

mu2=1/hex2 - dhex2*ex2/(fait*hex2*hex2);
nu2=dhex2*dfait*ex2*ex2/(fait*fait*hex2*hex2);


mu3=1/hex3 - dhex3*ex3/(fait*hex3*hex3);
nu3=dhex3*dfait*ex3*ex3/(fait*fait*hex3*hex3);

z1=[ex1/hex1 ex2/hex2 ex3/hex3]';
mu=diag([mu1 mu2 mu3]);
nu=[nu1 nu2 nu3]';


fai=norm(mu)^2  + norm(nu) * norm(nu);
alpha=-800*z1 -  0.2* fai *  pinv(mu) * z1 +dxd;


z2=x_hat2 - alpha;


c=[0 0 0 0]';sigma=2;
kesix1=[xo(1) xd(1) dxd(1) x_hat2(1)]';
faix1=exp(-(kesix1-c)'*(kesix1-c)/sigma^2);

kesix2=[xo(2) xd(2) dxd(2) x_hat2(2)]';
faix2=exp(-(kesix2-c)'*(kesix2-c)/sigma^2);

kesix3=[xo(3) xd(3) dxd(3) x_hat2(3)]';
faix3=exp(-(kesix3-c)'*(kesix3-c)/sigma^2);
Ax=[faix1 faix2 faix3]';
faix=1+norm(Ax,2)*norm(Ax,2);
kx1=1;kx2=1;
dae=-kx2*ae(1)+kx1*faix*norm(z2,2)*norm(z2,2)
t
ux=-100*z2-mu*z1;
um=ux-kx1*ae(1)*faix*z2;
tol=Je'*pinv(Jo')*um+1*Je'*Fic;
%计算Fi时采用通过Fic进行迂回的方法。直接把Fi引入改模块，编译时报错。
ddxo=Mt\(tol-Ct*dxo-Gt-Je'*Fi);
Fe1=pinv(Je1')*(tol(1:3)-D1*ddq1-C1*dq1-G1);
Fe2=pinv(Je2')*(tol(4:6)-D2*ddq2-C2*dq2-G2);
Fe=[Fe1' Fe2']';
end
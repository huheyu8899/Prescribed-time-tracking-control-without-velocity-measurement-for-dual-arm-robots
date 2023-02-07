function [t,Xd,Xo,FI,Tol]=dualarm_compared_control(dt,tstop)

global ddxo;          %物体运动的加速度
global dx_hat1;       %位置观测 
global dx_hat2;       %速度观测
global dae;           %神经网络的权重
global dr1;
global dr2;


%采样时间

ddxo=[0 0 0]';        %物体运动加速度的初始值
dx_hat1=[0 0 0]';     %位置观测器初始值
dx_hat2=[0 0 0]';     %速度观测器初始值
dae=0;                %神经网络权重的初始值

%dt=0.001;             %采样时间
tspan=[0 dt/2 dt];    %求解区间
tnum=tstop/dt;
%初始轨迹
xo=[1.1 2.7 pi/2+0.1]';    %位置初始值
dxo=[0 0 0]';         %速度初始值
y0=[xo' dxo']';       %物体位置求解器赋初值

yx_hat1=xo;           %位置观测求解器赋初值
x_hat1=xo;            %位置观测赋初值  
yx_hat2=dxo;          %速度观测求解器赋初值
x_hat2=dxo;           %速度观测赋初值
yae=0;                %神经网络权重求解器赋初值
ae=0;                 %神经网络权重赋初值

r1=[0 0 0]'; yr1=[0 0 0]';
r2=[0 0 0]'; yr2=[0 0 0]';


%初始角度
q1=Leftarm_ikinematic(xo);    %左臂运动学逆解，求出左臂关节角度的初值
q2=Rightarm_ikinematic(xo);   %右臂运动学逆解，求出右臂关节角度的初值
Aom=compute_Dom(q1,q2,xo);    %求出pinv(Je)*Jo的导数
Aom_t=Aom;                    %赋值pinv(Je)*Jo导数的前一时刻

%初始时刻，前一时刻的角度、速度、加速度值与当前值相同
q1_t=q1;
q2_t=q2;

dq1=(q1-q1_t)/dt;
dq2=(q2-q2_t)/dt;

dq1_t=dq1;
dq2_t=dq2;

ddq1=(dq1-dq1_t)/dt;
ddq2=(dq2-dq2_t)/dt;

%内力的期望值与初始值
Fd=[0;0;0;0;0;0];
Fi=[0;0;0;0;0;0];

%数据记录
Xd=[];Xo=[];dXo=[];
t=[];FI=[];Fait=[];
Qs1=[];Qs2=[];Tol=[];
 for i=0:1:tnum
    %采样时间
    ts=i/1000;
    %期望轨迹
    %xd=[1.2+0.1*sin(0.5*pi*ts);2+0.8*cos(0.5*pi*ts);0.4+0.1*sin(0.5*pi*ts)];
    xd=[1.2+0.5*sin(0.5*pi*ts);2+0.8*cos(0.5*pi*ts);pi/2+0.5*sin(0.5*pi*ts)];
    dxd=[0.5*0.5*pi*cos(0.5*pi*ts);-0.8*0.5*pi*sin(0.5*pi*ts);0.5*0.5*pi*cos(0.5*pi*ts)];
    
    %内力控制项
    Fic=Fd+0.005*(Fd-Fi);

    %计算关节速度与加速度
    dq1=(q1-q1_t)/dt;
    dq2=(q2-q2_t)/dt;
    ddq1=(dq1-dq1_t)/dt;
    ddq2=(dq2-dq2_t)/dt;
    DAom=(Aom-Aom_t)/dt;
    %赋值前一时刻的关节角度和关节速度
    q1_t=q1;
    q2_t=q2;
    dq1_t=dq1;
    dq2_t=dq2;
    %赋值前一时刻的pinv(Je)*Jo导数
    Aom_t=Aom;

    %根据设计的控制器求出轨迹与速度  
    [um,ddxo,tol,Fe,dae,deltau]= compared_controller(r1,r2,DAom,xd,dxd,ts,Fic,Fi,q1,dq1,ddq1,q2,dq2,ddq2,x_hat1,x_hat2,xo,dxo,ae); %控制器
    [tt,x0]=ode45(@odefunxr0,tspan,y0);          %求出轨迹及速度
    xo =x0(3,1:3)';                              %实时轨迹
    dxo=x0(3,4:6)';                              %实时速度
    y0=[xo' dxo']';                              %给积分求解器赋初值

   % deltau=[0 0 0]';
    dr1=r2-1*r1;
    %dr2=2*deltau-2*r2;
    dr2=0.95*deltau-2*r2;

    [tr1,xr1]=ode45(@odexr1,tspan,yr1);    %观测的位置
    r1 =xr1(3,1:3)';                          %观测的位置
    yr1=r1;                              %位置观测求解器赋初值
    [tr2,xr2]=ode45(@odexr2,tspan,yr2);    %速度的观测
    r2 =xr2(3,1:3)';                          %速度的观测
    yr2=r2;                              %速度观测求解器赋初值

    [dx_hat1,dx_hat2]= velocity_observer(xo,um,x_hat1,x_hat2); %速度观测器
    [tt1,x1]=ode45(@odex_hat1,tspan,yx_hat1);    %观测的位置
    x_hat1 =x1(3,1:3)';                          %观测的位置
    yx_hat1=x_hat1;                              %位置观测求解器赋初值
    [tt2,x2]=ode45(@odex_hat2,tspan,yx_hat2);    %速度的观测
    x_hat2 =x2(3,1:3)';                          %速度的观测
    yx_hat2=x_hat2;                              %速度观测求解器赋初值

    [ta,xa]=ode45(@odedae,tspan,yae);       %求出
    ae =xa(3,1)';                           %理性
    yae=ae;                                 %给出下一步对轨迹进行阻抗控制的初始状态

    %分别求左臂和右臂的关节角度
    q1=Leftarm_ikinematic(xo);
    q2=Rightarm_ikinematic(xo);
    Aom=compute_Dom(q1,q2,xo);
    
    %计算内力 
    Fi  = Internal_force(Fe,xo);
   
    %数据录取
    Xd=[Xd;xd'];Xo=[Xo;xo'];dXo=[dXo;dxo'];
    t=[t;ts];   FI=[FI;Fi']; 
    Qs1=[Qs1;q1']; Qs2=[Qs2;q2'];
    Tol=[Tol;tol'];
  end
end

%由ddxo求出xo,dxo
function y=odefunxr0(t,x)
  global ddxo;
  y=zeros(6,1); % 列向量
  y(1)=x(4);     %速度向量
  y(2)=x(5);
  y(3)=x(6);
  y(4)  =ddxo(1);  %加速度向量
  y(5)  =ddxo(2);
  y(6)  =ddxo(3);
end

%求r1
function y=odexr1(t,x)
  global dr1;
  y=zeros(3,1); % 列向量
  y(1)  =dr1(1);  %速度向量
  y(2)  =dr1(2);
  y(3)  =dr1(3);
end
%求r2
function y=odexr2(t,x)
  global dr2;
  y=zeros(3,1); % 列向量
  y(1)  =dr2(1);  %速度向量
  y(2)  =dr2(2);
  y(3)  =dr2(3);
end

%位置观测求解器
function y=odex_hat1(t,x)
  global dx_hat1;
  y=zeros(3,1); % 列向量
  y(1)  =dx_hat1(1);  %速度向量
  y(2)  =dx_hat1(2);
  y(3)  =dx_hat1(3);
end

%速度观测求解器
function y=odex_hat2(t,x)
  global dx_hat2;
  y=zeros(3,1); % 列向量
  y(1)  =dx_hat2(1);  %速度向量
  y(2)  =dx_hat2(2);
  y(3)  =dx_hat2(3);
end

%神经网络
function y=odedae(t,x)
  global dae;
  y=zeros(1,1); % 列向量
  y =dae;  %权重的导数
end
clear;clc;
%实验1，对比算法
dt=0.001;tstop=5;
[t1,Xd1,Xo1,FI1,Tol1]=dualarm_compared_control(dt,tstop);
%实验2，本文算法
dt=0.001;tstop=5;Tx=2;epsx=0.003;mo=1;
[t2,Xd2,Xo2,FI2,Fait2,Vel2,dXo2,Ae2,Tol2]=dualarm_velocity_prescribed_time_control(dt,tstop,Tx,epsx,mo);

%实验3，验证精度可变，与实验2相比，改变精度
dt=0.001;tstop=5;Tx=2;epsx=0.03;mo=1;
[t3,Xd3,Xo3,FI3,Fait3,Vel3,dXo3,Ae3,Tol3]=dualarm_velocity_prescribed_time_control(dt,tstop,Tx,epsx,mo);


%实验4，验证收敛时间可变，与实验2相比，改变收敛时间
dt=0.001;tstop=5;Tx=0.5;epsx=0.003;mo=1;
[t4,Xd4,Xo4,FI4,Fait4,Vel4,dXo4,Ae4,Tol4]=dualarm_velocity_prescribed_time_control(dt,tstop,Tx,epsx,mo);

%实验5，验证被抓取物体重量可变，与实验2相比，改变重量
dt=0.001;tstop=5;Tx=2;epsx=0.003;mo=4;
[t5,Xd5,Xo5,FI5,Fait5,Vel5,dXo5,Ae5,Tol5]=dualarm_velocity_prescribed_time_control(dt,tstop,Tx,epsx,mo);


%实验6，验证被抓取物体重量可变，与实验2相比，改变重量
dt=0.001;tstop=5;Tx=2;epsx=0.0005;mo=1;
[t6,Xd6,Xo6,FI6,Fait6,Vel6,dXo6,Ae6,Tol6]=dualarm_velocity_prescribed_time_control(dt,tstop,Tx,epsx,mo);

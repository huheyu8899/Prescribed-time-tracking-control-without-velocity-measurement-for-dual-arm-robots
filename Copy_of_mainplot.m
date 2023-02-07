close all;
clc;


%比较控制器的内力
figure(8);
y1=plot(t2(1:10000),FI2(1:10000,1),'r');
hold on; y2=plot(t2(1:10000),FI2(1:10000,1),'m');
hold on; y3=plot(t2(1:10000),FI2(1:10000,2),'b');
hold on; y4=plot(t2(1:10000),FI2(1:10000,2),'--r');
hold on; y5=plot(t2(1:10000),FI2(1:10000,3),'--m');
hold on; y6=plot(t2(1:10000),FI2(1:10000,3),'--b');
xlabel('Time(s)');
ylabel( 'Internal force(N)' );
ylim([-60 60]);
legend([y1,y2,y3,y4,y5,y6],'X-axis of left arm','Y-axis of left arm','\theta-axis of left arm','X-axis of right arm','Y-axis of right arm','\theta-axis of right arm','Location','northeast','NumColumns', 2);
text(0.1,600,'The proposed controller')
axes('position',[0.3 0.2 0.5 0.15]);
y1=plot(t2(1:10000),FI2(1:10000,1),'r');
hold on; y2=plot(t2(1:10000),FI2(1:10000,1),'m');
hold on; y3=plot(t2(1:10000),FI2(1:10000,2),'b');
hold on; y4=plot(t2(1:10000),FI2(1:10000,2),'--r');
hold on; y5=plot(t2(1:10000),FI2(1:10000,3),'--m');
hold on; y6=plot(t2(1:10000),FI2(1:10000,3),'--b');
xlabel('Time(s)');
xlim([0.01 0.1]);


figure(9);
y1=plot(t1(1:10000),FI1(1:10000,1),'r');
hold on; y2=plot(t1(1:10000),FI1(1:10000,1),'m');
hold on; y3=plot(t1(1:10000),FI1(1:10000,2),'b');
hold on; y4=plot(t1(1:10000),FI1(1:10000,2),'--r');
hold on; y5=plot(t1(1:10000),FI1(1:10000,3),'--m');
hold on; y6=plot(t1(1:10000),FI1(1:10000,3),'--b');
xlabel('Time(s)');
ylabel( 'Internal force(N)');
ylim([-60 60]);
legend([y1,y2,y3,y4,y5,y6],'X-axis of left arm','Y-axis of left arm','\theta-axis of left arm','X-axis of right arm','Y-axis of right arm','\theta-axis of right arm','Location','northeast','NumColumns', 2);
text(0.1,600,'Controller in [17]')
axes('position',[0.3 0.2 0.5 0.15]);
y1=plot(t1(1:10000),FI1(1:10000,1),'r');
hold on; y2=plot(t1(1:10000),FI1(1:10000,1),'m');
hold on; y3=plot(t1(1:10000),FI1(1:10000,2),'b');
hold on; y4=plot(t1(1:10000),FI1(1:10000,2),'--r');
hold on; y5=plot(t1(1:10000),FI1(1:10000,3),'--m');
hold on; y6=plot(t1(1:10000),FI1(1:10000,3),'--b');
xlim([0.01 0.1]);


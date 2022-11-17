close all;
clc;

AA=0.2;
%提出算法轨迹
figure(3);
subplot(2,1,1)
plot3(Xo2(1:5000,1),Xo2(1:5000,2),Xo2(1:5000,3),'b');
hold on ;plot3(Xd2(1:5000,1),Xd2(1:5000,2),Xd2(1:5000,3),'k');
legend('Actual trajectory with the proposed controller','Desired trajectory','Location','northeast');
xlabel( 'X axis(m)' );
ylabel( 'Y axis(m)');
zlabel( '\theta axis(rad)' );
%xlim([0.05 0.35]);
%ylim([-1.1 1.1]);
%zlim([0.25 0.8]);
%PD控制的轨迹
subplot(2,1,2)
plot3(Xo1(1:5000,1),Xo1(1:5000,2),Xo1(1:5000,3),'c');
hold on;plot3(Xd1(1:5000,1),Xd1(1:5000,2),Xd1(1:5000,3),'k');
legend('Actual trajectory with the controller in [17]','Desired trajectory','Location','northeast');
xlabel( 'X axis(m)');
ylabel( 'Y axis(m)' );
zlabel( '\theta axis(rad)');
%xlim([0.05 0.35]);
%ylim([-1.1 1.1]);
%zlim([0.25 0.75]);
%X方向的轨迹
figure(4)
subplot(2,1,1)
y1=plot(t2(1:5000),Xd2(1:5000,1),'k');
hold on; y2=plot(t2(1:5000),Xo2(1:5000,1),'b');
hold on; y3=plot(t2(1:5000),Xo1(1:5000,1),'c');
hold on; y4=plot(t1(1:5000),Xd2(1:5000,1)+AA,'--m');
hold on; y5=plot(t1(1:5000),Xd2(1:5000,1)-AA,'--m');
legend([y1,y2,y3,y4],'Desired trajectory','Actual trajectory with the controller in [17]','Actual trajectory with the proposed controller','The constrained boundary','Location','northeast');
xlabel('Time(s)');
ylabel( 'X axis (m)');
%ylim([-0.2 0.75]);
subplot(2,1,2)
y1=plot(t1(1:5000),Xo2(1:5000,1)-Xd2(1:5000,1),'b');
hold on; y2=plot(t1(1:5000),Fait2(1:5000,1),'--m');
hold on; y3=plot(t1(1:5000),-Fait2(1:5000,1),'--m');
legend([y1,y2],'Trajectory error in X-direction','The constrained boundary','Location','northeast');
xlabel('Time(s)');
ylabel( 'Trajectory error (m)');
axes('position',[0.45 0.16 0.4 0.08]);
y1=plot(t1(1:5000),Xo2(1:5000,1)-Xd2(1:5000,1),'b');
hold on; y2=plot(t1(1:5000),Fait2(1:5000,1),'--m');
hold on; y3=plot(t1(1:5000),-Fait2(1:5000,1),'--m');
xlim([2 5]);
ylim([-0.01 0.01]);
set(gca,'ytick',[-0.01 0 0.01],'yticklabel',{'-0.01','0','0.01'})




%Y方向的轨迹
figure(5)
subplot(2,1,1)
y1=plot(t2(1:5000),Xd2(1:5000,2),'k');
hold on; y2=plot(t2(1:5000),Xo2(1:5000,2),'b');
hold on; y3=plot(t1(1:5000),Xo1(1:5000,2),'c');
hold on; y4=plot(t2(1:5000),Xd2(1:5000,2)+AA,'--m');
hold on; y5=plot(t2(1:5000),Xd2(1:5000,2)-AA,'--m');
legend([y1,y2,y3,y4],'Desired trajectory','Actual trajectory with the controller in [17]','Actual trajectory with the proposed controller','The constrained boundary','Location','northeast');
xlabel('Time(s)');
ylabel( 'Y axis(m)');
%ylim([-1.1 1.8]);
subplot(2,1,2)
y1=plot(t1(1:5000),Xo2(1:5000,2)-Xd2(1:5000,2),'b');
hold on; y2=plot(t1(1:5000),Fait2(1:5000,1),'--m');
hold on; y3=plot(t1(1:5000),-Fait2(1:5000,1),'--m');
legend([y1,y2],'Trajectory error in Y-direction','The constrained boundary','Location','northeast');
xlabel('Time(s)');
ylabel( 'Trajectory error (m)');
axes('position',[0.45 0.16 0.4 0.08]);
y1=plot(t1(1:5000),Xo2(1:5000,2)-Xd2(1:5000,2),'b');
hold on; y2=plot(t1(1:5000),Fait2(1:5000,1),'--m');
hold on; y3=plot(t1(1:5000),-Fait2(1:5000,1),'--m');
xlim([2 5]);
ylim([-0.01 0.01]);
set(gca,'ytick',[-0.01 0 0.01],'yticklabel',{'-0.01','0','0.01'})


%theta方向的轨迹
figure(6)
subplot(2,1,1)
y1=plot(t2(1:5000),Xd2(1:5000,3),'k');
hold on; y2=plot(t2(1:5000),Xo2(1:5000,3),'b');
hold on; y3=plot(t1(1:5000),Xo1(1:5000,3),'c');
hold on; y4=plot(t2(1:5000),Xd2(1:5000,3)+AA,'--m');
hold on; y5=plot(t2(1:5000),Xd2(1:5000,3)-AA,'--m');
legend([y1,y2,y3,y4],'Desired trajectory','Actual trajectory with the controller in [17]','Actual trajectory with the proposed controller','The constrained boundary','Location','northeast');
xlabel('Time(s)');
ylabel( '\theta axis(rad)');
%ylim([0 1]);
subplot(2,1,2)
y1=plot(t1(1:5000),Xo2(1:5000,3)-Xd2(1:5000,3),'b');
hold on; y2=plot(t1(1:5000),Fait2(1:5000,1),'--m');
hold on; y3=plot(t1(1:5000),-Fait2(1:5000,1),'--m');
legend([y1,y2],'Trajectory error in \theta-direction','The constrained boundary','Location','northeast');
xlabel('Time(s)');
ylabel( 'Trajectory error (rad)' );
axes('position',[0.45 0.16 0.4 0.08]);
y1=plot(t1(1:5000),Xo2(1:5000,3)-Xd2(1:5000,3),'b');
hold on; y2=plot(t1(1:5000),Fait2(1:5000,1),'--m');
hold on; y3=plot(t1(1:5000),-Fait2(1:5000,1),'--m');
xlim([2 5]);
ylim([-0.01 0.01]);
set(gca,'ytick',[-0.01 0 0.01],'yticklabel',{'-0.01','0','0.01'})
%误差精度对比
figure(7);
ex_norm1(1:5000)=0;
ex_norm2(1:5000)=0;
ex2=Xo2-Xd2;
ex1=Xo1-Xd1;
for i=1:5000
  ex_norm1(i)=norm(ex1(i,:),2);
  ex_norm2(i)=norm(ex2(i,:),2);
end
ex_norm1=ex_norm1';

y1=plot(t1(1:5000),ex_norm1(1:5000),'c');
hold on; y2=plot(t1(1:5000),ex_norm2(1:5000),'b');
hold on; y3=plot(t1(1:5000),AA*sqrt(3)*Fait2(1:5000,1),'--m');
hold on; y4=plot(t1(1:5000),-AA*sqrt(3)*Fait2(1:5000,1),'--m');
legend([y1,y2,y3],'Controller in [17]','The proposed controller','The constrained boundary','Location','northeast');
ylabel({'$$ {\parallel} e_x {\parallel} (m)$$'},'Interpreter','latex');
xlabel('Time(s)');
axes('position',[0.3 0.2 0.5 0.15]);
y1=plot(t1(1:5000),ex_norm1(1:5000),'c');
hold on; y2=plot(t1(1:5000),ex_norm2(1:5000),'b');
hold on; y3=plot(t1(1:5000),AA*sqrt(3)*Fait2(1:5000,1),'--m');
hold on; y4=plot(t1(1:5000),-AA*sqrt(3)*Fait2(1:5000,1),'--m');
xlim([3 5]);
ylim([-0.008 0.008]);
set(gca,'ytick',[-0.01 -0.003 0.003,0.01],'yticklabel',{'-0.01','-0.003','0.003','0.01'})

%ylim([-0.01 0.01]);


%比较控制器的内力
figure(8);
y1=plot(t2(1:5000),FI2(1:5000,1),'r');
hold on; y2=plot(t2(1:5000),FI2(1:5000,1),'c');
hold on; y3=plot(t2(1:5000),FI2(1:5000,2),'b');
hold on; y4=plot(t2(1:5000),FI2(1:5000,2),'--r');
hold on; y5=plot(t2(1:5000),FI2(1:5000,3),'--c');
hold on; y6=plot(t2(1:5000),FI2(1:5000,3),'--b');
xlabel('Time(s)');
ylabel( 'Internal force(N)' );
ylim([-1500 1500]);
legend([y1,y2,y3,y4,y5,y6],'X-axis of left arm','Y-axis of left arm','\theta-axis of left arm','X-axis of right arm','Y-axis of right arm','\theta-axis of right arm','Location','northeast','NumColumns', 2);
text(0.1,600,'The proposed controller')
axes('position',[0.3 0.2 0.5 0.15]);
y1=plot(t2(1:5000),FI2(1:5000,1),'r');
hold on; y2=plot(t2(1:5000),FI2(1:5000,1),'c');
hold on; y3=plot(t2(1:5000),FI2(1:5000,2),'b');
hold on; y4=plot(t2(1:5000),FI2(1:5000,2),'--r');
hold on; y5=plot(t2(1:5000),FI2(1:5000,3),'--c');
hold on; y6=plot(t2(1:5000),FI2(1:5000,3),'--b');
xlabel('Time(s)');
xlim([0.01 0.1]);


figure(9);
y1=plot(t1(1:5000),FI1(1:5000,1),'r');
hold on; y2=plot(t1(1:5000),FI1(1:5000,1),'c');
hold on; y3=plot(t1(1:5000),FI1(1:5000,2),'b');
hold on; y4=plot(t1(1:5000),FI1(1:5000,2),'--r');
hold on; y5=plot(t1(1:5000),FI1(1:5000,3),'--c');
hold on; y6=plot(t1(1:5000),FI1(1:5000,3),'--b');
xlabel('Time(s)');
ylabel( 'Internal force(N)');
ylim([-1500 1500]);
legend([y1,y2,y3,y4,y5,y6],'X-axis of left arm','Y-axis of left arm','\theta-axis of left arm','X-axis of right arm','Y-axis of right arm','\theta-axis of right arm','Location','northeast','NumColumns', 2);
text(0.1,600,'Controller in [17]')
axes('position',[0.3 0.2 0.5 0.15]);
y1=plot(t1(1:5000),FI1(1:5000,1),'r');
hold on; y2=plot(t1(1:5000),FI1(1:5000,1),'c');
hold on; y3=plot(t1(1:5000),FI1(1:5000,2),'b');
hold on; y4=plot(t1(1:5000),FI1(1:5000,2),'--r');
hold on; y5=plot(t1(1:5000),FI1(1:5000,3),'--c');
hold on; y6=plot(t1(1:5000),FI1(1:5000,3),'--b');
xlim([0.01 0.1]);


%速度观测效果mo=1kg
figure(10);
subplot(3,1,1)
y1=plot(t2(1:5000),Vel2(1:5000,1),'b');
hold on; y2=plot(t2(1:5000),dXo2(1:5000,1),'c');
h=legend([y1,y2],'The observed velocity in X-direction','The real velocity in X-direction');
xlabel('Time(s)');
ylabel('Velocity(m/s)');
subplot(3,1,2)
y1=plot(t2(1:5000),Vel2(1:5000,2),'b');
hold on; y2=plot(t2(1:5000),dXo2(1:5000,2),'c');
h=legend([y1,y2],'The observed velocity in Y-direction','The real velocity in Y-direction');
xlabel('Time(s)');
ylabel('Velocity(m/s)');
subplot(3,1,3)
y1=plot(t2(1:5000),Vel2(1:5000,2),'b');
hold on; y2=plot(t2(1:5000),dXo2(1:5000,2),'c');
legend([y1,y2],'The observed velocity in \theta-direction','The real velocity in \theta-direction','Location','northeast');
xlabel('Time(s)');
ylabel('Velocity(rad/s)');




%误差收敛精度对比
figure(11)
subplot(2,1,1)
ex_norm3(1:5000)=0;
ex3=Xo3-Xd3;
for i=1:5000
  ex_norm1(i)=norm(ex3(i,1:3),2);
 end
ex_norm3=ex_norm3';

y1=plot(t3(1:5000),ex_norm3(1:5000),'b');
hold on; y3=plot(t1(1:5000),AA*sqrt(3)*Fait3(1:5000,1),'--m');
hold on; y4=plot(t1(1:5000),-AA*sqrt(3)*Fait3(1:5000,1),'--m');
h=legend([y1,y3],'$\varepsilon_x=0.03m$','The constrained boundary');
set(h,'Interpreter','latex','Location','northeast','FontWeight','normal');
ylabel({'$$ \parallel e_x \parallel (m)$$'},'Interpreter','latex');
xlabel('Time(s)');
ylim([-0.5 0.5]);
axes('position',[0.45 0.64 0.4 0.08]);
y1=plot(t1(1:5000),ex_norm3(1:5000),'b');
hold on; y3=plot(t1(1:5000),AA*sqrt(3)*Fait3(1:5000,1),'--m');
hold on; y4=plot(t1(1:5000),-AA*sqrt(3)*Fait3(1:5000,1),'--m');
xlim([1.8 5]);
ylim([-0.04 0.04]);
set(gca,'ytick',[-0.03 0 0.03],'yticklabel',{'-0.03','0','0.03'})

subplot(2,1,2)
ex_norm2(1:5000)=0;
ex2=Xo2-Xd2;
for i=1:5000
  ex_norm2(i)=norm(ex2(i,1:3),2);
 end
ex_norm2=ex_norm2';

y1=plot(t2(1:5000),ex_norm2(1:5000),'b');
hold on; y3=plot(t2(1:5000),AA*sqrt(3)*Fait2(1:5000,1),'--m');
hold on; y4=plot(t2(1:5000),-AA*sqrt(3)*Fait2(1:5000,1),'--m');
h=legend([y1,y3],'$\varepsilon_x=0.003m$','The constrained boundary');
set(h,'Interpreter','latex','Location','northeast','FontWeight','normal');
ylim([-0.5 0.5]);
ylabel({'$$ \parallel e_x \parallel (m)$$'},'Interpreter','latex');
xlabel('Time(s)');
axes('position',[0.45 0.16 0.4 0.08]);
y1=plot(t2(1:5000),ex_norm2(1:5000),'b');
hold on; y3=plot(t2(1:5000),AA*sqrt(3)*Fait2(1:5000,1),'--m');
hold on; y4=plot(t2(1:5000),-AA*sqrt(3)*Fait2(1:5000,1),'--m');
xlim([1.8 5]);
ylim([-0.004 0.004]);
set(gca,'ytick',[-0.003 0 0.003],'yticklabel',{'-0.003','0','0.003'})

%误差收敛时间对比
figure(12);
subplot(2,1,1)
ex_norm4(1:5000)=0;
ex4=Xo4-Xd4;
for i=1:5000
  ex_norm4(i)=norm(ex4(i,1:3),2);
 end
ex_norm4=ex_norm4';

y1=plot(t4(1:5000),ex_norm4(1:5000),'b');
hold on; y3=plot(t4(1:5000),AA*sqrt(3)*Fait4(1:5000,1),'--m');
hold on; y4=plot(t1(1:5000),-AA*sqrt(3)*Fait4(1:5000,1),'--m');
h=legend([y1,y3],'$T_x=0.5s$','The constrained boundary');
set(h,'Interpreter','latex','Location','northeast','FontWeight','normal');
ylabel({'$$ {\parallel} e_x {\parallel} (m)$$'},'Interpreter','latex');
xlabel('Time(s)');
%ylim([-0.5 0.5]);
axes('position',[0.45 0.64 0.4 0.08]);
y1=plot(t4(1:5000),ex_norm4(1:5000),'b');
hold on; y3=plot(t1(1:5000),AA*sqrt(3)*Fait4(1:5000,1),'--m');
hold on; y4=plot(t1(1:5000),-AA*sqrt(3)*Fait4(1:5000,1),'--m');
xlim([0 5]);
ylim([0 0.008]);
set(gca,'ytick',[0 0.003,0.008],'yticklabel',{'0','0.003','0.008'})

subplot(2,1,2)
ex_norm2(1:5000)=0;
ex2=Xo2-Xd2;
for i=1:5000
  ex_norm2(i)=norm(ex2(i,1:3),2);
 end
ex_norm2=ex_norm2';
y1=plot(t2(1:5000),ex_norm2(1:5000),'b');
hold on; y2=plot(t2(1:5000),AA*sqrt(3)*Fait2(1:5000,1),'--m');
hold on; y4=plot(t2(1:5000),-AA*sqrt(3)*Fait2(1:5000,1),'--m');
h=legend([y1,y3],'$T_x=2s$','The constrained boundary');
set(h,'Interpreter','latex','Location','northeast','FontWeight','normal');
ylim([-0.5 0.5]);
ylabel({'$$ \parallel e_x \parallel (m)$$'},'Interpreter','latex');
xlabel('Time(s)');
axes('position',[0.45 0.16 0.4 0.08]);
y1=plot(t2(1:5000),ex_norm2(1:5000),'b');
hold on; y3=plot(t2(1:5000),AA*sqrt(3)*Fait2(1:5000,1),'--m');
hold on; y4=plot(t2(1:5000),-AA*sqrt(3)*Fait2(1:5000,1),'--m');
xlim([0 5]);
ylim([0 0.008]);
set(gca,'ytick',[0 0.003,0.008],'yticklabel',{'0','0.003','0.008'})



%不同重量时的收敛时间
figure(13);
%set(gcf,'Position',[100 100 900 400]);
subplot(2,1,1)
ex_norm5(1:5000)=0;
ex5=Xo5-Xd5;
for i=1:5000
  ex_norm5(i)=norm(ex5(i,1:3),2);
 end
ex_norm5=ex_norm5';

y1=plot(t5(1:5000),ex_norm5(1:5000),'b');
hold on; y3=plot(t5(1:5000),AA*sqrt(3)*Fait5(1:5000,1),'--m');
hold on; y4=plot(t5(1:5000),-AA*sqrt(3)*Fait5(1:5000,1),'--m');
h=legend([y1,y3],'$m_o=4kg$','The constrained boundary');
set(h,'Interpreter','latex','Location','northeast','FontWeight','normal');
ylabel({'$$ {\parallel} e_x {\parallel} (m)$$'},'Interpreter','latex');
xlabel('Time(s)');
%ylim([-0.5 0.5]);
axes('position',[0.45 0.64 0.4 0.08]);
y1=plot(t5(1:5000),ex_norm5(1:5000),'b');
hold on; y3=plot(t5(1:5000),AA*sqrt(3)*Fait5(1:5000,1),'--m');
hold on; y4=plot(t5(1:5000),-AA*sqrt(3)*Fait5(1:5000,1),'--m');
xlim([0 5]);
ylim([0 0.008]);
set(gca,'ytick',[0 0.003,0.008],'yticklabel',{'0','0.003','0.008'})

subplot(2,1,2)
ex_norm2(1:5000)=0;
ex2=Xo2-Xd2;
for i=1:5000
  ex_norm2(i)=norm(ex2(i,1:3),2);
 end
ex_norm2=ex_norm2';
y1=plot(t2(1:5000),ex_norm2(1:5000),'b');
hold on; y2=plot(t2(1:5000),AA*sqrt(3)*Fait2(1:5000,1),'--m');
hold on; y4=plot(t2(1:5000),-AA*sqrt(3)*Fait2(1:5000,1),'--m');
h=legend([y1,y3],'$m_o=1kg$','The constrained boundary');
set(h,'Interpreter','latex','Location','northeast','FontWeight','normal');
ylim([-0.5 0.5]);
ylabel({'$$ \parallel e_x \parallel (m)$$'},'Interpreter','latex');
xlabel('Time(s)');
axes('position',[0.45 0.16 0.4 0.08]);
y1=plot(t2(1:5000),ex_norm2(1:5000),'b');
hold on; y3=plot(t2(1:5000),AA*sqrt(3)*Fait2(1:5000,1),'--m');
hold on; y4=plot(t2(1:5000),-AA*sqrt(3)*Fait2(1:5000,1),'--m');
xlim([0 5]);
ylim([0 0.008]);
set(gca,'ytick',[0 0.003,0.008],'yticklabel',{'0','0.003','0.008'})

%不同重量时的自适应参数
figure(14);
subplot(2,1,1)
y2=plot(t2(1:5000),Ae5(1:5000,1),'b');
h=legend([y2],'$m_o=4kg$');
set(h,'Interpreter','latex','Location','northeast','FontWeight','normal');
xlabel('Time(s)');
ylabel('Estimated value');
subplot(2,1,2)
y1=plot(t2(1:5000),Ae2(1:5000,1),'b');
h=legend([y1],'$m_o=1kg$');
set(h,'Interpreter','latex','Location','northeast','FontWeight','normal');
xlabel('Time(s)');
ylabel('Estimated value');






%预设精度为0.0005m时的转矩
figure(15);
subplot(3,1,1)
y1=plot(t2(1:5000),Tol6(1:5000,1),'b');
h=legend([y1,y2],'The 1st joint torque');
xlabel('Time(s)');
ylabel('Joint torque(N/m)');
subplot(3,1,2)
y1=plot(t2(1:5000),Tol6(1:5000,2),'b');
h=legend([y1,y2],'The 2nd joint torque');
xlabel('Time(s)');
ylabel('Joint torque(N/m)');
subplot(3,1,3)
y1=plot(t2(1:5000),Tol6(1:5000,2),'b');
legend([y1,y2],'The 3rd joint torque');
xlabel('Time(s)');
ylabel('Joint torque(N/m)');



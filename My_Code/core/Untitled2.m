%%
x=80:10:200;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止
%%
a=GFS_data(1,:); %a数据y值
b=E_data(1,:); %b数据y值
figure
plot(x,a,'-*r','LineWidth',2.5)
hold on
plot(x,b,'-.sk','LineWidth',2.5)
%axis([0,6,0,700])  %确定x轴与y轴框图大小
%set(gca,'XTick',[0:1:6]) %x轴范围1-6，间隔1
%set(gca,'YTick',[0:100:700]) %y轴范围0-700，间隔100
l1=legend('GFS','E-Optiaml');   %右上角标注
set(l1,'FontSize',16)
xlabel('G1采样集大小')  %x轴坐标描述
ylabel('初始优化目标值') %y轴坐标描述
set(gca,'FontSize',15)

%%
a=GFS_data(2,:); %a数据y值
b=E_data(2,:); %b数据y值
figure
plot(x,a,'-*r','LineWidth',2.5)
hold on
plot(x,b,'-.sk','LineWidth',2.5)
%axis([0,6,0,700])  %确定x轴与y轴框图大小
%set(gca,'XTick',[0:1:6]) %x轴范围1-6，间隔1
%set(gca,'YTick',[0:100:700]) %y轴范围0-700，间隔100
l2=legend('GFS','E-Optiaml');   %右上角标注
set(l2,'FontSize',16)
xlabel('G2采样集大小')  %x轴坐标描述
ylabel('初始优化目标值') %y轴坐标描述
set(gca,'FontSize',15)

%%
a=GFS_data(3,:); %a数据y值
b=E_data(3,:); %b数据y值
figure
plot(x,a,'-*r','LineWidth',2.5)
hold on
plot(x,b,'-.sk','LineWidth',2.5)
%axis([0,6,0,700])  %确定x轴与y轴框图大小
%set(gca,'XTick',[0:1:6]) %x轴范围1-6，间隔1
%set(gca,'YTick',[0:100:700]) %y轴范围0-700，间隔100
l3=legend('GFS','E-Optiaml');   %右上角标注
set(l3,'FontSize',16)
xlabel('G3采样集大小')  %x轴坐标描述
ylabel('初始优化目标值') %y轴坐标描述
set(gca,'FontSize',15)
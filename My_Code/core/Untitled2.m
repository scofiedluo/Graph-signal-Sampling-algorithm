%%
x=80:10:200;%x���ϵ����ݣ���һ��ֵ�������ݿ�ʼ���ڶ���ֵ��������������ֵ������ֹ
%%
a=GFS_data(1,:); %a����yֵ
b=E_data(1,:); %b����yֵ
figure
plot(x,a,'-*r','LineWidth',2.5)
hold on
plot(x,b,'-.sk','LineWidth',2.5)
%axis([0,6,0,700])  %ȷ��x����y���ͼ��С
%set(gca,'XTick',[0:1:6]) %x�᷶Χ1-6�����1
%set(gca,'YTick',[0:100:700]) %y�᷶Χ0-700�����100
l1=legend('GFS','E-Optiaml');   %���ϽǱ�ע
set(l1,'FontSize',16)
xlabel('G1��������С')  %x����������
ylabel('��ʼ�Ż�Ŀ��ֵ') %y����������
set(gca,'FontSize',15)

%%
a=GFS_data(2,:); %a����yֵ
b=E_data(2,:); %b����yֵ
figure
plot(x,a,'-*r','LineWidth',2.5)
hold on
plot(x,b,'-.sk','LineWidth',2.5)
%axis([0,6,0,700])  %ȷ��x����y���ͼ��С
%set(gca,'XTick',[0:1:6]) %x�᷶Χ1-6�����1
%set(gca,'YTick',[0:100:700]) %y�᷶Χ0-700�����100
l2=legend('GFS','E-Optiaml');   %���ϽǱ�ע
set(l2,'FontSize',16)
xlabel('G2��������С')  %x����������
ylabel('��ʼ�Ż�Ŀ��ֵ') %y����������
set(gca,'FontSize',15)

%%
a=GFS_data(3,:); %a����yֵ
b=E_data(3,:); %b����yֵ
figure
plot(x,a,'-*r','LineWidth',2.5)
hold on
plot(x,b,'-.sk','LineWidth',2.5)
%axis([0,6,0,700])  %ȷ��x����y���ͼ��С
%set(gca,'XTick',[0:1:6]) %x�᷶Χ1-6�����1
%set(gca,'YTick',[0:100:700]) %y�᷶Χ0-700�����100
l3=legend('GFS','E-Optiaml');   %���ϽǱ�ע
set(l3,'FontSize',16)
xlabel('G3��������С')  %x����������
ylabel('��ʼ�Ż�Ŀ��ֵ') %y����������
set(gca,'FontSize',15)
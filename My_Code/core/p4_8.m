%***********************************************************
%150�ڵ����������ͬ������£���ͬ�ؽ��㷨MSE�Ƚ�
%***********************************************************

clear
load('LP_filter.mat');
load('graph_signal_k50.mat');
M=[0,2,4,6,8,10,12,14,16,18,20];

LS_data=zeros(3,11);
GFS_data=zeros(3,11);
GFS_D_data=zeros(3,11);

k0=100;
K=50;
sample_size=150;


%%
tic
for k=1:10
for j=1:3
    if j==1
        W=full(double(G1.L));
        nodes_num=nodes_num1;
        T_FGFT=T1;
        f=f1;
        U=G1.U;
    end
    if j==2
        W=full(double(G2.L));
        nodes_num=nodes_num2;
        T_FGFT=T2;
        f=f2;
        U=G2.U;
    end
    if j==3
        W=full(double(G3.L));
        nodes_num=nodes_num3;
        T_FGFT=T3;
        f=f3;
        U=G3.U;
    end
    for i=1:11
        snr=M(i);
        [GFS_S1,GFS_S2,GFS_C,GFS_fs,inverse_GS]=greedy_GFS(nodes_num,sample_size,k0,T_FGFT,f);
        %[E_S1,E_S2,E_C,E_fs,V]=E_Optiaml_sampling(nodes_num,K,sample_size,W,f);
        ys=awgn(GFS_fs,snr);
        [recon_signal1] = LS_reconstruction(U,GFS_C,ys);
        [recon_signal2] = GFS_reconstruction(0,GFS_C,inverse_GS,ys,T_FGFT,GFS_S2,nodes_num,sample_size,K);
        [recon_signal3] = GFS_reconstruction(1,GFS_C,inverse_GS,ys,T_FGFT,GFS_S2,nodes_num,sample_size,K);
        
         LS_data(j,i)= LS_data(j,i)+compute_MSE(f,recon_signal1,nodes_num);
         GFS_data(j,i)=GFS_data(j,i)+compute_MSE(f,recon_signal2,nodes_num);
         GFS_D_data(j,i)=GFS_D_data(j,i)+compute_MSE(f,recon_signal3,nodes_num);
    end
end
end
LS_data=LS_data/10;
GFS_data=GFS_data/10;
GFS_D_data=GFS_D_data/10;
toc

%%
x=0:2:20;%x���ϵ����ݣ���һ��ֵ�������ݿ�ʼ���ڶ���ֵ��������������ֵ������ֹ
%%
a=LS_data(1,:); %a����yֵ
b=GFS_data(1,:); %b����yֵ
c=GFS_D_data(1,:);
figure
plot(x,a,'-.or','LineWidth',2.5)
hold on
plot(x,b,'-sb','LineWidth',2.5)
hold on
plot(x,c,'-hk','LineWidth',2.5); %���ԣ���ɫ�����
%axis([0,6,0,700])  %ȷ��x����y���ͼ��С
%set(gca,'XTick',[0:1:6]) %x�᷶Χ1-6�����1
%set(gca,'YTick',[0:100:700]) %y�᷶Χ0-700�����100
l1=legend('LS','GFS,$\beta =\mu$','GFS,designed  $\beta$');   %���ϽǱ�ע
set(l1,'Interpreter','latex','FontSize',16)
xlabel('G1  SNR(dB)')  %x����������
ylabel('MSE') %y����������
set(gca,'FontSize',15)

%%
a=LS_data(2,:); %a����yֵ
b=GFS_data(2,:); %b����yֵ
c=GFS_D_data(2,:);
figure
plot(x,a,'-.or','LineWidth',2.5)
hold on
plot(x,b,'-sb','LineWidth',2.5)
hold on
plot(x,c,'-hk','LineWidth',2.5); %���ԣ���ɫ�����
%axis([0,6,0,700])  %ȷ��x����y���ͼ��С
%set(gca,'XTick',[0:1:6]) %x�᷶Χ1-6�����1
%set(gca,'YTick',[0:100:700]) %y�᷶Χ0-700�����100
l2=legend('LS','GFS,$\beta =\mu $','GFS,designed $\beta $');   %���ϽǱ�ע
set(l2,'Interpreter','latex','FontSize',16)
xlabel('G2  SNR(dB)')  %x����������
ylabel('MSE') %y����������
set(gca,'FontSize',15)

%%
a=LS_data(3,:); %a����yֵ
b=GFS_data(3,:); %b����yֵ
c=GFS_D_data(3,:);
figure
plot(x,a,'-.or','LineWidth',2.5)
hold on
plot(x,b,'-sb','LineWidth',2.5)
hold on
plot(x,c,'-hk','LineWidth',2.5); %���ԣ���ɫ�����
%axis([0,6,0,700])  %ȷ��x����y���ͼ��С
%set(gca,'XTick',[0:1:6]) %x�᷶Χ1-6�����1
%set(gca,'YTick',[0:100:700]) %y�᷶Χ0-700�����100
l3=legend('LS','GFS,$\beta =\mu$','GFS,designed $\beta$');   %���ϽǱ�ע
set(l3,'Interpreter','latex','FontSize',16)
xlabel('G3  SNR(dB)')  %x����������
ylabel('MSE') %y����������
set(gca,'FontSize',15)
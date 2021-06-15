%*********************************************************
%***************10dB����ʱ��ͬ��������СMSEͼ��*****************

%%
clear
load('LP_filter.mat');
load('graph_signal_k50.mat');


M=[80,90,100,110,120,130,140,150,160,170,180,190,200];%��������С
node=[1000,1000,2642];
GFS_data=zeros(3,13);
E_data=zeros(3,13);
k0=100;
K=50;

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
    for i=1:13
        sample_size=M(i);
        [GFS_S1,GFS_S2,GFS_C,GFS_fs,inverse_GS]=greedy_GFS(nodes_num,sample_size,k0,T_FGFT,f);
        [E_S1,E_S2,E_C,E_fs,V]=E_Optiaml_sampling(nodes_num,K,sample_size,W,f);
        [recon_signal1] = LS_reconstruction(U,GFS_C,awgn(GFS_fs,10));
        [recon_signal2] = LS_reconstruction(U,E_C,awgn(E_fs,10));
        
        GFS_data(j,i)=GFS_data(j,i)+compute_MSE(f,recon_signal1,nodes_num);
        E_data(j,i)=GFS_data(j,i)+compute_MSE(f,recon_signal2,nodes_num);
    end
end
end
GFS_data=GFS_data/10;
E_data= E_data/10;
toc

%%
x=80:10:200;%x���ϵ����ݣ���һ��ֵ�������ݿ�ʼ���ڶ���ֵ��������������ֵ������ֹ
%%
a=GFS_data(1,:); %a����yֵ
b=E_data(1,:); %b����yֵ
figure
plot(x,a,'-+r',x,b,'-db'); %���ԣ���ɫ�����
%axis([0,6,0,700])  %ȷ��x����y���ͼ��С
%set(gca,'XTick',[0:1:6]) %x�᷶Χ1-6�����1
%set(gca,'YTick',[0:100:700]) %y�᷶Χ0-700�����100
l1=legend('GFS','E-Optiaml');   %���ϽǱ�ע
set(l1,'FontSize',12.5)
xlabel('G1��������С')  %x����������
ylabel('MSE') %y����������
set(gca,'FontSize',12)

%%
a=GFS_data(2,:); %a����yֵ
b=E_data(2,:); %b����yֵ
figure
plot(x,a,'-+r',x,b,'-db'); %���ԣ���ɫ�����
%axis([0,6,0,700])  %ȷ��x����y���ͼ��С
%set(gca,'XTick',[0:1:6]) %x�᷶Χ1-6�����1
%set(gca,'YTick',[0:100:700]) %y�᷶Χ0-700�����100
l2=legend('GFS','E-Optiaml');   %���ϽǱ�ע
set(l2,'FontSize',12.5)
xlabel('G2��������С')  %x����������
ylabel('MSE') %y����������
set(gca,'FontSize',12)

%%
a=GFS_data(3,:); %a����yֵ
b=E_data(3,:); %b����yֵ
figure
plot(x,a,'-+r',x,b,'-db'); %���ԣ���ɫ�����
%axis([0,6,0,700])  %ȷ��x����y���ͼ��С
%set(gca,'XTick',[0:1:6]) %x�᷶Χ1-6�����1
%set(gca,'YTick',[0:100:700]) %y�᷶Χ0-700�����100
l3=legend('GFS','E-Optiaml');   %���ϽǱ�ע
set(l3,'FontSize',12.5)
xlabel('G3��������С')  %x����������
ylabel('MSE') %y����������
set(gca,'FontSize',12)

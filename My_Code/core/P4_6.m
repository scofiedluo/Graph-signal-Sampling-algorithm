%********************************************************************
%*********不同噪声大小上150节点的LS重建**********************


clear
load('LP_filter.mat');
load('graph_signal_k50.mat');
M=[0,2,4,6,8,10,12,14,16,18,20];
GFS_data=zeros(3,11);
E_data=zeros(3,11);
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
        [E_S1,E_S2,E_C,E_fs,V]=E_Optiaml_sampling(nodes_num,K,sample_size,W,f);
        [recon_signal1] = LS_reconstruction(U,GFS_C,awgn(GFS_fs,snr));
        [recon_signal2] = LS_reconstruction(U,E_C,awgn(E_fs,snr));
        
        GFS_data(j,i)=GFS_data(j,i)+compute_MSE(f,recon_signal1,nodes_num);
        E_data(j,i)=GFS_data(j,i)+compute_MSE(f,recon_signal2,nodes_num);
    end
end
end
GFS_data=GFS_data/10;
E_data= E_data/10;
toc

%%
x=0:2:20;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止
%%
a=GFS_data(1,:); %a数据y值
b=E_data(1,:); %b数据y值
figure
plot(x,a,'-sr','LineWidth',2.5)
hold on
plot(x,b,'-.xk','LineWidth',2.5)
%axis([0,6,0,700])  %确定x轴与y轴框图大小
%set(gca,'XTick',[0:1:6]) %x轴范围1-6，间隔1
%set(gca,'YTick',[0:100:700]) %y轴范围0-700，间隔100
l1=legend('GFS','E-Optiaml');   %右上角标注
set(l1,'FontSize',16)
xlabel('G1   SNR(dB)')  %x轴坐标描述
ylabel('MSE') %y轴坐标描述
set(gca,'FontSize',15)

%%
a=GFS_data(2,:); %a数据y值
b=E_data(2,:); %b数据y值
figure
plot(x,a,'-sr','LineWidth',2.5)
hold on
plot(x,b,'-.xk','LineWidth',2.5)
%axis([0,6,0,700])  %确定x轴与y轴框图大小
%set(gca,'XTick',[0:1:6]) %x轴范围1-6，间隔1
%set(gca,'YTick',[0:100:700]) %y轴范围0-700，间隔100
l2=legend('GFS','E-Optiaml');   %右上角标注
set(l2,'FontSize',16)
xlabel('G2   SNR(dB)')  %x轴坐标描述
ylabel('MSE') %y轴坐标描述
set(gca,'FontSize',15)

%%
a=GFS_data(3,:); %a数据y值
b=E_data(3,:); %b数据y值
figure
plot(x,a,'-sr','LineWidth',2.5)
hold on
plot(x,b,'-.xk','LineWidth',2.5)
%axis([0,6,0,700])  %确定x轴与y轴框图大小
%set(gca,'XTick',[0:1:6]) %x轴范围1-6，间隔1
%set(gca,'YTick',[0:100:700]) %y轴范围0-700，间隔100
l3=legend('GFS','E-Optiaml');   %右上角标注
set(l3,'FontSize',16)
xlabel('G3   SNR(dB)')  %x轴坐标描述
ylabel('MSE') %y轴坐标描述
set(gca,'FontSize',15)
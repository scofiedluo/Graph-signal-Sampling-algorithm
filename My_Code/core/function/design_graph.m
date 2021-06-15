function [G1,G2,G3,f1,f2,f3,nodes_num1,nodes_num2,nodes_num3] = design_graph(K)
%************创建信号及添加加性高斯白噪声*************
%输入参数
%K：低通图信号带宽
%SNR:信噪比

%输出参数
%低通信号及含噪信号

%%
%********************************
%        初始化底层三个图           
%********************************
nodes_num1=1000;
G1 = gsp_community(nodes_num1);      %社区图，1000节点
paramplot.show_edges = 1;
%figure (1)
%gsp_plot_graph(G1,paramplot);

nodes_num2=1000;
G2 = gsp_sensor(nodes_num2);         %随机传感器网络图，1000节点
paramplot.show_edges = 1;
%figure (2)
%gsp_plot_graph(G2,paramplot);

nodes_num3=2642;
G3 = gsp_minnesota();      %minnesota真实世界图，2642个节点
paramplot.show_edges = 1;
%figure (3)
%gsp_plot_graph(G3,paramplot);

%%
%**********************************************
%构造三个图不含噪低通图信号                   
%先对图拉普拉斯矩阵进行特征分解                
%并构造带宽为50的低通图信号                    
%系数服从均值为0，方差为0.25的正态分布         
%***********************************************
tic
G1 = gsp_compute_fourier_basis(G1);  %特征分解
G2 = gsp_compute_fourier_basis(G2);
G3 = gsp_compute_fourier_basis(G3);
toc
%低通信号系数
alpha1=0.5.*randn(K,1);%生成m*n的服从标准正态分布的随机矩阵
alpha2=0.5.*randn(K,1);
alpha3=0.5.*randn(K,1);
f1=(G1.U(:,1:K))*alpha1;
f2=(G2.U(:,1:K))*alpha2;
f3=(G3.U(:,1:K))*alpha3;
figure(1)
%subplot(2,3,1)
gsp_plot_signal(G1,f1,paramplot);
title(['G1原信号,带宽K=',num2str(K)])

figure(2)
%subplot(2,3,2)
gsp_plot_signal(G2,f2);
title(['G2原信号,带宽K=',num2str(K)])

figure(3)
%subplot(2,3,3)
gsp_plot_signal(G3,f3);
title(['G3原信号,带宽K=',num2str(K)])
%%
%添加加性高斯白噪声
%fn1=awgn(f1,SNR);
%fn2=awgn(f2,SNR);
%fn3=awgn(f3,SNR);

%figure(4)
%subplot(2,3,4)
%gsp_plot_signal(G1,fn1,paramplot);
%title(['G1含噪信号,SNR=',num2str(SNR),'dB'])

%figure(5)
%subplot(2,3,5)
%gsp_plot_signal(G2,fn2);
%title(['G2含噪信号,SNR=',num2str(SNR),'dB'])

%figure(6)
%subplot(2,3,6)
%gsp_plot_signal(G3,fn3);
%title(['G3含噪信号,SNR=',num2str(SNR),'dB'])

end
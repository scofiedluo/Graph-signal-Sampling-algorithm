function [G1,G2,G3,f1,f2,f3,nodes_num1,nodes_num2,nodes_num3] = design_graph(K)
%************�����źż���Ӽ��Ը�˹������*************
%�������
%K����ͨͼ�źŴ���
%SNR:�����

%�������
%��ͨ�źż������ź�

%%
%********************************
%        ��ʼ���ײ�����ͼ           
%********************************
nodes_num1=1000;
G1 = gsp_community(nodes_num1);      %����ͼ��1000�ڵ�
paramplot.show_edges = 1;
%figure (1)
%gsp_plot_graph(G1,paramplot);

nodes_num2=1000;
G2 = gsp_sensor(nodes_num2);         %�������������ͼ��1000�ڵ�
paramplot.show_edges = 1;
%figure (2)
%gsp_plot_graph(G2,paramplot);

nodes_num3=2642;
G3 = gsp_minnesota();      %minnesota��ʵ����ͼ��2642���ڵ�
paramplot.show_edges = 1;
%figure (3)
%gsp_plot_graph(G3,paramplot);

%%
%**********************************************
%��������ͼ�������ͨͼ�ź�                   
%�ȶ�ͼ������˹������������ֽ�                
%���������Ϊ50�ĵ�ͨͼ�ź�                    
%ϵ�����Ӿ�ֵΪ0������Ϊ0.25����̬�ֲ�         
%***********************************************
tic
G1 = gsp_compute_fourier_basis(G1);  %�����ֽ�
G2 = gsp_compute_fourier_basis(G2);
G3 = gsp_compute_fourier_basis(G3);
toc
%��ͨ�ź�ϵ��
alpha1=0.5.*randn(K,1);%����m*n�ķ��ӱ�׼��̬�ֲ����������
alpha2=0.5.*randn(K,1);
alpha3=0.5.*randn(K,1);
f1=(G1.U(:,1:K))*alpha1;
f2=(G2.U(:,1:K))*alpha2;
f3=(G3.U(:,1:K))*alpha3;
figure(1)
%subplot(2,3,1)
gsp_plot_signal(G1,f1,paramplot);
title(['G1ԭ�ź�,����K=',num2str(K)])

figure(2)
%subplot(2,3,2)
gsp_plot_signal(G2,f2);
title(['G2ԭ�ź�,����K=',num2str(K)])

figure(3)
%subplot(2,3,3)
gsp_plot_signal(G3,f3);
title(['G3ԭ�ź�,����K=',num2str(K)])
%%
%��Ӽ��Ը�˹������
%fn1=awgn(f1,SNR);
%fn2=awgn(f2,SNR);
%fn3=awgn(f3,SNR);

%figure(4)
%subplot(2,3,4)
%gsp_plot_signal(G1,fn1,paramplot);
%title(['G1�����ź�,SNR=',num2str(SNR),'dB'])

%figure(5)
%subplot(2,3,5)
%gsp_plot_signal(G2,fn2);
%title(['G2�����ź�,SNR=',num2str(SNR),'dB'])

%figure(6)
%subplot(2,3,6)
%gsp_plot_signal(G3,fn3);
%title(['G3�����ź�,SNR=',num2str(SNR),'dB'])

end
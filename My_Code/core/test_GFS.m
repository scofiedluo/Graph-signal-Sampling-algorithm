clear
load('LP_filter.mat');
load('graph_signal_k50.mat');
%load('10dB_50k_signal.mat');
%[G1,G2,G3,f1,f2,f3,fn1,fn2,fn3,nodes_num1,nodes_num2,nodes_num3] = design_graph(50,10);

k0=100;
nodes_num=nodes_num3;
sample_size=150;
T_FGFT=T3;
f=f3;

[S1,S2,C,fs,inverse_GS]=greedy_GFS(nodes_num,sample_size,k0,T_FGFT,f); 
figure
gsp_plot_signal(G3,S1);

tic
[recon_signal] = LS_reconstruction(G3.U,C,awgn(fs,10));
toc

[error_MSE]=compute_MSE(f3,recon_signal,nodes_num)
figure
plot(abs(recon_signal-f3));

clear
load('LP_filter.mat');
load('graph_signal_k50.mat');
%[G1,G2,G3,f1,f2,f3,fn1,fn2,fn3,nodes_num1,nodes_num2,nodes_num3] = design_graph(50,10);

k0=100;
nodes_num=nodes_num3;
sample_size=150;
T_FGFT=T3;
f=f3;
K=50;

tic
[S1,S2,C,fs,inverse_GS]=greedy_GFS(nodes_num,sample_size,k0,T_FGFT,f);
toc
figure
gsp_plot_signal(G3,S1);


choice=0;
tic
[recon_signal] = GFS_reconstruction(choice,C,inverse_GS,awgn(fs,10),T3,S2,nodes_num,sample_size,K);
toc
[error_MSE]=compute_MSE(f3,recon_signal,nodes_num)
figure
plot(abs(recon_signal-f3));
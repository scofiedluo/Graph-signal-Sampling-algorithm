load('graph_signal_k50.mat');
%load('3graph_and_signal.mat');

nodes_num=nodes_num1;
K=50;
sample_size=150;
W=full(double(G1.L));
f=f1;
[S1,S2,C,fs,V]=E_Optiaml_sampling(nodes_num,K,sample_size,W,f);

figure
gsp_plot_signal(G1,S1);

[recon_signal] = LS_reconstruction(V,C,awgn(fs,10));

[error_MSE]=compute_MSE(f1,recon_signal,nodes_num)
figure
plot(abs(recon_signal-f1));
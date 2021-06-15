clear
load('LP_filter.mat');
load('graph_signal_k50.mat');
result=zeros(5,3);

k0=100;
sample_size=150;
K=50;
%%
nodes_num=nodes_num1;
T_FGFT=T1;
f=f1;

[GFS_S1,GFS_S2,GFS_C,GFS_fs,inverse_GS]=greedy_GFS(nodes_num,sample_size,k0,T_FGFT,f); 

W=full(double(G1.L));
[E_S1,E_S2,E_C,E_fs,V]=E_Optiaml_sampling(nodes_num,K,sample_size,W,f);

OP1=trace(inv((GFS_C*G1.U(:,1:K))'*(GFS_C*G1.U(:,1:K))));
OP2=trace(inv((E_C*G1.U(:,1:K))'*(E_C*G1.U(:,1:K))));
[recon_signal1] = LS_reconstruction(G1.U,GFS_C,awgn(GFS_fs,10));
[recon_signal2] = GFS_reconstruction(0,GFS_C,inverse_GS,awgn(GFS_fs,10),T1,GFS_S2,nodes_num,sample_size,K);
[recon_signal3] = GFS_reconstruction(1,GFS_C,inverse_GS,awgn(GFS_fs,10),T1,GFS_S2,nodes_num,sample_size,K);
result(1,1)=OP1;
result(2,1)=OP2;
result(3,1)=compute_MSE(f1,recon_signal1,nodes_num);
result(4,1)=compute_MSE(f1,recon_signal2,nodes_num);
result(5,1)=compute_MSE(f1,recon_signal3,nodes_num);

%%
nodes_num=nodes_num2;
T_FGFT=T2;
f=f2;

[GFS_S1,GFS_S2,GFS_C,GFS_fs,inverse_GS]=greedy_GFS(nodes_num,sample_size,k0,T_FGFT,f); 

W=full(double(G2.L));
[E_S1,E_S2,E_C,E_fs,V]=E_Optiaml_sampling(nodes_num,K,sample_size,W,f);

OP1=trace(inv((GFS_C*G2.U(:,1:K))'*(GFS_C*G2.U(:,1:K))));
OP2=trace(inv((E_C*G2.U(:,1:K))'*(E_C*G2.U(:,1:K))));
[recon_signal1] = LS_reconstruction(G2.U,GFS_C,awgn(GFS_fs,10));
[recon_signal2] = GFS_reconstruction(0,GFS_C,inverse_GS,awgn(GFS_fs,10),T2,GFS_S2,nodes_num,sample_size,K);
[recon_signal3] = GFS_reconstruction(1,GFS_C,inverse_GS,awgn(GFS_fs,10),T2,GFS_S2,nodes_num,sample_size,K);
result(1,2)=OP1;
result(2,2)=OP2;
result(3,2)=compute_MSE(f2,recon_signal1,nodes_num);
result(4,2)=compute_MSE(f2,recon_signal2,nodes_num);
result(5,2)=compute_MSE(f2,recon_signal3,nodes_num);

%%

nodes_num=nodes_num3;
T_FGFT=T3;
f=f3;

[GFS_S1,GFS_S2,GFS_C,GFS_fs,inverse_GS]=greedy_GFS(nodes_num,sample_size,k0,T_FGFT,f); 

W=full(double(G3.L));
[E_S1,E_S2,E_C,E_fs,V]=E_Optiaml_sampling(nodes_num,K,sample_size,W,f);

OP1=trace(inv((GFS_C*G3.U(:,1:K))'*(GFS_C*G3.U(:,1:K))));
OP2=trace(inv((E_C*G3.U(:,1:K))'*(E_C*G3.U(:,1:K))));
[recon_signal1] = LS_reconstruction(G3.U,GFS_C,awgn(GFS_fs,10));
[recon_signal2] = GFS_reconstruction(0,GFS_C,inverse_GS,awgn(GFS_fs,10),T3,GFS_S2,nodes_num,sample_size,K);
[recon_signal3] = GFS_reconstruction(1,GFS_C,inverse_GS,awgn(GFS_fs,10),T3,GFS_S2,nodes_num,sample_size,K);
result(1,3)=OP1;
result(2,3)=OP2;
result(3,3)=compute_MSE(f3,recon_signal1,nodes_num);
result(4,3)=compute_MSE(f3,recon_signal2,nodes_num);
result(5,3)=compute_MSE(f3,recon_signal3,nodes_num);

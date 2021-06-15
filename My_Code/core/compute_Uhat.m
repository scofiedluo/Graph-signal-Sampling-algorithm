clear
clc
load('graph_signal_k50.mat');

%%
%**********************************************
%近似理想低通滤波器T(FGFT)的构造              
%利用雅克比特征分解法 
%函数引用来自FAuST_code_version_1.1\demos_and_applications\FGFT\methods

%  Greedy matrix diagonalization with prallel Givens rotations.
%  [facts,D,err,L,coord_choices] = diagonalization_givens_parall(Lap,J,t)
%  runs the matrix diagonalization algorithm (Algorithm in figure 4 of [1]) 
%  on the specified input matrix "Lap" with "J" Givens rotations with "t" 
%  Givens rotations chosen in parallel at each step. It returns the 
%  obtained Givens rotations in the cell array "facts", the approximate 
%  eigenvalues matrix in "D", the error in "err", the corresponding
%  approximately diagonalized matrix in "L" and the coordinates of the
%  chosen Givens rotations in "coord_choices".
%***********************************************

G1_Lap=full(G1.L);
G2_Lap=full(G2.L);
G3_Lap=full(G3.L);

G1_J = 1*nodes_num1*round(log2(nodes_num1));
G2_J = 1*nodes_num2*round(log2(nodes_num2));
G3_J = 1*nodes_num3*round(log2(nodes_num3));

G1_t=nodes_num1/2;
G2_t=nodes_num2/2;
G3_t=nodes_num3/2;
tic
%D=eye(nodes_num1);
[G1_facts,G1_D,G1_L,G1_coord_choices] = FGFT(G1_Lap,G1_J,G1_t);
toc
[G2_facts,G2_D,G2_L,G2_coord_choices] = FGFT(G2_Lap,G2_J,G2_t);
toc
[G3_facts,G3_D,G3_L,G3_coord_choices] = FGFT(G3_Lap,G3_J,G3_t);
toc

%G1_Uhat_givens_parall=eye(nodes_num1);
%STLS = Lap;
%for j=1:numel(G1_facts)
   %  G1_Uhat_givens_parall=G1_facts{j}'*G1_Uhat_givens_parall;
%end
%G1_Uhat_givens_parall = G1_Uhat_givens_parall';

%计算G1的近似特征矩阵**************
%G1_STLS = G1_Lap;
G1_Uhat=eye(nodes_num1);
for j=1:numel(G1_facts)
    G1_Uhat=G1_Uhat*G1_facts{j};
    %G1_STLS = G1_facts{j}'*G1_STLS*G1_facts{j};  %特征值对角矩阵
end
G1_spec_hat = diag(G1_D);
[~,Ispec] = sort(G1_spec_hat);
Perm_1 = Ispec;
D_hat_1 = diag(G1_spec_hat(Ispec));
G1_Uhat=G1_Uhat(Perm_1,:);
%************************

%计算G2近似特征矩阵******************
%G2_STLS = G2_Lap;
G2_Uhat=eye(nodes_num2);
for j=1:numel(G2_facts)
    G2_Uhat=G2_Uhat*G2_facts{j};
    %G2_STLS = G2_facts{j}'*G2_STLS*G2_facts{j};  %特征值对角矩阵
end
G2_spec_hat = diag(G2_D);
[~,Ispec] = sort(G2_spec_hat);
Perm_2 = Ispec;
D_hat_2 = diag(G2_spec_hat(Ispec));
G2_Uhat=G2_Uhat(Perm_2,:);
%**************************************

%计算G3近似特征矩阵*********************
%G3_STLS = G3_Lap;
G3_Uhat=eye(nodes_num3);
for j=1:numel(G3_facts)
    G3_Uhat=G3_Uhat*G3_facts{j};
    %G3_STLS = G3_facts{j}'*G3_STLS*G3_facts{j};    %特征值对角矩阵
end
G3_spec_hat = diag(G3_D);
[~,Ispec] = sort(G3_spec_hat);
Perm_3 = Ispec;
D_hat_3 = diag(G3_spec_hat(Ispec));
G3_Uhat=G3_Uhat(Perm_3,:);
%**************************************
toc

%%
%低通滤波器的近似
cutoff=50;
T1=G1.U(:,1:cutoff)*G1.U(:,1:cutoff)';
T2=G2.U(:,1:cutoff)*G2.U(:,1:cutoff)';
T3=G3.U(:,1:cutoff)*G3.U(:,1:cutoff)';
T_FGFT_1 = G1_Uhat(:,1:cutoff)*G1_Uhat(:,1:cutoff)';
T_FGFT_2 = G2_Uhat(:,1:cutoff)*G2_Uhat(:,1:cutoff)';
T_FGFT_3 = G3_Uhat(:,1:cutoff)*G3_Uhat(:,1:cutoff)';
error1=norm(T1-T_FGFT_1,'fro')/norm(T1,'fro')
error2=norm(T2-T_FGFT_2,'fro')/norm(T2,'fro')
error3=norm(T3-T_FGFT_3,'fro')/norm(T3,'fro')


function [recon_signal] = LS_reconstruction(U,C,fs)
%%
%***********最小均方重建算法(LS)******************
%输入参数
%U：完全分解特征矩阵
%C:采样矩阵（采样算子）
%fs:采样信号

%输出参数
%recon_signal：重建信号
%%
K=50;
temp=C*U(:,1:K);
pseudo_inverse_temp=pinv(temp);
recon_signal=U(:,1:K)*pseudo_inverse_temp*fs;
%recon_signal=U(:,1:K)*inv(temp'*temp)*temp'*fs;
end
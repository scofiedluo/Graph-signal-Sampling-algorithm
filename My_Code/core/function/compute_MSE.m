function [error_MSE]=compute_MSE(f1,f2,N)
%%
%f1Ϊԭ�źţ�f2Ϊ�����ź�
%%
error_MSE=sum((f1-f2).^2)/N;

end
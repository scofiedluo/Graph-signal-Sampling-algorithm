function [error_MSE]=compute_MSE(f1,f2,N)
%%
%f1为原信号，f2为估计信号
%%
error_MSE=sum((f1-f2).^2)/N;

end
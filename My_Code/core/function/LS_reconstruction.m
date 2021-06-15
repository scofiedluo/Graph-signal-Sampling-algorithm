
function [recon_signal] = LS_reconstruction(U,C,fs)
%%
%***********��С�����ؽ��㷨(LS)******************
%�������
%U����ȫ�ֽ���������
%C:�������󣨲������ӣ�
%fs:�����ź�

%�������
%recon_signal���ؽ��ź�
%%
K=50;
temp=C*U(:,1:K);
pseudo_inverse_temp=pinv(temp);
recon_signal=U(:,1:K)*pseudo_inverse_temp*fs;
%recon_signal=U(:,1:K)*inv(temp'*temp)*temp'*fs;
end
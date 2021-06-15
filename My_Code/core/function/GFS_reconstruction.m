function [recon_signal] = GFS_reconstruction(choice,C,inverse_GS,fs,T_FGFT,S2,nodes_num,sample_size,K)
%%
%********************GFS重建*******************************************

%输入参数
%choice:模式选择，为0时重建参数beta与采样参数相同，即复用采样所得矩阵inverse_GS，为1时按文献设计beta
%inverse_GS：GFS采样返回结果之一
%fs:采样信号
%T_FGFT：由快速图傅里叶变换算法所得近似低通滤波器
%S2:采样索引集合
%K:带宽

%输出参数
%重建信号
T_VS=zeros(nodes_num,sample_size);
%sort_S=sort(S2);
%T_VS=T_FGFT(:,1:sample_size);
for i=1:sample_size
    T_VS(:,i)=T_FGFT(:,S2(i));
end

if choice==0             %使用采样结果直接进行重建
    recon_signal=T_VS*inverse_GS*fs;
end

if choice==1
    TS=C*T_FGFT*C';
    temp=0;
    for i=1:sample_size
        temp=temp+T_FGFT(S2(i),S2(i));
    end
    beta=temp/K;
    recon_signal=T_VS*inv(TS+beta*eye(sample_size))*fs;
end
end
function [recon_signal] = GFS_reconstruction(choice,C,inverse_GS,fs,T_FGFT,S2,nodes_num,sample_size,K)
%%
%********************GFS�ؽ�*******************************************

%�������
%choice:ģʽѡ��Ϊ0ʱ�ؽ�����beta�����������ͬ�������ò������þ���inverse_GS��Ϊ1ʱ���������beta
%inverse_GS��GFS�������ؽ��֮һ
%fs:�����ź�
%T_FGFT���ɿ���ͼ����Ҷ�任�㷨���ý��Ƶ�ͨ�˲���
%S2:������������
%K:����

%�������
%�ؽ��ź�
T_VS=zeros(nodes_num,sample_size);
%sort_S=sort(S2);
%T_VS=T_FGFT(:,1:sample_size);
for i=1:sample_size
    T_VS(:,i)=T_FGFT(:,S2(i));
end

if choice==0             %ʹ�ò������ֱ�ӽ����ؽ�
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
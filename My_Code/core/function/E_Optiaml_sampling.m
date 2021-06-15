function [S1,S2,C,fs,V]=E_Optiaml_sampling(nodes_num,K,sample_size,W,f)
%%
%E_optiaml̰�Ĳ���
%�ο����ף�
%Chen S., Varma R., Sandryhaila A., et al. Discrete Signal Processing
%on Graphs: Sampling Theory[J]. IEEE Transactions on Signal Processing,2015,63(24):6510-6523.

%���������
%nodes_num��ԭͼ�ڵ���
%K����ͨ�źŴ���Ϊһ����
%sample_size����������С
%W:Ȩ�ؾ��󣬼�������A����
%f:��ͼG��ͼ�ź�

%�������
%S1:nodes_numά��������ֵΪ1��ʾ�ýڵ㱻������Ϊ0��ʾδ����
%S2:nodes_numά��������ֵ��ʾ�����ڵ�������δ������
%fs:�����ź�

%%
[V,D]=eig(W);
V_K=V(:,1:K);
S1=zeros(1,nodes_num);     %��������������Ԫ��ֵΪ1��ʾ�����ڵ���Ѳ���������Ϊδ����
S2=zeros(1,sample_size);    %��������ڵ㼯��������������ѡȡ˳������

%Sample_V_K=zeros(1,K);      %%��ʼ���Ա����
min_singular=-1;            %%����ֵ������0���ʳ�ʼֵѡ��-1һ���ܸ���

for i=1:sample_size
    count=0;
    flag=0;
    for j=1:nodes_num-i+1           %�ò�ѭ��ѡ���������i���ڵ�ʱ����С����ֵ�������Ǹ�����Ӧ�Ľڵ�
        if S1(j)==0
            if i==1&&count==0
                temp_M=V_K(j,:);
                temp_singular=svd(temp_M);
                min_temp_singular=min(temp_singular);
                count=count+1;
            end
            
            if (i<=K)&&(i~=1)
                temp_M=[temp_M;V_K(j,:)];   %%����V_K�Ĳ��������Ա��ж��Ѳ����������Ƿ������޹�
                if rank(temp_M)<i           %%��if�����ж�Ŀǰ�����Ƿ�Ϊ������
                    temp_M=temp_M(1:i-1,:);
                else
                flag=flag+1;
                if flag==1
                    temp_singular=svd(temp_M);
                    min_temp_singular=min(temp_singular);
                    temp_M=temp_M(1:i-1,:);
                    min_singular=min_temp_singular;
                    add_nodes=j;
                    temp_row=V_K(j,:);
                else
                    temp_singular=svd(temp_M);
                    min_temp_singular=min(temp_singular);
                    temp_M=temp_M(1:i-1,:);
                end
                end
            end
            
            if (i<=K)&&(i==1)&&(count~=1)
                temp_M=V_K(j,:);   %%����V_K�Ĳ��������Ա��ж��Ѳ����������Ƿ������޹�
                temp_singular=svd(temp_M);
                min_temp_singular=min(temp_singular);
            end
            count=count+1;
            if i>K                 %����Ҫ�ж��Ƿ�����,ֻ��Ҫ��δ�����ڵ��в���ѡ�񣬲��Ƚ���С����ֵ
                temp_M=[temp_M;V_K(j,:)];
                temp_singular=svd(temp_M);
                min_temp_singular=min(temp_singular);
                temp_M=temp_M(1:i-1,:);
            end
        end
        if min_temp_singular>min_singular
           min_singular=min_temp_singular;
           add_nodes=j;
           temp_row=V_K(j,:);
        end
    end
    S1(add_nodes)=1;
    S2(i)=add_nodes;
    if i>1
    temp_M=[temp_M;temp_row];
    end
end

%%
%�����������
C=zeros(sample_size,nodes_num);
final_S=sort(S2);
for j=1:sample_size
    C(j,final_S(j))=1;
end
%%
fs=C*f;

end

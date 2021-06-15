function [S1,S2,C,fs,V]=E_Optiaml_sampling(nodes_num,K,sample_size,W,f)
%%
%E_optiaml贪心采样
%参考文献：
%Chen S., Varma R., Sandryhaila A., et al. Discrete Signal Processing
%on Graphs: Sampling Theory[J]. IEEE Transactions on Signal Processing,2015,63(24):6510-6523.

%输入参数：
%nodes_num：原图节点数
%K：低通信号带宽，为一整数
%sample_size：采样集大小
%W:权重矩阵，即文献中A矩阵
%f:该图G上图信号

%输出参数
%S1:nodes_num维行向量，值为1表示该节点被采样，为0表示未采样
%S2:nodes_num维行向量，值表示采样节点索引，未经排序
%fs:采样信号

%%
[V,D]=eig(W);
V_K=V(:,1:K);
S1=zeros(1,nodes_num);     %采样集索引表，表元素值为1表示采样节点采已采样，否则为未采样
S2=zeros(1,sample_size);    %储存采样节点集的所有索引，以选取顺序排列

%Sample_V_K=zeros(1,K);      %%初始化以便更新
min_singular=-1;            %%奇异值均大于0，故初始值选择-1一定能更新

for i=1:sample_size
    count=0;
    flag=0;
    for j=1:nodes_num-i+1           %该层循环选择采样到第i个节点时，最小奇异值中最大的那个所对应的节点
        if S1(j)==0
            if i==1&&count==0
                temp_M=V_K(j,:);
                temp_singular=svd(temp_M);
                min_temp_singular=min(temp_singular);
                count=count+1;
            end
            
            if (i<=K)&&(i~=1)
                temp_M=[temp_M;V_K(j,:)];   %%更新V_K的采样矩阵，以便判断已采样行向量是否线性无关
                if rank(temp_M)<i           %%该if用于判断目前矩阵是否为行满秩
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
                temp_M=V_K(j,:);   %%更新V_K的采样矩阵，以便判断已采样行向量是否线性无关
                temp_singular=svd(temp_M);
                min_temp_singular=min(temp_singular);
            end
            count=count+1;
            if i>K                 %不需要判断是否满秩,只需要在未采样节点中不断选择，并比较最小奇异值
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
%构造采样集合
C=zeros(sample_size,nodes_num);
final_S=sort(S2);
for j=1:sample_size
    C(j,final_S(j))=1;
end
%%
fs=C*f;

end

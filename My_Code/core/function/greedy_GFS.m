
function [S1,S2,C,fs,inverse_GS]=greedy_GFS(nodes_num,sample_size,k0,T_FGFT,f)
%%
%*****************基于滤波器子矩阵的采样算法*******************
%输入参数：
%nodes_num：原图节点数
%sample_size：采样集大小
%k0：用于计算参数u=1/(k0-1)
%T_FGFT:近似低通滤波器
%f:该图G上图信号

%输出参数:
%S1:nodes_num维行向量，值为1表示该节点被采样，为0表示未采样
%S2:sample_size维行向量，值表示采样节点索引，未经排序
%fs:采样信号

%%
mu=1/(k0-1);
OG=T_FGFT+mu*eye(nodes_num);

S1=zeros(1,nodes_num);     %采样集索引表，表元素值为1表示采样节点采已采样，否则为未采样
S2=zeros(1,sample_size);    %储存采样节点集的所有索引，以选取顺序排列
[G_ii,I]=max(diag(OG));            %查找OG中最大元素及其索引(优化初始化）
S1(I)=1;
S2(1)=I;
inverse_GS=1/G_ii;
%%

%循环
for j=2:sample_size        %寻找其余采样节点
    count=0;
    for i=1:nodes_num        %每寻找一次采样节点，均需遍历所有未采样节点
        if S1(i)==0
            count=count+1;
            gi=zeros(j-1,1);
            %[tempS,Ispec] = sort(S2);   %对S2进行排序，以便求得向量gk
            for k=1:j-1
                gi(k)=OG(S2(k),i); 
            end
            %temp_S=logical(S1);
            %gi=OG(temp_S,i);
            G_ii=OG(i,i);
            h=G_ii-gi'*inverse_GS*gi;
            temp_inverse_GS_i=[inverse_GS+1/h*inverse_GS*gi*gi'*inverse_GS,-1/h*inverse_GS*gi;
                          -1/h*gi'*inverse_GS,1/h];         %增添一个采样节点后采样集合矩阵的逆
            temp_Tr_inverse_GS_i=trace(temp_inverse_GS_i);           %求矩阵的inverse_GS_i迹
            %该if---end主要用于构造当前节点计算的相关优化值，并设置参数进行保存
            if count==1
                add_i=i;
                Tr_inverse_GS_i=temp_Tr_inverse_GS_i;
                inverse_GS_i=temp_inverse_GS_i;
            end
        end
        if temp_Tr_inverse_GS_i<Tr_inverse_GS_i            %判断该当前节点是否为局部最优（与之前的最优解比较）
            Tr_inverse_GS_i=temp_Tr_inverse_GS_i;
            add_i=i;
            inverse_GS_i=temp_inverse_GS_i;
        end
    end
    %更新参数
    inverse_GS=inverse_GS_i;
    S1(add_i)=1;
    S2(j)=add_i;             %最后的采样集合
end

%%
%构造采样算子
C=zeros(sample_size,nodes_num);
%final_S=sort(S2);
for j=1:sample_size
   %C(j,final_S(j))=1;
   C(j,S2(j))=1;
end
%%
fs=C*f;
end
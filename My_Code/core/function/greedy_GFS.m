
function [S1,S2,C,fs,inverse_GS]=greedy_GFS(nodes_num,sample_size,k0,T_FGFT,f)
%%
%*****************�����˲����Ӿ���Ĳ����㷨*******************
%���������
%nodes_num��ԭͼ�ڵ���
%sample_size����������С
%k0�����ڼ������u=1/(k0-1)
%T_FGFT:���Ƶ�ͨ�˲���
%f:��ͼG��ͼ�ź�

%�������:
%S1:nodes_numά��������ֵΪ1��ʾ�ýڵ㱻������Ϊ0��ʾδ����
%S2:sample_sizeά��������ֵ��ʾ�����ڵ�������δ������
%fs:�����ź�

%%
mu=1/(k0-1);
OG=T_FGFT+mu*eye(nodes_num);

S1=zeros(1,nodes_num);     %��������������Ԫ��ֵΪ1��ʾ�����ڵ���Ѳ���������Ϊδ����
S2=zeros(1,sample_size);    %��������ڵ㼯��������������ѡȡ˳������
[G_ii,I]=max(diag(OG));            %����OG�����Ԫ�ؼ�������(�Ż���ʼ����
S1(I)=1;
S2(1)=I;
inverse_GS=1/G_ii;
%%

%ѭ��
for j=2:sample_size        %Ѱ����������ڵ�
    count=0;
    for i=1:nodes_num        %ÿѰ��һ�β����ڵ㣬�����������δ�����ڵ�
        if S1(i)==0
            count=count+1;
            gi=zeros(j-1,1);
            %[tempS,Ispec] = sort(S2);   %��S2���������Ա��������gk
            for k=1:j-1
                gi(k)=OG(S2(k),i); 
            end
            %temp_S=logical(S1);
            %gi=OG(temp_S,i);
            G_ii=OG(i,i);
            h=G_ii-gi'*inverse_GS*gi;
            temp_inverse_GS_i=[inverse_GS+1/h*inverse_GS*gi*gi'*inverse_GS,-1/h*inverse_GS*gi;
                          -1/h*gi'*inverse_GS,1/h];         %����һ�������ڵ��������Ͼ������
            temp_Tr_inverse_GS_i=trace(temp_inverse_GS_i);           %������inverse_GS_i��
            %��if---end��Ҫ���ڹ��쵱ǰ�ڵ���������Ż�ֵ�������ò������б���
            if count==1
                add_i=i;
                Tr_inverse_GS_i=temp_Tr_inverse_GS_i;
                inverse_GS_i=temp_inverse_GS_i;
            end
        end
        if temp_Tr_inverse_GS_i<Tr_inverse_GS_i            %�жϸõ�ǰ�ڵ��Ƿ�Ϊ�ֲ����ţ���֮ǰ�����Ž�Ƚϣ�
            Tr_inverse_GS_i=temp_Tr_inverse_GS_i;
            add_i=i;
            inverse_GS_i=temp_inverse_GS_i;
        end
    end
    %���²���
    inverse_GS=inverse_GS_i;
    S1(add_i)=1;
    S2(j)=add_i;             %���Ĳ�������
end

%%
%�����������
C=zeros(sample_size,nodes_num);
%final_S=sort(S2);
for j=1:sample_size
   %C(j,final_S(j))=1;
   C(j,S2(j))=1;
end
%%
fs=C*f;
end
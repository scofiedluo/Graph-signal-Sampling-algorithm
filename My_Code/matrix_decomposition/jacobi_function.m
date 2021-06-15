%function [lam,U]=jacobi(A,eps)



%Jacobi���������ʵ�Գƾ��������ֵ������������
%���룺eps���������ޣ�Aʵ�Գƾ��������lam��n������ֵ��U����������Ӧ��������


%2015.11.19 
function [lam,U]=jacobi_function(A,eps)


%��ʼ��
n=size(A);
U=eye(n);
A1=eye(n);
%A1=A;
%�����ǶԽ�Ԫ���а�ģ����ֵ��p��qΪ���±�
p=1;
q=2;
for i=1:n
for j=i+1:n
if abs(A(i,j))>abs(A(p,q))
p=i;
 q=j;
 end
 end
end
%������ʼ
while abs(A(p,q))>=eps
A1=eye(n);
cot2=(A(p,p)-A(q,q))/(2*A(p,q));
 sin2=sqrt(1/(1+cot2*cot2));
 cos2=sqrt(1-sin2*sin2);
 cos1=sqrt((cos2+1)/2);
 sin1=sqrt(1-cos1*cos1);
 %����������,�洢�ھ���U
 R=U;
 for i=1:n
U(i,p)=R(i,p)*cos1+R(i,q)*sin1;
U(i,q)=-R(i,p)*sin1+R(i,q)*cos1;
for j=1:n
if j~=p&&j~=q
 U(i,j)=R(i,j);
end
 end
end
 %��A1
A1(p,p)=A(p,p)*cos1*cos1+A(q,q)*sin1*sin1+A(p,q)*sin2;
A1(q,q)=A(p,p)*sin1*sin1+A(q,q)*cos1*cos1-A(p,q)*sin2;
A1(p,q)=0.5*(A(q,q)-A(p,p))*sin2+A(p,q)*cos2;
A1(q,p)=A1(p,q);
for j=1:n
if j~=p&&j~=q
A1(p,j)=A(p,j)*cos1+A(q,j)*sin1;
A1(q,j)=-A(p,j)*sin1+A(q,j)*cos1;
 A1(j,p)=A1(p,j);%ʵ�Գƾ���
 A1(j,q)=A1(q,j);
end
end
 for i=1:n
 for j=1:n
if i~=p&&i~=q&&j~=p&&j~=q
A1(i,j)=A(i,j);
A1(j,i)=A1(i,j);
 end
end
end
A=A1;
lam=diag(A1)';
%�����A�ǶԽ�Ԫ���а�ģ���ֵ���±�p��q
p=1;
 q=2;
 for i=1:n
 for j=i+1:n
 if abs(A(i,j))>abs(A(p,q))
 p=i;
 q=j;
 end
 end
 end
end

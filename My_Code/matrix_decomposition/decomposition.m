clc
L=[0,0,0,0,1;1,0,0,0,0;0,1,0,0,0;0,0,1,0,0;0,0,0,1,0];
%U=eye(5);
%lamda=zeros(5,1);
%eps=0.00001;
%[lamda,U]=jacobi_function(L,eps)
[V,lamda]=eig(L)
cangle=zeros(5,1);
for i=1:5
    cangle(i)=angle(lamda(i,i))*180/pi;
end

cangle
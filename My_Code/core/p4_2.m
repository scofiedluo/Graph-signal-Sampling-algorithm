%***************************************************
%FGFT������eig����ֵ�ֽ�Ƚ�
%**************************************************
%%
figure
plot(G1.e,'-k','LineWidth',2);
hold on
plot(G1_spec_hat,'-.r','LineWidth',2);
l1=legend('matlab���������ֽ⺯��','���еĽضϵ��ſ˱ȣ�Jacobi������ֵ�ֽ�');
set(l1,'FontSize',14)
xlabel('G1����ֵ���')
ylabel('����ֵ��С')
set(gca,'FontSize',15)
%%
figure
plot(G2.e,'-k','LineWidth',2);
hold on
plot(G2_spec_hat,'-.r','LineWidth',2);
l2=legend('matlab���������ֽ⺯��','���еĽضϵ��ſ˱ȣ�Jacobi������ֵ�ֽ�');
set(l2,'FontSize',14)
xlabel('G2����ֵ���')
ylabel('����ֵ��С')
set(gca,'FontSize',15)
%%
figure
plot(G3.e,'-k','LineWidth',2);
hold on
plot(G3_spec_hat,'-.r','LineWidth',2);
l3=legend('matlab���������ֽ⺯��','���еĽضϵ��ſ˱ȣ�Jacobi������ֵ�ֽ�');
set(l3,'FontSize',14)
xlabel('G3����ֵ���')
ylabel('����ֵ��С')
set(gca,'FontSize',15)
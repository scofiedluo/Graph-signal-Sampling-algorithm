%***************************************************
%FGFT与内置eig特征值分解比较
%**************************************************
%%
figure
plot(G1.e,'-k','LineWidth',2);
hold on
plot(G1_spec_hat,'-.r','LineWidth',2);
l1=legend('matlab内置特征分解函数','并行的截断的雅克比（Jacobi）特征值分解');
set(l1,'FontSize',14)
xlabel('G1特征值序号')
ylabel('特征值大小')
set(gca,'FontSize',15)
%%
figure
plot(G2.e,'-k','LineWidth',2);
hold on
plot(G2_spec_hat,'-.r','LineWidth',2);
l2=legend('matlab内置特征分解函数','并行的截断的雅克比（Jacobi）特征值分解');
set(l2,'FontSize',14)
xlabel('G2特征值序号')
ylabel('特征值大小')
set(gca,'FontSize',15)
%%
figure
plot(G3.e,'-k','LineWidth',2);
hold on
plot(G3_spec_hat,'-.r','LineWidth',2);
l3=legend('matlab内置特征分解函数','并行的截断的雅克比（Jacobi）特征值分解');
set(l3,'FontSize',14)
xlabel('G3特征值序号')
ylabel('特征值大小')
set(gca,'FontSize',15)
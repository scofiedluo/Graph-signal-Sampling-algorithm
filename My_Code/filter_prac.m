G = gsp_logo();



N=1130;
f = sin((1:N)'*2*pi*4/N);
h0 = 0.9606;
h1 = -0.7453;
h2 = 0.1936;
h3 = -0.0162;
xf= (h0*eye(N)+h1*G.L+h2*G.L^2+h3*G.L^3)*f;


       
         GB = gsp_compute_fourier_basis(G);

         fhat = gsp_gft(GB,f);
         f_freq_lp =fhat;
         f_freq_lp(300:N)=0;
         f_lp=GB.U*f_freq_lp;
         paramplot.show_edges = 1;
         gsp_plot_graph(G,paramplot);
         figure(2)
         gsp_plot_signal(G,f);
         figure(3)
         gsp_plot_signal(G,xf);
         figure(4)
         gsp_plot_signal(G,fhat);
         figure(5)
         gsp_plot_signal(G,f_lp);



%          G = gsp_minnesota();
% N=2642;
% f = sin((1:N)'*2*pi*4/N);
% h0 = 0.9606;
% h1 = -0.7453;
% h2 = 0.1936;
% h3 = -0.0162;
% xf= (h0*eye(N)+h1*G.L+h2*G.L^2+h3*G.L^3)*f;
% 

%        
%          GB = gsp_compute_fourier_basis(G);
% 
%          fhat = gsp_gft(GB,f);
%          f_freq_lp =fhat;
%          f_freq_lp(20:N)=0;
%          f_lp=GB.U*f_freq_lp;
%          paramplot.show_edges = 1;
%          gsp_plot_graph(G,paramplot);
%          figure(2)
%          gsp_plot_signal(G,f);
%          figure(3)
%          gsp_plot_signal(G,xf);
%          figure(4)
%          gsp_plot_signal(G,fhat);
%          figure(5)
%          gsp_plot_signal(G,f_lp);


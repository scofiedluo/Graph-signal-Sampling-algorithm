
%sensor network
N = 32;
       G = gsp_sensor(32);
       GB = gsp_compute_fourier_basis(G);
       f = sin((1:N)'*2*pi*4/N);
       fhat = gsp_gft(GB,f);
       gsp_plot_signal_spectral(GB,fhat);
       figure (2)
       gsp_plot_graph(G);
       figure(3)
       gsp_plot_signal(G,f);
      
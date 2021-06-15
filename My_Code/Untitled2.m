
%swiss roll
N = 64;
       G = gsp_swiss_roll(64);
       GB = gsp_compute_fourier_basis(G);
       f = sin((1:N)'*2*pi*4/N);
       fhat = gsp_gft(GB,f);
       gsp_plot_signal_spectral(GB,fhat);
       figure (2)
       gsp_plot_graph(G);
       figure(3)
       gsp_plot_signal(G,f);
       
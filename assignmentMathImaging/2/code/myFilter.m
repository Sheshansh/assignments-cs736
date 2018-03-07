function [ram_lak,shepp_logan, cosine] = myFilter(image, fraction)
fourier_trans = fftshift(fft(image),1);
N = size(fourier_trans,1);
w = (0:N-1)';
w = w*2*pi/N;
w = w - w(round(N/2));
L = pi*fraction; 
% Ram Lak filter
ram_lak_filter = abs(w);
ram_lak_filter(abs(w) > L) = 0 ;
ram_lak_filter = repmat(ram_lak_filter,1,size(image,2));

% Shepp Logan filter
shepp_logan_filter = abs(w).*sin(0.5*pi*w/L)./(0.5*pi*w/L);
shepp_logan_filter(w == 0) = 0;
shepp_logan_filter(abs(w)> L) = 0;
shepp_logan_filter = repmat(shepp_logan_filter,1,size(image,2));

% Cosine filter
cosine_filter = abs(w).*cos(0.5*pi*w/L);
cosine_filter(abs(w)> L) = 0; 
cosine_filter = repmat(cosine_filter,1,size(image,2));

ram_lak = fourier_trans.*ram_lak_filter;
shepp_logan = fourier_trans.*shepp_logan_filter;
cosine = fourier_trans.*cosine_filter;

ram_lak = real(ifft(ifftshift(ram_lak,1)));
shepp_logan = real(ifft(ifftshift(shepp_logan,1)));
cosine = real(ifft(ifftshift(cosine,1)));
end
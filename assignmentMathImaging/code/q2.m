image = phantom(256);
rt = radon(image,0:3:177);
frt = fftshift(fft(rt),1);

%% Ram Lak Filter

ifft(frt);

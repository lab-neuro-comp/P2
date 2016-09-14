function [spec] = fft_spectrum(seq, s)
c = fft (seq, s) ; re = real (c) ; im = imag(c) ;
amp = sqrt (re.^2+im.^2) ; spec = amp (1 : s/2) ;
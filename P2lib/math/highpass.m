% --- filters the signal using a filter. is based on the fourier transform
function [signal] = highpass(signal, fs, minfreq)
% High pass filters a signal using the Fourier transform
spectre = fft(signal);
tamint = length(signal) / fs;
minpoint = round(minfreq*tamint/fs);
minpoint2 = length(spectre) - minpoint;
spectre(1:minpoint) = 0;
spectre(minpoint2:length(spectre)) = 0;
signal = real(ifft(spectre));

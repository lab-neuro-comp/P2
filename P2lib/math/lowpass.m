% --- filters the signal using a filter. is based on the fourier transform
function [signal] = lowpass(signal, fs, maxfreq)
% Low pass filters a signal using the Fourier transform
spectre = fft(signal);
tamint = length(signal) / fs;
maxpoint = round(maxfreq*tamint/fs);
maxpoint2 = length(spectre) - maxpoint;
spectre(maxpoint:maxpoint2) = 0;
signal = real(ifft(spectre));

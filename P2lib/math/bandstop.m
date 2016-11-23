% --- filters the signal using a filter. is based on the fourier transform
function [signal] = bandstop(signal, fs, minfreq, maxfreq)
% Applies a band pass filter to a signal using the Fourier transform

spectre = fft(signal);
tamint = length(signal) / fs;
maxpoint = round(maxfreq*tamint/fs);
maxpoint2 = length(spectre) - maxpoint;
minpoint = round(minfreq*tamint/fs);
minpoint2 = length(spectre) - minpoint;

spectre(minpoint:maxpoint) = 0;
spectre(maxpoint2:minpoint2) = 0;

signal = real(ifft(spectre));

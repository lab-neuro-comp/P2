% --- filters the signal using a filter. is based on the fourier transform
function [signal] = filter_signal(signal, minfreq, maxfreq, kind)
global fs;

spectre = fft(signal);
tamint = length(signal) / fs;
maxpoint = round(maxfreq*tamint/fs);
maxpoint2 = length(spectre) - maxpoint;
minpoint = round(minfreq*tamint/fs);
minpoint2 = length(spectre) - minpoint;

switch kind
case 'lowpass'
	spectre(maxpoint:maxpoint2) = 0;
case 'highpass'
	spectre(1:minpoint) = 0;
	spectre(minpoint2:length(spectre)) = 0;
case 'bandpass'
	spectre(1:minpoint) = 0;
	spectre(minpoint2:length(spectre)) = 0;
	spectre(maxpoint:maxpoint2) = 0;
case 'bandstop'
	spectre(minpoint:maxpoint) = 0;
	spectre(maxpoint2:minpoint2) = 0;
end

signal = real(ifft(spectre));

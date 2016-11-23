function [outlet] = wfft(inlet)
% Calculates the windowed fourier transform of the inlet
window = hamming(length(inlet)).';
outlet = fft(inlet .* window);
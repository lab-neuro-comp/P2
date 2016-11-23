function [power] = calculate_power(spectrum, f1, f2, fs)
% Calculates the power of the given spectrum
f1p = round(f1*length(spectrum)/fs);
f2p = round(f2*length(spectrum)/fs);
power = 0;

if f1p <= 0
    f1p = 1
end

for n = f1p:f2p
    power = power + spectrum(n).^2;
end

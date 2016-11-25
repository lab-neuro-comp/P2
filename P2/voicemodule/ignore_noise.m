function [corrected] = ignore_noise(signal, threshold)
% Noise Gate: this function will recieve the analysed power
% and it'll ignore everything that is below the threshold

corrected = zeros(1, length(signal));
n = 1;

if length(signal) == 0
	corrected = 0;
else
	while length(signal) > 0
		if signal(1) >= threshold
			corrected(n) = 1;
		end
		n = n + 1;
		signal = signal(2:length(signal));
	end
end
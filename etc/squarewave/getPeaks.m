function [peak] = getPeaks(time, inlet)
% Gets where are the edge triggers in an `inlet signal`.
%
bert = -imag(hilbert(inlet));
[downbert upbert] = moses(bert, 1);

figure;
hold on;
plot(time, downbert, 'g');
plot(time, upbert, 'm');
hold off;

peak = [ ];
note = false;
for it = (upbert-1);
	if and(~note, it > 0)
		peak(end+1) = 1;
	else
		peak(end+1) = 0;
	end
	note = it > 0;
end

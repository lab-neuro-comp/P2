function [analysis] = calculate_power(record, windowsize)

[record, queue] = update_queue(record, windowsize);
n = 1;
power = 0;

tic;
while length(queue) > 0
	% TODO Analyse window

	analysis(n) = calc_power(queue);
	n = n + 1;
	[record, queue] = update_queue(record, windowsize);
end
toc;

function [power] = calc_power(spectrum)

power = sqrt(sum(spectrum.^2));
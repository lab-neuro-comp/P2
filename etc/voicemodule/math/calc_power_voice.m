function [analysis] = calc_power_voice(record, windowsize)

[record, queue] = update_queue(record, windowsize);
n = 1;
power = 0;
fullbar = ceil(length(record)/length(queue));

h = waitbar(0,'Analise em andamento...');
tic;
while length(queue) > 0
	% TODO Analyse window

	analysis(n) = calc_power(queue);
	n = n + 1;
	[record, queue] = update_queue(record, windowsize);
	waitbar(n/fullbar);
end
toc;
delete(h);

function [power] = calc_power(spectrum)

power = sqrt(sum(spectrum.^2));
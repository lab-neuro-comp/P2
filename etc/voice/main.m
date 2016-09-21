function [analysis] = main()
% Callback to run button
% TODO Queue updating

% Loading voice signal
filename = 'data/voicerecognition.wav';
[record, fs, nbits] = wavread(filename);
analysis = [];
n = 1;

[b, a] = butter(2, [80, 260]/(fs/2));
record = filter(b, a, record);

figure;
plot(record);

windowsize = 128;
analysis = [];
[record, queue] = update_queue(record, windowsize);
n = 1;
power = 0;

while length(queue) > 0
	% TODO Analyse window

	[analysis(n), sranalysis(n)] = calc_power(queue);
	n = n + 1;
	[record, queue] = update_queue(record, windowsize);

end

figure;
plot(analysis);
figure;
plot(sranalysis);

function [power, srpower] = calc_power(spectrum)

power = sum(spectrum.^2);
srpower = sqrt(power);
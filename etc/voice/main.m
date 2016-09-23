function [analysis] = main()
% Callback to run button
% TODO Improve `isvoice` and/or `ignore_voice` functions

% Loading voice signal
filename = 'data/voicerecognition.wav';
[record, fs, nbits] = wavread(filename);
analysis = [];
n = 1;

[b, a] = butter(4, [80, 260]/(fs/2));
record = filter(b, a, record);

figure;
step = 0:(1/fs):(length(record)/fs);
plot(step(2:length(step)), record);

windowsize = 128;
analysis = [];
[record, queue] = update_queue(record, windowsize);
n = 1;
power = 0;

while length(queue) > 0
	% TODO Analyse window

	analysis(n) = calc_power(queue);
	n = n + 1;
	[record, queue] = update_queue(record, windowsize);

end

figure;
hold on;
plot(analysis, 'b');

% TODO Find a good mathematical way to get a good threshold
ignorenoise = [];
threshold = mean(analysis);
ignorenoise = ignore_noise(analysis, threshold);
% disp(threshold);
% plot(ignorenoise, 'g');

% Applying voice logic
analysis = isvoice(ignorenoise, threshold);
plot(analysis, 'r');
hold off;

function [power] = calc_power(spectrum)

power = sqrt(sum(spectrum.^2));
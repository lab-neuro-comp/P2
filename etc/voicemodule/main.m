function [lastanalysis] = main(filename)
% Callback to run button
% TODO Improve `isvoice` and/or `ignore_voice` functions

% Loading voice signal
[record, fs, nbits] = wavread(filename);
analysis = [];
n = 1;
windowsize = 1024;

[b, a] = butter(4, [80, 260]/(fs/2));
record = filter(b, a, record);

analysis = calculate_power(record, windowsize);

% TODO Find a good mathematical way to get a good threshold
ignorenoise = [];
threshold = mean(analysis);
ignorenoise = ignore_noise(analysis, threshold);

% Applying voice logic
analysis = isvoice(ignorenoise, threshold);

lastanalysis = mean_window(length(analysis), ignorenoise, analysis);

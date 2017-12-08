function [lastanalysis] = main(filename)
% Callback to run button

% Loading voice signal
[record, fs] = audioread(filename);
analysis = [];
n = 1;
windowsize = 1024;

% Creates a passband filter for the human voice frequency range
[b, a] = butter(4, [80, 260]/(fs/2));
record = filter(b, a, record);
%%filenameTemp = strrep(filename, '.wav', '_tmp.wav');
%%wavwrite(record, fs, filenameTemp);

analysis = calc_power_voice(record, windowsize);

% TODO Find a good mathematical way to get a good threshold
ignorenoise = [];
threshold = mean(analysis);
ignorenoise = ignore_noise(analysis, threshold);

% Applying voice logic
analysis = isvoice(ignorenoise, threshold);

lastanalysis = mean_window(length(analysis), ignorenoise, analysis);

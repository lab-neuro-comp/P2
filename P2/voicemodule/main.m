function [voiceTimes] = main(filename)
% Callback to run button

% Loading voice signal
[record, fs] = audioread(filename);
windowsize = 1024;

% Creates a passband filter for the human voice frequency range
[b, a] = butter(4, [80, 260]/(fs/2), 'bandpass');
record = filter(b, a, record);

analysis = calc_power_voice(record, windowsize);

%hold on;
%stem(step(2:windowsize:length(step)), analysis, 'b');

% TODO Find a good mathematical way to get a good threshold
ignorenoise = [];
threshold = mean(analysis);
ignorenoise = ignore_noise(analysis, threshold);

% Applying voice logic
analysis = isvoice(ignorenoise, threshold);
lastanalysis = mean_window(length(analysis), ignorenoise, analysis);

voiceTimes = turn_to_time(lastanalysis, length(record)/fs);

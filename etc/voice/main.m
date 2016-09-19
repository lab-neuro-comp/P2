function [analysis] = main()
% Callback to run button
% TODO Queue updating

% Loading voice signal
filename = 'data/actualcase.wav';
[record, fs, nbits] = wavread(filename);
figure;
plot(1:length(record), record);

analysis = [];
n = 1;

[b, a] = butter(2, [80, 260]/(fs/2));
analysis = filter(b, a, record);

figure;
plot(analysis);
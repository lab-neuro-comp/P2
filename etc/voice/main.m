function [windows] = main()
% Callback to run button

% Loading voice signal
filename = 'data/voicerecognition.wav';
[record, fs, nbits] = wavread(filename);
clc;
figure;
plot(1:length(record), record);

%Just trying to see what happens with the old approach
windowsize = 128;
[record, queue] = update_queue(record, windowsize);
windows = [];
n = 1;

while length(queue) > 0
	% TODO Analyse window
	windows(:, n) = wfft(queue); % WARNING might destroy memory
	n = n+1; % hehehe
	[record, queue] = update_queue(record, windowsize);
end

figure;
surf(real(windows));
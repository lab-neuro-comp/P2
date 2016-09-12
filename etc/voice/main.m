function main()

filename = 'data/voicerecognition.wav';
[record, fs, nbits] = wavread(filename);
clc;
plot(1:length(record), record);

%Just trying to see what happens with the old approach
windowsize = 128;
[record, queue] = update_queue(record, [], windowsize);

while length(queue) > 0
	% TODO Analyse window
	[record, queue] = update_queue(record, queue, windowsize);
end

plot(1:length(queue), queue);

function [record, queue] = update_queue(record, queue, windowsize)

n = 1;
queue = [];

while and((n <= windowsize), (length(record) > 0))
	queue(n) = record(1);
	n = n + 1;
	record = record(2:length(record));
end

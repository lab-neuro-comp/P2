function main()

filename = 'data/voicerecognition.wav';
[record, fs, nbits] = wavread(filename);
plot(1:length(record), record);

%Just trying to see what happens with the old approach
windowsize = 128;
[record, queue] = update_queue(record, [], windowsize);
clc;
plot(1:length(queue), queue);

function [record, queue] = update_queue(record, queue, windowsize)

n = 1;
queue = [];

while and((n <= windowsize), (length(record) > 0))
	queue(n) = record(1);
	n = n + 1;
	record = record(2:length(record));
end

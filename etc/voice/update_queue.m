function [record, queue] = update_queue(record, windowsize)
% Updates the record and queue
% TODO Make this fuction a better thing to work with
% Probably not using the loop in line 12

n = 1;
queue = zeros(1, windowsize);

if length(record) == 0
	queue = [];
else
	if length(record) >= 128
		queue = record(1:128);
		record = record(129:length(record));
	elseif length(record) < 128
		queue = record(1:length(record));
		record = record(129:length(record));
	end		
end
function [record, queue] = update_queue(record, windowsize)
% Updates the record and queue

n = 1;
queue = zeros(1, windowsize);

if length(record) == 0
	queue = [];
else
	if length(record) >= windowsize
		queue = record(1:windowsize);
		record = record((windowsize+1):length(record));
	elseif length(record) < windowsize
		queue = record(1:length(record));
		record = record((windowsize+1):length(record));
	end		
end

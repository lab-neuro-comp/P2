function [record, queue] = update_queue(record, windowsize)
% Updates the record and queue
% TODO Make this fuction a better thing to work with
% Probably not using the loop in line 12

n = 1;
queue = zeros(1, windowsize);

if length(record) == 0
	queue = [];
else
	while and((n <= windowsize), (length(record) > 0))
		queue(n) = record(1);
		n = n + 1;
		record = record(2:length(record));
	end
end
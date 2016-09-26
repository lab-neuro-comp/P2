function [timevector] = mean_window(limit, signal, timevector)
% Trying to work out a way to eliminate the ok's 
% that happen at the end of the word

queue = [];
disp(limit);

for n = 1:limit
	[signal, queue] = update_queue(signal, 5);
	meanvalue = sum(queue);
	if and((meanvalue < 4), (length(queue) == 5))
		disp(timevector(n*5:(n*5)+4));
		disp(zeros(1, 5));
		timevector(n*5:(n*5)+4) = zeros(1, 5);
	end
end
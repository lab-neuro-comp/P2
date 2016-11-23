function [timevector] = mean_window(limit, signal, timevector)
% Trying to work out a way to eliminate the ok's 
% that happen at the end of the word

queue = [];

for n = 1:limit
	if timevector(n) == true
		queue = signal(n:n+4);
		meanvalue = sum(queue);
		if and((meanvalue < 3), (length(queue) == 5))
			timevector(n) = 0;
		end
	end
end
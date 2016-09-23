function [timevector] = mean_window(signal, timevector)
% Trying to work out a way to eliminate the ok's 
% that happen at the end of the word

limit = length(signal)
window = [];
queue = [];
windowsize = 5;

for n = 1:limit
	if timevector(n) == 1
		[timevector, queue] = update_queue(timevector, windowsize);
		disp(queue);
		meanvalue = mean(queue)
		if meanvalue < 0.8
			timevector(n) = 0;
		end
	end
%	disp(n);
end
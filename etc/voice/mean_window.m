function [timevector] = mean_window(limit, signal, timevector)
% Trying to work out a way to eliminate the ok's 
% that happen at the end of the word

%limit = length(signal)
disp('Is it you?')
disp(length(signal));
queue = [];
windowsize = 5;

for n = 1:2084
	if timevector(n) == true
		disp(n);
		[signal, queue] = update_queue(signal, windowsize);
		disp(queue)
		meanvalue = sum(queue)
		if meanvalue < 4
			timevector(n) = 0;
		end
	end
%	disp(n);
end
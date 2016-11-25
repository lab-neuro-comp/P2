function [timevector] = mean_window(limit, signal, timevector)
% Corrects the signal to minimize the problems that happen at the
% end of a word when the voice amplitude varies to much creating
% the impression of false ends and false starts

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
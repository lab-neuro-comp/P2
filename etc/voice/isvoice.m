function [boolean] = isvoice(signal)
% Checks where the voice begins
previous = false;
limit = length(signal);
boolean = zeros(1, limit);
threshold = 0;

for n = 1:limit
	if signal(n) > threshold % there is signal
		boolean(n) = not(previous);
		previous = true;
	else
		previous = false;
	end
end
function [boolean] = isvoice(signal, threshold)
% Checks where the voice begins

previous = false;
limit = length(signal);
boolean = zeros(1, limit);

for n = 2:limit-1 
	% This will not analyse the very beginning and the very end
	% of the signal, but it'll solve the issue of taking a sample
	% outside of the range of the signal

	if signal(n) > 0
		boolean(n) = not(previous);
		previous = true;
	else
		before = signal(n-1);
		after = signal(n+1);

		% In case the speech varies too much in amplitude going
		% below the threshold and thus creating the false impression of
		% a false end or a false start, as analysis of the signal
		% immediatly before and after the current one is made.
		% Solves only a pontual problem, thus if the imperfection lasts
		% for too long, it won't be caught.
		if or((before > threshold), (after > threshold))
			boolean(n) = not(previous);
			previous = true;
		else
			previous = false;
		end
	end
end
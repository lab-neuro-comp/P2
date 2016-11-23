function [boolean] = isvoice(signal, threshold)
% Checks where the voice begins

previous = false;
limit = length(signal);
boolean = zeros(1, limit);
%threshold = 0;

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

		if or((before > threshold), (after > threshold))
			% this solve only a pontual problem
			% if the zero inside the word persist for too long, this is useless
			boolean(n) = not(previous);
			previous = true;
		else
			previous = false;
		end
	end
end
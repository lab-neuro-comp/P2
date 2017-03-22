function [outlet] = replace_in_string(inlet, from, to)
% Replaces the `from` character to the `to` char in the `inlet` string.
outlet = '';
for n = 1:length(inlet)
	if inlet(n) == from
		outlet(n) = to;
	else
		outlet(n) = inlet(n);
	end
end

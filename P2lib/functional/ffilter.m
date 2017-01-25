function [outlet] = ffilter(op, inlet)
% Provides a functional filtering operation for cell arrays.
outlet = { };
for n = 1:length(inlet)
	if op(inlet{n})
		outlet{end+1} = inlet{n};
	end
end

function [outlet] = fmap(op, inlet)
% Provides a functional mapping operation for cell arrays.
outlet = { };
for n = 1:length(inlet)
	outlet{n} = op(inlet{n});
end

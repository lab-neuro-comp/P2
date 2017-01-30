function [outlet] = freduce(op, outlet, inlet)
% Provides a functional reducing operation
for n = 1:length(inlet)
	outlet = op(outlet, inlet{n});
end

function [outlet] = fpipe(inlet, ops)
% Provides a functional pipe. `inlet` is the first variable; and `ops` is a cell array of SISO functions.
outlet = inlet;
for n = 1:length(ops)
	op = ops{n};
	outlet = op(outlet);
end

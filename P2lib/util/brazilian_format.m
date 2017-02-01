function [outlet] = brazilian_format(inlet)
% Number to string with brazilian number format.
%
outlet = num2str(inlet);
for n = 1:length(outlet)
	if isequal(outlet(n), '.')
		outlet(n) = ',';
	end
end

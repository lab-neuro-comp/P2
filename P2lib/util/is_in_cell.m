function [result] = is_in_cell(stuff, thing)
% Checks if a string is in a cell array of strings
%
result = false;
limit = length(stuff);
for n = 1:limit
	if isequal(stuff{n}, thing)
		result = true;
	end
end

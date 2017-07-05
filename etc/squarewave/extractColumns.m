function [relevantColumns] = extractColumns(rawCsv, whichColumns)
% Extracts the relevant columns from the *.edat2 file. Returns a
% java.util.HashMap relating the column name to an array of valid items.
%

% Compressing table to be better read
temp = { };
lineNo = 0;
m = 1;
while length(rawCsv{m}) > 0
	if length(rawCsv{m}) > 1
		lineNo = lineNo+1;
		n = 1;
		flag = true;
		while flag
			try
				temp{lineNo, n} = rawCsv{m, n};
				n = n+1;
			catch
				flag = false;
			end
		end
	end
	m = m+1;
end

% Compressing strings to be better processed
howManyLines = lineNo - 1;
howManyColumns = n - 1;
for y = 1:howManyLines
	for x = 1:howManyColumns
		temp{y, x} = masterTrim(temp{y, x});
	end
end

% Taking only the relevant columns
indexes = java.util.HashMap;
relevantColumns = java.util.HashMap;
for n = 1:howManyColumns
	if is_in_cell(whichColumns, temp{2, n})
		put(indexes, temp{2, n}, n);
	end
end
indexes

% -----------------------------------------------------------------------------
function [outlet] = masterTrim(inlet)
% Removing every null char in the `inlet` string.
%
if ischar(inlet)
	outlet = '';
	for n = 1:length(inlet)
		if inlet(n) > 0
			outlet(end+1) = inlet(n);
		end
	end
else
	outlet = inlet;
end

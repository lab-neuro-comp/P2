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
howMabyColumns = n - 1;
relevantColumns = temp;

% Taking only the relevant columns

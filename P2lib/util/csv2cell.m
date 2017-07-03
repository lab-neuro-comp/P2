function [outlet] = csv2cell(filename)
% Converts a CSV file to a cell matrix.
%
outlet = { };
fp = fopen(filename, 'r');
lineNo = 0;
line = fgetl(fp);
while ischar(line)
	lineNo = lineNo + 1;
	stuff = split_string(line, '\t');
	limit = length(stuff);
	for columnNo = 1:limit
		outlet{lineNo, columnNo} = stuff{columnNo};
	end
	line = fgetl(fp);
end
fclose(fp);

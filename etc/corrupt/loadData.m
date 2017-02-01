% Loads data from a matrix file
function [what] = loadData(where)
fp = fopen(where, 'r');
what = [ ];
n = 1;
line = fgetl(fp);
while ischar(line)
	what(n) = str2num(line);
	n = n + 1;
	line = fgetl(fp);
end
fclose(fp);

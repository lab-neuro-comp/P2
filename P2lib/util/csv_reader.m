%% csv_reader: Reads a CSV file to an cell array of strings
function [table] = csv_reader(filename)
% filename  the path to the file to read
fp = fopen(filename);
table = {};

row = fgetl(fp);
while ischar(row)
	table = push_cell(table, split_string(row, ','));
	row = fgetl(fp);
end

fclose(fp);


% # About
% 
% This script translates every file in a database
% 'EEG.csv' using the 'csv2ascii' function
%
% ## Algorithm
% 
%     for each row on csv
%       GET FILE NAME fn
%       GET INTERVALS b, e
%       csv to ascii(fn, b, e)
%     end
%
% # Side notes
%
% + The original *.xls file has 289 lines, and 
%   the first one is a header. 
%

input_file = 'EEG.csv';
fp = fopen(input_file, 'r');
row = fgetl(fp); % reading header
row = fgetl(fp); % first row
while ischar(row)
	[fn, b, e] = parse_row(row);
	ff = strcat(fullfile(cd, fn), '.csv');
	if exist(ff, 'file') == 2
		csv2ascii(fn, b, e);
	end
	row = fgetl(fp);
end
fclose(fp);
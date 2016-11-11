%function [timeArray] = analyse_for_stimulus(filename)
function [stimulus_time] = analyse_for_stimulus(filename)

fileID = fopen(filename, 'r');
content = textscan(fileID, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s');
fclose(fileID);
k = 1;
timeArray = content{4};

[R, C] = size(timeArray);

for n = 1:R
	timeArray{n,1} = split_string(timeArray{n,1}, ':')
end


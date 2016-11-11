%function [timeArray] = analyse_for_stimulus(filename)
function [stimulus_time] = analyse_for_stimulus(filename)

fileID = fopen(filename, 'r');
content = textscan(fileID, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s');
fclose(fileID);
k = 1;
timeArray = content{4};

[R, C] = size(timeArray);

for n = 1:R
	timeArray{n,1} = split_string(timeArray{n,1}, ':');
end

% TODO Turn to second
timeArray{1}{6} = 0;
for n = 1:R
	timeArray{n}{5} = (str2num(timeArray{n}{1})*3600 +...
					   str2num(timeArray{n}{2})*60 +...
					   str2num(timeArray{n}{3}) +...
					   str2num(timeArray{n}{4})/1000);

	% Calculates the gap of time from one time to the other
	if (n > 1)
		timeArray{n}{6} = (timeArray{n}{5} - timeArray{n-1}{5}) + timeArray{n-1}{6};
		disp(timeArray{n}{6});
	end
end

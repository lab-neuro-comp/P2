function [stimulusTime] = analyse_for_stimulus(filename)
% Analyses the file generated during a test with Stroop
% and gets the time were the stimuli were produced turning them
% into a timeline in seconds

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
stimulusTime(1) = 0;
for n = 1:R
	timeArray{n}{5} = (str2num(timeArray{n}{1})*3600 +...	% Hours
					   str2num(timeArray{n}{2})*60 +...		% Minutes
					   str2num(timeArray{n}{3}) +...		% Seconds
					   str2num(timeArray{n}{4})/1000);		% Miliseconds

	% Calculates the gap of time between stimuli
	% and creates a timeline
	if (n > 1)
		stimulusTime(n) = (timeArray{n}{5} - timeArray{n-1}{5}) + stimulusTime(n-1);
	end
end

fileID = fopen('data/audio_AnaPaulaRiveiro_Edward2_19.csv');
timecontent = textscan(fileID, '%s');
fclose(fileID);

[R, C] = size(timecontent{1})

for n = 1:R
	timecontent{1}{n} = split_string(timecontent{1}{n}, ';');
	disp(timecontent{1}{n}{2});
%	if n > 1
%		audioTime(n) = timecontent{1}{2,2};
%	end
end

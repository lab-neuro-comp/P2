function [responseTime] = analyse_for_stimulus(audioName, testName)
% Analyses the file generated during a test with Stroop and gets
% the time were the stimuli were produced turning them into a
% timeline in seconds

fileID = fopen(testName, 'r');
content = textscan(fileID, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s');
fclose(fileID);
k = 1;
%timeArray = content{4};
%firstTime = content{4};
timeArray = content{5};

[R, C] = size(timeArray);

% The times that are stored in testName.txt record the exact time of the day
% the stimuli where presented to the user. This time is turned into a time 
% in seconds and, comparing its value with the that is presented as the
% beginning of the test, the timeline of the test can be created for later
% comparison with the audio timeline.
audioName = strrep(audioName, '.wav', '.csv');
initialTime = find_beginning(audioName);

for n = 1:R
	if ~isempty(timeArray{n})
%		timeArray{n,1} = split_string(timeArray{n,1}, ':');
%		timeArray{n}{5} = (str2num(timeArray{n}{1})*3600 +...	% Hours
%						   str2num(timeArray{n}{2})*60 + 120*n +...	% Minutes
%						   str2num(timeArray{n}{3}) +...		% Seconds
%						   str2num(timeArray{n}{4})/1000);		% Miliseconds
		
		% Calculates the gap of time between stimuli
		% and creates a timeline
%		if (n > 1)
%			stimulusTime(n) = (timeArray{n}{5} - timeArray{n-1}{5}) + stimulusTime(n-1);
%		elseif (n == 1)
%			stimulusTime(1) = timeArray{n}{5} - initialTime;
%		end

		stimulusTime(n) = str2num(timeArray{n})/1000;

%		if (n > 1)
%			stimulusTime(n) = str2num(timeArray{n})/timeFactor;
%		elseif (n == 1)
%			firstTime{n,1} = split_string(firstTime{n,1}, ':');
%			firstTime{n}{5} = (str2num(firstTime{n}{1})*3600 +...	% Hours
%							   str2num(firstTime{n}{2})*60 +...		% Minutes
%							   str2num(firstTime{n}{3}) +...		% Seconds
%							   str2num(firstTime{n}{4})/1000);		% Miliseconds
%			stimulusTime(n) = firstTime{n}{5} - initialTime + 2;
%			timeFactor = str2num(timeArray{n})/stimulusTime(n);
%		end
	end
end
figure;
plot(0);
hold on;
plot(stimulusTime, 0, 'ob');

% Gets the timeline from the .csv file generated from the audio analysis
fileID = fopen(audioName);
timecontent = textscan(fileID, '%s');
fclose(fileID);

[R, C] = size(timecontent{1});

for n = 2:R
	timecontent{1}{n} = split_string(timecontent{1}{n}, ';');
	temp = timecontent{1}{n}{2};
	temp = split_string(temp, ',');
	audioTime(n-1) = str2num(char(strcat(temp(1), '.', temp(2))));
end
plot(audioTime, 0, 'or');

% Time that takes for one to respond to a stimulus
k = 1;
for n = 2:length(stimulusTime)
	if k <= length(audioTime)
		if stimulusTime(n) >= audioTime(k)
			responseTime(n-1) = audioTime(k) - stimulusTime(n-1);
			k = k + 1;
%			if n == length(stimulusTime)
%				responseTime(n) = audioTime(k) - stimulusTime(n);
%			end
		else
			while (stimulusTime(n) < audioTime(k) && n < length(stimulusTime))
				responseTime(n-1) = 0;
				n = n + 1;
			end
		end
	else 
		responseTime(n) = 0;
		disp('Extra');
	end
end
		

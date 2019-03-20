function [responseTime] = analyse_for_stimulus(audioName, testName, hAxes)
% Analyses the file generated during a test with Stroop and gets
% the time were the stimuli were produced turning them into a
% timeline in seconds

fileID = fopen(testName, 'r');
content = textscan(fileID, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s');
fclose(fileID);
k = 1;
timeArray = content{6};

[R, C] = size(timeArray);

% The times that are stored in testName.txt record the exact time of the day
% the stimuli where presented to the user. This time is turned into a time 
% in seconds and, comparing its value with the that is presented as the
% beginning of the test, the timeline of the test can be created for later
% comparison with the audio timeline.
% On the other hand, this file also stores the information about how long
% after the test began the stumuli were presented.
initialTime = find_beginning(audioName);

for n = 1:R
	if ~isempty(timeArray{n})
		stimulusTime(n) = str2num(timeArray{n})/1000;
	end
end
axes(hAxes);
plot(0);
hold on;
plot(stimulusTime, 0, 'ob', 'MarkerFaceColor', 'b');

% Obtains the timeline from the CSV file generated from the audio analysis
fileID = fopen(audioName);
timecontent = textscan(fileID, '%s');
fclose(fileID);

% Modifies the format of the number stored in the file exchanging ',' by '.'
[R, C] = size(timecontent{1});
for n = 2:R
	timecontent{1}{n} = split_string(timecontent{1}{n}, ';');
	temp = timecontent{1}{n}{2};
	temp = split_string(temp, ',');
	audioTime(n-1) = str2num(char(strcat(temp(1), '.', temp(2))));
end
plot(audioTime, 0, 'or');
hold off;

% Time that takes for one to respond to a stimulus
k = 1; % counts which word of the audio file is being analysed
for n = 2:length(stimulusTime)

	% IF there are still more words to be analysed
	if k <= length(audioTime)
		% TODO Fix the 'if' condition
		if stimulusTime(n) >= audioTime(k)
			responseTime(n-1) = audioTime(k) - stimulusTime(n-1);
			k = k + 1;
			% IF the stimulus being analysed is the last one
			if ((n == length(stimulusTime)) && (k <= length(audioTime)))
				responseTime(n) = audioTime(k) - stimulusTime(n);
			else
				responseTime(n) = 0;
			end

		% TODO Related to the 'if' that needs to be fixed
		else
			while (stimulusTime(n) < audioTime(k) && n < length(stimulusTime))
				responseTime(n-1) = 0;
				n = n + 1;
			end
		end

	% ELSE, every word has already been analysed and the participant
	%		didn't answered to further stimuli
	else 
		responseTime(n) = 0;
	end
end
		

function main(folder)
% This is the main procedure for dealing with the apparent corruption of EDF
% signals that is happenning on SST data collection.
%
% Right now it is being called as `main ..\..\b\SST` or
% `main ..\..\..\SST\data\ns\EEG\edf`
%
% The current idea of this procedure is to calculate the RMS power for each
% channel, then relate all channels and files through a table, and try to find
% any patterns in the data.
%

% Adding P2Lib
cd ..
cd ..
addP2Lib
cd etc
cd corrupt

% Looking for fitting files
dirData = dir(folder);
dirIndex = [ dirData.isdir ];
files = { dirData(~dirIndex).name };
files = selectWithCorrectExtension(files);

% Calculating RMS power for each channel in each file.
tic
channels = { };
rms = { };
% IDEA Run this for in parallel
limit = length(files);
for m = 1:limit
	file = files{m};
	fprintf('%s (%d/%d)\n', file, m, limit);
	fileName = strcat(folder, filesep, file);
	edf = br.unb.biologiaanimal.edf.EDF(fileName);
	labels = edf.getLabels();
	for n = 1:length(labels)
		label = labels(n);
		k = whereToAdd(channels, label);
		channels{k} = label;
		signal = edf.getSignal(label);
		rms{k, m} = calculateRms(signal);
	end
end
toc
% TODO Display this RMS variable as a CSV table
dataFile = strcat(folder, filesep, 'data.csv');
horizontalTags = fmap(@char, channels);
verticalTags = fmap(@char, files);
saveCsv(dataFile, horizontalTags, verticalTags, rms);

%% Filtering out files with extensions that are not '*.edf'.
function [outlet] = selectWithCorrectExtension(inlet)
outlet = { };
for n = 1:length(inlet)
	it = inlet{n};
	ext = it(length(it)-3:length(it));
	if isequal('.edf', ext)
		outlet{end+1} = it;
	end
end

%% Assessing where to add a string in a set.
function [where] = whereToAdd(channels, label)
where = length(channels)+1;
for n = 1:length(channels)
	if isequal(channels{n}, label)
		where = n;
	end
end

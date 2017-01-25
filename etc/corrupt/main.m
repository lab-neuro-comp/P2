function main(folder)
% This is the main procedure for dealing with the apparent corruption of EDF
% signals that is happenning on SST data collection.
%
% Right now it is being called as `main ..\..\b\SST`
%

% Adding P2Lib
cd ..
cd ..
addP2Lib
cd etc
cd corrupt

% The current idea of this procedure is to calculate the RMS power for each
% channel.
dirData = dir(folder);
dirIndex = [ dirData.isdir ];
files = { dirData(~dirIndex).name };
files = selectWithCorrectExtension(files);

tic
rms = { };
for file = files
	disp(file);
	% TODO Calculate RMS for each channel
	fileName = strcat(folder, filesep, file);
	edf = br.unb.biologiaanimal.edf.EDF(fileName);
	localRms = [ ];
	labels = edf.getLabels();
	for n = 1:length(labels)
		label = labels(n);
		signal = edf.getSignal(label);
		localRms(n) = calculateRms(signal);
	end
	% TODO Store RMS
	rms{end+1} = mean(localRms)
end
toc
rms

function [outlet] = selectWithCorrectExtension(inlet)
outlet = { };
for n = 1:length(inlet)
	it = inlet{n};
	ext = it(length(it)-3:length(it));
	if isequal('.edf', ext)
		outlet{end+1} = it;
	end
end

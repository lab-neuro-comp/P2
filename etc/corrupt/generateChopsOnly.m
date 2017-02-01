function generateChopsOnly(folder)
% This is the main procedure for dealing with the apparent corruption of EDF
% signals that is happenning on SST data collection.
%
% Right now it is being called as `main ..\..\b\SST` or
% `main ..\..\..\SST\data\ns\EEG\edf`
%
% The current idea of this procedure is to extract a sample of the signal and
% calculate its STFT, resulting in a plot that will be analyzed later.
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

% Chopping files
tic
channels = { };
noFiles = length(files);
parfor m = 1:noFiles
	fprintf('%s (%d/%d)\n', files{m}, m, noFiles);
	channels{m} = chopSignals(folder, files{m});
end
toc

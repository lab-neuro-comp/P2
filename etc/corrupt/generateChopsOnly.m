function generateChopsOnly(folder)
% Extracts the samples of the files and saves which files it has generated
% on a file called `ids.txt`. Before running this procedure, be sure that this
% output file does not exist.
%

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

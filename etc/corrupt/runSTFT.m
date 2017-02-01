function runSTFT(folder, fileName)
% Runs the STFT on a sample of the signal stored in the EDF file that is
% provided by the input.
% TODO Implement this function!
%

% Preparing filesystem for this procedure
outputDir = strcat(folder, filesep, strcat(fileName, '.output'));
if ~isequal(exist(outputDir, 'dir'), 7)
	mkdir(outputDir);
end

% Loading data
fullName = strcat(folder, filesep, fileName);
edf = br.unb.biologiaanimal.edf.EDF(fullName);
samplingRate = edf.getSamplingRate();
labels = edf.getLabels();

% Calculating Fourier Transform
parfor n = 1:length(labels)
	label = labels(n)
	recording = edf.getSignal(label);
	% Extracting sample
	recording = subSignal(recording, 0.4, 0.6);
	% TODO Run STFT
	% Storing data
	outputFileName = [ outputDir filesep char(label) '.mat' ];
	saveData(outputFileName, recording);
end

% --- AUXILIARY FUNCTIONS

%% Chops a signal based on a lower and upper bounds percentages
function [outlet] = subSignal(inlet, lowerbound, upperbound)
limit = length(inlet);
from = floor(lowerbound * limit);
to = floor(upperbound * limit);
outlet = inlet(from:to);

%% Stores data on memory
function saveData(where, what)
fp = fopen(where, 'wb');
fwrite(fp, what, 'real*4');
fclose(fp);

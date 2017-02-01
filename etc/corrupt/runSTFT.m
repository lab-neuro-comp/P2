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

% Setting parameters for STFT
winsize = 256;
window = blackman(winsize);

% Calculating Fourier Transform
parfor n = 1:length(labels)
	label = labels(n)
	recording = edf.getSignal(label);
	% Extracting sample
	recording = subSignal(recording, 0.4, 0.6);
	% TODO Run STFT
	% BUG This call is consuming the whole memory
	recording = calcstft(recording, window, winsize);
	% Storing data
	outputFileName = [ outputDir filesep char(label) '.mat' ];
	saveData(outputFileName, recording);
end

function [signalsIDs] = chopSignals(folder, fileName)
% Extracts a sample from the recording provided by the input. The generated
% files are stored in  a file called 'ids,txt' that is stored in the same
% given folder
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
signalsIDs = { };

% Chopping signals
for n = 1:length(labels)
	label = labels(n);
	recording = edf.getSignal(label);
	% Extracting sample
	recording = subSignal(recording, 0.45, 0.55);
	% Storing data
	outputFileName = [ outputDir filesep char(label) '.mat' ];
	saveData(outputFileName, recording);
	signalsIDs{n} = outputFileName;
end

% Storing IDs
idfile = strcat(folder, filesep, 'ids.txt');
fp = fopen(idfile, 'a');
for n = 1:length(signalsIDs)
	fprintf(fp, '%s\n', signalsIDs{n});
end
fclose(fp);

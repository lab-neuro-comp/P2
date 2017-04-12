function [outputFile, infoFile] = performDwtAnalysis(inputFile)
% Converts an EDF file to its filtered ASCII version. The applied filter is
% based on the DWT transform.
%
outputFile = change_extension(inputFile, 'ascii');
infoFile = change_extension(inputFile, 'txt');
edf = br.unb.biologiaanimal.edf.EDF(inputFile);
labels = edf.getLabels();
limit = length(labels);
signals = [ ];
if isequal(char(labels(end)), 'EDF Annotations')
	limit = limit-1;
end
% TODO For each label, filter the correspondent signal
parfor n = 1:limit
	label = labels(n);
	signal = edf.getSignal(label);
	signal = filterMe(signal)
	signals(:,n) = signal; % Requires all signals to have the same size
end
% TODO Save the signals on a single file
dlmwrite(outputFile, signals, 'delimiter', '\t');
% TODO Create information file

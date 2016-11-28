function [EMG, GSR] = separateGSR(edffile)
% Separates GSR signal from EMG

%import *;
edfinfo = br.unb.biologiaanimal.edf.EDF(edffile);
labels = edfinfo.getLabels();

% Converting EDF file to something we can use
[asciifile] = edftoascii(edffile, edfinfo, labels);

if strcmp(asciifile, 'null')
	EMG = 0;
	GSR = 0;
	return;
end

% Trying to use the EDF file
raw = load(asciifile);

% TODO Optimize parameters of the function
GSR = smooth(raw, 255, 'sgolay', 2);
EMG = raw - GSR;

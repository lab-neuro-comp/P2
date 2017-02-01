function [EMG, GSR, SamplingRate] = separateGSR(edffile)
% Separates GSR signal from EMG

%import *;
h = msgbox('Loading file...');
edfinfo = br.unb.biologiaanimal.edf.EDF(edffile);
labels = edfinfo.getLabels();
SamplingRate = edfinfo.getSamplingRate();
delete(h);

% Converting EDF file to something we can use
h = msgbox('Searching for EMG-GSR channel...');
[asciifile] = edftoascii(edffile, edfinfo, labels);
delete(h);

if strcmp(asciifile, 'null')
	EMG = 0;
	GSR = 0;
	return;
end

% Trying to use the EDF file
h = msgbox('Separating channel...');
raw = load(asciifile);

% TODO Optimize parameters of the function
GSR = smooth(raw, 255, 'sgolay', 2);
EMG = raw - GSR;
delete(h);

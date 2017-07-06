function [EMG, GSR] = separateGSR(pathToSave, ALLEEG, EEG, n)
% Separates GSR signal from EMG

% Converting EDF file to something we can use
h = msgbox('Converting EMG-GSR channel...');
[asciifile] = edftoascii(pathToSave, ALLEEG, EEG, n);
try
	close(h);
end

% Trying to use the EDF file
h = msgbox('Separating channel...');

% TODO Optimize parameters of the function
GSR = smooth(asciifile, 255, 'sgolay', 2);
EMG = asciifile - transpose(GSR);
try
	close(h);
end

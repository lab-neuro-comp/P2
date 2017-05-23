function [EMG, GSR] = separateGSR(pathToSave, ALLEEG, edffile, n, channelLabel)
% Separates GSR signal from EMG

% Converting EDF file to something we can use
h = msgbox('Converting EMG-GSR channel...');
[asciifile] = edftoascii(pathToSave, ALLEEG, edffile, n, channelLabel);
delete(h);

% Trying to use the EDF file
h = msgbox('Separating channel...');

% TODO Optimize parameters of the function
GSR = smooth(asciifile, 255, 'sgolay', 2);
EMG = asciifile - transpose(GSR);
delete(h);

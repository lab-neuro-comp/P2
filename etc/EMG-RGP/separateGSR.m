%% separateGSR: Separates GSR signal from EMG
function [EMG, GSR] = separateGSR(edffile)
% Separates GSR signal from EMG

% Converting EDF file to something we can use
[asciifile, txtfile] = edftoascii(edffile);

% Trying to use the EDF file
raw = load(asciifile);
figure;
plot(raw); % TODO Why is the signal all fucked up?

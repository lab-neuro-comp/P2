%% separateGSR: Separates GSR signal from EMG
function [EMG, GSR] = separateGSR(edffile)
% Separates GSR signal from EMG

% Converting EDF file to something we can use
[asciifile, txtfile] = edftoascii(edffile);

% Trying to use the EDF file
raw = load(asciifile);
figure;
hold on;
plot(raw, 'r'); % TODO Why is the signal all fucked up?

% TODO Find out the sampling frequency
fs = 2560;
[b, a] = butter(4, [5, 450]/(fs/2));
record = filter(b, a, raw);
plot(record, 'b');
plot (0:lenght(record), 0, 'g');
hold off;
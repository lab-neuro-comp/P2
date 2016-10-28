%% separateGSR: Separates GSR signal from EMG
function [EMG, GSR] = separateGSR(edffile)
% Separates GSR signal from EMG

javaaddpath('edf.jar');
import br.unb.biologiaanimal.edf.*;
edfinfo = EDF(edffile);
labels = edfinfo.getLabels();

% Converting EDF file to something we can use
[asciifile, txtfile] = edftoascii(edffile, edfinfo, labels);

% Trying to use the EDF file
raw = load(asciifile);
figure;
hold on;
plot(raw, 'r'); % TODO Why is the signal all fucked up?

% TODO Keep working with the smooth function
%Y = smooth(raw, 'sgolay', 2); 
%X = smooth(raw, 1023, 'sgolay', 2); 
X = smooth(raw, 4095, 'sgolay', 2); 
%plot(Y, 'b');
Y = X - 65000; % Just shifted down so it'd be easier to see
plot(Y, 'b');

MEMG = raw - X;
plot(MEMG, 'g');

% TODO Find out the sampling frequency
fs = edfinfo.getSamplingRate;
[b, a] = butter(2, 5/(fs/2), 'high');
record = filter(b, a, X);
%plot(record, 'm');

hold off;

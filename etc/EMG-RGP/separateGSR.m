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
%hold on;
plot(raw, 'r'); % TODO Why is the signal all fucked up?

% TODO Keep working with the smooth function
Y = smooth(raw, 255, 'sgolay', 2); 
figure;
plot(Y, 'b');

% TODO Find out the sampling frequency
%fs = edfinfo.getSamplingRate;
%[b, a] = butter(4, [1, 5]/(fs/2));
%record = filter(b, a, raw);
%plot(record, 'b');
%hold off;
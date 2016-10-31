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

% TODO Optimize parameters of the function
X = smooth(raw, 255, 'sgolay', 2); 
Y = X - 65000; % Just shifted down so it'd be easier to see
plot(Y, 'b');

MEMG = raw - X;
plot(MEMG, 'g');

hold off;

function [newsig] = chop_signal(oldsig, fs, beginning, ending)
% chops a signal between the defined time intervals
% oldsig     the signal to be chopped
% fs         the frequency rate, in Hz
% beginning  the first moment, in ms
% ending     the second moment, in ms

% Fixing dimensions
fs = fs/1000;
% Chopping signal
from = floor(beginning * fs);
to = floor(ending * fs);
newsig = oldsig(from:to);

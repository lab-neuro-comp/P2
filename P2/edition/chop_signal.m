function [newsig] = chop_signal(oldsig, fs, beginning, ending)
% chops a signal between the defined time intervals

% Fixing dimensions
fs = fs/1000;
% Chopping signal
from = floor(beginning * fs);
to = floor(ending * fs);
newsig = oldsig(from:to);

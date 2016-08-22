function [newsig] = chop_signal(oldsig, fs, beginning, ending)
% chops a signal between the defined time intervals
from = beginning * fs;
to = ending * fs;
newsig = oldsig(from:to);

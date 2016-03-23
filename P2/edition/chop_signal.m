function [newsig] = chop_signal(oldsig, beginning, ending)
% chops a signal between the defined time intervals
global fs
newsig = oldsig(beginning * fs:ending * fs);

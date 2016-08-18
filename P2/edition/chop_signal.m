function [newsig] = chop_signal(oldsig, fs, beginning, ending)
% chops a signal between the defined time intervals
newsig = oldsig(beginning * fs:ending * fs);

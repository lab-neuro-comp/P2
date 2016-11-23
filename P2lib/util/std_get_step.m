function [step] = std_get_step(signal, fs)
% get step to use in plot based on Frequency
step = 0:1/fs:(length(signal) - 1)/fs;

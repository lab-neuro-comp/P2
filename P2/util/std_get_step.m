function [step] = std_get_step(signal) % get step to use in plot based on Frequency
global fs
step = 0:1/fs:(length(signal) - 1)/fs;

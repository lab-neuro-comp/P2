function [step] = std_get_step(signal, fs)
% Gets step to use in plot based on sample rate
step = 0:1/fs:(length(signal) - 1)/fs;

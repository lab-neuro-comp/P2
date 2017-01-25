function [rms] = calculateRms(signal)
% Calculates the RMS value related to that signal.
rms = sqrt(sum(signal.^2));

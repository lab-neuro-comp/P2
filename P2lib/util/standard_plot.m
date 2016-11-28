%% Plots the current signal on screen
function [handle] = standard_plot(signal, fs)
handle = plot(std_get_step(signal, fs), signal);

function [handle] = standard_plot(signal) % plot the current signal on screen
handle = plot(std_get_step(signal), signal);

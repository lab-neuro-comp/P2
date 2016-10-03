function [abcxyz] = callPlot(files, stuff)
% Calls another window for processing voice moments
% files  the list of processed files 
%
global abcxyz;
disp('Calling Plot...');
plot_stuff(files, stuff)
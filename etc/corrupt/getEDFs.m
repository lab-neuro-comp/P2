function [edfs] = getEDFs(directory)
% This function gets all the EDF files in the given directory
%
files = dir([ directory filesep '*.edf']);
edfs = { files.name }';

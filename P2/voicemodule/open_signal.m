function [record, fs] = open_signal(hObject, handles, files, n)
%-------------
% INPUTS:
%	hObject, handles = handles structs concerning the GUI
%	files			 = list of files that will the analised
%
% OUTPUTS:
%	record			 = stores the record of the files that's being analysed
%	fs 				 = stores the sampling frequency of record
%-------------

% Recover file original name
filename = strrep(files{n}, '.csv', '.wav');
filename = strrep(filename, strcat(filesep, 'CSVFiles', filesep), filesep);
[fpath, fname, fext] = fileparts(files{n});
set(handles.textFilename, 'String', strcat(fname, fext));

% Opening audio file
[record, fs] = audioread(filename);


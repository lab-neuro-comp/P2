function [asciifile] = edftoascii(pathToSave, ALLEEG, edffile, n, label)
% function to call the EDFtoASCII app

asciipath = strcat(pathToSave, 'temp.ascii');

EEG = pop_select(edffile, 'channel', label);
EEG = pop_saveset(EEG, 'filename', 'temp.set', ...
                       'filepath', pathToSave);
EEG = pop_export(EEG, asciipath, 'time', 'off', 'elec', 'off');

asciifile = load(asciipath);
delete(asciipath);
delete(strcat(pathToSave, filesep, 'temp.set'));
delete(strcat(pathToSave, filesep, 'temp.fdt'));
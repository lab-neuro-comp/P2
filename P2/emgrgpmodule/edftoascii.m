function [asciifile] = edftoascii(pathToSave, edffile, label)
% function to call the EDFtoASCII app

asciipath = strcat(pathToSave, 'temp.ascii');

EEG = pop_select(edffile, 'channel', label);
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);
EEG = pop_saveset(EEG, 'filename', 'temp.set', ...
                       'filepath', pathToSave);
EEG = pop_export(edffile, asciipath, 'time', 'off', 'elec', 'off');

asciifile = load(asciipath);
delete(asciipath);

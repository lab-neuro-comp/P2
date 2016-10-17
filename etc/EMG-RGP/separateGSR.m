%% separateGSR: Separates GSR signal from EMG
function [EMG, GSR] = separateGSR(edffile)
% Separates GSR signal from EMG

% Getting raw EDF id
limit = length(edffile);
while ~isequal(edffile(limit), '.')
    limit = limit-1;
end
raw = edffile(1:limit);

% Converting EDF file
info_stuff = strcat(raw, 'txt');
data_stuff = strcat(raw, 'ascii');

% works when the .exe is in the same folder,
% but it doesn't save
command = sprintf('edftoascii.exe %s 22 %s %s /SPACE /BATCH', ...
                  edffile, info_stuff, data_stuff);
[status, result] = system(command);

% TODO Store the conversion result in data_stuff

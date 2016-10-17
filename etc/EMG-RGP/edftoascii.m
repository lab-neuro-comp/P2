%% edftoascii: function to call the EDFtoASCII app
function [asciifile, txtfile] = edftoascii(edffile)
% function to call the EDFtoASCII app

% Getting raw EDF id
limit = length(edffile);
while ~isequal(edffile(limit), '.')
    limit = limit-1;
end
raw = edffile(1:limit);

% Converting EDF file
txtfile = strcat(raw, 'txt');
asciifile = strcat(raw, 'ascii');

% works when the .exe is in the same folder,
% but it doesn't save
command = sprintf('edftoascii.exe %s 22 %s %s /SPACE /BATCH', ...
                  edffile, txtfile, asciifile);
[status, result] = system(command);

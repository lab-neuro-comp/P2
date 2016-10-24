%% edftoascii: function to call the EDFtoASCII app
function [asciifile, txtfile] = edftoascii(edffile)
% function to call the EDFtoASCII app

javaaddpath('edf.jar');
import br.unb.biologiaanimal.edf.*;
teste = EDF(edffile);
labels = teste.getLabels();

% Getting raw EDF id
limit = length(edffile);
while ~isequal(edffile(limit), '.')
    limit = limit-1;
end
raw = edffile(1:limit);

% Converting EDF file
txtfile = strcat(raw, 'txt');
asciifile = strcat(raw, 'ascii');
teste.toSingleChannelAscii(asciifile, 'EMG-RGP');

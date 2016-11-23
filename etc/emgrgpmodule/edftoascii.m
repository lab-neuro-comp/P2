%% edftoascii: function to call the EDFtoASCII app
function [asciifile] = edftoascii(edffile, edfinfo, labels)
% function to call the EDFtoASCII app

for n = 1:length(labels)
	if strcmp(labels(n), 'EMG-RGP');

		% Getting raw EDF id
		limit = length(edffile);
		while ~isequal(edffile(limit), '.')
		    limit = limit-1;
		end
		raw = edffile(1:limit);

		% Converting EDF file
		asciifile = strcat(raw, 'ascii');
		edfinfo.toSingleChannelAscii(asciifile, 'EMG-RGP');
		return;
	end
end

asciifile = 'null';

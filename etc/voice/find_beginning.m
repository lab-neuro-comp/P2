function [initialTime] = find_beginning(filename)
% TODO Find a better way to get this result

underline = findstr(filename, '_');
remain = filename;

for n = 1:length(underline)
	[token, remain] = strtok(remain, '_');
end

remain = strrep(remain, '_', '');
remain = strrep(remain, '.csv', '');

initialTime = 0;
[token, remain] = strtok(remain, 'h');
initialTime = (str2num(token))*3600;
[token, remain] = strtok(remain, '.');

initialTime = initialTime + ...
			  ((str2num(strrep(token, 'h', '')))*60) + ...
			  (str2num(strrep(remain, '.', '')));

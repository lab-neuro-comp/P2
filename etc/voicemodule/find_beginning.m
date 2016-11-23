function [initialTime] = find_beginning(filename)
% The variable filename should be structured like the following example:
% audio_participanName_testName_date_time.wav
% If so, the function manages to get the time the audio file was created,
% thus turning its value into seconds for later comparison.

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

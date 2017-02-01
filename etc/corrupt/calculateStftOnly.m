function calculateStftPnly(folder)
% Calculates the STFT for each recording in the `ids.txt` file contained in
% this folder.
%
% Must be called after `generateChopsOnly`.
%

% Setting parameters for STFT
winsize = 256;
window = blackman(winsize);
lines = { };

tic
% Reading lines
fullName = strcat(folder, filesep, 'ids.txt');
fp = fopen(fullName, 'r');
line = fgetl(fp);
while ischar(line)
	lines{end+1} = line;
	line = fgetl(fp);
end
fclose(fp);

% Running STFT
limit = length(lines);
for m = 1:limit
	fprintf('%s (%d/%d)\n', lines{m}, m, limit);
	recording = loadData(lines{m});
	% BUG This call is consuming the whole memory
	recording = calcstft(recording, window, winsize);
	contour(recording);
end
toc

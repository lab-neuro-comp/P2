function calculateStftPnly(folder)
% Calculates the STFT for each recording in the `ids.txt` file contained in
% this folder.
%
% Must be called after `generateChopsOnly`.
%

% Setting parameters for STFT
winsize = 256;
window = blackman(winsize);
nfft = winsize;
noverlap = winsize-1;
fs = 2000;
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
	% Calculating STFT by the spectrogram function
	% Ref: http://www.mathworks.com/help/wavelet/ug/wavelet-packets.html
	figure;
	[S, F, T] = spectrogram(recording, window, noverlap, nfft, fs);
	imagesc(T, F, log10(abs(S)));
	set(gca, 'YDir', 'Normal');
	% xlabel('Time (secs)');
	% ylabel('Freq (Hz)');
	% title([ 'STFT ' lines{m} ]);
	saveas(gcf, [ lines{m} '.fig' ]);
	close;
end
toc

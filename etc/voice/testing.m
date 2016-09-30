function testing()
% Testing calling plot_stuff

files = { 'data/voicerecognition.wav' };
%files = { 'data/actualcase.wav' 'data/voicerecognition.wav' };
stuff = java.util.HashMap;

for n = 1:length(files)
	stuff.put(files{n}, main(files{n}));
end

plot_stuff(files, stuff);
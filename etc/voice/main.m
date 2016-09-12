function main()

filename = 'data/voicerecognition.wav';
[record, fs, nbits] = wavread(filename);
plot(1:length(record), record);
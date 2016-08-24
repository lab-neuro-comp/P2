%% main: the callback to the run button
function main(testcase, threshold, windowsize)
% the callback to the run button
tic
temp_file = 'fourier.ascii';
stuff = FourierRecognition(testcase, threshold, windowsize);
save_to_file(temp_file, stuff); limit = length(stuff); clear stuff;
intervals_file = recognize_density(temp_file, threshold, windowsize);
outlet = load_intervals(intervals_file, limit);
toc

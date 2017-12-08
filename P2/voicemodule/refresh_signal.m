function [record, fs] = refresh_signal(hObject, handles, files, stuff, n, analysis)

% Recover file original name
filename = strrep(files{n}, '.csv', '.wav')
filename = strrep(filename, strcat(filesep, 'CSVFiles', filesep), filesep);
[fpath, fname, fext] = fileparts(files{n});
set(handles.textFilename, 'String', strcat(fname, fext));

% Opening audio file
[record, fs] = audioread(filename);

% If the file being analysed is indeed an audio
if analysis
	moments = get(stuff, files{n})
	timemoments = turn_to_time(moments, length(record)/fs);

% Else, if file hasa been analysed already
% and the information provided is a CSV
else
	timemoments = get(stuff, files{n});
end

% Plots audio wave
axes(handles.axes1);
plot(0);
step = 0:(1/fs):(length(record)/fs);
hold on;
plot(step(2:length(step)), record, 'b');

% Replace each point that represents speech
for n = 1:numel(timemoments)
	% TODO Keep looking for a better way to plot it
    xposition = timemoments(n);
    plot(xposition, 0, 'or', 'MarkerSize', 4);
end
hold off;

guidata(hObject, handles);

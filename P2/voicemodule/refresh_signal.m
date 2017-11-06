function [record, fs] = refresh_signal(hObject, handles, files, stuff, n)

filename = strrep(files{n}, '.wav', '2.wav');
moments = get(stuff, files{n});

[fpath, fname, fext] = fileparts(files{n});
set(handles.textFilename, 'String', strcat(fname, fext));
[record, fs] = wavread(filename);
timemoments = turn_to_time(moments, length(record)/fs)
%list = get(handles.listboxMoments, 'Value');
%set(handles.listboxMoments, 'String', timemoments);

axes(handles.axes1);
plot(0);
step = 0:(1/fs):(length(record)/fs);

hold on;
plot(step(2:length(step)), record, 'b');

% TODO Keep looking for a better way to plot it
for n = 1:numel(timemoments)
    xposition = timemoments(n);
    plot(xposition, 0, 'or', 'MarkerSize', 2);
end
hold off;

guidata(hObject, handles);

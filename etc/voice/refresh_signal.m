function refresh_signal(hObject, handles, files, stuff, n)

filename = files{n};
disp(length(files));
disp(n);
moments = get(stuff, filename);

set(handles.textFilename, 'String', filename);
[record, fs, nbits] = wavread(filename);
timemoments = turn_to_time(moments, length(record)/fs);
list = get(handles.listboxMoments, 'Value');
set(handles.listboxMoments, 'String', timemoments);

axes(handles.axes1);
plot(0);
step = 0:(1/fs):(length(record)/fs);

hold on;
plot(step(2:length(step)), record, 'b');

% TODO Keep looking for a better way to plot it
for n = 1:numel(timemoments)
    xposition = timemoments(n);
    plot(xposition, -1:0.01:1, 'r', 'LineWidth', 2,...
         'MarkerFaceColor', 'r', 'MarkerSize', 10);
end
hold off;

handles.record = record;
handles.fs = fs;

guidata(hObject, handles);

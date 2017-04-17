function [record, fs] = refresh_signal(hObject, handles, files, stuff, n)

filename = files{n};
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
    plot([xposition xposition], [-(0.5*max(record)) (0.5*max(record))], '-r', ...
    	 'LineWidth', 1, ...
         'MarkerFaceColor', 'r',...
         'MarkerSize', 2);
end
hold off;

guidata(hObject, handles);

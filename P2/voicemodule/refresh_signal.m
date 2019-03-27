function refresh_signal(hObject, handles, files, stuff, n, record, fs, analysis, first, interval)
%-------------
% INPUTS:
%	hObject, handles = handles structs concerning the GUI
%	files			 = list of files that will the analised
%	stuff			 = hasp map contains time moments of each file
%	n 				 = number of the file of the list that is being analysed
%	record			 = stores the record of the files that's being analysed
%	fs 				 = stores the sampling frequency of record
%	analysis		 = stores the not being used?
%	first 			 = first point that is being displayed in plot
%	interval		 = size of the interval that is being displayed
%
% OUTPUTS:
%	none
%-------------

% If the file being analysed is indeed an audio
timemoments = get(stuff, files{n});

% Plots audio wave
axes(handles.axes1);
plot(0);
timeAxis = first:(1/fs):(first + interval);
hold on;
rfLimit = (first * fs) + 1; % first record interval
rlLimit = (first + interval)*fs; % last record interval
plot(timeAxis(1:length(timeAxis)-1), record(rfLimit:rlLimit), 'b');
xlim([first (first + interval)]);
%ylim([min(record)/4 max(record)/4]);

% Replace each point that represents speech
for n = 1:numel(timemoments)
	% TODO Keep looking for a better way to plot it
	xposition = timemoments(n);
	if (xposition >= first && xposition < first + interval)
	    plot(xposition, 0, 'or', 'MarkerSize', 4);
	end
end
hold off;

guidata(hObject, handles);

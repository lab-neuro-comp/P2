% --- discovers which filter is currently selected in the available filter lists
function [fk] = get_filter_kind(handles)
switch 1
case get(handles.lowpassbutton, 'Value')
	fk = 'lowpass';
case get(handles.highpassbutton, 'Value')
	fk = 'highpass';
case get(handles.bandpassbutton, 'Value')
	fk = 'bandpass';
case get(handles.bandstopbutton, 'Value')
	fk = 'bandstop';
end

function [handles] = disable_predet_opts(hObject, handles)
	
set(handles.EditMin, 'Enable', 'on');
set(handles.EditMax, 'Enable', 'on');

set(handles.RadioDelta, 'Enable', 'off', 'Value', 0);
set(handles.RadioTheta, 'Enable', 'off', 'Value', 0);
set(handles.RadioAlpha, 'Enable', 'off', 'Value', 0);
set(handles.RadioBeta, 'Enable', 'off', 'Value', 0);
set(handles.RadioGamma, 'Enable', 'off', 'Value', 0);

set(handles.RadioManual, 'Value', 0);
set(handles.RadioPredet, 'Value', 0);
set(hObject, 'Value', 1);

guidata(hObject, handles);
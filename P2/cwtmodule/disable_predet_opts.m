function [handles] = disable_predet_opts(hObject, handles)
	
set(handles.EditMin, 'Enable', 'on');
set(handles.EditMax, 'Enable', 'on');
set(handles.RadioDelta, 'Enable', 'off');
set(handles.RadioTheta, 'Enable', 'off');
set(handles.RadioAlpha, 'Enable', 'off');
set(handles.RadioBeta, 'Enable', 'off');
set(handles.RadioGamma, 'Enable', 'off');
set(handles.RadioManual, 'Value', 0);
set(handles.RadioPredet, 'Value', 0);
set(hObject, 'Value', 1);
guidata(hObject, handles);
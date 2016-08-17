function [handles] = disable_manual_opts(hObject, handles)
set(handles.EditMin, 'Enable', 'off');
set(handles.EditMax, 'Enable', 'off');
set(handles.RadioDelta, 'Enable', 'on');
set(handles.RadioTheta, 'Enable', 'on');
set(handles.RadioAlpha, 'Enable', 'on');
set(handles.RadioBeta, 'Enable', 'on');
set(handles.RadioGamma, 'Enable', 'on');
set(handles.RadioPredet, 'Value', 0);
set(handles.RadioManual, 'Value', 0);
set(hObject, 'Value', 1);
guidata(hObject, handles);
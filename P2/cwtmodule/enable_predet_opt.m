function [handles] = enable_predet_opt(hObject, handles)
set(handles.RadioDelta, 'Value', 0);
set(handles.RadioTheta, 'Value', 0);
set(handles.RadioAlpha, 'Value', 0);
set(handles.RadioBeta, 'Value', 0);
set(handles.RadioGamma, 'Value', 0);
set(hObject, 'Value', 1);
guidata(hObject, handles);
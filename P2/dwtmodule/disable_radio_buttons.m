function [handles] = disable_radio_buttons(hObject, handles)
set(handles.RadioReplace, 'Value', 0);
set(handles.RadioConstrain, 'Value', 0);
set(handles.RadioEOG, 'Value', 0);
set(hObject, 'Value', 1);
guidata(hObject, handles);

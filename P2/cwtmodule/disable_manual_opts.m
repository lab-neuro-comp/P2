function [handles] = disable_manual_opts(hObject, handles)
	
set(handles.EditMin, 'Enable', 'off');
set(handles.EditMax, 'Enable', 'off');

set(handles.RadioDelta, 'Enable', 'on', 'Value', 1);
wavename = get(handles.TextWavelet, 'String');
deltaf1 = str2num(handles.constants.get('deltaf1'));
deltaf2 = str2num(handles.constants.get('deltaf2'));
set_predet_scales(hObject, handles, wavename, deltaf1, deltaf2);

set(handles.RadioTheta, 'Enable', 'on', 'Value', 0);
set(handles.RadioAlpha, 'Enable', 'on', 'Value', 0);
set(handles.RadioBeta, 'Enable', 'on', 'Value', 0);
set(handles.RadioGamma, 'Enable', 'on', 'Value', 0);

set(handles.RadioPredet, 'Value', 0);
set(handles.RadioManual, 'Value', 0);
set(hObject, 'Value', 1);

guidata(hObject, handles);
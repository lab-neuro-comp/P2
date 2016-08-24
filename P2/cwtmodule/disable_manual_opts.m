function [handles] = disable_manual_opts(hObject, handles)
	
set(handles.EditMin, 'Enable', 'off');
set(handles.EditMax, 'Enable', 'off');

set(handles.RadioDelta, 'Enable', 'on');
set(handles.RadioDelta, 'Value', 1);
contents = cellstr(get(handles.PopupWaveletType, 'String'));
wavetype = contents{get(handles.PopupWaveletType, 'Value')};
wavename = handles.wavelets.get(wavetype);
deltaf1 = str2num(handles.constants.get('deltaf1'));
deltaf2 = str2num(handles.constants.get('deltaf2'));
set_predet_scales(hObject, handles, wavename, deltaf1, deltaf2);

set(handles.RadioTheta, 'Enable', 'on');
set(handles.RadioAlpha, 'Enable', 'on');
set(handles.RadioBeta, 'Enable', 'on');
set(handles.RadioGamma, 'Enable', 'on');

set(handles.RadioPredet, 'Value', 0);
set(handles.RadioManual, 'Value', 0);
set(hObject, 'Value', 1);

guidata(hObject, handles);
function initialize_module(hObject, handles)

fs = str2num(handles.constants.get('fs'));
set(handles.TextSamplingFreq, 'String', fs);

set(handles.PopupWaveletType, 'Enable', 'on');
set(handles.PopupWaveletType, 'Value', 1);
wavename = handles.wavelets.get('Haar');
set(handles.TextSignal, 'String', wavename);

set(handles.RadioManual, 'Enable', 'on');
set(handles.RadioManual, 'Value', 1);
set(handles.RadioPredet, 'Enable', 'on');
set(handles.EditMin, 'Enable', 'on');
set(handles.EditInt, 'Enable', 'on');
set(handles.EditMax, 'Enable', 'on');
deltaf1 = str2num(handles.constants.get('deltaf1'));
deltaf2 = str2num(handles.constants.get('deltaf2'));
set_predet_scales(hObject, handles, wavename, deltaf1, deltaf2);

set(handles.ButtonCalculate, 'Enable', 'on');

set(handles.EditScale, 'Enable', 'on');
set(handles.EditScale, 'String', '1');
set(handles.EditPsFreq, 'Enable', 'on');
PsFreqValue = centfrq(wavename)/(1/fs);
set(handles.EditPsFreq, 'String', sprintf('%5.2f', PsFreqValue));

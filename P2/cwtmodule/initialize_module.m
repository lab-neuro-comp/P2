function initialize_module(hObject, handles)

fs = str2num(handles.constants.get('fs'));
set(handles.TextSamplingFreq, 'String', fs);

set(handles.PopupWaveletType, 'Enable', 'on', 'Value', 1);
wavename = handles.wavelets.get('Haar');
set(handles.TextWavelet, 'String', wavename);

set(handles.RadioManual, 'Enable', 'on', 'Value', 1);
set(handles.RadioPredet, 'Enable', 'on');
set(handles.EditMin, 'Enable', 'on');
set(handles.EditInt, 'Enable', 'on');
set(handles.EditMax, 'Enable', 'on');
deltaf1 = str2num(handles.constants.get('deltaf1'));
deltaf2 = str2num(handles.constants.get('deltaf2'));
set_predet_scales(hObject, handles, wavename, deltaf1, deltaf2);

set(handles.ButtonCalculate, 'Enable', 'on');

set(handles.EditScale, 'Enable', 'on', 'String', '1');
PsFreqValue = centfrq(wavename)/(1/fs);
set(handles.EditPsFreq, 'Enable', 'on', 'String', sprintf('%5.2f', PsFreqValue));

set(handles.RadioScaleGraph, 'Enable', 'off');
set(handles.EditScaleGraph, 'Enable', 'off');
set(handles.RadioTimeGraph, 'Enable', 'off');
set(handles.EditTimeGraph, 'Enable', 'off');
set(handles.ButtonView, 'Enable', 'off');
set(handles.ButtonZoom, 'Enable', 'off');
set(handles.ButtonColorbar, 'Enable', 'off');
set(handles.ButtonReset, 'Enable', 'off');

axes(handles.PlotAnalysis);
cla reset;
grid(handles.PlotAnalysis, 'on');
signaltime = 0:1/fs:(length(handles.signal)-1)/fs;
RegisteredTime = num2str(max(signaltime));
xlabel(strcat('Tempo [s]', ' [', '0:', RegisteredTime, ']'));
ylabel('Scale');
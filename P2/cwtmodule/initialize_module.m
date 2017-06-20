function initialize_module(hObject, handles)

fs = str2num(handles.constants.get('fs'));
set(handles.TextSamplingFreq, 'String', fs);

set(handles.PopupWaveletType, 'Enable', 'on', 'Value', 1);
wavename = handles.wavelets.get('Haar');
set(handles.TextWavelet, 'String', wavename);
set(handles.PopupWaveletVar, 'Visible', 'off');

set(handles.RadioManual, 'Enable', 'on', 'Value', 1);
set(handles.RadioPredet, 'Enable', 'on', 'Value', 0);
set(handles.RadioDelta, 'Enable', 'off', 'Value', 1);
set(handles.RadioTheta, 'Enable', 'off', 'Value', 0);
set(handles.RadioAlpha, 'Enable', 'off', 'Value', 0);
set(handles.RadioBeta, 'Enable', 'off', 'Value', 0);
set(handles.RadioGamma, 'Enable', 'off', 'Value', 0);
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

set(handles.RadioScaleGraph, 'Enable', 'off', 'Value', 1);
set(handles.EditScaleGraph, 'Enable', 'off');
set(handles.RadioTimeGraph, 'Enable', 'off', 'Value', 0);
set(handles.EditTimeGraph, 'Enable', 'off');
set(handles.ButtonView, 'Enable', 'off');
set(handles.ButtonZoom, 'Enable', 'off', 'Value', 0);
set(handles.ButtonColorbar, 'Enable', 'off', 'Value', 0);
set(handles.ButtonReset, 'Enable', 'off');
zoom off;

axes(handles.PlotAnalysis);
cla reset;
grid(handles.PlotAnalysis, 'on');
signaltime = 0:1/fs:(length(handles.signal)-1)/fs;
RegisteredTime = num2str(max(signaltime));
xlabel(strcat('Tempo [s]', ' [', '0:', RegisteredTime, ']'));
ylabel('Scale');
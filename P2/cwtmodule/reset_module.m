function reset_module(hObject, handles)

axes(handles.PlotSignal);
cla reset;
grid on;
ylabel('Amplitude [uV]');

axes(handles.PlotAnalysis);
cla reset;
grid on;
%grid(handles.PlotAnalysis, 'on');
%signaltime = 0:1/fs:(length(handles.signal)-1)/fs;
%RegisteredTime = num2str(max(signaltime));
xlabel('Tempo [s]');
ylabel('Scale');

set(handles.TextFilename, 'String', ' ');
set(handles.TextSamplingFreq, 'String', ' ');

set(handles.PopupWaveletType, 'Enable', 'off', 'Value', 1);
set(handles.PopupWaveletVar, 'Visible', 'off');
set(handles.TextWavelet, 'String', ' ');

set(handles.RadioManual, 'Enable', 'off', 'Value', 1);
set(handles.RadioPredet, 'Enable', 'off', 'Value', 0);
set(handles.EditMin, 'Enable', 'off', 'String', 'Min');
set(handles.EditInt, 'Enable', 'off', 'String', 'Int');
set(handles.EditMax, 'Enable', 'off', 'String', 'Max');
set(handles.RadioDelta, 'Enable', 'off', 'Value', 0);
set(handles.RadioTheta, 'Enable', 'off', 'Value', 0);
set(handles.RadioAlpha, 'Enable', 'off', 'Value', 0);
set(handles.RadioBeta, 'Enable', 'off', 'Value', 0);
set(handles.RadioGamma, 'Enable', 'off', 'Value', 0);

set(handles.ButtonCalculate, 'Enable', 'off');

set(handles.EditScale, 'Enable', 'off', 'String', 'Scale');
set(handles.EditPsFreq, 'Enable', 'off', 'String', 'Pseudofreq');

set(handles.RadioScaleGraph, 'Enable', 'off', 'Value', 1);
set(handles.EditScaleGraph, 'Enable', 'off', 'String', 'Scale');
set(handles.RadioTimeGraph, 'Enable', 'off', 'Value', 0);
set(handles.EditTimeGraph, 'Enable', 'off', 'String', 'Time');
set(handles.ButtonView, 'Enable', 'off');
set(handles.ButtonZoom, 'Enable', 'off', 'Value', 0);
set(handles.ButtonColorbar, 'Enable', 'off', 'Value', 0);
set(handles.ButtonReset, 'Enable', 'off');

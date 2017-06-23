function [handles] = vhrfcn(tvalue, rvalue, hObject, handles)

ecgexportmx = handles.ecgexportmx;

vhr = diff(tvalue);
ecgexportmx{9,3} = 'HRV(R-R)[s]';

for ex = 1:length(vhr)
    ecgexportmx{9+ex,3} = vhr(ex);
end

axes(handles.ecgaxes);
hold on;
hpeack = plot(tvalue, rvalue, 'or');
axes(handles.vhraxes);
hvhr = plot(tvalue(2:length(tvalue)), vhr);
xlabel('[s]');
ylabel('[s]');
title('VHR');
axis tight;
grid on;

axes(handles.vhrspecaxes);
vhrspectrum = abs(fft(vhr));
ecgexportmx{9,5} = 'HRV SPECTRUM';
ecgexportmx{10,5} = 'Power [ms^2]';
ecgexportmx{10,6} = 'Frequency [Hz]';
faxis = 0:1/(length(vhr)-1):1;

for ex = 1:length(vhrspectrum)
    ecgexportmx{10+ex,5} = vhrspectrum(ex);
    ecgexportmx{10+ex,6} = faxis(ex);
end

[p1 p004] = min(abs(faxis-0.04));
[p1 p015] = min(abs(faxis-0.15));
[p1 p04] = min(abs(faxis-0.4));
hf = 0;
lf = 0;

for i = p004:p015
    lf = lf + vhrspectrum(i)^2;
end

for k = p015+1:p04
    hf = hf + vhrspectrum(k)^2;
end

hvhrspec = plot(faxis, vhrspectrum);
xlabel('[Hz]');
ylabel('[ms^2]');
title('VHR SPECTRUM');
axis tight;
set(handles.vhrspecaxes, 'xlim', [0 0.5]);
grid on;

set(handles.beats, 'string', strcat('Beats:', num2str(length(tvalue))));
ecgexportmx{3,1} = 'Beats:';
ecgexportmx{3,2} = length(tvalue);
set(handles.sdnn, 'string', strcat('SDNN:', num2str(std(vhr))));
ecgexportmx{4,1} = 'SDNN:';
ecgexportmx{4,2} = std(vhr);
rmsvhr = (sum(vhr.^2)/length(vhr))^0.5;
set(handles.rms, 'string', strcat('RMSSD:', num2str(rmsvhr)));
ecgexportmx{5,1} = 'RMSSD:';
ecgexportmx{5,2} = rmsvhr;
set(handles.lfhf, 'string', strcat('LF/HF:', num2str(lf/hf)));
ecgexportmx{7,1} = 'LF/HF:';
ecgexportmx{7,2} = lf/hf;
ecgexportmx{6,1} = 'pNN50:';
nn50detect = find(diff(vhr) > 0.05);

switch isempty(nn50detect)
    case 1
        set(handles.pnn50, 'String', 'pNN50:0');
        ecgexportmx{6,2} = 0;
    case 0
        set(handles.pnn50, 'String', strcat('pNN50:', num2str(length(nn50detect)/length(vhr))));
        ecgexportmx{6,2} = length(nn50detect)/length(vhr);
end

set(handles.showdc, 'Enable', 'on', 'Value', 1);
set([handles.figurevhr handles.figurevhrspec handles.ecgexport], 'Enable', 'on');

handles.hvhr = hvhr;
handles.hvhrspec = hvhrspec;
handles.hpeack = hpeack;
handles.vhrspectrum = vhrspectrum;
handles.faxis = faxis;
handles.ecgexportmx = ecgexportmx;

guidata(hObject, handles);

function graph_coefficients(hObject, handles)

fs = str2num(handles.constants.get('fs'));

signaltime = 0:1/fs:(length(handles.signal)-1)/fs;

MinValue = str2num(get(handles.EditMin, 'String'));
IntValue = str2num(get(handles.EditInt, 'String'));
MaxValue = str2num(get(handles.EditMax, 'String'));
analysis = cwt(handles.signal, MinValue:IntValue:MaxValue,...
 		   get(handles.TextWavelet, 'String'));

switch get(handles.RadioScaleGraph, 'Value')
    case 1
    	f=figure('numbertitle', 'off', 'name', 'Scale Coeficients',...
    	  'color','white', 'menubar', 'none');
    	ScaleValue = str2num(get(handles.EditScaleGraph, 'String'));
    	ScaleInd = round((ScaleValue - MinValue)/IntValue)+1;
    	plot(signaltime, analysis(ScaleInd, :));
        axis tight
        grid on
        xlabel('Time [s]')
        ylabel('Coeficients')
        title(strcat('Coeficients at scale ', sprintf('\t %5.2f', ScaleValue)))
    case 0
    	f=figure('numbertitle', 'off', 'name', 'Time Coeficients',...
    	  'color','white', 'menubar', 'none');
    	TimeValue = str2num(get(handles.EditTimeGraph, 'String'));
    	TimeInd = round(TimeValue*fs)+1;
    	plot(MinValue:IntValue:MaxValue, analysis(:,TimeInd));
        axis tight
        grid on
        xlabel('Scales')
        ylabel('Coeficientes')
        title(strcat('Coeficients at time: ', num2str(TimeValue)))
end

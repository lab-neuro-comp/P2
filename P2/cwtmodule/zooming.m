function zooming(hObject, handles)

ax = findobj(handles.figure1, 'type', 'axes');
handles.PlotSignal = ax(2); 
handles.PlotAnalysis = ax(1);
axisvals = [get(handles.PlotSignal, 'xlim'), get(handles.PlotSignal, 'ylim')];

% Focus on bottom axes
set(handles.PlotAnalysis, 'xlim', [pi/180*axisvals(1:2)]);
set(handles.PlotAnalysis, 'ylim', axisvals(3:4));

%switch cax
%    case handles.PlotAnalysis
        disp('Is this the problem?');
%        AnalysisLim = get(handles.PlotAnalysis, 'xlim');
%        disp('Or maybe this one...')
%        ProAnalysisLim = AnalysisLim/fs;
%        disp('I dont even know anymore~...')
%        if ProAnalysisLim(2) > RegisteredTime
%            ProAnalysisLim(2) = RegisteredTime;
%        end
%        set(handles.PlotSignal, 'xlim', ProAnalysisLim);
%    case handles.PlotSignal
        disp('Or maybe this one...');
%        SignalLim = get(handles.PlotSignal, 'xlim');
%        if SignalLim(2) > RegisteredTime;
%            SignalLim(2) = RegisteredTime;
%        end;
%        AnalysisLim = round(SignalLim.*fs);
%        set(handles.PlotAnalysis, 'xlim', SignalLim);
%end
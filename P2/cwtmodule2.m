function varargout = cwtmodule2(varargin)
% This module calculates the continuous wavelet transform of a signal chosen
% by the user. Upon calling cwtmodule2 the user can choose a signal to be
% analysed. The user can also choose among different type/subtypes of
% wavelets and the scale used to make the analysis. After the module
% calculates the cwt of the given signal, the user can graph its
% coefficients either on time or scales. The calculation of the complex
% wavelet transform is made using the matlab function cwt that is available
% for MATLAB2008a.
%

% Edit the above text to modify the response to help cwtmodule2

% Last Modified by GUIDE v2.5 20-Jun-2017 07:59:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cwtmodule2_OpeningFcn, ...
                   'gui_OutputFcn',  @cwtmodule2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

addpath ([cd '/cwtmodule']);
% End initialization code - DO NOT EDIT

% --- Executes just before cwtmodule2 is made visible.
function cwtmodule2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cwtmodule2 (see VARARGIN)

handles.output = hObject;
handles.constants = load_constants();
handles.wavelets = load_wavelets();

% Update handles structure
set(handles.figure1, 'Name', 'CWT Module');
guidata(hObject, handles);

% UIWAIT makes cwtmodule2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cwtmodule2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fa = str2num(handles.constants.get('fa'));
fb = str2num(handles.constants.get('fb'));
fc = str2num(handles.constants.get('fc'));
fs = str2num(handles.constants.get('fs'));
[signalname, signalpath, filterindex]  = uigetfile('*.ascii', 'Select files', ...
                                               'MultiSelect', 'on');
handles.cases = {};
if ~isequal(signalname, 0)
    if ischar(signalname)
        handles.cases = { strcat(signalpath, signalname) };
    elseif iscell(signalname)
        handles.cases = {};
        for n = 1:length(signalname)
            handles.cases{n} = strcat(signalpath, signalname{n});
        end
    end
    set(handles.popupName, 'String', signalname);
    handles.signalpath = signalpath;
    handles.signalname = signalname;

    signal = (load(handles.cases{1}) + fa)*fb - fc;
    handles.signal = signal;
    axes(handles.PlotSignal);
    cla reset;
    standard_plot(handles.signal, fs);
    grid(handles.PlotSignal, 'on');
    axis tight;
    ylabel('Amplitude [uV]');
else
    return;
end

initialize_module(hObject, handles);

guidata(hObject, handles);

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))',...
    'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --------------------------------------------------------------------
% --- Executes on selection change in popupName.
function popupName_Callback(hObject, eventdata, handles)

fa = str2num(handles.constants.get('fa'));
fb = str2num(handles.constants.get('fb'));
fc = str2num(handles.constants.get('fc'));
fs = str2num(handles.constants.get('fs'));

contents = cellstr(get(hObject, 'String'));
signalname = contents{get(hObject, 'Value')};

signal = (load(strcat(handles.signalpath, signalname)) + fa)*fb - fc;
handles.signal = signal;
axes(handles.PlotSignal);
cla reset;
standard_plot(handles.signal, fs);
grid(handles.PlotSignal, 'on');
axis tight;
ylabel('Amplitude [uV]');

axes(handles.PlotAnalysis);
cla reset;
grid(handles.PlotAnalysis, 'on');
signaltime = 0:1/fs:(length(handles.signal)-1)/fs;
RegisteredTime = num2str(max(signaltime));
xlabel(strcat('Tempo [s]', ' [', '0:', RegisteredTime, ']'));
ylabel('Scale');

set(handles.ButtonZoom, 'Value', 0);
set(handles.ButtonColorbar, 'Value', 0);
zoom off;

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
% --- Executes on selection change in PopupWaveletType.
function PopupWaveletType_Callback(hObject, eventdata, handles)

% ## Available wavelets ##
% + Haar
% + Daubechies
%   - db1, db2, db3, ..., db10
% + Symlets
%   - 2, 3, ..., 8
% + Coiflets
%   - 1, 2, ..., 5
% + Biorthogonal
%   - 1.1, 1.3, 1.5, 2.2, 2.4, 2.6, 2.8, 3.1, 3.3, 3.5, 3.7, 3.9, 4.4, 5.5, 6.8
% + R_Biorthigonal
%   - 1.1, 1.3, 1.5, 2.2, 2.4, 2.6, 2.8, 3.1, 3.3, 3.5, 3.7, 3.9, 4.4, 5.5, 6.8
% + Meyer
% + Gaussian
%   - 1, 2, ..., 8
% + Mexican
% + Morlet

dbvaropts={'db1','db2','db3','db4','db5','db6','db7','db8','db9','db10'};
symvaropts={'2','3','4','5','6','7','8'};
coifvaropts={'1','2','3','4','5'};
biorvaropts={'1.1','1.3','1.5','2.2','2.4','2.6','2.8',...
             '3.1','3.3','3.5','3.7','3.9','4.4','5.5','6.8'};
rbiovaropts=biorvaropts;
gausvaropts={'1','2','3','4','5','6','7','8'};

contents = cellstr(get(hObject, 'String'));
wavelettype = contents{get(hObject, 'Value')};

switch wavelettype
    case 'Daubechies'
        set(handles.PopupWaveletVar, 'Visible', 'on', 'Value', 1, 'String', dbvaropts);
        set(handles.TextWavelet, 'String', 'db1');
        wavename = 'db1';
    case 'Symlets'
        set(handles.PopupWaveletVar, 'Visible', 'on', 'Value', 1, 'String', symvaropts);
        set(handles.TextWavelet, 'String', 'sym2');
        wavename = 'sym2';
    case 'Coiflets'
        set(handles.PopupWaveletVar, 'Visible', 'on', 'Value', 1, 'String', coifvaropts);
        set(handles.TextWavelet, 'String', 'coif1');
        wavename = 'coif1';
    case 'Biorthogonal'
        set(handles.PopupWaveletVar, 'Visible', 'on', 'Value', 1, 'String', biorvaropts);
        set(handles.TextWavelet, 'String', 'bior1.1');
        wavename = 'bior1.1';
    case 'R_Biorthogonal'
        set(handles.PopupWaveletVar, 'Visible', 'on', 'Value', 1, 'String', rbiovaropts);
        set(handles.TextWavelet, 'String', 'rbio1.1');
        wavename = 'rbio1.1';
    case 'Gaussian'
        set(handles.PopupWaveletVar, 'Visible', 'on', 'Value', 1, 'String', gausvaropts);
        set(handles.TextWavelet, 'String', 'gaus1');
        wavename = 'gaus1';
    otherwise
        set(handles.PopupWaveletVar, 'Visible', 'off');
        wavename = handles.wavelets.get(wavelettype);
        set(handles.TextWavelet, 'String', wavename);
end

set_scales_for_wavelets(hObject, handles, wavename);


% --- Executes during object creation, after setting all properties.
function PopupWaveletType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopupWaveletType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PopupWaveletVar.
function PopupWaveletVar_Callback(hObject, eventdata, handles)

contents = cellstr(get(hObject, 'String'));
wavesubtype = contents{get(hObject, 'Value')};

typecontents = get(handles.PopupWaveletType, 'String');
wavetype = typecontents{get(handles.PopupWaveletType, 'Value')};

switch wavetype
    case 'Daubechies'
        wavename = wavesubtype;
    otherwise
        wavetype = handles.wavelets.get(wavetype);
        wavename = strcat(wavetype, wavesubtype);
end

set(handles.TextWavelet, 'String', wavename);
set_scales_for_wavelets(hObject, handles, wavename);


% --- Executes during object creation, after setting all properties.
function PopupWaveletVar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopupWaveletVar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
% --- Executes on button press in RadioManual.
function RadioManual_Callback(hObject, eventdata, handles)

disable_predet_opts(hObject, handles);


% --- Executes on button press in RadioPredet.
function RadioPredet_Callback(hObject, eventdata, handles)

disable_manual_opts(hObject, handles);


% --------------------------------------------------------------------
function EditMin_Callback(hObject, eventdata, handles)

wavename = get(handles.TextWavelet, 'String');

MinBase = centfrq(wavename)/0.5;
MinValue = str2num(get(handles.EditMin, 'String'));
MaxValue = str2num(get(handles.EditMax, 'String'));

if ((MinBase - MinValue) > 0.001)
    h = msgbox({'The minimum scale corresponds to a' 'pseudofrequency bigger than fs/2.'},...
                'Error', 'warn');
    set(handles.EditMin, 'String', MinBase);
elseif (MinValue < 0)
    h = msgbox({'The minimum scale' 'must be positive.'}, 'Error', 'warn');
    set(handles.EditMin, 'String', MinBase);
elseif (MinValue > MaxValue)
    h = msgbox({'The minimum scale must be smaller' 'than the maximum scale.'},...
                'Error', 'warn');
    set(handles.EditMin, 'String', MinBase);
end


% --- Executes during object creation, after setting all properties.
function EditMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditInt_Callback(hObject, eventdata, handles)

IntValue = str2num(get(handles.EditInt, 'String'));
MinValue = str2num(get(handles.EditMin, 'String'));
MaxValue = str2num(get(handles.EditMax, 'String'));

if (IntValue > (MaxValue - MinValue) | IntValue < 0)
    h = msgbox({'The interval must be positive and smaller than the' 'difference between the maximum and minimun scales.'},...
                'Error', 'warn');
end


% --- Executes during object creation, after setting all properties.
function EditInt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditInt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditMax_Callback(hObject, eventdata, handles)

fs = str2num(handles.constants.get('fs'));
deltaf1 = str2num(handles.constants.get('deltaf1'));
wavename = get(handles.TextWavelet, 'String');

MaxBase = centfrq(wavename)/((1/fs)*deltaf1);
MinValue = str2num(get(handles.EditMin, 'String'));
MaxValue = str2num(get(handles.EditMax, 'String'));

if (MaxValue < 0)
    h = msgbox({'The maximum scale' 'must be positive.'}, 'Error', 'warn');
    set(handles.EditMin, 'String', MaxBase);
elseif (MinValue > MaxValue)
    h = msgbox({'The maximum scale must be bigger' 'than the minimum scale.'},...
                'Error', 'warn');
    set(handles.EditMin, 'String', MaxBase);
end


% --- Executes during object creation, after setting all properties.
function EditMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
% --- Executes on button press in RadioDelta.
function RadioDelta_Callback(hObject, eventdata, handles)

enable_predet_opt(hObject, handles);

deltaf1 = str2num(handles.constants.get('deltaf1'));
deltaf2 = str2num(handles.constants.get('deltaf2'));
wavename = get(handles.TextWavelet, 'String');
set_predet_scales(hObject, handles, wavename, deltaf1, deltaf2);


% --- Executes on button press in RadioTheta.
function RadioTheta_Callback(hObject, eventdata, handles)

enable_predet_opt(hObject, handles);

thetaf1 = str2num(handles.constants.get('thetaf1'));
thetaf2 = str2num(handles.constants.get('thetaf2'));
wavename = get(handles.TextWavelet, 'String');
set_predet_scales(hObject, handles, wavename, thetaf1, thetaf2);


% --- Executes on button press in RadioAlpha.
function RadioAlpha_Callback(hObject, eventdata, handles)

enable_predet_opt(hObject, handles);

alphaf1 = str2num(handles.constants.get('alphaf1'));
alphaf2 = str2num(handles.constants.get('alphaf2'));
wavename = get(handles.TextWavelet, 'String');
set_predet_scales(hObject, handles, wavename, alphaf1, alphaf2);


% --- Executes on button press in RadioBeta.
function RadioBeta_Callback(hObject, eventdata, handles)

enable_predet_opt(hObject, handles);

betaf1 = str2num(handles.constants.get('betaf1'));
betaf2 = str2num(handles.constants.get('betaf2'));
wavename = get(handles.TextWavelet, 'String');
set_predet_scales(hObject, handles, wavename, betaf1, betaf2);


% --- Executes on button press in RadioGamma.
function RadioGamma_Callback(hObject, eventdata, handles)

enable_predet_opt(hObject, handles);

gammaf1 = str2num(handles.constants.get('gammaf1'));
gammaf2 = str2num(handles.constants.get('gammaf2'));
wavename = get(handles.TextWavelet, 'String');
set_predet_scales(hObject, handles, wavename, gammaf1, gammaf2);


% --------------------------------------------------------------------
% --- Executes on button press in ButtonCalculate.
function ButtonCalculate_Callback(hObject, eventdata, handles)

MinValue = str2num(get(handles.EditMin, 'String'));
IntValue = str2num(get(handles.EditInt, 'String'));
MaxValue = str2num(get(handles.EditMax, 'String'));
wavename = get(handles.TextWavelet, 'String');

h = msgbox('Calculating...');
axes(handles.PlotAnalysis);
clear analysis;
analysis = cwt(handles.signal, MinValue:IntValue:MaxValue, wavename, 'plot');
ylabel('Scale');
close(h);

fs = str2num(handles.constants.get('fs'));
signaltime = 0:1/fs:(length(handles.signal)-1)/fs;
RegisteredTime = num2str(max(signaltime));
xlabel(strcat('Tempo [s]', ' [', '0:', RegisteredTime, ']'));
title ' ';

set(handles.RadioScaleGraph, 'Enable', 'on');
set(handles.EditScaleGraph, 'Enable', 'on', 'String', get(handles.EditMin, 'String'));

set(handles.RadioTimeGraph, 'Enable', 'on');
set(handles.EditTimeGraph, 'Enable', 'off', 'String', '0');

set(handles.ButtonView, 'Enable', 'on');

set(handles.ButtonZoom, 'Enable', 'on');
set(handles.ButtonColorbar, 'Enable', 'on');
set(handles.ButtonReset, 'Enable', 'on');


% --------------------------------------------------------------------
function EditScale_Callback(hObject, eventdata, handles)

fs = str2num(handles.constants.get('fs'));
wavename = get(handles.TextWavelet, 'String');

PsFreqBase = str2num(get(handles.EditPsFreq, 'String'));
ScaleBase = centfrq(wavename)/((1/fs)*PsFreqBase);
ScaleValue = str2num(get(handles.EditScale, 'String'));

if (ScaleValue < 0)
    h = msgbox({'The scale must' 'be positive.'}, 'Error', 'warn');
    set(handles.EditScale, 'String', ScaleBase);
end
PsFreqValue = centfrq(wavename)/((1/fs)*ScaleValue);
set(handles.EditPsFreq, 'String', sprintf('%5.2f', PsFreqValue));


% --- Executes during object creation, after setting all properties.
function EditScale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditPsFreq_Callback(hObject, eventdata, handles)

fs = str2num(handles.constants.get('fs'));
wavename = get(handles.TextWavelet, 'String');

ScaleBase = str2num(get(handles.EditScale, 'String'));
PsFreqBase = centfrq(wavename)/((1/fs)*ScaleBase);
PsFreqValue = str2num(get(handles.EditPsFreq, 'String'));

if (PsFreqValue < 0)
    h = msgbox({'The pseudofrequency' 'must be positive.'}, 'Error', 'warn');
    set(handles.EditPsFreq, 'String', PsFreqBase);
end
ScaleValue = centfrq(wavename)/((1/fs)*PsFreqValue);
set(handles.EditScale, 'String', sprintf('%5.2f', ScaleValue));


% --- Executes during object creation, after setting all properties.
function EditPsFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditPsFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --------------------------------------------------------------------
% --- Executes on button press in RadioScaleGraph.
function RadioScaleGraph_Callback(hObject, eventdata, handles)

set(handles.RadioScaleGraph, 'Value', 1);
set(handles.EditScaleGraph, 'Enable', 'on');

set(handles.RadioTimeGraph, 'Value', 0);
set(handles.EditTimeGraph, 'Enable', 'off', 'Value', 0);

set(handles.ButtonView, 'Enable', 'on');


function EditScaleGraph_Callback(hObject, eventdata, handles)

ScaleMin = str2num(get(handles.EditMin, 'String'));
ScaleMax = str2num(get(handles.EditMax, 'String'));
ScaleGraphValue = str2num(get(handles.EditScaleGraph, 'String'));

if (ScaleGraphValue < ScaleMin)
    h = msgbox({'The scale input must be within' 'the scale values analysed.'},...
                'Error', 'warn');
    set(handles.EditScaleGraph, 'String', get(handles.EditMin, 'String'));
elseif (ScaleGraphValue > ScaleMax)
    h = msgbox({'The scale input must be within' 'the scale values analysed.'},...
                'Error', 'warn');
    set(handles.EditScaleGraph, 'String', get(handles.EditMax, 'String'));
end

set(handles.ButtonView, 'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function EditScaleGraph_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditScaleGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in RadioTimeGraph.
function RadioTimeGraph_Callback(hObject, eventdata, handles)

set(handles.RadioTimeGraph, 'Value', 1);
set(handles.EditTimeGraph, 'Enable', 'on');

set(handles.RadioScaleGraph, 'Value', 0);
set(handles.EditScaleGraph, 'Enable', 'off');

set(handles.ButtonView, 'Enable', 'on');


function EditTimeGraph_Callback(hObject, eventdata, handles)

fs = str2num(handles.constants.get('fs'));

signaltime = 0:1/fs:(length(handles.signal)-1)/fs;
RegisteredTime = max(signaltime);
TimeGraphValue = str2num(get(handles.EditTimeGraph, 'String'));

if (TimeGraphValue < 0)
    h = msgbox({'The time input' 'must be positive.'}, 'Error', 'warn');
    set(handles.EditTimeGraph, 'String', '0');
elseif (TimeGraphValue > RegisteredTime)
    h = msgbox({'The time input must be smaller' 'or equal the registered time.'},...
                'Error', 'warn');
    set(handles.EditTimeGraph, 'String', sprintf('%5.3f', RegisteredTime));
end

set(handles.ButtonView, 'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function EditTimeGraph_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditTimeGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ButtonView.
function ButtonView_Callback(hObject, eventdata, handles)

set(handles.ButtonView, 'Enable', 'off');

graph_coefficients(hObject, handles);



% --------------------------------------------------------------------
% --- Executes on button press in ButtonZoom.
function ButtonZoom_Callback(hObject, eventdata, handles)

fs = str2num(handles.constants.get('fs'));
signaltime = 0:1/fs:(length(handles.signal)-1)/fs;
RegisteredTime = max(signaltime);

switch get(handles.ButtonZoom, 'Value')
    case 1
        zoom;
    case 0
        zoom off;
        cax = gca;
        switch cax
            case handles.PlotAnalysis
                AnalysisLim = get(handles.PlotAnalysis, 'xlim');
                ProAnalysisLim = AnalysisLim/fs;
                if ProAnalysisLim(2) > RegisteredTime
                    ProAnalysisLim(2) = RegisteredTime;
                end
                set(handles.PlotSignal, 'xlim', ProAnalysisLim);
            case handles.PlotSignal
                SignalLim = get(handles.PlotSignal, 'xlim');
                if SignalLim(2) > RegisteredTime;
                    SignalLim(2) = RegisteredTime;
                end;
                    AnalysisLim = round(SignalLim*fs);
                    set(handles.PlotAnalysis, 'xlim', AnalysisLim);
        end
end


% --- Executes on button press in ButtonColorbar.
function ButtonColorbar_Callback(hObject, eventdata, handles)

switch get(handles.ButtonColorbar, 'Value')
    case 1
        axes(handles.PlotAnalysis);
        colorbar('southoutside', 'fontsize', 8);
    otherwise
        colorbar('off');
end


% --- Executes on button press in ButtonReset.
function ButtonReset_Callback(hObject, eventdata, handles)

if get(handles.ButtonReset, 'Value')
    selection = questdlg('Reset all the changes?', 'Reset', 'Yes', 'No', 'Yes');
    if strcmp(selection, 'Yes')
        reset_module(hObject, handles);
    end
end



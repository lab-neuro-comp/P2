function varargout = cwtmodule2(varargin)
% CWTMODULE2 M-file for cwtmodule2.fig
%      CWTMODULE2, by itself, creates a new CWTMODULE2 or raises the existing
%      singleton*.
%
%      H = CWTMODULE2 returns the handle to a new CWTMODULE2 or the handle to
%      the existing singleton*.
%
%      CWTMODULE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CWTMODULE2.M with the given input arguments.
%
%      CWTMODULE2('Property','Value',...) creates a new CWTMODULE2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cwtmodule2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cwtmodule2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cwtmodule2

% Last Modified by GUIDE v2.5 26-Aug-2016 09:46:43

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
addpath ([cd '/util']);
addpath ([cd '/math']);
% End initialization code - DO NOT EDIT

% --- Executes just before cwtmodule2 is made visible.
function cwtmodule2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cwtmodule2 (see VARARGIN)

% Choose default command line output for cwtmodule2
handles.output = hObject;
handles.constants = load_constants();
handles.wavelets = load_wavelets();

handles.approximations = {};
handles.details = {};

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using cwtmodule2.
%if strcmp(get(hObject,'Visible'),'off')
%    plot(rand(5));
%end

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

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;

popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        plot(rand(5));
    case 2
        plot(sin(1:0.01:25.99));
    case 3
        bar(1:.5:10);
    case 4
        plot(membrane);
    case 5
        surf(peaks);
end


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

%file = uigetfile('*.ascii');
%if ~isequal(file, 0)
%    open(file);
%end

fa = str2num(handles.constants.get('fa'));
fb = str2num(handles.constants.get('fb'));
fc = str2num(handles.constants.get('fc'));
fs = str2num(handles.constants.get('fs'));
[signalname, signalpath] = uigetfile('*.ascii', 'Choose the data file');

if ~isequal(signalname, 0)
    signal = (load(strcat(signalpath, signalname)) + fa)*fb - fc;
    signalname = signalname(1:length(signalname)-6);

    handles.signalname = signalname;
    handles.signal = signal;
    %handles.approximations = { };
    %handles.details = { };
    set(handles.TextFilename, 'String', signalname);
    %plot_decomposition(handles);
    axes(handles.PlotSignal);
    cla reset;
    %    set(handles.PlotSignal, 'XLabel', 'Amplitude [uV]');
    standard_plot(handles.signal, fs);
    grid(handles.PlotSignal, 'on');
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

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --------------------------------------------------------------------
% --- Executes on selection change in PopupWaveletType.
function PopupWaveletType_Callback(hObject, eventdata, handles)
% hObject    handle to PopupWaveletType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
biorvaropts={'1.1','1.3','1.5','2.2','2.4','2.6','2.8','3.1','3.3','3.5','3.7','3.9','4.4','5.5','6.8'};
rbiovaropts=biorvaropts;
gausvaropts={'1','2','3','4','5','6','7','8'};

contents = cellstr(get(hObject, 'String'));
wavelettype = contents{get(hObject, 'Value')};

switch wavelettype
    case 'Daubechies'
        set_subwaveopts_on(hObject, handles, dbvaropts);
        set(handles.TextSignal, 'String', 'db1');
        wavename = 'db1';
    case 'Symlets'
        set_subwaveopts_on(hObject, handles, symvaropts);
        set(handles.TextSignal, 'String', 'sym2');
        wavename = 'sym2';
    case 'Coiflets'
        set_subwaveopts_on(hObject, handles, coifvaropts);
        set(handles.TextSignal, 'String', 'coif1');
        wavename = 'coif1';
    case 'Biorthogonal'
        set_subwaveopts_on(hObject, handles, biorvaropts);
        set(handles.TextSignal, 'String', 'bior1.1');
        wavename = 'bior1.1';
    case 'R_Biorthogonal'
        set_subwaveopts_on(hObject, handles, rbiovaropts);
        set(handles.TextSignal, 'String', 'rbio1.1');
        wavename = 'rbio1.1';
    case 'Gaussian'
        set_subwaveopts_on(hObject, handles, gausvaropts);
        set(handles.TextSignal, 'String', 'gaus1');
        wavename = 'gaus1';
    otherwise
        set(handles.PopupWaveletVar, 'Visible', 'off');
        wavename = handles.wavelets.get(wavelettype);
        set(handles.TextSignal, 'String', wavename);
end

deltaf1 = str2num(handles.constants.get('deltaf1'));
set_scales_for_wavelets(hObject, handles, wavename, deltaf1);

% Hints: contents = get(hObject,'String') returns PopupWaveletType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopupWaveletType


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
% hObject    handle to PopupWaveletVar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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

set(handles.TextSignal, 'String', wavename);
deltaf1 = str2num(handles.constants.get('deltaf1'));
set_scales_for_wavelets(hObject, handles, wavename, deltaf1);

% Hints: contents = get(hObject,'String') returns PopupWaveletVar contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopupWaveletVar


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
% hObject    handle to RadioManual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disable_predet_opts(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of RadioManual


% --- Executes on button press in RadioPredet.
function RadioPredet_Callback(hObject, eventdata, handles)
% hObject    handle to RadioPredet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disable_manual_opts(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of RadioPredet


% --------------------------------------------------------------------
function EditMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

wavename = get(handles.TextSignal, 'String');

MinBase = centfrq(wavename)/0.5;
MinValue = str2num(get(handles.EditMin, 'String'));
MaxValue = str2num(get(handles.EditMax, 'String'));

if ((MinBase - MinValue) > 0.001)
    h = msgbox({'The minimum scale corresponds to a' 'pseudofrequency bigger than fs/2.'}, 'Error', 'warn');
    set(handles.EditMin, 'String', MinBase);
elseif (MinValue < 0)
    h = msgbox({'The minimum scale' 'must be positive.'}, 'Error', 'warn');
    set(handles.EditMin, 'String', MinBase);
elseif (MinValue > MaxValue)
    h = msgbox({'The minimum scale must be smaller' 'than the maximum scale.'}, 'Error', 'warn');
    set(handles.EditMin, 'String', MinBase);
end

% Hints: get(hObject,'String') returns contents of EditMin as text
%        str2double(get(hObject,'String')) returns contents of EditMin as a double


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
% hObject    handle to EditInt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

IntValue = str2num(get(handles.EditInt, 'String'));
MinValue = str2num(get(handles.EditMin, 'String'));
MaxValue = str2num(get(handles.EditMax, 'String'));

if (IntValue > (MaxValue - MinValue) | IntValue < 0)
    h = msgbox({'The interval must be positive and smaller than the' 'difference between the maximum and minimun scales.'}, 'Error', 'warn');
end

% Hints: get(hObject,'String') returns contents of EditInt as text
%        str2double(get(hObject,'String')) returns contents of EditInt as a double


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
% hObject    handle to EditMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fs = str2num(handles.constants.get('fs'));
deltaf1 = str2num(handles.constants.get('deltaf1'));
wavename = get(handles.TextSignal, 'String');

MaxBase = centfrq(wavename)/((1/fs)*deltaf1);
MinValue = str2num(get(handles.EditMin, 'String'));
MaxValue = str2num(get(handles.EditMax, 'String'));

if (MaxValue < 0)
    h = msgbox({'The maximum scale' 'must be positive.'}, 'Error', 'warn');
    set(handles.EditMin, 'String', MaxBase);
elseif (MinValue > MaxValue)
    h = msgbox({'The maximum scale must be bigger' 'than the minimum scale.'}, 'Error', 'warn');
    set(handles.EditMin, 'String', MaxBase);
end

% Hints: get(hObject,'String') returns contents of EditMax as text
%        str2double(get(hObject,'String')) returns contents of EditMax as a double


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
% hObject    handle to RadioDelta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

enable_predet_opt(hObject, handles);

deltaf1 = str2num(handles.constants.get('deltaf1'));
deltaf2 = str2num(handles.constants.get('deltaf2'));
wavename = get(handles.TextSignal, 'String');
set_predet_scales(hObject, handles, wavename, deltaf1, deltaf2);

%set_predet_scales(hObject, handles, wavename, deltaf1, deltaf2);

% Hint: get(hObject,'Value') returns toggle state of RadioDelta


% --- Executes on button press in RadioTheta.
function RadioTheta_Callback(hObject, eventdata, handles)
% hObject    handle to RadioTheta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

enable_predet_opt(hObject, handles);

thetaf1 = str2num(handles.constants.get('thetaf1'));
thetaf2 = str2num(handles.constants.get('thetaf2'));
wavename = get(handles.TextSignal, 'String');
set_predet_scales(hObject, handles, wavename, thetaf1, thetaf2);

% Hint: get(hObject,'Value') returns toggle state of RadioTheta


% --- Executes on button press in RadioAlpha.
function RadioAlpha_Callback(hObject, eventdata, handles)
% hObject    handle to RadioAlpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

enable_predet_opt(hObject, handles);

alphaf1 = str2num(handles.constants.get('alphaf1'));
alphaf2 = str2num(handles.constants.get('alphaf2'));
wavename = get(handles.TextSignal, 'String');
set_predet_scales(hObject, handles, wavename, alphaf1, alphaf2);

% Hint: get(hObject,'Value') returns toggle state of RadioAlpha


% --- Executes on button press in RadioBeta.
function RadioBeta_Callback(hObject, eventdata, handles)
% hObject    handle to RadioBeta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

enable_predet_opt(hObject, handles);

betaf1 = str2num(handles.constants.get('betaf1'));
betaf2 = str2num(handles.constants.get('betaf2'));
wavename = get(handles.TextSignal, 'String');
set_predet_scales(hObject, handles, wavename, betaf1, betaf2);

% Hint: get(hObject,'Value') returns toggle state of RadioBeta


% --- Executes on button press in RadioGamma.
function RadioGamma_Callback(hObject, eventdata, handles)
% hObject    handle to RadioGamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

enable_predet_opt(hObject, handles);

gammaf1 = str2num(handles.constants.get('gammaf1'));
gammaf2 = str2num(handles.constants.get('gammaf2'));
wavename = get(handles.TextSignal, 'String');
set_predet_scales(hObject, handles, wavename, gammaf1, gammaf2);

% Hint: get(hObject,'Value') returns toggle state of RadioGamma


% --------------------------------------------------------------------
% --- Executes on button press in ButtonCalculate.
function ButtonCalculate_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonCalculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

MinValue = str2num(get(handles.EditMin, 'String'));
IntValue = str2num(get(handles.EditInt, 'String'));
MaxValue = str2num(get(handles.EditMax, 'String'));
wavename = get(handles.TextSignal, 'String');

axes(handles.PlotAnalysis);
clear analysis;
analysis = cwt(handles.signal, MinValue:IntValue:MaxValue, wavename, 'plot');

set(handles.RadioScaleGraph, 'Enable', 'on');
set(handles.EditScaleGraph, 'Enable', 'on');
ScaleValue = get(handles.EditScale, 'String');
set(handles.EditScaleGraph, 'String', ScaleValue);

set(handles.RadioTimeGraph, 'Enable', 'on');
set(handles.EditTimeGraph, 'Enable', 'on');
set(handles.EditTimeGraph, 'String', '1');

set(handles.ButtonView, 'Enable', 'on');

set(handles.ButtonZoom, 'Enable', 'on');
set(handles.ButtonColorbar, 'Enable', 'on');
set(handles.ButtonReset, 'Enable', 'on');


% --------------------------------------------------------------------
function EditScale_Callback(hObject, eventdata, handles)
% hObject    handle to EditScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fs = str2num(handles.constants.get('fs'));
wavename = get(handles.TextSignal, 'String');

PsFreqBase = str2num(get(handles.EditPsFreq, 'String'));
ScaleBase = centfrq(wavename)/((1/fs)*PsFreqBase);
ScaleValue = str2num(get(handles.EditScale, 'String'));

if (ScaleValue < 0)
    h = msgbox({'The scale must' 'be positive.'}, 'Error', 'warn');
    set(handles.EditScale, 'String', ScaleBase);
end
PsFreqValue = centfrq(wavename)/((1/fs)*ScaleValue);
set(handles.EditPsFreq, 'String', sprintf('%5.2f', PsFreqValue));

% Hints: get(hObject,'String') returns contents of EditScale as text
%        str2double(get(hObject,'String')) returns contents of EditScale as a double


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
% hObject    handle to EditPsFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fs = str2num(handles.constants.get('fs'));
wavename = get(handles.TextSignal, 'String');

ScaleBase = str2num(get(handles.EditScale, 'String'));
PsFreqBase = centfrq(wavename)/((1/fs)*ScaleBase);
PsFreqValue = str2num(get(handles.EditPsFreq, 'String'));

if (PsFreqValue < 0)
    h = msgbox({'The pseudofrequency' 'must be positive.'}, 'Error', 'warn');
    set(handles.EditPsFreq, 'String', PsFreqBase);
end
ScaleValue = centfrq(wavename)/((1/fs)*PsFreqValue);
set(handles.EditScale, 'String', sprintf('%5.2f', ScaleValue));

% Hints: get(hObject,'String') returns contents of EditPsFreq as text
%        str2double(get(hObject,'String')) returns contents of EditPsFreq as a double


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
% hObject    handle to RadioScaleGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.RadioTimeGraph, 'Value', 0);

% Hint: get(hObject,'Value') returns toggle state of RadioScaleGraph


function EditScaleGraph_Callback(hObject, eventdata, handles)
% hObject    handle to EditScaleGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditScaleGraph as text
%        str2double(get(hObject,'String')) returns contents of EditScaleGraph as a double


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
% hObject    handle to RadioTimeGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.RadioScaleGraph, 'Value', 0);

% Hint: get(hObject,'Value') returns toggle state of RadioTimeGraph


function EditTimeGraph_Callback(hObject, eventdata, handles)
% hObject    handle to EditTimeGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fs = str2num(handles.constants.get('fs'));

signaltime = 0:1/fs:(length(handles.signalname)-1)/fs
RegisteredTime = max(signaltime)

% Hints: get(hObject,'String') returns contents of EditTimeGraph as text
%        str2double(get(hObject,'String')) returns contents of EditTimeGraph as a double


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
% hObject    handle to ButtonView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
% --- Executes on button press in ButtonZoom.
function ButtonZoom_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ButtonZoom


% --- Executes on button press in ButtonColorbar.
function ButtonColorbar_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonColorbar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ButtonColorbar


% --- Executes on button press in ButtonReset.
function ButtonReset_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



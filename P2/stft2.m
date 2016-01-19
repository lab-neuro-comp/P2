function varargout = stft2(varargin)
% STFT2 M-file for stft2.fig
%      STFT2, by itself, creates a new STFT2 or raises the existing
%      singleton*.
%
%      H = STFT2 returns the handle to a new STFT2 or the handle to
%      the existing singleton*.
%
%      STFT2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STFT2.M with the given input arguments.
%
%      STFT2('Property','Value',...) creates a new STFT2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stft2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stft2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stft2

% Last Modified by GUIDE v2.5 05-Jan-2016 08:34:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stft2_OpeningFcn, ...
                   'gui_OutputFcn',  @stft2_OutputFcn, ...
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

addpath([cd '/math']);
% End initialization code - DO NOT EDIT

% --- Executes just before stft2 is made visible.
function stft2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stft2 (see VARARGIN)

% Choose default command line output for stft2
handles.output = hObject;

% create handles
handles.spectra = {};
handles.names = {};
handles.intervals = {};
handles.durations = {};
handles.window = 'Hamming';
handles.windows = {'Hamming' 'Gaussian' 'Blackman' 'Hann' 'Kaiser'};

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = stft2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in ButtonPlot.
function ButtonPlot_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------

% --- Plots the current spectrum
function surface_plot(spectrum)
surfc(spectrum);

% --------------------------------------------------------------------
function [spectrum] = calculate_transform(signal, window, windowsize)
global fs

switch window
case 'Gaussian'
    windowfunction = @gausswin;
case 'Blackman'
    windowfunction = @blackman;
case 'Hann'
    windowfunction = @hann;
case 'Kaiser'
    windowfunction = @kaiser;
otherwise
    windowfunction = @hamming;
end

windowsize = floor(windowsize*fs);
spectrum = calcstft(signal, windowfunction(windowsize), windowsize);

% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fa fb fc fs
[signalname, signalpath] = uigetfile('*.ascii', 'Choose the data file');

if ~isequal(signalname, 0)
	signal = load(strcat(signalpath, signalname));
    signal = (signal + fa)*fb - fc;
    windowsize = str2num(get(handles.editWindowSize, 'String'));
    spectrum = calculate_transform(signal, handles.window, windowsize);
	signalname = signalname(1:length(signalname)-6);
	interval = 0:1/fs:(length(signal) - 1)/fs;
    duration = length(signal)/fs;

	handles.names{length(handles.names)+1} = signalname;
	handles.spectra{length(handles.spectra)+1} = spectrum;
	handles.intervals{length(handles.intervals)+1} = interval;
    handles.durations{length(handles.durations)+1} = duration;

    set(handles.popupSpectra, 'String', handles.names);
	if isequal(length(handles.spectra), 1)
		surface_plot(spectrum);
	end
end

guidata(hObject, handles);

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close STFT module?'],...
                     ['Close STFT module...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)

% --- Executes on selection change in popupSpectra.
function popupSpectra_Callback(hObject, eventdata, handles)
% hObject    handle to popupSpectra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject, 'String'));
signalname = contents{get(hObject, 'Value')};
spectrum = handles.spectra{needle_in_haystack(handles.names, signalname)};
surface_plot(spectrum);
guidata(hObject, handles);
% surface_plot(handles.spectra{needle_in_haystack(handles.names, cellstr(get(hObject, 'String')){get(hOjbect, 'Value')})});

% --- Executes during object creation, after setting all properties.
function popupSpectra_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupSpectra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'),...
                   get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function menuSettings_Callback(hObject, eventdata, handles)
% hObject    handle to menuSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuChangeWindow_Callback(hObject, eventdata, handles)
% hObject    handle to menuChangeWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuEEGRhythms_Callback(hObject, eventdata, handles)
% hObject    handle to menuEEGRhythms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rhythmconfig;


% --- Executes on selection change in popupWindow.
function popupWindow_Callback(hObject, eventdata, handles)
% hObject    handle to popupWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupWindow contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupWindow
contents = cellstr(get(hObject, 'String'));
switch contents{get(hObject, 'Value')}
case 'Gaussian'
    menuGaussian_Callback(hObject, eventdata, handles);
case 'Blackman'
    menuBlackman_Callback(hObject, eventdata, handles);
case 'Hann'
    menuHann_Callback(hObject, eventdata, handles);
case 'Kaiser'
    menuKaiser_Callback(hObject, eventdata, handles);
otherwise
    menuHamming_Callback(hObject, eventdata, handles);
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupWindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'Hamming' 'Gaussian' 'Blackman' 'Hann' 'Kaiser'});
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function textFrequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global fs
set(hObject, 'String', ['Frequency: ' num2str(fs)]);
guidata(hObject, handles);

% --------------------------------------------------------------------

function [handles] = deactivate_windows(hObject, handles)
set(handles.menuHamming, 'Checked', 'off');
set(handles.menuGaussian, 'Checked', 'off');
set(handles.menuBlackman, 'Checked', 'off');
set(handles.menuHann, 'Checked', 'off');
set(handles.menuKaiser, 'Checked', 'off');

% --------------------------------------------------------------------
function menuHamming_Callback(hObject, eventdata, handles)
handles = deactivate_windows(hObject, handles);
set(handles.menuHamming, 'Checked', 'on');
set(handles.popupWindow, 'Value', needle_in_haystack(handles.windows, 'Hamming'));
handles.window = 'Hamming';
guidata(hObject, handles);

% --------------------------------------------------------------------
function menuGaussian_Callback(hObject, eventdata, handles)
handles = deactivate_windows(hObject, handles);
set(handles.menuGaussian, 'Checked', 'on');
set(handles.popupWindow, 'Value', needle_in_haystack(handles.windows, 'Gaussian'));
handles.window = 'Gaussian';
guidata(hObject, handles);

% --------------------------------------------------------------------
function menuBlackman_Callback(hObject, eventdata, handles)
handles = deactivate_windows(hObject, handles);
set(handles.menuBlackman, 'Checked', 'on');
set(handles.popupWindow, 'Value', needle_in_haystack(handles.windows, 'Blackman'));
handles.window = 'Blackman';
guidata(hObject, handles);

% --------------------------------------------------------------------
function menuHann_Callback(hObject, eventdata, handles)
handles = deactivate_windows(hObject, handles);
set(handles.menuHann, 'Checked', 'on');
set(handles.popupWindow, 'Value', needle_in_haystack(handles.windows, 'Hann'));
handles.window = 'Hann';
guidata(hObject, handles);

% --------------------------------------------------------------------
function menuKaiser_Callback(hObject, eventdata, handles)
handles = deactivate_windows(hObject, handles);
set(handles.menuKaiser, 'Checked', 'on');
set(handles.popupWindow, 'Value', needle_in_haystack(handles.windows, 'Kaiser'));
handles.window = 'Kaiser';
guidata(hObject, handles);

% -------------------------------------------------------------------------------------
function editWindowSize_Callback(hObject, eventdata, handles)
% hObject    handle to editWindowSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editWindowSize as text
%        str2double(get(hObject,'String')) returns contents of editWindowSize as a double


% --- Executes during object creation, after setting all properties.
function editWindowSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWindowSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'),...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

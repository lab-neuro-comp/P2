function varargout = fourier2(varargin)
% FOURIER2 M-file for fourier2.fig
%      FOURIER2, by itself, creates a new FOURIER2 or raises the existing
%      singleton*.
%
%      H = FOURIER2 returns the handle to a new FOURIER2 or the handle to
%      the existing singleton*.
%
%      FOURIER2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOURIER2.M with the given input arguments.
%
%      FOURIER2('Property','Value',...) creates a new FOURIER2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fourier2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fourier2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fourier2

% Last Modified by GUIDE v2.5 23-Dec-2015 09:33:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fourier2_OpeningFcn, ...
                   'gui_OutputFcn',  @fourier2_OutputFcn, ...
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
% End initialization code - DO NOT EDIT

% --- Executes just before fourier2 is made visible.
function fourier2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fourier2 (see VARARGIN)

% Choose default command line output for fourier2
handles.spectra = {};
handles.signalnames = {};
handles.intervals = {};
handles.durations = {};
handles.plots = {};
handles.colors = {'r' 'b' 'g' 'c' 'm' 'y' 'k'};
handles.output = hObject;
handles.window = 'hamming';

if strcmp(get(hObject,'Visible'),'off')
    plot(0);
end

axes(handles.axes1);
cla;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fourier2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = fourier2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------------
function [index] = find_this_string(needle, haystack)
index = 1;
for hay = haystack
    hay
    if isequal(needle, hay)
        break;
    else
        index = index + 1;
    end
end

% --- Calculate the Fourier transform
function [spectrum] = calculate_fourier_transform(signal, window_name)
global fs fa fb fc

switch window_name
case 'hamming'
    ns = hamming(length(signal)) * signal;
otherwise
    spectrum = real(fft(signal));
    return
end

spectrum = real(fft(ns)) / length(signal);

% --- Executes on button press in buttonToggleSignal.
function buttonToggleSignal_Callback(hObject, eventdata, handles)
item = get(handles.listRecordings, 'Value');
handles.plots{item} = ~handles.plots{item};

plot(0);
hold all;
for index = 1:length(handles.plots)
    if handles.plots{index}
        context_plot(handles.spectra{index}, handles.colors{index});
    end
end
hold off;

guidata(hObject, handles);

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- gets that signal parameter
function [step] = get_step(signal)
global fs
step = 0:1/fs:(length(signal) - 1)/fs;

% --- Plots the current
function context_plot(signal, colour)
plot(get_step(signal), signal, colour);

% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
global fa fb fc fs
[signalname, signalpath] = uigetfile('*.ascii', 'Choose the data file');

if ~isequal(signalname, 0)
	signal = load(strcat(signalpath, signalname));
    signal = (signal + fa)*fb - fc;
    spectrum = calculate_fourier_transform(signal, handles.window);
	signalname = signalname(1:length(signalname)-6);
	interval = 0:1/fs:(length(signal) - 1)/fs;
    duration = length(signal)/fs;

	handles.signalnames{length(handles.signalnames)+1} = signalname;
	handles.spectra{length(handles.spectra)+1} = spectrum;
	handles.intervals{length(handles.intervals)+1} = interval;
    handles.plots{length(handles.plots)+1} = true;
    handles.durations{length(handles.durations)+1} = duration;

	set(handles.listRecordings, 'String', handles.signalnames);
	if isequal(length(handles.spectra), 1)
		context_plot(spectrum, handles.colors{1});
        set(handles.buttonToggleSignal, 'Enable', 'on');
        set(handles.buttonCalculatePower, 'Enable', 'on');
        set(handles.buttonExportPower, 'Enable', 'on');
        set(handles.labelPower, 'Enable', 'on');
	end
end

guidata(hObject, handles);

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close Fourier module?'],...
                     ['Closing Fourier''s module...'],...
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
if ispc && isequal(get(hObject,'BackgroundColor'),...
                   get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

% --------------------------------------------------------------------
function SettingsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to SettingsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function ChooseWindowMenu_Callback(hObject, eventdata, handles)
% hObject    handle to ChooseWindowMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function EEGMenu_Callback(hObject, eventdata, handles)
rhythmconfig;

% --------------------------------------------------------------------
function [handles] = deactivate_windows(hObject, handles)
set(handles.HammingWindowMenu, 'Checked', 'off');
set(handles.GaussianWindowMenu, 'Checked', 'off');
set(handles.BlackmanWindowMenu, 'Checked', 'off');
set(handles.HanningWindowMenu, 'Checked', 'off');
set(handles.KaiserWindowMenu, 'Checked', 'off');
set(handles.HannWindowMenu, 'Checked', 'off');

function HammingWindowMenu_Callback(hObject, eventdata, handles)
handles = deactivate_windows(hObject, handles);
set(handles.labelWindow, 'String', 'Window: Hamming');
handles.window = 'hamming';
set(hObject, 'Checked', 'on');
guidata(hObject, handles);

function GaussianWindowMenu_Callback(hObject, eventdata, handles)
handles = deactivate_windows(hObject, handles);
set(handles.labelWindow, 'String', 'Window: Gaussian');
handles.window = 'gaussian';
set(hObject, 'Checked', 'on');
guidata(hObject, handles);

function BlackmanWindowMenu_Callback(hObject, eventdata, handles)
handles = deactivate_windows(hObject, handles);
set(handles.labelWindow, 'String', 'Window: Blackman');
handles.window = 'blackman';
set(hObject, 'Checked', 'on');
guidata(hObject, handles);

function HanningWindowMenu_Callback(hObject, eventdata, handles)
handles = deactivate_windows(hObject, handles);
set(handles.labelWindow, 'String', 'Window: Hanning');
handles.window = 'hanning';
set(hObject, 'Checked', 'on');
guidata(hObject, handles);

function KaiserWindowMenu_Callback(hObject, eventdata, handles)
handles = deactivate_windows(hObject, handles);
set(handles.labelWindow, 'String', 'Window: Kaiser');
handles.window = 'kaiser';
set(hObject, 'Checked', 'on');
guidata(hObject, handles);

function HannWindowMenu_Callback(hObject, eventdata, handles)
handles = deactivate_windows(hObject, handles);
set(handles.labelWindow, 'String', 'Window: Hann');
handles.window = 'hann';
set(hObject, 'Checked', 'on');
guidata(hObject, handles);

% --- Executes on button press in buttonCalculatePower.
function [power] = calculate_power(spectrum, f1, f2)
global fs
f1p = round(f1*length(spectrum)/fs);
f2p = round(f2*length(spectrum)/fs);
power = 0;
for n = f1p:f2p
    power = power + spectrum(n).^2;
end

function [text] = generate_statistics(spectrum, signalname)
global fs deltaf1 deltaf2 thetaf1 thetaf2 alphaf1 alphaf2 betaf1 betaf2 gammaf1 gammaf2
signalinterval = length(spectrum) / fs;
deltapot = calculate_power(spectrum, deltaf1, deltaf2);
thetapot = calculate_power(spectrum, thetaf1, thetaf2);
alphapot = calculate_power(spectrum, alphaf1, alphaf2);
betapot = calculate_power(spectrum, betaf1, betaf2);
gammapot = calculate_power(spectrum, gammaf1, gammaf2);
total = 0;
for n = 1:length(spectrum)/2
    total = total + spectrum(n).^2;
end

text = {...
	['Signal: ' signalname];...
	['Interval: ' num2str(signalinterval)];...
    ['Delta: ' num2str(deltapot)];...
    ['Theta: ' num2str(thetapot)];...
    ['Alpha: ' num2str(alphapot)];...
    ['Beta: ' num2str(betapot)];...
    ['Gamma: ' num2str(gammapot)];...
	['Total: ' num2str(total)]};

function buttonCalculatePower_Callback(hObject, eventdata, handles)
set(handles.labelPower, 'Enable', 'on');
spectrum = handles.spectra{get(handles.listRecordings, 'Value')};
signalname = handles.signalnames{get(handles.listRecordings, 'Value')};
set(handles.labelPower, 'String', generate_statistics(spectrum, signalname));
guidata(hObject, handles);

% --- Executes on selection change in listRecordings.
function listRecordings_Callback(hObject, eventdata, handles)
% hObject    handle to listRecordings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listRecordings contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listRecordings


% --- Executes during object creation, after setting all properties.
function listRecordings_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listRecordings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function textFrequency_CreateFcn(hObject, eventdata, handles)
global fs
set(hObject, 'String', ['Frequency: ' num2str(fs)]);
guidata(hObject, handles);

% --- Executes on button press in buttonExportPower.
function buttonExportPower_Callback(hObject, eventdata, handles)
index = get(handles.listRecordings, 'Value');
spectrum = handles.spectra{index};
spectrum_name = handles.signalnames{index};
output = generate_statistics(spectrum, spectrum_name);

[filename pathname] = uiputfile('*.txt', 'Save statistics');
outlet = fopen([pathname filename], 'w');
for line = 1:length(output)
	fprintf(outlet, '%s\n', output{line});
end
fclose(outlet);

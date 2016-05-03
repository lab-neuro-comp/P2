function varargout = editionmodule2(varargin)
% EDITIONMODULE2 M-file for editionmodule2.fig
%      EDITIONMODULE2, by itself, creates a new EDITIONMODULE2 or raises the existing
%      singleton*.
%
%      H = EDITIONMODULE2 returns the handle to a new EDITIONMODULE2 or the handle to
%      the existing singleton*.
%
%      EDITIONMODULE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDITIONMODULE2.M with the given input arguments.
%
%      EDITIONMODULE2('Property','Value',...) creates a new EDITIONMODULE2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before editionmodule2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to editionmodule2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help editionmodule2

% Last Modified by GUIDE v2.5 11-Apr-2016 08:32:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @editionmodule2_OpeningFcn, ...
                   'gui_OutputFcn',  @editionmodule2_OutputFcn, ...
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

% --- Executes just before editionmodule2 is made visible.
function editionmodule2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to editionmodule2 (see VARARGIN)

% Choose default command line output for editionmodule2
handles.output = hObject;

% This sets up the initial plot - only do when we are invisible
% so window can get raised using editionmodule2.
if strcmp(get(hObject,'Visible'),'off')
    plot(0);
end

% Adding path
addpath(strcat(cd, '/util'));
addpath(strcat(cd, '/edition'));

% % Setup context variables
handles.current = [];
handles.v5signalname = '.ascii';
handles.signalnames = {};
handles.signals = {};
handles.constants = load_constants();

% UIWAIT makes editionmodule2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Update handles structure
guidata(hObject, handles);
% clc;

% --- Outputs from this function are returned to the command line.
function varargout = editionmodule2_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

% --- Executes on button press in plotbutton.
function plotbutton_Callback(hObject, eventdata, handles)
axes(handles.axes1);
xlabel('Time [s]');
ylabel('Amplitude [s]');
cla;

if length(handles.signals) > 0
	standard_plot(handles.signals{get(handles.popupmenu1, 'Value')});
end

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
fa = str2num(handles.constants.get('fa'));
fb = str2num(handles.constants.get('fb'));
fc = str2num(handles.constants.get('fc'));
fs = str2num(handles.constants.get('fs'));
[signalname, signalpath] = uigetfile('*.ascii', 'Choose the data file');

if ~isequal(signalname, 0)
	signal = load(strcat(signalpath, signalname));
    signal = (signal + fa)*fb - fc;
	signalname = signalname(1:length(signalname)-6);

	handles.signalnames{length(handles.signalnames)+1} = signalname;
	handles.signals{length(handles.signals)+1} = signal;
	set(handles.popupmenu1, 'String', handles.signalnames);
	if isequal(length(handles.signals), 1)
		standard_plot(signal, fs);
        handles.current = signal;
	end
end

guidata(hObject, handles);

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
selection = questdlg(['Close Time/Spec module?'],...
                     ['Close Time/Spec module...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end
delete(handles.figure1)

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
set(hObject, 'String', handles.signalnames);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'None'});

function tinitial_edit_Callback(hObject, eventdata, handles)
% hObject    handle to tinitial_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tinitial_edit as text
%        str2double(get(hObject,'String')) returns contents of tinitial_edit as a double


% --- Executes during object creation, after setting all properties.
function tinitial_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function tfinal_edit_Callback(hObject, eventdata, handles)
% hObject    handle to tfinal_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tfinal_edit as text
%        str2double(get(hObject,'String')) returns contents of tfinal_edit as a double


% --- Executes during object creation, after setting all properties.
function tfinal_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tfinal_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chopbutton.
function chopbutton_Callback(hObject, eventdata, handles)
global fs

tinitial = get(handles.tinitial_edit, 'String');
tfinal = get(handles.tfinal_edit, 'String');
beginning = str2num(tinitial);
ending = str2num(tfinal);

if beginning == 0
	beginning = beginning + 1;
end

if and(beginning, ending)
	if beginning >= ending
		warndlg('Initial time frame is bigger than final time frame');
	else
		index = get(handles.popupmenu1, 'Value');
		signal = chop_signal(handles.signals{index}, beginning, ending);
		standard_plot(signal);
        handles.current = signal;
		handles.signals{index} = signal;
	end
end
guidata(hObject, handles);

%-------------------------------------------------------------------------
function [handles] = disable_buttons(handles)
set(handles.lowpassbutton, 'Value', 0);
set(handles.highpassbutton, 'Value', 0);
set(handles.bandpassbutton, 'Value', 0);
set(handles.bandstopbutton, 'Value', 0);

% --- Executes on button press in lowpassbutton.
function lowpassbutton_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of lowpassbutton
handles = disable_buttons(handles);
set(handles.minedit, 'Enable', 'off');
set(handles.maxedit, 'Enable', 'on');
set(hObject, 'Value', 1);
guidata(hObject, handles);

% --- Executes on button press in highpassbutton.
function highpassbutton_Callback(hObject, eventdata, handles)
handles = disable_buttons(handles);
set(handles.minedit, 'Enable', 'on');
set(handles.maxedit, 'Enable', 'off');
set(hObject, 'Value', 1);
guidata(hObject, handles);

% --- Executes on button press in bandpassbutton.
function bandpassbutton_Callback(hObject, eventdata, handles)
handles = disable_buttons(handles);
set(handles.minedit, 'Enable', 'on');
set(handles.maxedit, 'Enable', 'on');
set(hObject, 'Value', 1);
guidata(hObject, handles);

% --- Executes on button press in bandstopbutton.
function bandstopbutton_Callback(hObject, eventdata, handles)
handles = disable_buttons(handles);
set(handles.minedit, 'Enable', 'on');
set(handles.maxedit, 'Enable', 'on');
set(hObject, 'Value', 1);
guidata(hObject, handles);

function minedit_Callback(hObject, eventdata, handles)
% ...

% --- Executes during object creation, after setting all properties.
function minedit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function maxedit_Callback(hObject, eventdata, handles)
% ...

% --- Executes during object creation, after setting all properties.
function maxedit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in filterbutton.
function filterbutton_Callback(hObject, eventdata, handles)
global fs;

fk = get_filter_kind(handles);
minimum = 0;
maximum = realmax;
if isequal(fk, 'highpass') || isequal(fk, 'bandpass') || isequal(fk, 'bandstop')
	minimum = str2num(get(handles.minedit, 'String'));
end
if isequal(fk, 'lowpass') || isequal(fk, 'bandpass') || isequal(fk, 'bandstop')
	maximum = str2num(get(handles.maxedit, 'String'));
end

if and(minimum, maximum)
	if minimum >= maximum
		warndlg('Minimum frequency is bigger than maximum frequency');
	elseif length(handles.signals) > 0
		signal = handles.signals{get(handles.popupmenu1, 'Value')};
		signal = filter_signal(signal, minimum, maximum, fk);
		handles.signals{get(handles.popupmenu1, 'Value')} = signal;
		standard_plot(signal);
        handles.current = signal;
	end
end

guidata(hObject, handles);


% --- Executes on button press in savebutton.
function savebutton_Callback(hObject, eventdata, handles)
% hObject    handle to savebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uiputfile('*.ascii', 'Save statistics');
if and(~isequal(filename, false), ~isequal(pathname, false))
    write_signal(handles.signals{get(handles.popupmenu1, 'Value')}, ...
                 strcat(pathname, filename));
end

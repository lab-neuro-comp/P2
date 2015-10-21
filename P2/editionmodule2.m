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

% Last Modified by GUIDE v2.5 21-Oct-2015 16:49:09

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

% % Setup context variables
% handles.edit_enable=1;
% handles.v5tipofiltro=1;
% handles.v5nedit=1;
% handles.v5tiniok=0;
% handles.v5fminok=0;
% handles.v5fmaxok=fs/2;
% handles.v5numsig=1;
% handles.v5refselect=0;
% handles.v5promon=0;
% handles.v5errorfile=0;
handles.v5signalname = '.ascii';
handles.signalnames = {};
handles.signals = {};

% UIWAIT makes editionmodule2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Update handles structure
guidata(hObject, handles);
% clc;

% --- Outputs from this function are returned to the command line.
function varargout = editionmodule2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in plotbutton.
function plotbutton_Callback(hObject, eventdata, handles)
% hObject    handle to plotbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
xlabel('Time [s]');
ylabel('Amplitude [s]');
cla;

if length(handles.signals) > 0
	plot(handles.signals{get(handles.popupmenu1, 'Value')});
end
% switch popup_sel_index
%     case 1
%         plot(rand(5));
%     case 2
%         plot(sin(1:0.01:25.99));
%     case 3
%         bar(1:.5:10);
%     case 4
%         plot(membrane);
%     case 5
%         surf(peaks);
% end

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

global fa fb fc fs
[signalname, signalpath] = uigetfile('*.ascii', 'Choose the data file');

if ~isequal(signalname, 0)
	signal = load(strcat(signalpath, signalname));
    signal = (signal + fa)*fb - fc;
	signalname = signalname(1:length(signalname)-6);

	v5t = 0:1/fs:(length(signal) - 1)/fs;
	v5treg = sprintf(' %5.2f', max(v5t));

	handles.signalnames{length(handles.signalnames)+1} = signalname;
	handles.signals{length(handles.signals)+1} = signal;
	set(handles.popupmenu1, 'String', handles.signalnames);
	if isequal(length(handles.signals), 1)
		plot(handles.signals{1})
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
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close Time/Spec module?'],...
                     ['Close Time/Spec module...'],...
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

set(hObject, 'String', handles.signalnames);
guidata(hObject, handles);


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

% set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});
set(hObject, 'String', {'None'});



function tinitial_edit_Callback(hObject, eventdata, handles)
% hObject    handle to tinitial_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tinitial_edit as text
%        str2double(get(hObject,'String')) returns contents of tinitial_edit as a double


% --- Executes during object creation, after setting all properties.
function tinitial_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tinitial_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
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
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chopbutton.
function chopbutton_Callback(hObject, eventdata, handles)
% hObject    handle to chopbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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
		signal = handles.signals{get(handles.popupmenu1, 'Value')};
		signal = (signal(beginning:ending));
		plot(signal);
		handles.signals{get(handles.popupmenu1, 'Value')} = signal;
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

function [signal] = filter_signal(signal, minimum, maximum)


% --- Executes on button press in filterbutton.
function filterbutton_Callback(hObject, eventdata, handles)
minimum = str2num(get(handles.minedit, 'String'));
maximum = str2num(get(handles.maxedit, 'String'));

if and(minimum, maximum)
	if minimum >= maximum
		warndlg('Minimum frequency is bigger than maximum frequency');
	else if length(handles.signals) > 0
		signal = handles.signals{get(handles.popupmenu1, 'Value')}
		signal = filter_signal(signal, minimum, maximum);
	end
end

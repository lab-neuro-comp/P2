function varargout = eegcutmodule(varargin)
% EEGCUTMODULE M-file for eegcutmodule.fig
%      EEGCUTMODULE, by itself, creates a new EEGCUTMODULE or raises the existing
%      singleton*.
%
%      H = EEGCUTMODULE returns the handle to a new EEGCUTMODULE or the handle to
%      the existing singleton*.
%
%      EEGCUTMODULE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EEGCUTMODULE.M with the given input arguments.
%
%      EEGCUTMODULE('Property','Value',...) creates a new EEGCUTMODULE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before eegcutmodule_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to eegcutmodule_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help eegcutmodule

% Last Modified by GUIDE v2.5 14-Dec-2016 10:35:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @eegcutmodule_OpeningFcn, ...
                   'gui_OutputFcn',  @eegcutmodule_OutputFcn, ...
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


% --- Executes just before eegcutmodule is made visible.
function eegcutmodule_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to eegcutmodule (see VARARGIN)

% Choose default command line output for eegcutmodule
handles.output = hObject;
handles.edfinfo = varargin{1};

% Update handles structure
channels = char(handles.edfinfo.getLabels());
set(handles.listChannels, 'String', channels);
handles.channels = channels;
guidata(hObject, handles);

% UIWAIT makes eegcutmodule wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = eegcutmodule_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
close(handles.figure1);


% --- Executes on selection change in listChannels.
function listChannels_Callback(hObject, eventdata, handles)
% hObject    handle to listChannels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listChannels contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listChannels

channels = handles.channels;
maxlist = length(channels);
set(handles.listChannels, 'Max', maxlist);


% --- Executes during object creation, after setting all properties.
function listChannels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listChannels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonOk.
function buttonOk_Callback(hObject, eventdata, handles)
% hObject    handle to buttonOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selection = questdlg({'The selected channels will be cut.',...
					   'Do you wish to continue?'},...
					 ['Cut selected channels?'],...
					 'Ok','Cancel','Ok');
if strcmp(selection,'Cancel')
	return;
end

toBeCut = get(handles.listChannels, 'Value');
handles.output = toBeCut;
guidata(hObject, handles);
uiresume(handles.figure1);


% --- Executes on button press in buttonCancel.
function buttonCancel_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

empty = [];
handles.output = empty;
guidata(hObject, handles);
uiresume(handles.figure1);


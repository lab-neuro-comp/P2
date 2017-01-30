function varargout = pickChannels(varargin)
% PICKCHANNELS M-file for pickChannels.fig
%      PICKCHANNELS, by itself, creates a new PICKCHANNELS or raises the existing
%      singleton*.
%
%      H = PICKCHANNELS returns the handle to a new PICKCHANNELS or the handle to
%      the existing singleton*.
%
%      PICKCHANNELS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PICKCHANNELS.M with the given input arguments.
%
%      PICKCHANNELS('Property','Value',...) creates a new PICKCHANNELS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pickChannels_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pickChannels_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pickChannels

% Last Modified by GUIDE v2.5 30-Jan-2017 13:45:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pickChannels_OpeningFcn, ...
                   'gui_OutputFcn',  @pickChannels_OutputFcn, ...
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


% --- Executes just before pickChannels is made visible.
function pickChannels_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pickChannels (see VARARGIN)

% Choose default command line output for pickChannels
handles.output = hObject;
handles.labels = varargin{1};

% Setup UI
set(handles.listboxLabels, 'String', cell(handles.labels));
set(handles.listboxLabels, 'Max', length(handles.labels));
set(handles.listboxLabels, 'Min', 0);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pickChannels wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pickChannels_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
close(handles.figure1);

% --- Executes on selection change in listboxLabels.
function listboxLabels_Callback(hObject, eventdata, handles)
% hObject    handle to listboxLabels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listboxLabels contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxLabels

% --- Executes during object creation, after setting all properties.
function listboxLabels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxLabels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject, 'BackgroundColor'), ...
                   get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on button press in pushbuttonOk.
function pushbuttonOk_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%TODO Implement Ok button
contents = get(handles.listboxLabels, 'String');
indexes = get(handles.listboxLabels, 'Value');
labels = { };

for index = indexes
    labels{end+1} = contents{index};
end

handles.output = labels;
guidata(hObject, handles);
uiresume(handles.figure1);

% --- Executes on button press in pushbuttonCancel.
function pushbuttonCancel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = { };
guidata(hObject, handles);
uiresume(handles.figure1);

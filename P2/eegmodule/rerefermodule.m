function varargout = rerefermodule(varargin)
% 

% Edit the above text to modify the response to help rerefermodule

% Last Modified by GUIDE v2.5 14-Dec-2016 11:00:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rerefermodule_OpeningFcn, ...
                   'gui_OutputFcn',  @rerefermodule_OutputFcn, ...
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


% --- Executes just before rerefermodule is made visible.
function rerefermodule_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rerefermodule (see VARARGIN)

% Choose default command line output for rerefermodule
handles.output = hObject;
handles.edfinfo = varargin{1};

% Update handles structure
channels = char(handles.edfinfo.getLabels());
set(handles.listChannels, 'String', channels);
handles.channels = channels;
guidata(hObject, handles);

% UIWAIT makes rerefermodule wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rerefermodule_OutputFcn(hObject, eventdata, handles) 
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

selection = questdlg({'The selected channels will be used to rerefering.',...
					  'Do you wish to continue?'},...
					 ['Use selected channel to rerefering?'],...
					 'Ok','Cancel','Ok');
if strcmp(selection,'Cancel')
	return;
end

toBeRerefered = get(handles.listChannels, 'Value');
handles.output = toBeRerefered;
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


function varargout = removemodule(varargin)
% This module allows the user to choose which channels  will be cut.
% The user can select (Ctrl+click or Shift+click for multiselection)
% which channels they wish to exclude once the confirmation button
% is pressed.
%

% Edit the above text to modify the response to help removemodule

% Last Modified by GUIDE v2.5 14-Dec-2016 11:17:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @removemodule_OpeningFcn, ...
                   'gui_OutputFcn',  @removemodule_OutputFcn, ...
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


% --- Executes just before removemodule is made visible.
function removemodule_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to removemodule (see VARARGIN)

% Choose default command line output for removemodule
handles.output = hObject;
handles.edfinfo = varargin{1};

% Update handles structure
channels = char(handles.edfinfo.getLabels());
set(handles.listChannels, 'String', channels);
handles.channels = channels;
guidata(hObject, handles);

% UIWAIT makes removemodule wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = removemodule_OutputFcn(hObject, eventdata, handles) 
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


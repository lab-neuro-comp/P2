function varargout = plot_stuff(varargin)
% PLOT_STUFF M-file for plot_stuff.fig
%      PLOT_STUFF, by itself, creates a new PLOT_STUFF or raises the existing
%      singleton*.
%
%      H = PLOT_STUFF returns the handle to a new PLOT_STUFF or the handle to
%      the existing singleton*.
%
%      PLOT_STUFF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_STUFF.M with the given input arguments.
%
%      PLOT_STUFF('Property','Value',...) creates a new PLOT_STUFF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_stuff_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_stuff_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plot_stuff

% Last Modified by GUIDE v2.5 28-Sep-2016 10:48:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_stuff_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_stuff_OutputFcn, ...
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
% ME OBRIGUE

% --- Executes just before plot_stuff is made visible.
function plot_stuff_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_stuff (see VARARGIN)

% Choose default command line output for plot_stuff
disp('opening function');
handles.output = hObject;
handles.files = varargin{1};
handles.stuff = varargin{2};

% Update handles structure
set(handles.popupmenuFiles, 'String', handles.files);
guidata(hObject, handles);

% UIWAIT makes plot_stuff wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_stuff_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
varargout{2} = handles.stuff; % TODO Check when these objects are returned

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
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

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


% --------------------------------------------------------------------
% --- Executes on selection change in popupmenuFiles.
function popupmenuFiles_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenuFiles contents 
%                                         as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuFiles

contents = cellstr(get(hObject, 'String'));
filename = contents{get(hObject, 'Value')};
moments = handles.stuff.get(filename);
set(handles.listboxMoments, 'String', moments);

axes(handles.axes1);
reset(gca);
[record, fs, nbits] = wavread(filename);
step = 0:(1/fs):(length(record)/fs);
hold on;
plot(step(2:length(step)), record);


% --- Executes during object creation, after setting all properties.
function popupmenuFiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in listboxMoments.
function listboxMoments_Callback(hObject, eventdata, handles)
% hObject    handle to listboxMoments (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = cellstr(get(handles.popupmenuFiles, 'String'));
filename = contents{get(handles.popupmenuFiles, 'Value')};
moments = handles.stuff.get(filename);
maxlist = numel(moments);
set(handles.listboxMoments, 'Max', maxlist);


% --- Executes during object creation, after setting all properties.
function listboxMoments_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxMoments (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



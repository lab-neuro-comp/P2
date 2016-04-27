function varargout = edfp2ascii(varargin)
% EDFP2ASCII M-file for edfp2ascii.fig
%      EDFP2ASCII, by itself, creates a new EDFP2ASCII or raises the existing
%      singleton*.
%
%      H = EDFP2ASCII returns the handle to a new EDFP2ASCII or the handle to
%      the existing singleton*.
%
%      EDFP2ASCII('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDFP2ASCII.M with the given input arguments.
%
%      EDFP2ASCII('Property','Value',...) creates a new EDFP2ASCII or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before edfp2ascii_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to edfp2ascii_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help edfp2ascii

% Last Modified by GUIDE v2.5 28-Mar-2016 10:29:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @edfp2ascii_OpeningFcn, ...
                   'gui_OutputFcn',  @edfp2ascii_OutputFcn, ...
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


% --- Executes just before edfp2ascii is made visible.
function edfp2ascii_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to edfp2ascii (see VARARGIN)

% Choose default command line output for edfp2ascii
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes edfp2ascii wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% adding relevant paths
addpath('./edfp2ascii');


% --- Outputs from this function are returned to the command line.
function varargout = edfp2ascii_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkMultiple.
function checkMultiple_Callback(hObject, eventdata, handles)
% hObject    handle to checkMultiple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMultiple



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject, 'BackgroundColor', 'white');
else
    set(hObject, ...
        'BackgroundColor', ...
        get(0, 'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in buttonTranslate.
function buttonTranslate_Callback(hObject, eventdata, handles)
% hObject    handle to buttonTranslate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject, 'String', 'Translating...');
ok = translate_edf2ascii(get(handles.editInput, 'String'), ...
                         ~get(handles.checkMultiple, 'Value'));
set(hObject, 'String', 'Translate');
if isequal(ok, 0)
    msgbox('Translation done! :)');
else
    errordlg('Something went wrong! :(');
end

% --- Executes on button press in buttonSearch.
function buttonSearch_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname filterindex] = uigetfile('*.edf');
if ~isequal(filename, 0)
    set(handles.editInput, 'String', [pathname filename]);
end

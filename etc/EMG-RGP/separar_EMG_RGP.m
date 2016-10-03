function varargout = separar_EMG_RGP(varargin)
% SEPARAR_EMG_RGP M-file for separar_EMG_RGP.fig
%      SEPARAR_EMG_RGP, by itself, creates a new SEPARAR_EMG_RGP or raises the existing
%      singleton*.
%
%      H = SEPARAR_EMG_RGP returns the handle to a new SEPARAR_EMG_RGP or the handle to
%      the existing singleton*.
%
%      SEPARAR_EMG_RGP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEPARAR_EMG_RGP.M with the given input arguments.
%
%      SEPARAR_EMG_RGP('Property','Value',...) creates a new SEPARAR_EMG_RGP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before separar_EMG_RGP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to separar_EMG_RGP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help separar_EMG_RGP

% Last Modified by GUIDE v2.5 03-Oct-2016 08:48:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @separar_EMG_RGP_OpeningFcn, ...
                   'gui_OutputFcn',  @separar_EMG_RGP_OutputFcn, ...
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


% --- Executes just before separar_EMG_RGP is made visible.
function separar_EMG_RGP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to separar_EMG_RGP (see VARARGIN)

% Choose default command line output for separar_EMG_RGP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes separar_EMG_RGP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = separar_EMG_RGP_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editFiles_Callback(hObject, eventdata, handles)
% hObject    handle to editFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFiles as text
%        str2double(get(hObject,'String')) returns contents of editFiles as a double


% --- Executes during object creation, after setting all properties.
function editFiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject, 'BackgroundColor'), ...
                   get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end


% --- Executes on button press in pushbuttonSearch.
function pushbuttonSearch_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonRun.
function pushbuttonRun_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

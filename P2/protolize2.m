function varargout = protolize2(varargin)
% PROTOLIZE2 M-file for protolize2.fig
%
% Protolize! is an educational biological signal processing suite for MATLAB,
% developed at the Laboratory of Neuroscience and Behaviour from the University
% of Brasilia. This function will call the main window, enabling the user to
% access its modules and tools at a glance.
%

% Last Modified by GUIDE v2.5 28-Mar-2017 14:36:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @protolize2_OpeningFcn, ...
                   'gui_OutputFcn',  @protolize2_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before protolize2 is made visible.
function protolize2_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for protolize2
handles.output = hObject;

% Defining some handles for the program
handles.constants = load_constants();

% Update handles structure
set(handles.figure1, 'Name', 'Protolize 2 v1.0b');
guidata(hObject, handles);


% UIWAIT makes protolize2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = protolize2_OutputFcn(hObject, eventdata, handles)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
% --- Executes on button press in eegprocessbut.
function eegprocessbut_Callback(hObject, eventdata, handles)
eegmodule2;

% --- Executes on button press in studymapbut.
function studymapbut_Callback(hObject, eventdata, handles)
studymodule;

% --- Executes on button press in emgrgpbut.
function emgrgpbut_Callback(hObject, eventdata, handles)
emgrgpmodule2;

% --- Executes on button press in singleprocessbut.
function singleprocessbut_Callback(hObject, eventdata, handles)
emgmodule2;

% --- Executes on button press in voicerecogbut.
function voicerecogbut_Callback(hObject, eventdata, handles)
voicemodule2;

% --- Executes on button press in voicecompbut.
function voicecompbut_Callback(hObject, eventdata, handles)
comparemodule2;

% --- Executes on button press in edfconvbut.
function edfconvbut_Callback(hObject, eventdata, handles)
edfconverter;


% --------------------------------------------------------------------
% --- Executes on button press in timespecbut.
function timespecbut_Callback(hObject, eventdata, handles)
editionmodule2;

% --- Executes on button press in dwtbut.
function dwtbut_Callback(hObject, eventdata, handles)
dwtmodule2;


% --------------------------------------------------------------------
% --- Executes on button press in timedombut.
function timedombut_Callback(hObject, eventdata, handles)
timemodule2;

% --- Executes on button press in fourierbut.
function fourierbut_Callback(hObject, eventdata, handles)
fourier2; % done but needs some changes

% --- Executes on button press in stftbut.
function stftbut_Callback(hObject, eventdata, handles)
stft2; % under construction

% --- Executes on button press in cwtbut.
function cwtbut_Callback(hObject, eventdata, handles)
cwtmodule2;

% --- Executes on button press in ecgbut.
function ecgbut_Callback(hObject, eventdata, handles)
ecgmodule; % needs to be checked


% --------------------------------------------------------------------
function mainfnc_Callback(hObject, eventdata, handles)
% Does nothing


% --------------------------------------------------------------------
function mainexit_Callback(hObject, eventdata, handles)
close;
clear;
clc;
cd ..


% --------------------------------------------------------------------
function mainhelp_Callback(hObject, eventdata, handles)
% Does nothing

% --------------------------------------------------------------------
function paramconfig_main_Callback(hObject, eventdata, handles)
paramconfig;

%---------------------------------------------------------------------
function mainconfig_Callback(hObject, eventData, handles)
% Does nothing


% --------------------------------------------------------------------
function settings_main_Callback(hObject, eventdata, handles)
% Does nothing


% --------------------------------------------------------------------
function rhythmconfig_main_Callback(hObject, eventdata, handles)
rhythmconfig;

% --------------------------------------------------------------------
function docmain_Callback(hObject, eventdata, handles)
web('file:///', cd, 'doc.html');

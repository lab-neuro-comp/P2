function varargout = protolize2(varargin)
% PROTOLIZE2 M-file for protolize2.fig
%      PROTOLIZE2, by itself, creates a new PROTOLIZE2 or raises the existing
%      singleton*.
%
%      H = PROTOLIZE2 returns the handle to a new PROTOLIZE2 or the handle to
%      the existing singleton*.
%
%      PROTOLIZE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROTOLIZE2.M with the given input arguments.
%
%      PROTOLIZE2('Property','Value',...) creates a new PROTOLIZE2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before protolize2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to protolize2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help protolize2

% Last Modified by GUIDE v2.5 08-Oct-2015 10:04:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @protolize2_OpeningFcn, ...
                   'gui_OutputFcn',  @protolize2_OutputFcn, ...
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


% --- Executes just before protolize2 is made visible.
function protolize2_OpeningFcn(hObject, eventdata, handles, varargin)
global deltaf1 deltaf2 thetaf1 thetaf2 alphaf1 alphaf2 betaf1 betaf2 gammaf1 gammaf2 fa fb fc fs frhzoom hfourier pcalc
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to protolize2 (see VARARGIN)

% Choose default command line output for protolize2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% SETUP GLOBALS
deltaf1=0.5;
deltaf2=3.5;
thetaf1=3.5;
thetaf2=7;
alphaf1=8;
alphaf2=13;
betaf1=15;
betaf2=24;
gammaf1=30;
gammaf2=70;
fs=200;
fa=4096;
fb=0.0610426077402027;
fc=250;

% UIWAIT makes protolize2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = protolize2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in timedombut.
function timedombut_Callback(hObject, eventdata, handles)
% hObject    handle to timedombut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
timemodule2;

% --- Executes on button press in fourierbut.
function fourierbut_Callback(hObject, eventdata, handles)
% hObject    handle to fourierbut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fourier2; % done but needs some changes

% --- Executes on button press in stftbut.
function stftbut_Callback(hObject, eventdata, handles)
% hObject    handle to stftbut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stft2; % under construction

% --- Executes on button press in cwtbut.
function cwtbut_Callback(hObject, eventdata, handles)
% hObject    handle to cwtbut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cwtmodule; % imported from P1 % does not work

% --- Executes on button press in ecgbut.
function ecgbut_Callback(hObject, eventdata, handles)
% hObject    handle to ecgbut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ecgmodule; % needs to be checked

% --- Executes on button press in timespecbut.
function timespecbut_Callback(hObject, eventdata, handles)
% hObject    handle to timespecbut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
editionmodule2;

% --- Executes on button press in dwtbut.
function dwtbut_Callback(hObject, eventdata, handles)
% hObject    handle to dwtbut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dwtmodule2; % under construction

% --- Executes on button press in tsstbut.
function tsstbut_Callback(hObject, eventdata, handles)
% hObject    handle to tsstbut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tsstmodule; % apparently missing

% --- Executes on button press in reflexbut.
function reflexbut_Callback(hObject, eventdata, handles)
% hObject    handle to reflexbut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% % show global variables
% global fs fa fb fc
% fprintf('%f %f %f %f\n', fs, fa, fb, fc);

% --------------------------------------------------------------------
function mainfnc_Callback(hObject, eventdata, handles)
% hObject    handle to mainfnc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mainexit_Callback(hObject, eventdata, handles)
% hObject    handle to mainexit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
clear;
clc;


% --------------------------------------------------------------------
function mainhelp_Callback(hObject, eventdata, handles)
% hObject    handle to mainhelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function paramconfig_main_Callback(hObject, eventdata, handles)
% hObject    handle to paramconfig_main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
paramconfig;

%---------------------------------------------------------------------
function mainconfig_Callback(hObject, eventData, handles)
% hObject    handle to mainconfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function settings_main_Callback(hObject, eventdata, handles)
% hObject    handle to settings_main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function rhythmconfig_main_Callback(hObject, eventdata, handles)
% hObject    handle to rhythmconfig_main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rhythmconfig;

% --------------------------------------------------------------------
function docmain_Callback(hObject, eventdata, handles)
% hObject    handle to docmain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('file:///', cd, 'doc.html');

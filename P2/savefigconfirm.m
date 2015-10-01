function varargout = savefigconfirm(varargin)
% SAVEFIGCONFIRM M-file for savefigconfirm.fig
%      SAVEFIGCONFIRM, by itself, creates a new SAVEFIGCONFIRM or raises the existing
%      singleton*.
%
%      H = SAVEFIGCONFIRM returns the handle to a new SAVEFIGCONFIRM or the handle to
%      the existing singleton*.
%
%      SAVEFIGCONFIRM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAVEFIGCONFIRM.M with the given input arguments.
%
%      SAVEFIGCONFIRM('Property','Value',...) creates a new SAVEFIGCONFIRM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before savefigconfirm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to savefigconfirm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help savefigconfirm

% Last Modified by GUIDE v2.5 07-May-2009 16:05:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @savefigconfirm_OpeningFcn, ...
                   'gui_OutputFcn',  @savefigconfirm_OutputFcn, ...
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


% --- Executes just before savefigconfirm is made visible.
function savefigconfirm_OpeningFcn(hObject, eventdata, handles, varargin)

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to savefigconfirm (see VARARGIN)

% Choose default command line output for savefigconfirm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
grid on
% UIWAIT makes savefigconfirm wait for user response (see UIRESUME)
% uiwait(handles.savefig);


% --- Outputs from this function are returned to the command line.
function varargout = savefigconfirm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in savefigyes.
function savefigyes_Callback(hObject, eventdata, handles)
% hObject    handle to savefigyes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axeposition=get(handles.savefigaxes,'position');
axeposition(2)=0.1;
axeposition(4)=0.83;
set(handles.savefigaxes,'position',axeposition);
set([handles.question handles.savefigyes handles.savefigno],'visible','off')
[figfile figpath]=uiputfile('*.jpg','Save Figure');
print(handles.savefig,'-djpeg',strcat(figpath,figfile))
close(handles.savefig)

% --- Executes on button press in savefigno.
function savefigno_Callback(hObject, eventdata, handles)
% hObject    handle to savefigno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.savefig)


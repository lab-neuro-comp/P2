function varargout = studiesmodule(varargin)
% STUDIESMODULE M-file for studiesmodule.fig
%      STUDIESMODULE, by itself, creates a new STUDIESMODULE or raises the existing
%      singleton*.
%
%      H = STUDIESMODULE returns the handle to a new STUDIESMODULE or the handle to
%      the existing singleton*.
%
%      STUDIESMODULE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STUDIESMODULE.M with the given input arguments.
%
%      STUDIESMODULE('Property','Value',...) creates a new STUDIESMODULE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before studiesmodule_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to studiesmodule_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help studiesmodule

% Last Modified by GUIDE v2.5 25-Apr-2016 09:46:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @studiesmodule_OpeningFcn, ...
                   'gui_OutputFcn',  @studiesmodule_OutputFcn, ...
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


% --- Executes just before studiesmodule is made visible.
function studiesmodule_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to studiesmodule (see VARARGIN)

% Choose default command line output for studiesmodule
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes studiesmodule wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = studiesmodule_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listActions.
function listActions_Callback(hObject, eventdata, handles)
% hObject    handle to listActions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') 
%            returns listActions contents as cell array                                        
%        contents{get(hObject,'Value')} 
%            returns selected item from listActions


% --- Executes during object creation, after setting all properties.
function listActions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listActions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject, ...
        'BackgroundColor', ...
        'white');
else
    set(hObject, ...
        'BackgroundColor', ...
        get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in buttonAdd. -------------------------
function buttonAdd_Callback(hObject, eventdata, handles)
% hObject    handle to buttonAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonRun. -------------------------
function buttonRun_Callback(hObject, eventdata, handles)
% hObject    handle to buttonRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuNew_Callback(hObject, eventdata, handles)
% hObject    handle to menuNew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuSave_Callback(hObject, eventdata, handles)
% hObject    handle to menuSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuLoad_Callback(hObject, eventdata, handles)
% hObject    handle to menuLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuQuit_Callback(hObject, eventdata, handles)
% hObject    handle to menuQuit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuRun_Callback(hObject, eventdata, handles)
% hObject    handle to menuRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuFile_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Common UI functions --------------------------------------------

% Run callback
function [outlet] = run_view(handles)
outlet = '';

% 

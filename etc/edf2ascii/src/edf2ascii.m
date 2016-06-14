function varargout = edf2ascii(varargin)
% EDF2ASCII M-file for edf2ascii.fig
%      EDF2ASCII, by itself, creates a new EDF2ASCII or raises the existing
%      singleton*.
%
%      H = EDF2ASCII returns the handle to a new EDF2ASCII or the handle to
%      the existing singleton*.
%
%      EDF2ASCII('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDF2ASCII.M with the given input arguments.
%
%      EDF2ASCII('Property','Value',...) creates a new EDF2ASCII or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before edf2ascii_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to edf2ascii_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help edf2ascii

% Last Modified by GUIDE v2.5 07-Mar-2016 09:28:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @edf2ascii_OpeningFcn, ...
                   'gui_OutputFcn',  @edf2ascii_OutputFcn, ...
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

addpath('./convert_edf2ascii');
% End initialization code - DO NOT EDIT


% --- Executes just before edf2ascii is made visible.
function edf2ascii_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to edf2ascii (see VARARGIN)

% Choose default command line output for edf2ascii
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes edf2ascii wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = edf2ascii_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editInput_Callback(hObject, eventdata, handles)
% hObject    handle to editInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInput as text
%        str2double(get(hObject,'String')) returns contents of editInput as a double


% --- Executes during object creation, after setting all properties.
function editInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in buttonSelect.
function buttonSelect_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname filterindex] = uigetfile('*.edf');
if ~isequal(filename, 0)
    set(handles.editInput, 'String', [pathname filename]);
end

% --- Executes on button press in buttonConvert.
function buttonConvert_Callback(hObject, eventdata, handles)
msgbox(elvis(isequal(convert_edf2ascii(get(handles.editInput, 'String')), 0), 'File converted!', 'ERROR'));

function [outlet] = elvis(predicate, trueclause, falseclause)
if predicate; outlet = trueclause; else; outlet = falseclause; end;

function buttonConvert_Callback_Alternate(hObject, eventdata, handles)
inlet = get(handles.editInput, 'String');
dlg = @errordlg;
outlet = 'ERROR';
result = convert_edf2ascii(inlet);
if isequal(result, 0)
    outlet = 'File converted!';
    dlg = @msgbox;
end
dlg(outlet);

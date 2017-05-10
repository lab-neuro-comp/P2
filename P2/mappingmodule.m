function varargout = mappingmodule(varargin)
% MAPPINGMODULE M-file for mappingmodule.fig
%      MAPPINGMODULE, by itself, creates a new MAPPINGMODULE or raises the existing
%      singleton*.
%
%      H = MAPPINGMODULE returns the handle to a new MAPPINGMODULE or the handle to
%      the existing singleton*.
%
%      MAPPINGMODULE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAPPINGMODULE.M with the given input arguments.
%
%      MAPPINGMODULE('Property','Value',...) creates a new MAPPINGMODULE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mappingmodule_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mappingmodule_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mappingmodule

% Last Modified by GUIDE v2.5 09-May-2017 07:35:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mappingmodule_OpeningFcn, ...
                   'gui_OutputFcn',  @mappingmodule_OutputFcn, ...
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

addpath ([cd '/mappingmodule']);


% --- Executes just before mappingmodule is made visible.
function mappingmodule_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mappingmodule (see VARARGIN)

% Choose default command line output for mappingmodule
handles.output = hObject;

% Update handles structure
instruction = {};
instruction{1} = get(handles.textInst1, 'String');
instruction{2} = get(handles.textInst2, 'String');
instruction{3} = get(handles.textInst3, 'String');
instruction{4} = get(handles.textInst4, 'String');
instruction{5} = get(handles.textInst5, 'String');
instruction{6} = get(handles.textInst6, 'String');
instruction{7} = get(handles.textInst7, 'String');

handles.instruction = instruction;

instNumber = 1;
handles.instNumber = instNumber;

set(handles.figure1, 'Name', 'Mapping Module');
guidata(hObject, handles);

% UIWAIT makes mappingmodule wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mappingmodule_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in buttonFirst.
function buttonFirst_Callback(hObject, eventdata, handles)
% hObject    handle to buttonFirst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set([handles.buttonFirst handles.buttonPrevious], 'Enable', 'off');
set([handles.buttonNext handles.buttonLast], 'Enable', 'on');
instNumber = 1;
instruction = handles.instruction;
set(handles.textInst1, 'String', instruction{1});
handles.instNumber = instNumber;

guidata(hObject, handles);


% --- Executes on button press in buttonPrevious.
function buttonPrevious_Callback(hObject, eventdata, handles)
% hObject    handle to buttonPrevious (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set([handles.buttonNext handles.buttonLast], 'Enable', 'on');
instNumber = handles.instNumber;
instNumber = instNumber - 1;
instruction = handles.instruction;
set(handles.textInst1, 'String', instruction{instNumber});

if instNumber == 1
	set([handles.buttonFirst handles.buttonPrevious], 'Enable', 'off');
end
handles.instNumber = instNumber;
guidata(hObject, handles);


% --- Executes on button press in buttonNext.
function buttonNext_Callback(hObject, eventdata, handles)
% hObject    handle to buttonNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set([handles.buttonFirst handles.buttonPrevious], 'Enable', 'on');
instNumber = handles.instNumber;
instNumber = instNumber + 1;
instruction = handles.instruction;
set(handles.textInst1, 'String', instruction{instNumber});

if instNumber == length(instruction)
	set([handles.buttonNext handles.buttonLast], 'Enable', 'off');
end
handles.instNumber = instNumber;
guidata(hObject, handles);


% --- Executes on button press in buttonLast.
function buttonLast_Callback(hObject, eventdata, handles)
% hObject    handle to buttonLast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set([handles.buttonNext handles.buttonLast], 'Enable', 'off');
set([handles.buttonFirst handles.buttonPrevious], 'Enable', 'on');
instruction = handles.instruction;
instNumber = length(instruction);
set(handles.textInst1, 'String', instruction{instNumber});
handles.instNumber = instNumber;

guidata(hObject, handles);



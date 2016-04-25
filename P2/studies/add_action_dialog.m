function varargout = add_action_dialog(varargin)
% ADD_ACTION_DIALOG M-file for add_action_dialog.fig
%      ADD_ACTION_DIALOG, by itself, creates a new ADD_ACTION_DIALOG or raises the existing
%      singleton*.
%
%      H = ADD_ACTION_DIALOG returns the handle to a new ADD_ACTION_DIALOG or the handle to
%      the existing singleton*.
%
%      ADD_ACTION_DIALOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADD_ACTION_DIALOG.M with the given input arguments.
%
%      ADD_ACTION_DIALOG('Property','Value',...) creates a new ADD_ACTION_DIALOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before add_action_dialog_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to add_action_dialog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help add_action_dialog

% Last Modified by GUIDE v2.5 25-Mar-2002 12:19:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @add_action_dialog_OpeningFcn, ...
                   'gui_OutputFcn',  @add_action_dialog_OutputFcn, ...
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


% --- Executes just before add_action_dialog is made visible.
function add_action_dialog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to add_action_dialog (see VARARGIN)

% Choose default command line output for add_action_dialog
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes add_action_dialog wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = add_action_dialog_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function varargout = separar_EMG_RGP(varargin)
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

function separar_EMG_RGP_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = separar_EMG_RGP_OutputFcn(hObject, eventdata, handles)


function editFiles_Callback(hObject, eventdata, handles)


function editFiles_CreateFcn(hObject, eventdata, handles)


function pushbuttonSearch_Callback(hObject, eventdata, handles)


function pushbuttonRun_Callback(hObject, eventdata, handles)

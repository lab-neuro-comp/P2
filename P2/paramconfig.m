function varargout = paramconfig(varargin)
% PARAMCONFIG M-file for paramconfig.fig
%      PARAMCONFIG, by itself, creates a new PARAMCONFIG or raises the existing
%      singleton*.
%
%      H = PARAMCONFIG returns the handle to a new PARAMCONFIG or the handle to
%      the existing singleton*.
%
%      PARAMCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARAMCONFIG.M with the given input arguments.
%
%      PARAMCONFIG('Property','Value',...) creates a new PARAMCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before paramconfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to paramconfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help paramconfig

% Last Modified by GUIDE v2.5 20-Jun-2017 08:34:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @paramconfig_OpeningFcn, ...
                   'gui_OutputFcn',  @paramconfig_OutputFcn, ...
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


% --- Executes just before paramconfig is made visible.
function paramconfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to paramconfig (see VARARGIN)

% Choose default command line output for paramconfig
handles.output = hObject;

% UIWAIT makes paramconfig wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Write parameters from constants file here
handles.constants = load_constants();
set(handles.fa_edit, 'String', str2num(handles.constants.get('fa')));
set(handles.fb_edit, 'String', str2num(handles.constants.get('fb')));
set(handles.fc_edit, 'String', str2num(handles.constants.get('fc')));
set(handles.fs_edit, 'String', str2num(handles.constants.get('fs')));

% % Atempt to make fb_edit remember their previous value
% handles.fbprev = 0.061043;
% handles.fb = handles.fbprev;
% set(handles.fb, 'String', num2str(handles.fbprev));

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = paramconfig_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function fa_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fa_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fa_edit as text
%        str2double(get(hObject,'String')) returns contents of fa_edit as a double

% --- Executes during object creation, after setting all properties.
function fa_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fa_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global fa
set(hObject, 'String', fa);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function fb_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fb_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fb_edit as text
%        str2double(get(hObject,'String')) returns contents of fb_edit as a double

% raw = str2num(get(hObject, 'String'));
% set(handles.fb, 'String', num2str(raw));
% handles.fbprev = raw;
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function fb_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fb_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global fb

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'String', num2str(fb));

function fc_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fc_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fc_edit as text
%        str2double(get(hObject,'String')) returns contents of fc_edit as a double

% --- Executes during object creation, after setting all properties.
function fc_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fc_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global fc
set(hObject, 'String', num2str(fc));
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in updatebutton.
function updatebutton_Callback(hObject, eventdata, handles)
% hObject    handle to updatebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fs fa fb fc

fs = get(handles.fs_edit, 'String');
fa = get(handles.fa_edit, 'String');
fb = get(handles.fb_edit, 'String');
fc = get(handles.fc_edit, 'String');
% fprintf('%f %f %f %f\n', fs, fa, fb, fc);

handles.constants.put('fs', fs);
handles.constants.put('fa', fa);
handles.constants.put('fb', fb);
handles.constants.put('fc', fc);
save_constants(handles.constants);
close;

function fs_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fs_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fs_edit as text
%        str2double(get(hObject,'String')) returns contents of fs_edit as a double

% --- Executes during object creation, after setting all properties.
function fs_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fs_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global fs
set(hObject, 'String', fs);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in restorebutton.
function restorebutton_Callback(hObject, eventdata, handles)
% hObject    handle to restorebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fs fa fb fc

selection = questdlg([{'Once restored to default' 'the current values will be lost.' 'Do you wish to proceed?'}],...
                     ['Reset parameters values?'],...
                     'Yes','No','Yes');

if strcmp(selection,'Yes')
    handles.constants.put('fs', handles.constants.get('fs_default'));
    handles.constants.put('fa', handles.constants.get('fa_default'));
    handles.constants.put('fb', handles.constants.get('fb_default'));
    handles.constants.put('fc', handles.constants.get('fc_default'));
    save_constants(handles.constants);
    close;
else
    return;
end


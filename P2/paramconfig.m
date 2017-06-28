function varargout = paramconfig(varargin)
% Starts the window for changing some commonly used parameters in EEGLab.
%

% Last Modified by GUIDE v2.5 28-Jun-2017 09:10:01

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
handles.output = hObject;
handles.constants = load_constants();
set(handles.fa_edit, 'String', num2str(handles.constants.get('fa')));
set(handles.fb_edit, 'String', num2str(handles.constants.get('fb')));
set(handles.fc_edit, 'String', num2str(handles.constants.get('fc')));
set(handles.fs_edit, 'String', str2num(handles.constants.get('fs')));
set(handles.editeeglab, 'String', handles.constants.get('EEGLAB_PATH'));
set(handles.editlocations, 'String', handles.constants.get('LOCATIONS_PATH'));
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = paramconfig_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

% --- Does nothing
function fa_edit_Callback(hObject, eventdata, handles)
% DOING NOTHING

% --- Executes during object creation, after setting all properties.
function fa_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Does nothing
function fb_edit_Callback(hObject, eventdata, handles)
% XXX

% --- Executes during object creation, after setting all properties.
function fb_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Doing nothing
function fc_edit_Callback(hObject, eventdata, handles)
% XXX

% --- Executes during object creation, after setting all properties.
function fc_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in updatebutton.
function updatebutton_Callback(hObject, eventdata, handles)
fs = get(handles.fs_edit, 'String');
fa = get(handles.fa_edit, 'String');
fb = get(handles.fb_edit, 'String');
fc = get(handles.fc_edit, 'String');
eeglab_path = get(handles.editeeglab, 'String');
locs_path = get(handles.editlocations, 'String');

handles.constants.put('fs', fs);
handles.constants.put('fa', fa);
handles.constants.put('fb', fb);
handles.constants.put('fc', fc);
handles.constants.put('EEGLAB_PATH', eeglab_path);
handles.constants.put('LOCATIONS_PATH', locs_path);
save_constants(handles.constants);
close;

% --- Doing nothing
function fs_edit_Callback(hObject, eventdata, handles)
% XXX

% --- Executes during object creation, after setting all properties.
function fs_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in restorebutton.
function restorebutton_Callback(hObject, eventdata, handles)
selection = questdlg([{'Once restored to default' 'the current values will be lost.' 'Do you wish to proceed?'}],...
                     ['Reset parameters values?'],...
                     'Yes','No','Yes');
if strcmp(selection,'Yes')
    handles.constants.put('fs', handles.constants.get('fs_default'));
    handles.constants.put('fa', handles.constants.get('fa_default'));
    handles.constants.put('fb', handles.constants.get('fb_default'));
    handles.constants.put('fc', handles.constants.get('fc_default'));
    save_constants(handles.constants);
else
    return;
end
guidata(hObject, handles);



% --- Executes on button press in cancelbutton.
function cancelbutton_Callback(hObject, eventdata, handles)
close;

% --- Doing nothing
function editeeglab_Callback(hObject, eventdata, handles)
% XXX


% --- Executes during object creation, after setting all properties.
function editeeglab_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in buttonsearcheeglab.
function buttonsearcheeglab_Callback(hObject, eventdata, handles)
% TODO Start search activity

% --- Doing nothing
function editlocations_Callback(hObject, eventdata, handles)
% XXX


% --- Executes during object creation, after setting all properties.
function editlocations_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in buttonlocs.
function buttonlocs_Callback(hObject, eventdata, handles)
% TODO Start search activity

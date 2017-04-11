function varargout = studymodule(varargin)
% STUDYMODULE M-file for studymodule.fig
%      STUDYMODULE, by itself, creates a new STUDYMODULE or raises the existing
%      singleton*.
%
%      H = STUDYMODULE returns the handle to a new STUDYMODULE or the handle to
%      the existing singleton*.
%
%      STUDYMODULE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STUDYMODULE.M with the given input arguments.
%
%      STUDYMODULE('Property','Value',...) creates a new STUDYMODULE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before studymodule_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to studymodule_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help studymodule

% Last Modified by GUIDE v2.5 24-Mar-2017 12:07:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @studymodule_OpeningFcn, ...
                   'gui_OutputFcn',  @studymodule_OutputFcn, ...
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


addpath ([cd '/eegmodule']);
javaaddpath('edf.jar');
if ~is_in_javapath('edf.jar')
      javaaddpath('edf.jar');
end

% --- Executes just before studymodule is made visible.
function studymodule_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to studymodule (see VARARGIN)

% Choose default command line output for studymodule
handles.output = hObject;
handles.constants = load_constants();
add_eeglab_path(get(handles.constants, 'EEGLAB_PATH'));

% Update handles structure
set(handles.editEEGLab, 'String', handles.constants.get('EEGLAB_PATH'));
set(handles.editOutput, 'String', strcat(pwd, filesep, 'output'));
set(handles.figure1, 'Name', 'Study Module');
guidata(hObject, handles);

% UIWAIT makes studymodule wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = studymodule_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%-----------------------------------------------------------------
function editEEGLab_Callback(hObject, eventdata, handles)
% hObject    handle to editEEGLab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEEGLab as text
%        str2double(get(hObject,'String')) returns contents of editEEGLab as a double


% --- Executes during object creation, after setting all properties.
function editEEGLab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEEGLab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSearchEEGLab.
function buttonSearchEEGLab_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSearchEEGLab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

EEGPath = uigetdir(cd, 'Select the EEGLab folder');
set(handles.editEEGLab, 'String', EEGPath);


function editOutput_Callback(hObject, eventdata, handles)
% hObject    handle to editOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOutput as text
%        str2double(get(hObject,'String')) returns contents of editOutput as a double


% --- Executes during object creation, after setting all properties.
function editOutput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSearchOut.
function buttonSearchOut_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSearchOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

EEGPath = uigetdir(cd, 'Select the EEGLab folder');
set(handles.editEEGLab, 'String', EEGPath);


% --- Executes on button press in buttonParameters.
function buttonParameters_Callback(hObject, eventdata, handles)
% hObject    handle to buttonParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch (get(handles.buttonParameters, 'Value'))
    case 1
        set([ handles.editEEGLab handles.editOutput,...
              handles.buttonSearchEEGLab handles.buttonSearchOut ],...
            'Enable', 'on');
        set(handles.buttonParameters, 'String', 'Save Parameters');
    otherwise
        set([ handles.editEEGLab handles.editOutput,...
              handles.buttonSearchEEGLab handles.buttonSearchOut ],...
            'Enable', 'off');
        handles.constants.put('EEGLAB_PATH', ...
                              get(handles.editEEGLab, 'String'));
        handles.constants.put('OUTPUT_PATH', ...
                              get(handles.editOutput, 'String'));
        save_constants(handles.constants);
        add_eeglab_path(get(handles.constants, 'EEGLAB_PATH'));
        set(handles.buttonParameters, 'String', 'Edit Parameters');
end
guidata(hObject, handles);


%-----------------------------------------------------------------
function editFile_Callback(hObject, eventdata, handles)
% hObject    handle to editFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFile as text
%        str2double(get(hObject,'String')) returns contents of editFile as a double

if isempty(get(handles.editFile, 'String'))
    set(handles.buttonStudy, 'Enable', 'off');
else
    set(handles.buttonStudy, 'Enable', 'on');
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSearch.
function buttonSearch_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename filepath FileInd] = uigetfile('*.xls', 'Select the data file:');

if ~isequal(filename, 0)
    outlet = strcat(filepath, filename);
    set(handles.editFile, 'String', outlet);
    set(handles.buttonStudy, 'Enable', 'on');
else
    return;
    set(handles.buttonStudy, 'Enable', 'off');
end
guidata(hObject, handles);


% --- Executes on button press in buttonStudy.
function buttonStudy_Callback(hObject, eventdata, handles)
% hObject    handle to buttonStudy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ints_table = ler_arq_ints(get(handles.editFile, 'String'));

% Open eeglab:
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

studyName = strcat(get(handles.editOutput, 'String'), filesep, 'Study_', date, '.study');
handles.studyName = studyName;
[STUDY ALLEEG] = pop_study([ ], [ ]);

for n = 1:size(ints_table)
   % Adding to STUDY
    setFile = strcat(get(handles.editOutput, 'String'), filesep, ints_table{n, 11});
    [STUDY ALLEEG] = std_editset(STUDY, ALLEEG, ...
                                 'name', studyName, ...
                                 'filename', strcat('/Study_', date), ...
                                 'filepath', get(handles.editOutput, 'String'), ...
                                 'commands', ...
                                 {'index', n, ...
                                 'load', setFile, ...
                                 'subject', ints_table{n, 1}, ...
                                 'session', ints_table{n, 6}});
end

set(handles.buttonMap, 'Enable', 'on');
guidata(hObject, handles);

% --- Executes on button press in buttonMap.
function buttonMap_Callback(hObject, eventdata, handles)
% hObject    handle to buttonMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

studyName = handles.studyName;
[studyfilepath, studyfilename, studyfileext] = fileparts(studyName);

[STUDY ALLEEG] = pop_loadstudy('filename', strcat(studyfilename, studyfileext), ...
                               'filepath', studyfilepath);



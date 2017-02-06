function varargout = emgmodule2(varargin)
% EMGMODULE2 M-file for emgmodule2.fig
%      EMGMODULE2, by itself, creates a new EMGMODULE2 or raises the existing
%      singleton*.
%
%      H = EMGMODULE2 returns the handle to a new EMGMODULE2 or the handle to
%      the existing singleton*.
%
%      EMGMODULE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EMGMODULE2.M with the given input arguments.
%
%      EMGMODULE2('Property','Value',...) creates a new EMGMODULE2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before emgmodule2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to emgmodule2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help emgmodule2

% Last Modified by GUIDE v2.5 01-Feb-2017 13:52:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
       'gui_Singleton',  gui_Singleton, ...
       'gui_OpeningFcn', @emgmodule2_OpeningFcn, ...
       'gui_OutputFcn',  @emgmodule2_OutputFcn, ...
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

addpath ([cd '/eegmodule']);
% End initialization code - DO NOT EDIT


% --- Executes just before emgmodule2 is made visible.
function emgmodule2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to emgmodule2 (see VARARGIN)

% Choose default command line output for emgmodule2
handles.output = hObject;
handles.constants = load_constants();
add_eeglab_path(get(handles.constants, 'EEGLAB_PATH'));

% Update handles structure
set(handles.editEEGLab, 'String', handles.constants.get('EEGLAB_PATH'));
set(handles.editLocations, 'String', handles.constants.get('LOCATIONS_PATH'));
set(handles.editOutput, 'String', strcat(pwd, filesep, 'output'));
set(handles.figure1, 'Name', 'EEG Module');
guidata(hObject, handles);

% UIWAIT makes emgmodule2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = emgmodule2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%-----------------------------------------------------------------
% --- Executes on button press in buttonParameters.
function buttonParameters_Callback(hObject, eventdata, handles)
% hObject    handle to buttonParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch get(handles.buttonParameters, 'Value')
    case 1
        set([ handles.editEEGLab handles.editLocations,...
              handles.buttonSearchEEG handles.buttonSearchLoc ],...
            'Enable', 'on');
        set(handles.buttonParameters, 'String', 'Save Parameters');
    otherwise
        set([ handles.editEEGLab handles.editLocations,...
              handles.buttonSearchEEG handles.buttonSearchLoc],...
            'Enable', 'off');
        handles.constants.put('EEGLAB_PATH', ...
                              get(handles.editEEGLab, 'String'));
        handles.constants.put('LOCATIONS_PATH', ...
                              get(handles.editLocations, 'String'));
        save_constants(handles.constants);
        add_eeglab_path(get(handles.constants, 'EEGLAB_PATH'));
        set(handles.buttonParameters, 'String', 'Edit Parameters');
end


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
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSearchEEG.
function buttonSearchEEG_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSearchEEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EEGPath = uigetdir(cd, 'Select the EEGLab folder');
set(handles.editEEGLab, 'String', EEGPath);

function editLocations_Callback(hObject, eventdata, handles)
% hObject    handle to editLocations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLocations as text
%        str2double(get(hObject,'String')) returns contents of editLocations as a double


% --- Executes during object creation, after setting all properties.
function editLocations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLocations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSearchLoc.
function buttonSearchLoc_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSearchLoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[LocName LocPath FileInd] = uigetfile('*.ced', 'Select the locations file');
set(handles.editLocations, 'String', strcat(LocPath, LocName));

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
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSearchOut.
function buttonSearchOut_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSearchOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
directoryName = uigetdir(pwd, 'Select output folder');
set(handles.editOutput, 'String', directoryName);


%-----------------------------------------------------------------
function editTable_Callback(hObject, eventdata, handles)
% hObject    handle to editTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTable as text
%        str2double(get(hObject,'String')) returns contents of editTable as a double

if isempty(get(handles.editTable, 'String'))
    set([ handles.buttonRun, ...
          handles.handles, ...
          checkCut.checkRerefer, ...
          handles.checkLocate,...
          handles.checkInfo, ...
          handles.checkICA, ...
          handles.checkSteps ],...
        'Enable', 'off');
end


% --- Executes during object creation, after setting all properties.
function editTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSearch.
function buttonSearch_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.xls', 'Select the parameters file');

if ~isequal(filename, 0)
    outlet = strcat(pathname, filename);
    set([ handles.buttonRun, ...
          handles.checkCut, ...
          handles.checkRerefer, ...
          handles.checkLocate,...
          handles.checkInfo, ...
          handles.checkICA, ...
          handles.checkSteps, ...
          handles.checkArtifacts ],...
        'Enable', 'on');
    set(handles.editTable, 'String', outlet);
else
    return;
    set([ handles.buttonRun, ...
          handles.checkCut, ...
          handles.checkRerefer, ...
          handles.checkLocate,...
          handles.checkInfo, ...
          handles.checkICA, ...
          handles.checkSteps, ...
          handles.checkArtifacts ],...
        'Enable', 'off');
end

%-----------------------------------------------------------------
% --- Executes on button press in checkLocate.
function checkLocate_Callback(hObject, eventdata, handles)
% hObject    handle to checkLocate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkLocate


% --- Executes on button press in checkICA.
function checkICA_Callback(hObject, eventdata, handles)
% hObject    handle to checkICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkICA


% --- Executes on button press in checkSteps.
function checkSteps_Callback(hObject, eventdata, handles)
% hObject    handle to checkSteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkSteps


% --- Executes on button press in buttonRun.
function buttonRun_Callback(hObject, eventdata, handles)
% hObject    handle to buttonRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Set the output folder
outputFolder = checkForOutputFolder(get(handles.editOutput, 'String'));
if outputFolder == 0
    % TODO Change this to a dialog box
    fprintf('INVALID OUTPUT FOLDER\n')
    return
else
    outputFolder = strcat(outputFolder, filesep);
end

% Getting EEGLAB parameters
eeglabPath = get(handles.editEEGLab, 'String');
eeglocPath = get(handles.editLocations, 'String');

% Setting options
options = [ get(handles.checkSteps,     'Value') ...
            get(handles.checkRerefer,   'Value') ...
            get(handles.checkCut,       'Value') ...
            get(handles.checkLocate,    'Value') ...
            get(handles.checkInfo,      'Value') ...
            get(handles.checkICA,       'Value') ...
            get(handles.checkArtifacts, 'Value') ] ...
        == 1;

% Abrir o arquivo
xlsfile = get(handles.editTable, 'String');

% Let's process it!
processEEG(xlsfile, eeglabPath, eeglocPath, outputFolder, options);

function varargout = eegmodule2(varargin)
% EEGMODULE2 M-file for eegmodule2.fig
%      EEGMODULE2, by itself, creates a new EEGMODULE2 or raises the existing
%      singleton*.
%
%      H = EEGMODULE2 returns the handle to a new EEGMODULE2 or the handle to
%      the existing singleton*.
%
%      EEGMODULE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EEGMODULE2.M with the given input arguments.
%
%      EEGMODULE2('Property','Value',...) creates a new EEGMODULE2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before eegmodule2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to eegmodule2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help eegmodule2

% Last Modified by GUIDE v2.5 18-Dec-2017 09:12:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
       'gui_Singleton',  gui_Singleton, ...
       'gui_OpeningFcn', @eegmodule2_OpeningFcn, ...
       'gui_OutputFcn',  @eegmodule2_OutputFcn, ...
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


% --- Executes just before eegmodule2 is made visible.
function eegmodule2_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for eegmodule2
handles.output = hObject;
handles.constants = load_constants();
add_eeglab_path(get(handles.constants, 'EEGLAB_PATH'));

% Update handles structure
set(handles.editEEGLab, 'String', handles.constants.get('EEGLAB_PATH'));
set(handles.editLocations, 'String', handles.constants.get('LOCATIONS_PATH'));
set(handles.editOutput, 'String', handles.constants.get('OUTPUT_PATH'));
set(handles.figure1, 'Name', 'EEG Module');
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = eegmodule2_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
varargout{1} = handles.output;


%-----------------------------------------------------------------
% --- Executes on button press in buttonParameters.
function buttonParameters_Callback(hObject, eventdata, handles)
switch get(handles.buttonParameters, 'Value')
    case 1
        set([ handles.editEEGLab handles.buttonSearchEEG,...
              handles.editLocations handles.buttonSearchLoc,...
              handles.editOutput handles.buttonSearchOut ],...
            'Enable', 'on');
        set(handles.buttonParameters, 'String', 'Save Parameters');
    otherwise
        set([ handles.editEEGLab handles.buttonSearchEEG,...
              handles.editLocations handles.buttonSearchLoc,...
              handles.editOutput handles.buttonSearchOut ],...
            'Enable', 'off');
        handles.constants.put('EEGLAB_PATH', ...
                              get(handles.editEEGLab, 'String'));
        handles.constants.put('LOCATIONS_PATH', ...
                              get(handles.editLocations, 'String'));
        handles.constants.put('OUTPUT_PATH', ...
                              get(handles.editOutput, 'String'));
        save_constants(handles.constants);
        add_eeglab_path(get(handles.constants, 'EEGLAB_PATH'));
        set(handles.buttonParameters, 'String', 'Edit Parameters');
end


function editEEGLab_Callback(hObject, eventdata, handles)
% Does nothing

% --- Executes during object creation, after setting all properties.
function editEEGLab_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSearchEEG.
function buttonSearchEEG_Callback(hObject, eventdata, handles)
EEGPath = uigetdir(pwd, 'Select the EEGLab folder');
if EEGPath
    set(handles.editEEGLab, 'String', EEGPath);
end


function editLocations_Callback(hObject, eventdata, handles)
% Does nothing


% --- Executes during object creation, after setting all properties.
function editLocations_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSearchLoc.
function buttonSearchLoc_Callback(hObject, eventdata, handles)
[LocName LocPath FileInd] = uigetfile('*.ced', 'Select the locations file');
if LocName
    set(handles.editLocations, 'String', strcat(LocPath, LocName));
end


% --- OUTPUT FOLDER STUFF ------------------------------------------------------
function editOutput_Callback(hObject, eventdata, handles)
% Does nothing


% --- Executes during object creation, after setting all properties.
function editOutput_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSearchOut.
function buttonSearchOut_Callback(hObject, eventdata, handles)
directoryName = uigetdir(pwd, 'Select output folder');
if directoryName
    set(handles.editOutput, 'String', directoryName);
end


%-----------------------------------------------------------------
function editTable_Callback(hObject, eventdata, handles)
if isempty(get(handles.editTable, 'String'))
    set([ handles.buttonRun, ...
          handles.checkRemove, ...
          handles.checkRerefer, ...
          handles.checkLocate,...
          handles.checkInfo, ...
          handles.checkICA, ...
          handles.checkSteps, ...
          handles.checkArtifacts, ...
          handles.checkEvents ],...
        'Enable', 'off');
else
    set([ handles.buttonRun, ...
          handles.checkRemove, ...
          handles.checkRerefer, ...
          handles.checkLocate,...
          handles.checkInfo, ...
          handles.checkICA, ...
          handles.checkSteps, ...
          handles.checkArtifacts, ...
          handles.checkEvents ],...
        'Enable', 'on');
end


% --- Executes during object creation, after setting all properties.
function editTable_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSearch.
function buttonSearch_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile('*.xls', 'Select the parameters file');

if ~isequal(filename, 0)
    outlet = strcat(pathname, filename);
    set([ handles.buttonRun, ...
          handles.checkRemove, ...
          handles.checkRerefer, ...
          handles.checkLocate,...
          handles.checkInfo, ...
          handles.checkICA, ...
          handles.checkSteps, ...
          handles.checkArtifacts, ...
          handles.checkEvents ],...
        'Enable', 'on');
    set(handles.editTable, 'String', outlet);
else
    return;
    set([ handles.buttonRun, ...
          handles.checkRemove, ...
          handles.checkRerefer, ...
          handles.checkLocate,...
          handles.checkInfo, ...
          handles.checkICA, ...
          handles.checkSteps, ...
          handles.checkArtifacts, ...
          handles.checkEvents ],...
        'Enable', 'off');
end

%-----------------------------------------------------------------
% --- Executes on button press in checkRerefer.
function checkRerefer_Callback(hObject, eventdata, handles)
% Does nothing


% --- Executes on button press in checkRemove.
function checkRemove_Callback(hObject, eventdata, handles)
% Does nothing


% --- Executes on button press in checkInfo.
function checkInfo_Callback(hObject, eventdata, handles)
% Does nothing


% --- Executes on button press in checkICA.
function checkICA_Callback(hObject, eventdata, handles)
% Does nothing


% --- Executes on button press in checkArtifacts.
function checkArtifacts_Callback(hObject, eventdata, handles)
% Does nothing


% --- Executes on button press in checkLocate.
function checkLocate_Callback(hObject, eventdata, handles)
% Does nothing


% --- Executes on button press in checkEvents.
function checkEvents_Callback(hObject, eventdata, handles)
% Does nothing


% --- Executes on button press in checkSteps.
function checkSteps_Callback(hObject, eventdata, handles)
% Does nothing


% --- Executes on button press in buttonRun.
function buttonRun_Callback(hObject, eventdata, handles)
% Set the output folder
outputFolder = checkForOutputFolder(get(handles.editOutput, 'String'));
if outputFolder == 0
    msgbox('Invalid output folder!', 'Invalid', 'error');
    return;
else
    outputFolder = strcat(outputFolder, filesep);
end

% Getting EEGLAB parameters
eeglabPath = get(handles.editEEGLab, 'String');
eeglocPath = get(handles.editLocations, 'String');

% Setting options
options = [ get(handles.checkRerefer,   'Value') ...
            get(handles.checkRemove,    'Value') ...
            get(handles.checkInfo,      'Value') ...
            get(handles.checkICA,       'Value') ...
            get(handles.checkArtifacts, 'Value') ...
            get(handles.checkLocate,    'Value') ...
            get(handles.checkEvents,    'Value') ...
            get(handles.checkSteps,     'Value') ] ...
        == 1;

% Opens the file
xlsfile = get(handles.editTable, 'String');

% Let's process it!
processEEG(xlsfile, eeglabPath, eeglocPath, outputFolder, options);
msgbox('Files processed!');




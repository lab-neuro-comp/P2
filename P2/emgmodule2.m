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

% Last Modified by GUIDE v2.5 13-Feb-2017 11:15:57

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
set(handles.editOutput, 'String', strcat(pwd, filesep, 'output'));
set(handles.figure1, 'Name', 'Single Channel Module');
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
    set(handles.buttonRun, 'Enable', 'off');
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
    set(handles.buttonRun, 'Enable', 'on');
    set(handles.editTable, 'String', outlet);
else
    return;
    set(handles.buttonRun, 'Enable', 'off');
end


%-----------------------------------------------------------------
% --- Executes on button press in radioEDF.
function radioEDF_Callback(hObject, eventdata, handles)
% hObject    handle to radioEDF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.radioASCII, 'Value', 0);
guidata(hObject, handles);


% --- Executes on button press in radioASCII.
function radioASCII_Callback(hObject, eventdata, handles)
% hObject    handle to radioASCII (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.radioEDF, 'Value', 0);
guidata(hObject, handles);


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

% Reading parameters file
ints_table = ler_arq_ints(get(handles.editTable, 'String'));

% Open eeglab:
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% Different approaches for each file extension
if (get(handles.radioASCII, 'Value'))
    % The input should be the same as the eegmodule input,
    % but the filename in the last column must be replaced
    % by the name of the ascii file
    disp('this will deal with ascii files');
else
    for n = 1:size(ints_table)
    % Variables
    arqedf = ints_table{n, 9};
    int1 = ints_table{n, 5};
    int2 = ints_table{n, 6};
    edfinfo = br.unb.biologiaanimal.edf.EDF(arqedf);
    samplingRate = edfinfo.getSamplingRate();
    blockrange = floor([int1/samplingRate int2/samplingRate]);

    % Loading EDF
    h = msgbox('Loading EDF...');
    EEG = pop_biosig(arqedf, 'blockrange', blockrange, 'rmeventchan', 'off');
    close(h);

    arqset = change_extension(arqedf, 'set');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, n,...
                                         'setname', arqset,...
                                         'overwrite', 'on');

    % Selecting data to keep
    % TODO check EEGLab function pop_select()
    h = msgbox('Cutting dataset...');
    EEG = eeg_checkset(EEG);
    EEG = pop_select(EEG, 'time', [int1 int2]);
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
    close(h);

    % Storing data
    h = msgbox('Saving dataset...');
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
    [arqsetpath, arqsetname, arqsetext] = fileparts(arqset);
    EEG = pop_saveset(EEG, 'filename', strcat(arqsetname, arqsetext), ...
                           'filepath', outputFolder);
    close(h);
    end
end
    
disp('DEKITA~! o/')

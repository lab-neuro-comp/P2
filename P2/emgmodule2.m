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

% Last Modified by GUIDE v2.5 14-Mar-2017 08:12:45

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
        set([ handles.editEEGLab handles.editOutput,...
              handles.buttonSearchEEG handles.buttonSearchOut ],...
            'Enable', 'on');
        set(handles.buttonParameters, 'String', 'Save Parameters');
    otherwise
        set([ handles.editEEGLab handles.editOutput,...
              handles.buttonSearchEEG handles.buttonSearchOut ],...
            'Enable', 'off');
        handles.constants.put('EEGLAB_PATH', ...
                              get(handles.editEEGLab, 'String'));
        handles.constants.put('OUTPUT_PATH', ...
                              get(handles.editOutput, 'String'));
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
else
    set(handles.buttonRun, 'Enable', 'on');
end
guidata(hObject, handles);


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
    set(handles.editTable, 'String', outlet);
    set(handles.buttonRun, 'Enable', 'on');
else
    return;
    set(handles.buttonRun, 'Enable', 'off');
end
guidata(hObject, handles);


%-----------------------------------------------------------------
% --- Executes on button press in radioEMG.
function radioEMG_Callback(hObject, eventdata, handles)
% hObject    handle to radioEMG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.radioEDA, 'Value', 0);
guidata(hObject, handles);


% --- Executes on button press in radioEMG.
function radioEDA_Callback(hObject, eventdata, handles)
% hObject    handle to radioEMG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.radioEMG, 'Value', 0);
guidata(hObject, handles);


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
handles.outFolder = outputFolder;

% Reading parameters file
ints_table = ler_arq_ints(get(handles.editTable, 'String'));

% Open eeglab:
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% Different approaches for each file extension
listset = {};
handles.listset = listset;

if (get(handles.radioASCII, 'Value'))
    % The input should be the same as the eegmodule input,
    % but the filename in the last column must be replaced
    % by the name of the ascii file

    for n = 1:size(ints_table)
        % Variables
        arqascii = ints_table{n, 9};
        int1 = ints_table{n, 5};
        int2 = ints_table{n, 6};
        samplingRate = ints_table{n, 7};
        blockrange = floor([int1/samplingRate int2/samplingRate]);

        h = msgbox('Loading ASCII...');
        if (get(handle.radioEDA, 'Value'))
            arqset = strcat(ints_table{n, 1}, '-',...
                            ints_table{n, 3}, '-EDA-',...
                            ints_table{n, 2}, '.set')
        elseif (get(handles.radioEMG, 'Value'))
            arqset = strcat(ints_table{n, 1}, '-',...
                            ints_table{n, 3}, '-EMG-',...
                            ints_table{n, 2}, '.set');
        end
        EEG = pop_importdata('data', arqascii,...
                             'dataformat', 'ascii',...
                             'srate', samplingRate);
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, n,...
                                             'setname', arqset,...
                                             'overwrite', 'on');
        close(h);

        % Selecting data to keep
        % TODO check EEGLab function pop_select()
        h = msgbox('Cutting dataset...');
        EEG = eeg_checkset(EEG);
        EEG = pop_select(EEG, 'time', blockrange);
        [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
        close(h);

        % Storing data
        h = msgbox('Saving dataset...');
        [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
        [arqsetpath, arqsetname, arqsetext] = fileparts(arqset);
        EEG = pop_saveset(EEG, 'filename', strcat(arqsetname, arqsetext), ...
                               'filepath', outputFolder);
        close(h);

        % Adding file to the processed list
        listset{n} = arqset;
        set(handles.listFiles, 'String', listset);
    end
elseif (get(handles.radioEDF, 'Value'))
    % This runs the version of the button that analyses and
    % cuts EDF files

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
        EEG = pop_biosig(arqedf, 'rmeventchan', 'off');
        close(h);

        if (get(handle.radioEDA, 'Value'))
            arqset = strcat(ints_table{n, 1}, '-',...
                            ints_table{n, 3}, '-EDA-',...
                            ints_table{n, 2}, '.set')
        elseif (get(handles.radioEMG, 'Value'))
            arqset = strcat(ints_table{n, 1}, '-',...
                            ints_table{n, 3}, '-EMG-',...
                            ints_table{n, 2}, '.set');
        end
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, n,...
                                             'setname', arqset,...
                                             'overwrite', 'on');

        % Selecting data to keep
        h = msgbox('Cutting dataset...');
        EEG = eeg_checkset(EEG);
        if (get(handles.radioEDA, 'Value'))
            EEG = pop_select(EEG, 'time', blockrange, 'channel', 'RGP');
        elseif (get(handles.radioEMG, 'Value'))
            EEG = pop_select(EEG, 'time', blockrange, 'channel', 'EMG');
        end
        [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
        close(h);

        % Storing data
        h = msgbox('Saving dataset...');
        [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, n);
        [arqsetpath, arqsetname, arqsetext] = fileparts(arqset);
        EEG = pop_saveset(EEG, 'filename', strcat(arqsetname, arqsetext), ...
                               'filepath', outputFolder);
        close(h);

        % Adding file to the processed list
        listset{n} = arqset;
        set(handles.listFiles, 'String', listset);
    end
end
    
disp('DEKITA~! o/')

set( [handles.radioFilt handles.radioPlot, ...
      handles.checkHiFilt handles.editHiFilt, ...
      handles.checkLoFilt handles.buttonProcess], ...
    'Enable', 'on');
guidata(hObject, handles);


%-----------------------------------------------------------------
% --- Executes on button press in radioFilt.
function radioFilt_Callback(hObject, eventdata, handles)
% hObject    handle to radioFilt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set( [handles.radioPlot handles.checkLoFilt], ... 
    'Value', 0);
set(handles.checkHiFilt, 'Value', 1);
set( [handles.checkHiFilt handles.editHiFilt, ...
      handles.checkLoFilt], ...
    'Enable', 'on');
set(handles.buttonProcess, 'String', 'Filter');
guidata(hObject, handles);


% --- Executes on button press in radioPlot.
function radioPlot_Callback(hObject, eventdata, handles)
% hObject    handle to radioPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set( [handles.radioFilt handles.checkLoFilt handles.checkNotch], ... 
    'Value', 0);
set(handles.checkHiFilt, 'Value', 1);
set( [handles.checkHiFilt handles.editHiFilt, ...
      handles.checkLoFilt handles.editLoFilt, ...
      handles.checkNotch], ...
    'Enable', 'off');
set(handles.buttonProcess, 'String', 'Plot');
guidata(hObject, handles);


%-----------------------------------------------------------------
% --- Executes on button press in checkHiFilt.
function checkHiFilt_Callback(hObject, eventdata, handles)
% hObject    handle to checkHiFilt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch get(handles.checkHiFilt, 'Value')
    case 1
        set(handles.editHiFilt, 'Enable', 'on');
        if ~isempty(get(handles.editHiFilt, 'String'))
            set(handles.buttonProcess, 'Enable', 'on');
            switch get(handles.checkLoFilt, 'Value')
                case 0
                    set(handles.checkNotch, 'Enable', 'off', 'Value', 0);
                otherwise
                    if ~isempty(get(handles.editLoFilt, 'String'))
                        set(handles.checkNotch, 'Enable', 'on');
                    else
                        set(handles.checkNotch, 'Enable', 'off');
                        set(handles.buttonProcess, 'Enable', 'off', 'Value', 0);
                    end
            end
        else
            set(handles.checkNotch, 'Enable', 'off', 'Value', 0);
            set(handles.editHiFilt, 'String', '');
            switch get(handles.checkLoFilt, 'Value')
                case 0
                    set(handles.buttonProcess, 'Enable', 'off');
                otherwise
                    if ~isempty(get(handles.editLoFilt, 'String'))
                        set(handles.buttonProcess, 'Enable', 'on');
                    else
                        set(handles.buttonProcess, 'Enable', 'off');
                    end
            end
        end
    otherwise
        set(handles.editHiFilt, 'Enable', 'off');
        set(handles.checkNotch, 'Enable', 'off', 'Value', 0);
        if ~(get(handles.checkLoFilt, 'Value'))
            set(handles.buttonProcess, 'Enable', 'off');
        end
end
guidata(hObject, handles);


function editHiFilt_Callback(hObject, eventdata, handles)
% hObject    handle to editHiFilt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(get(handles.editHiFilt, 'String'))
    set(handles.buttonProcess, 'Enable', 'on');
    switch get(handles.checkLoFilt, 'Value')
        case 0
            set(handles.checkNotch, 'Enable', 'off', 'Value', 0);
        otherwise
            if ~isempty(get(handles.editLoFilt, 'String'))
                set(handles.checkNotch, 'Enable', 'on');
            else
                set(handles.checkNotch, 'Enable', 'off');
                set(handles.buttonProcess, 'Enable', 'off', 'Value', 0);
            end
    end
else
    set(handles.checkNotch, 'Enable', 'off', 'Value', 0);
    switch get(handles.checkLoFilt, 'Value')
        case 0
            set(handles.buttonProcess, 'Enable', 'off');
        otherwise
            if ~isempty(get(handles.editLoFilt, 'String'))
                set(handles.buttonProcess, 'Enable', 'on');
            else
                set(handles.buttonProcess, 'Enable', 'off');
            end
    end
end

if (str2double(get(handles.editHiFilt, 'String')) < 1)
    set(handles.editHiFilt, 'String', '1');
end

if isequal(get(handles.editLoFilt, 'String'), get(handles.editHiFilt, 'String'))
    msgbox('The frequency values must be different.', 'Error', 'error');
    set(handles.editHiFilt, 'String', '');
end
guidata(hObject, handles);
    

% --- Executes during object creation, after setting all properties.
function editHiFilt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editHiFilt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in checkLoFilt.
function checkLoFilt_Callback(hObject, eventdata, handles)
% hObject    handle to checkLoFilt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch get(handles.checkLoFilt, 'Value')
    case 1
        set(handles.editLoFilt, 'Enable', 'on');
        if ~isempty(get(handles.editLoFilt, 'String'))
            set(handles.buttonProcess, 'Enable', 'on');
            switch get(handles.checkHiFilt, 'Value')
                case 0
                    set(handles.checkNotch, 'Enable', 'off', 'Value', 0);
                otherwise
                    if ~isempty(get(handles.editHiFilt, 'String'))
                        set(handles.checkNotch, 'Enable', 'on');
                    else
                        set(handles.checkNotch, 'Enable', 'off', 'Value', 0);
                        set(handles.buttonProcess, 'Enable', 'off');
                    end
            end
        else
            set(handles.checkNotch, 'Enable', 'off', 'Value', 0);
            set(handles.editLoFilt, 'String', '');
            switch get(handles.checkHiFilt, 'Value')
                case 0
                    set(handles.buttonProcess, 'Enable', 'off');
                otherwise
                    if ~isempty(get(handles.editLoFilt, 'String'))
                        set(handles.buttonProcess, 'Enable', 'on');
                    else
                        set(handles.buttonProcess, 'Enable', 'off');
                    end
            end
        end
    otherwise
        set(handles.editLoFilt, 'Enable', 'off');
        set(handles.checkNotch, 'Enable', 'off', 'Value', 0);
        if ~(get(handles.checkHiFilt, 'Value'))
            set(handles.buttonProcess, 'Enable', 'off');
        end
end
guidata(hObject, handles);


function editLoFilt_Callback(hObject, eventdata, handles)
% hObject    handle to editLoFilt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(get(handles.editLoFilt, 'String'))
    set(handles.buttonProcess, 'Enable', 'on');
    switch get(handles.checkHiFilt, 'Value')
        case 0
            set(handles.checkNotch, 'Enable', 'off', 'Value', 0);
        otherwise
            if ~isempty(get(handles.editHiFilt, 'String'))
                set(handles.checkNotch, 'Enable', 'on');
            else
                set(handles.checkNotch, 'Enable', 'off', 'Value', 0);
                set(handles.buttonProcess, 'Enable', 'off');
            end
    end
else
    set(handles.checkNotch, 'Enable', 'off', 'Value', 0);
    switch get(handles.checkHiFilt, 'Value')
        case 0
            set(handles.buttonProcess, 'Enable', 'off');
        otherwise
            if ~isempty(get(handles.editLoFilt, 'String'))
                set(handles.buttonProcess, 'Enable', 'on');
            else
                set(handles.buttonProcess, 'Enable', 'off');
            end
    end
end

if and(~isempty(get(handles.editLoFilt, 'String')),...
       (str2double(get(handles.editLoFilt, 'String')) < 1))
    set(handles.editLoFilt, 'String', '1')
end

if isequal(get(handles.editLoFilt, 'String'), get(handles.editHiFilt, 'String'))
    msgbox('The frequency values must be different.', 'Error', 'error');
    set(handles.editLoFilt, 'String', '');
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editLoFilt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLoFilt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkNotch.
function checkNotch_Callback(hObject, eventdata, handles)
% hObject    handle to checkNotch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch get(handles.checkNotch, 'Value')
    case 1
        if (get(handles.checkHiFilt, 'Value') && ~isempty(get(handles.editHiFilt, 'String')) && get(handles.checkLoFilt, 'Value') && ~isempty(get(handles.editLoFilt, 'String')))
            set(handles.buttonProcess, 'Enable', 'on');
        else
            set(handles.buttonProcess, 'Enable', 'off');
        end
    otherwise
        return;
end
guidata(hObject, handles);


% --- Executes on button press in buttonProcess.
function buttonProcess_Callback(hObject, eventdata, handles)
% hObject    handle to buttonProcess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Storing checkbox info in variables for easy access
checkNo = get(handles.checkNotch, 'Value');
valueHi = str2double(get(handles.editHiFilt, 'String'));
valueLo = str2double(get(handles.editLoFilt, 'String'));

% Loading the selected dataset
files = cellstr(get(handles.listFiles, 'String'));
[m n] = size(files);
arqset = get(handles.listFiles, 'Value');
EEG = pop_loadset('filename', files(arqset),...
                  'filepath', get(handles.editOutput, 'String'));

% An approach for each action (plot or filter)
if get(handles.radioPlot, 'Value')
    % Plot Option
    pop_eegplot(EEG);

elseif get(handles.radioFilt, 'Value')
    % Filter Option
    h = msgbox('Filtering data...');
    [filtEEG com b] = pop_eegfiltnew(EEG, valueHi, valueLo, [], checkNo);
    close(h);
    pop_eegplot(filtEEG);
    choice = questdlg('Would you like to save the filtered data?',...
                      'Save?', 'Yes', 'No', 'No');
    switch choice
        case 'Yes'
            % Storing data
            h = msgbox('Saving dataset...');
            filtfile = char(strrep(files(arqset), '.set', '-filt.set'));
            outputFolder = handles.outFolder;
            filtEEG = pop_saveset(filtEEG, 'filename', filtfile, ...
                                  'filepath', outputFolder);
            close(h);

            % Adding file to the processed list
            files{m + 1} = filtfile;
            set(handles.listFiles, 'String', files);
        case 'No'
            return;
    end
end



%-----------------------------------------------------------------
% --- Executes on selection change in listFiles.
function listFiles_Callback(hObject, eventdata, handles)
% hObject    handle to listFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function listFiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



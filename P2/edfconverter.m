function varargout = edfconverter(varargin)
% Enables the user to convert EDF files to the ASCII format. It can write to
% multiple files, each one with a signal. If the 'Pick channels' option is
% selected, the user will be prompted to determine which channels they want to
% convert. Otherwise, it will write all channels to a single file.
%

% Edit the above text to modify the response to help edfconverter

% Last Modified by GUIDE v2.5 29-Mar-2017 08:27:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @edfconverter_OpeningFcn, ...
                   'gui_OutputFcn',  @edfconverter_OutputFcn, ...
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

addpath([cd '/edfconverter']);
if ~is_in_javapath('edf.jar')
    javaaddpath('edf.jar');
end
% End initialization code - DO NOT EDIT


% --- Executes just before edfconverter is made visible.
function edfconverter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to edfconverter (see VARARGIN)

% Choose default command line output for edfconverter
handles.constants = load_constants();
add_eeglab_path(get(handles.constants, 'EEGLAB_PATH'));
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes edfconverter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = edfconverter_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function editSearch_Callback(hObject, eventdata, handles)
% hObject    handle to editSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSearch as text
%        str2double(get(hObject,'String')) returns contents of editSearch as a double


% --- Executes during object creation, after setting all properties.
function editSearch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonSearch.
function pushbuttonSearch_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.edf', 'MultiSelect', 'on');

% TODO Set editNotesOutput string to the output
if isnumeric(filename)
    return
elseif iscell(filename)
    set(handles.editSearch, ...
        'String', ...
        join_strings(strcat(pathname, filename), ';'));
else
    set(handles.editSearch, ...
        'String', ...
        strcat(pathname, ...
               filename));
end

% --- Executes on button press in checkboxMultiple.
function checkboxMultiple_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxMultiple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxMultiple


% --- Executes on button press in pushbuttonRun.
function pushbuttonRun_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
raw = get(handles.editSearch, 'String');

% Separating raw into many strings
stuff = {};
while not(isempty(raw))
    [stuff{end+1}, raw] = strtok(raw, ';');
end

% Open eeglab:
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% IDEA Try to run this on parallel
if isequal(get(handles.checkboxMultiple, 'Value'), true)
    for n = 1:length(stuff)
        inlet = stuff{n};
        
        % Find root file
        [filepath filename fileext] = fileparts(inlet);
        mkdir(filepath, 'ASCII_Files');
        root = strcat(filepath, filesep, 'ASCII_Files', filesep, filename)

        EEG = pop_biosig(inlet, 'importevent', 'off',...
                                'blockepoch', 'off',...
                                'blockrange', [0 1]);
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, n,...
                                             'setname', strcat(filepath, filesep, 'temp.set'),...
                                             'overwrite', 'on');
        channelsConvert = getChannelsCode({EEG.chanlocs.labels});
        
        % Checking if previous selections can be reused
        if isequal(get(handles.checkboxChoose, 'Value'), true)
            if convertReuse.containsKey(channelsConvert)
                fprintf('Reusing previous selection');
                toBeConverted = convertReuse.get(channelsConvert)
            else
                h = msgbox('Choose the channel to be converted:');
                [chosenIndex chosenName chosenCell] = pop_chansel({EEG.chanlocs.labels}, 'withindex', 'on');
                toBeConverted = chosenIndex
                close(h);
                if toBeConverted > 0
                    convertReuse.put(channelsConvert, toBeConverted);
                else
                    h = msgbox({['No channel has been chosen for'];...
                                [strcat(edffilename, edffileext)]}, 'Error', 'error');
                end
            end
        end

        listChannels = {};
        while not(isempty(channelsConvert))
            [listChannels{end+1}, channelsConvert] = strtok(channelsConvert, ';');
        end

        for m = 1:length(listChannels)
            EEG = pop_select(EEG, 'channel', m);
            EEG = pop_saveset(EEG, 'filename', 'temp.set', ...
                                   'filepath', filepath);
            EEG = pop_export(EEG, strcat(root, '.ascii'), 'time', 'off', 'elec', 'off');
        end
    end
else
    for n = 1:length(stuff)
        % TODO Add effect of picking channels here
        inlet = stuff{n};
        
        % Find root file
        [filepath filename fileext] = fileparts(inlet);
        mkdir(filepath, 'ASCII_Files');
        root = strcat(filepath, filesep, 'ASCII_Files', filesep, filename);

        EEG = pop_biosig(inlet, 'importevent', 'off',...
                                'blockepoch', 'off');
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, n,...
                                             'setname', strcat(filepath, filesep, 'temp.set'),...
                                             'overwrite', 'on');
    
        EEG = pop_saveset(EEG, 'filename', 'temp.set', ...
                               'filepath', filepath);
        EEG = pop_export(EEG, strcat(root, '.ascii'), 'time', 'off', 'elec', 'off');
    end
end

delete(strcat(filepath, filesep, 'temp.set'));
delete(strcat(filepath, filesep, 'temp.fdt'));
msgbox('DONE!');

% --- Executes on button press in checkboxChoose.
function checkboxChoose_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxChoose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxChoose
% TODO Implement callback


% --- Executes on button press in pushbuttonConvertNotes.
function pushbuttonConvertNotes_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonConvertNotes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% IDEA Try to implement this procedure to run on parallel
raw = get(handles.editSearch, 'String');
stuff = split_string(raw, ';');

fprintf('---\n');
for n = 1:length(stuff)
    inlet = stuff{n};
    fprintf('file: %s\n', inlet);
    edf = br.unb.biologiaanimal.edf.EDF(inlet);
    outlet = change_extension(inlet, 'csv');
    % TODO Write CSV to output file
    fprintf('annotations: ');
    csv = notes2csv(edf);
    if csv
        fprintf('\n%s\n', csv);
        fp = fopen(outlet, 'w');
        fprintf(fp, '%s', csv);
        fclose(fp);
    else
        fprintf('nope\n');
    end
end
fprintf('...\n');

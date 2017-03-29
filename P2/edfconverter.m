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
        join_strings(append_on_each_one(filename, ...
                                        pathname), ...
                     ';'));
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
stuff = split_string(raw, ';');

% IDEA Try to run this on parallel
if isequal(get(handles.checkboxMultiple, 'Value'), true)
    for n = 1:length(stuff)
        inlet = stuff{n};
        edf = br.unb.biologiaanimal.edf.EDF(inlet);

        % Find root file
        root_index = length(inlet);
        while ~isequal(inlet(root_index), '.')
            root_index = root_index - 1;
        end
        root = inlet(1:root_index);

        % To each file, loop through their labels
        labels = cell(edf.getLabels());
        if isequal(get(handles.checkboxChoose, 'Value'), true)
            labels = pickChannels(inlet, labels);
            % TODO Reuse selection if labels in thiese channels already appeared
            if length(labels) == 0; return; end;
        end
        for m = 1:length(labels)
            label = labels{m};
            outlet = strcat(root, label, '.ascii');
            fprintf('%s\n', outlet);
            edf.toSingleChannelAscii(outlet, label);
        end
    end
else
    for n = 1:length(stuff)
        % TODO Add effect of picking channels here
        item = stuff{n};
        inlet = item;
        edf = br.unb.biologiaanimal.edf.EDF(item);
        outlet = change_extension(inlet, '.ascii');
        edf.toAscii(outlet);
    end
end
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

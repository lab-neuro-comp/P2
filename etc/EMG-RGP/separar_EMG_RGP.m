function varargout = separar_EMG_RGP(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @separar_EMG_RGP_OpeningFcn, ...
                   'gui_OutputFcn',  @separar_EMG_RGP_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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
% There is no need to exist a function like this


function editFiles_CreateFcn(hObject, eventdata, handles)
% Nor a function here


function pushbuttonSearch_Callback(hObject, eventdata, handles)
% Callback when clicking "buscar" pushbutton
[filename, pathname] = uigetfile('*.edf', 'MultiSelect', 'on');
outlet = '';

if iscell(filename)
    for n = 1:length(filename)
        filename{n} = strcat(pathname, filename{n});
    end
    outlet = filename{1};
    for n = 2:length(filename)
        outlet = strcat(outlet, ';', filename{n});
    end
elseif ischar(filename)
    outlet = strcat(pathname, filename);
end

set(handles.editFiles, 'String', outlet);

function pushbuttonRun_Callback(hObject, eventdata, handles)
% Callback when clicking "processar" pushbutton
inlet = get(handles.editFiles, 'String');

% Separating inlet into many strings
testcases = {};
while not(isempty(inlet))
    [testcases{end+1}, inlet] = strtok(inlet, ';');
end

% Applying algorithm
info_stuff = { };
data_stuff = { };
for n = 1:length(testcases)
    % Getting raw file
    testcase = testcases{n};
    limit = length(testcase);
    while ~isequal(testcase(limit), '.')
        limit = limit-1;
    end
    raw = testcase(1:limit);
    % Translating EDF to ASCII and TXT
    info_stuff{n} = strcat(raw, 'txt');
    data_stuff{n} = strcat(raw, 'ascii');
    command = sprintf('EDFtoASCII.exe %s 22 %s %s /SPACE /BATCH', ...
                      testcases{n}, info_stuff{n}, data_stuff{n});
    system(command);
end

% TODO apply separating function

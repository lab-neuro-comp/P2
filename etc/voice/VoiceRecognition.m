function varargout = VoiceRecognition(varargin)
% VOICERECOGNITION M-file for VoiceRecognition.fig
%      VOICERECOGNITION, by itself, creates a new VOICERECOGNITION 
%      or raises the existing singleton*.
%
%      H = VOICERECOGNITION returns the handle to a new VOICERECOGNITION 
%      or the handle to the existing singleton*.
%
%      VOICERECOGNITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VOICERECOGNITION.M with the given input 
%      arguments.
%
%      VOICERECOGNITION('Property','Value',...) creates a new VOICERECOGNITION 
%      or raises the existing singleton*.  Starting from the left, property value 
%      pairs are applied to the GUI before VoiceRecognition_OpeningFunction gets 
%      called.  An unrecognized property name or invalid value makes property 
%      application stop.  All inputs are passed to VoiceRecognition_OpeningFcn 
%      via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above textFiles to modify the response to help VoiceRecognition

% Last Modified by GUIDE v2.5 14-Jun-2016 15:02:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VoiceRecognition_OpeningFcn, ...
                   'gui_OutputFcn',  @VoiceRecognition_OutputFcn, ...
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


% --- Executes just before VoiceRecognition is made visible.
function VoiceRecognition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VoiceRecognition (see VARARGIN)

% Choose default command line output for VoiceRecognition
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VoiceRecognition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VoiceRecognition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editFiles_Callback(hObject, eventdata, handles)
% hObject    handle to editFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFiles as textFiles
%        str2double(get(hObject,'String')) returns contents of 
%        editFiles as a double


% --- Executes during object creation, after setting all properties.
function editFiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject, ...
        'BackgroundColor', ...
        'white');
else
    set(hObject, ...
        'BackgroundColor', ...
        get(0, ...
            'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbuttonSearch.
function pushbuttonSearch_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname, filterindex] = uigetfile('*.wav', ...
                                              'Select sound files', ...
                                              'MultiSelect', 'on');
if ischar(filename)
    outlet = strcat(pathname, filename);
elseif iscell(filename)
    outlet = reduce_for_buttonSearch(filename, pathname)
end
set(handles.editFiles, 'String', outlet);

function [outlet] = reduce_for_buttonSearch(filename, pathname)
outlet = strcat(strcat(pathname, filename{1}), ...
                reduce_loop_for_buttonSearch(2, filename, pathname));

function [outlet] = reduce_loop_for_buttonSearch(where, stuff, acc)
if where <= length(stuff)
    outlet = strcat(';', ...
                    strcat(acc, stuff{where}), ...
                    reduce_loop_for_buttonSearch(where+1, stuff, acc));
else
    outlet = '';
end

function [outlet] = split_string(inlet, delim)
outlet = tokenizeString(inlet, delim);

function [tokens] = tokenizeString(string,delimeter)
tokens = {};
while not(isempty(string))
    [tokens{end+1},string] = strtok(string,delimeter);
end


function editThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to editThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editThreshold as textFiles
%        str2double(get(hObject,'String')) returns contents of editThreshold 
%        as a double
set(handles.sliderThreshold, 'Value', str2num(get(hObject, 'String')));

% --- Executes during object creation, after setting all properties.
function editThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject, ...
        'BackgroundColor', ...
        'white');
else
    set(hObject, ...
        'BackgroundColor', ...
        get(0, ...
            'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function sliderThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to sliderThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.editThreshold, 'String', num2str(get(hObject, 'Value')));

% --- Executes during object creation, after setting all properties.
function sliderThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject, ...
        'BackgroundColor', ...
        [.9 .9 .9]);
else
    set(hObject, ...
        'BackgroundColor', ...
        get(0, ...
            'defaultUicontrolBackgroundColor'));
end


function editWindow_Callback(hObject, eventdata, handles)
% hObject    handle to editWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.sliderWindow, 'Value', str2num(get(hObject, 'String')));

% --- Executes during object creation, after setting all properties.
function editWindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject, ...
        'BackgroundColor', ...
        'white');
else
    set(hObject, ...
        'BackgroundColor', ...
        get(0, ...
            'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function sliderWindow_Callback(hObject, eventdata, handles)
% hObject    handle to sliderWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.editWindow, 'String', num2str(get(hObject, 'Value')));

% --- Executes during object creation, after setting all properties.
function sliderWindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject, ...
        'BackgroundColor', ...
        [.9 .9 .9]);
else
    set(hObject, ...
        'BackgroundColor', ...
        get(0, ...
            'defaultUicontrolBackgroundColor'));
end

% --- Executes on button press in pushbuttonRun.
function pushbuttonRun_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject, 'String', 'Running...');
testcases = split_string(get(handles.editFiles, 'String'), ';');
threshold = str2num(get(handles.editThreshold, 'String'));
windowsize = str2num(get(handles.editWindow, 'String'));
for n = 1:length(testcases)
    RecognizeVoice(testcases{n}, threshold, windowsize);
end
set(hObject, 'String', 'Run');




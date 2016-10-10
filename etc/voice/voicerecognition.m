function varargout = voicerecognition(varargin)
% VOICERECOGNITION M-file for voicerecognition.fig
%      VOICERECOGNITION, by itself, creates a new VOICERECOGNITION or raises the existing
%      singleton*.
%
%      H = VOICERECOGNITION returns the handle to a new VOICERECOGNITION or the handle to
%      the existing singleton*.
%
%      VOICERECOGNITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VOICERECOGNITION.M with the given input arguments.
%
%      VOICERECOGNITION('Property','Value',...) creates a new VOICERECOGNITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before voicerecognition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to voicerecognition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help voicerecognition

% Last Modified by GUIDE v2.5 26-Sep-2016 10:19:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
				   'gui_Singleton',  gui_Singleton, ...
				   'gui_OpeningFcn', @voicerecognition_OpeningFcn, ...
				   'gui_OutputFcn',  @voicerecognition_OutputFcn, ...
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

% --- Executes just before voicerecognition is made visible.
function voicerecognition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to voicerecognition (see VARARGIN)

% Choose default command line output for voicerecognition
handles.output = hObject;
handles.cases = {};
handles.files = {};
handles.stuff = {};

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes voicerecognition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = voicerecognition_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
	open(file);
end

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
					 ['Close ' get(handles.figure1,'Name') '...'],...
					 'Yes','No','Yes');
if strcmp(selection,'No')
	return;
end

delete(handles.figure1)


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
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSearch.
function buttonSearch_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname, filterindex]  = uigetfile('*.wav', 'Select files', ...
											   'MultiSelect', 'on');
handles.cases = {};
if ischar(filename)
	handles.cases = { strcat(pathname, filename) };
elseif iscell(filename)
	handles.cases = {};
	for n = 1:length(filename)
		handles.cases{n} = strcat(pathname, filename{n});
	end
end

outlet = join_string(handles.cases);
set(handles.editSearch, 'String', outlet);
set(handles.buttonRun, 'Enable', 'on');
handles.pathname = pathname;
handles.filename = filename;
guidata(hObject, handles);

% --- Executes on button press in buttonRun.
function buttonRun_Callback(hObject, eventdata, handles)
% hObject    handle to buttonRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global abcxyz;

outlet = get(handles.editSearch, 'String');
files = split_string(outlet, ';');
stuff = java.util.HashMap;
for n = 1:length(files)
	stuff.put(files{n}, main(files{n}));
end

set(handles.buttonPlot, 'Enable', 'on');
set(handles.buttonSave, 'Enable', 'on');

handles.files = files;
handles.stuff = stuff;
abcxyz = handles.stuff;
guidata(hObject, handles);

% TODO Cause the appropiate side effects
% TODO Discover why some test cases are missing


% --- Executes on button press in buttonPlot.
function buttonPlot_Callback(hObject, eventdata, handles)
% hObject    handle to buttonPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global abczyx;

abcxyz = callPlot(handles.files, handles.stuff);
handles.stuff = abcxyz;
guidata(hObject, handles);


% --- Executes on button press in buttonSave.
function buttonSave_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global abcxyz;

handles.stuff = abcxyz;
file = handles.files
moments = {};
name = handles.filename;
name = split_string(name, '.')

for n = 1:length(file)
	[record, fs, nbits] = wavread(file{n});
	moments{n} = handles.stuff.get(file{n});
	time{n} = turn_to_time(moments{n}, length(record)/fs);
	
	tablename = char(strcat(name{n}, '.csv'));
    fileID = fopen(strcat(handles.pathname, tablename), 'w');
	fprintf(fileID, '%6s;%6s\n', 'Filename', 'Moments');
	
	for m = 1:length(time{n})
		timestring = replace_dot(time{n}(m));
		h = strcat(file{n}, '; ', timestring);
		fprintf(fileID, '%6s;%6s\n', file{n}, timestring);
	end
	fclose(fileID);
end

guidata(hObject, handles);
% TODO Save as .csv
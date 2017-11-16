function varargout = voicemodule(varargin)
% This module analyses an audio file, searching for an event, in
% this case, when someone says something. Based on the typical
% frequency range of the human voice, the beginning of a word must
% be recognized and the time of its occurence, stored.
%

% Edit the above text to modify the response to help voicemodule2

% Last Modified by GUIDE v2.5 13-Nov-2017 11:38:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
				   'gui_Singleton',  gui_Singleton, ...
				   'gui_OpeningFcn', @voicemodule2_OpeningFcn, ...
				   'gui_OutputFcn',  @voicemodule2_OutputFcn, ...
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

addpath([cd '/voicemodule']);

% --- Executes just before voicemodule2 is made visible.
function voicemodule2_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for voicemodule2
handles.output = hObject;
handles.cases = {};
handles.files = {};
handles.stuff = {};
handles.type = '*.wav';

% Update handles structure
set(handles.figure1, 'Name', 'Voice Recognition');
guidata(hObject, handles);

% UIWAIT makes voicemodule2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = voicemodule2_OutputFcn(hObject, eventdata, handles)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% Does nothing

% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)

file = uigetfile('*.fig');
if ~isequal(file, 0)
	open(file);
end

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)

selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
					 ['Close ' get(handles.figure1,'Name') '...'],...
					 'Yes','No','Yes');
if strcmp(selection,'No')
	return;
end

delete(handles.figure1)


% --- Executes on button press in radioAudio.
function radioAudio_Callback(hObject, eventdata, handles)

if get(hObject, 'Value');
	set(handles.radioTable, 'Value', 0);
	set(handles.buttonPlot, 'Enable', 'off');
	set(handles.buttonRun, 'Enable', 'on');
	set(handles.buttonSave, 'Enable', 'off');
	handles.type = '*.wav';
end
guidata(hObject, handles);

% --- Executes on button press in radioTable.
function radioTable_Callback(hObject, eventdata, handles)

if get(hObject, 'Value')
	set(handles.radioAudio, 'Value', 0);
	set(handles.buttonPlot, 'Enable', 'on');
	set(handles.buttonRun, 'Enable', 'off');
	set(handles.buttonSave, 'Enable', 'on');
	handles.type = '*.csv';
end
guidata(hObject, handles);

function editSearch_Callback(hObject, eventdata, handles)
% Does nothing


% --- Executes during object creation, after setting all properties.
function editSearch_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSearch.
function buttonSearch_Callback(hObject, eventdata, handles)

[filename, pathname, filterindex]  = uigetfile(handles.type, 'Select files', ...
											   'MultiSelect', 'on');
handles.cases = {};
if ~isequal(filename, 0)
	if ischar(filename)
		handles.cases = { strcat(pathname, filename) };
	elseif iscell(filename)
		handles.cases = {};
		for n = 1:length(filename)
			handles.cases{n} = strcat(pathname, filename{n});
		end
	end
	outlet = join_strings(handles.cases, ';');
	set(handles.editSearch, 'String', outlet);
	set(handles.buttonRun, 'Enable', 'on');
	handles.pathname = pathname;
	handles.filename = filename;
else
	return;
end

guidata(hObject, handles);


% --- Executes on button press in buttonRun.
function buttonRun_Callback(hObject, eventdata, handles)

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
guidata(hObject, handles);

% TODO Cause the appropiate side effects
% TODO Discover why some test cases are missing


% --- Executes on button press in buttonPlot.
function buttonPlot_Callback(hObject, eventdata, handles)

if get(handles.radioTable, 'Value')
	% transform time column with replace_dot
	% fill out stuff hash with new value
	outlet = get(handles.editSearch, 'String');
	files = split_string(outlet, ';');
	stuff = java.util.HashMap;

	for n = 1:length(files)
		fileID = fopen(filename, 'r');
		content = textscan(files{n});
		[R, C] = size(content{1});

		for k = 2:R
			semicollon = findstr(content{1}{k}, ';');
			timeArray[k - 1] = content{1}{k}(semicollon(1):length(content{1}{k}));
			timeArray[k - 1] = str2num(strrep(timeArray[k - 1], ',', '.'));
		end
		fclose(fileID);

		class(timeArray);
		stuff.put(files{n}, timeArray);
	end
end
handles.stuff = plot_stuff(handles.files, handles.stuff);
guidata(hObject, handles);


% --- Executes on button press in buttonSave.
function buttonSave_Callback(hObject, eventdata, handles)

file = handles.files;
moments = {};
name = handles.filename;
mkdir(handles.pathname, 'CSVFiles');

for n = 1:length(file)
	[record, fs, nbits] = wavread(file{n});
	moments{n} = handles.stuff.get(file{n});
	time{n} = turn_to_time(moments{n}, length(record)/fs);
	
    if ischar(name)
		tablename = strrep(name, '.wav', '.csv');
    elseif iscell(name)
        tablename = strrep(name{n}, '.wav', '.csv');
    end
	
	fileID = fopen(strcat(handles.pathname, 'CSVFiles/', tablename), 'w');
	fprintf(fileID, '%s;%s\n', 'Filename', 'Moments');
	
	for m = 1:length(time{n})
		timestring = replace_dot(time{n}(m));
		h = strcat(file{n}, '; ', timestring);
		fprintf(fileID, '%s;%s\n', file{n}, timestring);
	end
	fclose(fileID);
end

guidata(hObject, handles);

h = msgbox('Files successfully saved!');

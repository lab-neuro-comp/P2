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

% Defining some handles for the program
handles.files = {};		% strcat(pathname, filename)
handles.filename = {};	% stores filenames
handles.pathname = {};	% stores file paths
handles.stuff = {};		% stores hash map with analysed audio information
handles.ext = '*.wav';	% stores file extension expected

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

% If user chooses to analyse a brand new audio
if get(hObject, 'Value');
	set(handles.radioTable, 'Value', 0);
	set(handles.buttonRun, 'Enable', 'on');
	set([handles.buttonPlot handles.buttonSave], 'Enable', 'off');
	handles.ext = '*.wav';
end
guidata(hObject, handles);

% --- Executes on button press in radioTable.
function radioTable_Callback(hObject, eventdata, handles)

% If user decides to reanalyse an audio that
% already has a CSV "attached" to it
if get(hObject, 'Value')
	set(handles.radioAudio, 'Value', 0);
	set(handles.buttonRun, 'Enable', 'off');
	set([handles.buttonPlot handles.buttonSave], 'Enable', 'on');
	handles.ext = '*.csv';
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

[filename, pathname, filterindex]  = uigetfile(handles.ext, 'Select files', ...
											   'MultiSelect', 'on');
temp = {};

% If a file wasa selected during search
if ~isequal(filename, 0)
	% If only one file was selected during search
	if ischar(filename)
		temp = {strcat(pathname, filename)};

	% Else, if multiple files were selected during search
	elseif iscell(filename)
		for n = 1:length(filename)
			temp{n} = strcat(pathname, filename{n});
		end
	end

	outlet = join_strings(temp, ';');
	set(handles.editSearch, 'String', outlet);

	% If an audio will be analysed, Run must be enabled
	if get(handles.radioAudio, 'Value')
		set(handles.buttonRun, 'Enable', 'on');
	end

	% Set pathname and filename to a handle structure
	handles.pathname = pathname;
	filename = cellstr(filename);
	handles.filename = filename;
else
	return;
end

guidata(hObject, handles);


% --- Executes on button press in buttonRun.
function buttonRun_Callback(hObject, eventdata, handles)

pathname = handles.pathname;
filename = handles.filename;
stuff = java.util.HashMap;

% Analyse each audio provided by the user
for n = 1:length(filename)
	file{n} = strcat(pathname, filename{n});
	stuff.put(file{n}, main(file{n}));
end

% After audios have been analysed, enable Plot and Save
set([handles.buttonPlot handles.buttonSave], 'Enable', 'on');
%set(handles.buttonSave, 'Enable', 'on');

% Stores filenames and hash map in handles structures
handles.files = file;
handles.stuff = stuff;
guidata(hObject, handles);


% --- Executes on button press in buttonPlot.
function buttonPlot_Callback(hObject, eventdata, handles)

% If files provided were CSV tables
if get(handles.radioTable, 'Value')
	pathname = handles.pathname;
	filename = handles.filename;
	stuff = java.util.HashMap;
	
	for n = 1:length(filename)
		file{n} = strcat(pathname, filename{n});
		fileID = fopen(file{n}, 'r');
		content = textscan(fileID, '%s\n');
		[R, C] = size(content{1});

		% Transform time column from string to number
		for k = 2:R
			semicollon = findstr(content{1}{k}, ';');
			temp = content{1}{k}(semicollon(1):length(content{1}{k}));
			timeArray(k - 1) = str2num(strrep(temp, ',', '.'));
		end
		fclose(fileID);
		file{n} = content{1}{k}(1:semicollon(1) - 1);
		
		% Fill out stuff hash map with new value
		stuff.put(file{n}, timeArray);
	end

	% Updates handles structures with filename and hash map
	handles.files = file;
	handles.stuff = stuff;
	guidata(hObject, handles);

end
handles.stuff = plot_stuff(handles.files, handles.stuff,...
						   get(handles.radioAudio, 'Value'));
guidata(hObject, handles);


% --- Executes on button press in buttonSave.
function buttonSave_Callback(hObject, eventdata, handles)

file = handles.files;
name = handles.filename;
if get(handles.radioAudio, 'Value')
	mkdir(handles.pathname, 'CSVFiles');
end

% For each file provided in search
for n = 1:length(file)
	% Prepares information that will be written
	[record, fs] = audioread(file{n});
	time{n} = handles.stuff.get(file{n});
	
	% Prepares file in which the information will be written on
	tablename = strrep(name{n}, '.wav', '.csv');
	if get(handles.radioAudio, 'Value')
		fileID = fopen(strcat(handles.pathname, 'CSVFiles', filesep, tablename), 'w');
	else
		fileID = fopen(strcat(handles.pathname, tablename), 'w');
	end
	fprintf(fileID, '%s;%s\n', 'Filename', 'Moments');
	
	% Write each pair of filename/moment in time
	for m = 1:length(time{n})
		% Replaces '.' in numbers (US decimal separator)
		% by ',' (BR decimal separator)
		timestring = replace_dot(time{n}(m));

		h = strcat(file{n}, '; ', timestring);
		fprintf(fileID, '%s;%s\n', file{n}, timestring);
	end
	fclose(fileID);
end

guidata(hObject, handles);

h = msgbox('Files successfully saved!');

function varargout = comparemodule2(varargin)
% This module analyses the time of events of a response that where
% recorded on audio with the time when the stimulus was given to the
% participant. Upon reaching  the interface, one must be able to
% choose amongst the audio files that were previously analysed and
% search for its correspondent .txt files containing the informations
%on the test. After its analysis, the data is stored in a .csv file
% with the data that was generated before after the audio analysis.
%

% Edit the above text to modify the response to help comparemodule2

% Last Modified by GUIDE v2.5 01-Feb-2017 08:14:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
									 'gui_Singleton',  gui_Singleton, ...
									 'gui_OpeningFcn', @comparemodule2_OpeningFcn, ...
									 'gui_OutputFcn',  @comparemodule2_OutputFcn, ...
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

addpath([cd '/comparemodule']);


% --- Executes just before comparemodule2 is made visible.
function comparemodule2_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for comparemodule2
handles.output = hObject;

% Update handles structure
set(handles.figure1, 'Name', 'Test Response Delay');
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = comparemodule2_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in buttonFolder.
function buttonFolder_Callback(hObject, eventdata, handles)

CSVPath = uigetdir(cd, 'Select the folder containing the analysed audio');
handles.CSVPath = CSVPath;
programPath = cd(CSVPath);

listCSV = ls('*.csv');
handles.CSVFiles = listCSV;
CSVPath = cd(programPath);

set(handles.listFiles, 'String', listCSV);
guidata(hObject, handles);


% --- Executes on selection change in listFiles.
function listFiles_Callback(hObject, eventdata, handles)

set(handles.buttonSave, 'Enable', 'off');


% --- Executes during object creation, after setting all properties.
function listFiles_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSearch.
function buttonSearch_Callback(hObject, eventdata, handles)

% Searches for text file to match the CSV
[filename, pathname, filterindex]  = uigetfile('*.txt', 'Select files');
set(handles.editTest, 'String', strcat(pathname, filename));

% Disables Save if new search was made
set(handles.buttonSave, 'Enable', 'off');

% If a file was selected during search
if ~isempty(get(handles.editTest, 'String'))
	% Enables analysis
	set(handles.buttonAnalyse, 'Enable', 'on');
end


function editTest_Callback(hObject, eventdata, handles)

% Disables save if filename is modified
set(handles.buttonSave, 'Enable', 'off');

% If text name field is not empty
if ~isempty(get(handles.editTest, 'String'))
	set(handles.buttonAnalyse, 'Enable', 'on');

% Else, if text name field is empty
else
	% Prevents user from analysing no file
	set(handles.buttonAnalyse, 'Enable', 'off');
end

% --- Executes during object creation, after setting all properties.
function editTest_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
		set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonAnalyse.
function buttonAnalyse_Callback(hObject, eventdata, handles)

contents = cellstr(get(handles.listFiles, 'String'));
filename = contents{get(handles.listFiles, 'Value')};
filename = strcat(handles.CSVPath, filesep, filename);
handles.filename = filename;

% analyse_for_stimulus will analyse the file containing information about
% the time in which each stimulus were presented and calculate the delay
% of the answer of the participant
responseTime = analyse_for_stimulus(filename, get(handles.editTest, 'String'));
set(handles.listAnalysis, 'String', responseTime);
set(handles.buttonSave, 'Enable', 'on');

% Updates handles structure
handles.responseTime = responseTime;
guidata(hObject, handles);


% --- Executes on selection change in listAnalysis.
function listAnalysis_Callback(hObject, eventdata, handles)
% Does nothing


% --- Executes during object creation, after setting all properties.
function listAnalysis_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
		set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSave.
function buttonSave_Callback(hObject, eventdata, handles)

% Prepares for write in file
filename = handles.filename;
fileID = fopen(filename, 'r');
content = textscan(fileID, '%s');
responseTime = handles.responseTime; % contains the delays calculated for the stimuli

% Counts how many ';' a line has
semicollon = findstr(content{1}{1}, ';');

k = 2; % counts the line of the file that will be modified
[R, C] = size(content{1});

% If line has only one ';', the file has never been successfully analysed before
if length(semicollon) == 1
	% Therefore, a new column must be created
	content{1}{1} = strcat(content{1}{1}, ';Delay');
	
	for n = 1:length(responseTime)
		% If the participant answered to the stimulus
		if ((~isequal(responseTime(n), 0)) && (k <= R))
			responseFile = replace_dot(responseTime(n));
			content{1}{k} = strcat(content{1}{k}, ';', responseFile);
			n = n + 1;
			k = k + 1;

		% Else, there has been an omission
		% or one is trying to write too much information
		else
			n = n + 1;
		end
	end

% Else, the file has been successfully analysed before and
%		one wishes to overwrite previous information
else
	% Assusres that the new column has the correct header
	content{1}{1} = content{1}{1}(1:semicollon(2));
	content{1}{1} = strcat(content{1}{1}, 'Delay');
	
	for n = 1:length(responseTime)
		% If the participant answered to the stimulus
		if ((~isequal(responseTime(n), 0)) && (k <= R))
			% Finds the last semicollon of the line
			% so the information after that can be replaced
			semicollon = findstr(content{1}{k}, ';');
			content{1}{k} = content{1}{k}(1:semicollon(2));

			responseFile = replace_dot(responseTime(n));
			content{1}{k} = strcat(content{1}{k}, responseFile);
			n = n + 1;
			k = k + 1;
		
		% Else, there has been an omission
		else
			n = n + 1;
		end
	end
end
fclose(fileID);

% Opens filename to write the new information
fileID = fopen(filename, 'w');
for n = 1:length(content{1})
	fprintf(fileID, '%s\n', content{1}{n});
end
fclose(fileID);

set(handles.buttonSave, 'Enable', 'off');
h = msgbox('File successfully saved!');

guidata(hObject, handles);

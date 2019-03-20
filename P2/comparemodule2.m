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

% Last Modified by GUIDE v2.5 20-Mar-2019 14:31:14

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
handles.programPath = cd;
handles.flagCSV = 0;
handles.flagTXT = 0;

% Update handles structure
set(handles.figure1, 'Name', 'Test Response Delay');
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = comparemodule2_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in buttonCSV.
function buttonCSV_Callback(hObject, eventdata, handles)

handles.flagCSV = 0;
if ~isempty(get(handles.editTXT, 'String'))
	folder = get(handles.editTXT, 'String');
else
	folder = handles.programPath;
end

CSVPath = uigetdir(cd, 'Select the folder containing the analysed audio');
if (~all(CSVPath) && isempty(get(handles.editCSV, 'String')))
	set(handles.listCSV, 'String', {'No folder informed'});
else
	if all(CSVPath)
		handles.CSVPath = CSVPath;
		cd(CSVPath);
		set(handles.editCSV, 'String', CSVPath);
	else
		CSVPath = get(handles.editCSV, 'String');
		cd(CSVPath);
		set(handles.editCSV, 'String', CSVPath);
	end	

	listCSV = ls('*.csv');
	if ~isempty(listCSV)
		handles.CSVFiles = listCSV;
		cd(handles.programPath);
		set(handles.listCSV, 'String', listCSV);
		handles.flagCSV = 1;
	else
		set(handles.listCSV, 'String', {'No CSV in this folder'});
	end	
end

if (handles.flagCSV && handles.flagTXT)
	set(handles.buttonAnalyse, 'Enable', 'on');
else
	set(handles.buttonAnalyse, 'Enable', 'off');
end
guidata(hObject, handles);


function editCSV_Callback(hObject, eventdata, handles)

handles.flagCSV = 0;

% Disables save if path has been modified
set(handles.buttonSave, 'Enable', 'off');

% If path field is not empty
if ~isempty(get(handles.editCSV, 'String'))
	set(handles.buttonAnalyse, 'Enable', 'on');
	
	CSVPath = get(handles.editCSV, 'String');
	handles.CSVPath = CSVPath;
	cd(CSVPath);

	listCSV = ls('*.csv');
	if ~isempty(listCSV)
		handles.CSVFiles = listCSV;
		cd(handles.programPath);
		set(handles.listCSV, 'String', listCSV);
		handles.flagCSV = 1;
	else
		set(handles.listCSV, 'String', {'No CSV in this folder'});
	end

% Else, if path field is empty
else
	% Prevents user from analysing no file
	set(handles.buttonSave, 'Enable', 'off');
	set(handles.listCSV, 'String', {'No folder informed'});
end

if (handles.flagCSV && handles.flagTXT)
	set(handles.buttonAnalyse, 'Enable', 'on');
else
	set(handles.buttonAnalyse, 'Enable', 'off');
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editCSV_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listCSV.
function listCSV_Callback(hObject, eventdata, handles)

set([handles.buttonSave handles.buttonCorrect], 'Enable', 'off');
set([handles.buttonPan handles.buttonZoom], 'Enable', 'off');


% --- Executes during object creation, after setting all properties.
function listCSV_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonTXT.
function buttonTXT_Callback(hObject, eventdata, handles)

handles.flagTXT = 0;
if ~isempty(get(handles.editCSV, 'String'))
	folder = get(handles.editCSV, 'String');
else
	folder = handles.programPath;
end
	
TXTPath = uigetdir(cd, 'Select the folder containing the test information');
if (~all(TXTPath) && isempty(get(handles.editTXT, 'String')))
	set(handles.listTXT, 'String', {'No folder informed'});
else
	if all(TXTPath)
		handles.TXTPath = TXTPath;
		cd(TXTPath);
		set(handles.editTXT, 'String', TXTPath);
	else
		TXTPath = get(handles.editTXT, 'String');
		cd(TXTPath);
		set(handles.editTXT, 'String', TXTPath);
	end	

	listTXT = ls('*.txt');
	if ~isempty(listTXT)
		handles.TXTFiles = listTXT;
		cd(handles.programPath);
		set(handles.listTXT, 'String', listTXT);
		handles.flagTXT = 1;
	else
		set(handles.listTXT, 'String', {'No TXT in this folder'});
	end	
end

if (handles.flagCSV && handles.flagTXT)
	set(handles.buttonAnalyse, 'Enable', 'on');
else
	set(handles.buttonAnalyse, 'Enable', 'off');
end
guidata(hObject, handles);


function editTXT_Callback(hObject, eventdata, handles)

% Disables save if filename is modified
set(handles.buttonSave, 'Enable', 'off');

handles.flagTXT = 0;

% Disables save if path has been modified
set(handles.buttonSave, 'Enable', 'off');

% If path field is not empty
if ~isempty(get(handles.editTXT, 'String'))
	set(handles.buttonAnalyse, 'Enable', 'on');
	
	TXTPath = get(handles.editTXT, 'String');
	handles.TXTPath = CSVPath;
	cd(TXTPath);

	listTXT = ls('*.txt');
	if ~isempty(listTXT)
		handles.TXTFiles = listTXT;
		cd(handles.programPath);
		set(handles.listTXT, 'String', listTXT);
		handles.flagTXT = 1;
	else
		set(handles.listTXT, 'String', {'No TXT in this folder'});
	end

% Else, if path field is empty
else
	% Prevents user from analysing no file
	set(handles.buttonSave, 'Enable', 'off');
	set(handles.listTXT, 'String', {'No folder informed'});
end

if (handles.flagCSV && handles.flagTXT)
	set(handles.buttonAnalyse, 'Enable', 'on');
else
	set(handles.buttonAnalyse, 'Enable', 'off');
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editTXT_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
		set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listTXT.
function listTXT_Callback(hObject, eventdata, handles)

set([handles.buttonSave handles.buttonCorrect], 'Enable', 'off');
set([handles.buttonPan handles.buttonZoom], 'Enable', 'off');


% --- Executes during object creation, after setting all properties.
function listTXT_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonAnalyse.
function buttonAnalyse_Callback(hObject, eventdata, handles)

contentsCSV = cellstr(get(handles.listCSV, 'String'));
fileCSV = contentsCSV{get(handles.listCSV, 'Value')};
fileCSV = strcat(handles.CSVPath, filesep, fileCSV);
handles.fileCSV = fileCSV;

contentsTXT = cellstr(get(handles.listTXT, 'String'));
fileTXT = contentsTXT{get(handles.listTXT, 'Value')};
handles.fileTXT = strcat(handles.TXTPath, filesep, fileTXT);

% analyse_for_stimulus will analyse the file containing information about
% the time in which each stimulus were presented and calculate the delay
% of the answer of the participant
responseTime = analyse_for_stimulus(fileCSV, handles.fileTXT);
set(handles.listRT, 'String', responseTime);
set([handles.buttonSave handles.buttonCorrect], 'Enable', 'on');
set([handles.buttonZoom handles.buttonPan], 'Enable', 'on');

% Updates handles structure
handles.responseTime = responseTime;
guidata(hObject, handles);


% --------------------------------------------------------------------
% --- Executes on selection change in listRT.
function listRT_Callback(hObject, eventdata, handles)
% Does nothing


% --- Executes during object creation, after setting all properties.
function listRT_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
		set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
% --- Executes on button press in buttonCorrect.
function buttonCorrect_Callback(hObject, eventdata, handles)
% allows pair of points to be reassigned


% --- Executes on button press in buttonZX.
function buttonZoom_Callback(hObject, eventdata, handles)
% controls the zoom in the x-axis
switch get(handles.buttonZoom, 'Value')
 	case 1
 		set(handles.buttonPan, 'Enable', 'off')
 		zoom xon;
 	otherwise
 		set(handles.buttonPan, 'Enable', 'on')
 		zoom off;
 end
guidata(hObject, handles);


% --- Executes on button press in buttonPan.
function buttonPan_Callback(hObject, eventdata, handles)
% controls the pan in the x-axis
switch get(handles.buttonPan, 'Value')
 	case 1
 		set(handles.buttonZoom, 'Enable', 'off')
 		pan xon;
 	otherwise
 		set(handles.buttonZoom, 'Enable', 'off')
 		pan off;
 end
guidata(hObject, handles);


% --- Executes on button press in buttonSave.
function buttonSave_Callback(hObject, eventdata, handles)

% Prepares for write in file
fileCSV = handles.fileCSV;
fileID = fopen(fileCSV, 'r');
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


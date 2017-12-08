function varargout = plot_stuff(varargin)
% This modele provides the way for the user to clear the data
% obtained from the analysis made for the beginning of a word.
% If there's more data being recorded as a speech, the user can
% leave it unmarked to be erased when the file is saved.
%

% Edit the above text to modify the response to help plot_stuff

% Last Modified by GUIDE v2.5 25-Jun-2017 11:33:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
					 'gui_Singleton',  gui_Singleton, ...
					 'gui_OpeningFcn', @plot_stuff_OpeningFcn, ...
					 'gui_OutputFcn',  @plot_stuff_OutputFcn, ...
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


% --- Executes just before plot_stuff is made visible.
function plot_stuff_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for plot_stuff
handles.output = hObject;

% Defining some handles for the program
handles.files = varargin{1};
handles.stuff = varargin{2};
handles.exp = varargin{3};

handles.number = 1;
set(handles.panelName,...
	'Title', strcat('File: ', num2str(1), '/', num2str(length(handles.files))));

% If only one file was informed
if length(handles.files) == 1
	set(handles.pushbuttonSave, 'String', 'Save');
end

% Prepare axes for first plot
[handles.record, handles.fs] = refresh_signal(hObject, handles,...
							   				  handles.files,...
							   				  handles.stuff,...
							   				  handles.number,...
							   				  handles.ext);

% If file being analysed is an audio
if handles.ext
	% The information stored in hash map must be updated
	moments = get(handles.stuff, handles.files{handles.number});
	timeArray = turn_to_time(moments, length(handles.record)/handles.fs);

%Else, if the file is CSV table
else
	timeArray = get(handles.stuff, handles.files{handles.number});
end

% Update number of points marked in file
set(handles.textPoints, 'String', num2str(length(timeArray)));

% Update handles structure
handles.times = timeArray;
set(handles.figure1, 'Name', 'Moments Verification');
guidata(hObject, handles);

% UIWAIT makes plot_stuff wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_stuff_OutputFcn(hObject, eventdata, handles)

% Get default command line output from handles structure
varargout{1} = handles.output;
close(handles.figure1);


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


% --------------------------------------------------------------------
function toolZoom_OnCallback(hObject, eventdata, handles)

% Enables zoom horizontally
zoom xon;
set([handles.toolAdd handles.toolRemove], 'Enable', 'off');
set([handles.toolPan handles.toolData], 'State', 'off');


function toolPan_OnCallback(hObject, eventdata, handles)

% Enables pan horizontally
pan xon;
set([handles.toolAdd handles.toolRemove], 'Enable', 'off');
set([handles.toolZoom handles.toolData], 'State', 'off');


% --------------------------------------------------------------------
function toolData_OnCallback(hObject, eventdata, handles)

% Enables data cursor
switch get(hObject,'State')
    case 'on'
        hdata = datacursormode;
		datacursormode on;
		set([handles.toolAdd handles.toolRemove], 'Enable', 'on');
		set([handles.toolZoom handles.toolPan], 'State', 'off');
    case 'off'
        set([handles.toolAdd handles.toolRemove], 'Enable', 'off');
		datacursormode off;
end

handles.hdata = hdata;

guidata(hObject, handles);


function toolAdd_ClickedCallback(hObject, eventdata, handles)

% Gets points marked with cursor from data cursor
datainfo = getCursorInfo(handles.hdata);
[h w] = size(datainfo);

timeArray = handles.times;

switch isempty(datainfo)
	% If some point has been selected
    case 0
        for n = 1:w
            spotposition = datainfo(1,n).Position;
            timeArray(length(timeArray)+1) = spotposition(1);
            timeArray = sort(timeArray);
            index = find(timeArray == spotposition(1));
        end

    % Else, if no point has been selected
    case 1
        msgbox('Make sure at least one point is selected.');
        beep;
end

% Updates number of points marked in audio
tmp = str2num(get(handles.textPoints, 'String'));
set(handles.textPoints, 'String', num2str(tmp + w));

% Adds new points to hash map
recordtime = length(handles.record)/handles.fs;
moments = turn_to_moment(handles.stuff.get(handles.files{handles.number}),...
						 timeArray, recordtime);
handles.stuff.put(handles.files{handles.number}, moments);

% Updates plot
[handles.record, handles.fs] = refresh_signal(hObject, handles,...
							   				  handles.files,...
							   				  handles.stuff,...
							   				  handles.number,...
							   				  handles.ext);

% Updates handles structure
handles.times = timeArray;
guidata(hObject, handles);


function toolRemove_ClickedCallback(hObject, eventdata, handles)

% Gets points marked with cursor from data cursor
datainfo = getCursorInfo(handles.hdata);
[h w] = size(datainfo);

timeArray = handles.times;

switch isempty(datainfo)
	% If some point has been selected
    case 0
        for n = 1:w
            spotposition = datainfo(1,n).Position;
            temp = timeArray - spotposition(1);
            [minimum minindex] = min(abs(temp));
            timeArray(minindex) = [];
        end

    % Else, if no point has been selected
    case 1
        msgbox('Make sure at least one point is selected.');
        beep;
end

% Updates number of points marked in audio
tmp = str2num(get(handles.textPoints, 'String'));
set(handles.textPoints, 'String', num2str(tmp - w));

% Removes points from hash map
recordtime = length(handles.record)/handles.fs;
moments = turn_to_moment(handles.stuff.get(handles.files{handles.number}),...
										   timeArray, recordtime);
handles.stuff.put(handles.files{handles.number}, moments);

% Updates plot
[handles.record, handles.fs] = refresh_signal(hObject, handles,...
							   				  handles.files,...
							   				  handles.stuff,...
							   				  handles.number,...
							   				  handles.ext);

% Updates handles structure
handles.times = timeArray;
guidata(hObject, handles);


% --------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function textFilename_CreateFcn(hObject, eventdata, handles)
% Does nothing


% --- Executes on button press in pushbuttonSave.
function pushbuttonSave_Callback(hObject, eventdata, handles)

number = handles.number;

% Prepares to save file
filename = handles.files;
moments = get(handles.stuff, filename{number});
timeArray = turn_to_time(moments, length(handles.record)/handles.fs);

selection = questdlg({'You will save only the marked moments.',...
					 'Do you wish to continue?'},...
					 ['Save ' filename{number} '?'],...
					 'Ok','Cancel','Ok');
if strcmp(selection,'Cancel')
	return;
end

% Updates hash map with modified information
recordtime = length(handles.record)/handles.fs;
moments = turn_to_moment(handles.stuff.get(filename{handles.number}),...
						 timeArray, recordtime);
handles.stuff.put(filename{number}, moments);

number = number + 1;
handles.number = number;

% If there are still more files to be analysed
if number <= length(handles.files)
	if number == length(handles.files)
		set(handles.pushbuttonSave, 'String', 'Save');
	end
	
	% Updates plot with next audio
	[handles.record, handles.fs] = refresh_signal(hObject, handles,...
							   				  handles.files,...
							   				  handles.stuff,...
							   				  handles.number,...
							   				  handles.ext);
	
	filename = handles.files;
	% If file being analysed is an audio
	if handles.ext
		% The information stored in hash map must be updated
		moments = get(handles.stuff, handles.files{handles.number});
		timeArray = turn_to_time(moments, length(handles.record)/handles.fs);

	%Else, if the file is CSV table
	else
		timeArray = get(handles.stuff, handles.files{handles.number});
	end

	% Update number of points marked in file
	set(handles.textPoints, 'String', num2str(length(timeArray)));

	% Update handles structure
	handles.times = timeArray;
	guidata(hObject, handles);

% Else, if all files have been analysed
else
	% Handles control back to voicemodule2
	handles.output = handles.stuff;
	guidata(hObject, handles);
	uiresume(handles.figure1);
end


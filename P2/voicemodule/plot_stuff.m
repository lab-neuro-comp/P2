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
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_stuff (see VARARGIN)

% Choose default command line output for plot_stuff
handles.output = hObject;
handles.files = varargin{1};
handles.stuff = varargin{2};

% Update handles structure
set(handles.figure1, 'Name', 'Moments Verification');
number = 1;
handles.number = number;
set(handles.panelName, 'Title', strcat('File: ', num2str(number), '/', num2str(length(handles.files))));

if number == length(handles.files)
	set(handles.pushbuttonSave, 'String', 'Save');
end
[handles.record, handles.fs] = refresh_signal(hObject, handles,...
							   handles.files, handles.stuff, handles.number);
filename = handles.files;
moments = get(handles.stuff, filename{handles.number});
timeArray = turn_to_time(moments, length(handles.record)/handles.fs);
handles.times = timeArray;
set(handles.textPoints, 'String', num2str(length(timeArray)));
guidata(hObject, handles);

% UIWAIT makes plot_stuff wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_stuff_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
close(handles.figure1);


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


% --------------------------------------------------------------------
function toolZoom_OnCallback(hObject, eventdata, handles)

zoom on;
set([handles.toolAdd handles.toolRemove], 'Enable', 'off');
set([handles.toolPan handles.toolData], 'State', 'off');


function toolPan_OnCallback(hObject, eventdata, handles)

pan on;
set([handles.toolAdd handles.toolRemove], 'Enable', 'off');
set([handles.toolZoom handles.toolData], 'State', 'off');


% --------------------------------------------------------------------
function toolData_OnCallback(hObject, eventdata, handles)

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

datainfo = getCursorInfo(handles.hdata);
[h w] = size(datainfo);

timeArray = handles.times;

switch isempty(datainfo)
    case 0
        for n = 1:w
            spotposition = datainfo(1,n).Position;
            timeArray(length(timeArray)+1) = spotposition(1);
            timeArray = sort(timeArray);
            index = find(timeArray == spotposition(1));
        end
    case 1
        msgbox('Make sure at least one point is selected.');
        beep;
end
tmp = str2num(get(handles.textPoints, 'String'));
set(handles.textPoints, 'String', num2str(tmp + w));

recordtime = length(handles.record)/handles.fs;
moments = turn_to_moment(handles.stuff.get(handles.files{handles.number}), timeArray, recordtime);
handles.stuff.put(handles.files{handles.number}, moments);

[handles.record, handles.fs] = refresh_signal(hObject, handles,...
							   handles.files, handles.stuff, handles.number);

handles.times = timeArray;

guidata(hObject, handles);


function toolRemove_ClickedCallback(hObject, eventdata, handles)

datainfo = getCursorInfo(handles.hdata);
[h w] = size(datainfo);

timeArray = handles.times;

switch isempty(datainfo)
    case 0
        for n = 1:w
            spotposition = datainfo(1,n).Position;
            temp = timeArray - spotposition(1);
            [minimum minindex] = min(abs(temp));
            timeArray(minindex) = [];
        end
    case 1
        msgbox('Make sure at least one point is selected.');
        beep;
end
tmp = str2num(get(handles.textPoints, 'String'));
set(handles.textPoints, 'String', num2str(tmp - w));

recordtime = length(handles.record)/handles.fs;
moments = turn_to_moment(handles.stuff.get(handles.files{handles.number}), timeArray, recordtime);
handles.stuff.put(handles.files{handles.number}, moments);

[handles.record, handles.fs] = refresh_signal(hObject, handles,...
							   handles.files, handles.stuff, handles.number);

handles.times = timeArray;

guidata(hObject, handles);


% --------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function textFilename_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in pushbuttonSave.
function pushbuttonSave_Callback(hObject, eventdata, handles)

number = handles.number;

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

recordtime = length(handles.record)/handles.fs;
moments = turn_to_moment(handles.stuff.get(filename{handles.number}), timeArray, recordtime);

handles.stuff.put(filename{number}, moments);
delete(strrep(filename{handles.number}, '.wav', '_tmp.wav'));

number = number + 1;
handles.number = number;

if number <= length(handles.files)
	if number == length(handles.files)
		set(handles.pushbuttonSave, 'String', 'Save');
	end
	[handles.record, handles.fs] = refresh_signal(hObject, handles,...
							       handles.files, handles.stuff, handles.number);
	filename = handles.files;
	moments = get(handles.stuff, filename{handles.number});
	timeArray = turn_to_time(moments, length(handles.record)/handles.fs);
	handles.times = timeArray;
	guidata(hObject, handles);
else
	handles.output = handles.stuff;
	guidata(hObject, handles);
	uiresume(handles.figure1);
end


